<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Validation;
use App\Models\User;
use App\Models\Loan;
use App\Models\LoanType as LoanT;
use App\Models\LoanStatus as LoanS;
use App\Models\Condition;
use App\Models\ConditionType;
use Illuminate\Support\Str;

class LoanController extends BaseController
{
    //

    public function index(Request $request){
        return $this->sendRespons(Loan::find(auth()->user()->id),'All the loans of the user autenticated.');
    }

    public function store(Request $request){
        $user_id = auth()->user()->id;
        return $this->sendRespons(['id'=>$user_id],'Store de loan, de momento solo da el id del usuario.');
    }
    
    public function delete(Request $request){
        $user_id = auth()->user()->id;
        return $this->sendRespons(['id'=>$user_id],'Delete de loan, de momento solo da el id del usuario.');
    }

    public function create(Request $request){
        $validated = $request->validate([
            'user_to_id' => 'required',
            'concept' => 'required|max:255',
            'description' => 'required',
            'type_loan_id' => 'required',
            'limit_date' => 'required|date',
            'condition_description' => 'required',
            'condition_condition_type_id' => 'required',
            'document_base64' => 'nullable|string|min:1',
        ]);
        try {
            $src_document = $this->decodeDocumentSave($request);

            if($request->has('condition_condition_type_id')){
                $conditionType = ConditionType::find($request->condition_condition_type_id);
                $conditionBBDD = Condition::create([
                    'description'=>$request->condition_description,
                    'condition_type_id'=>$conditionType->id
                ]);
                $newLoan = Loan::create([
                    'user_from_id'=> auth()->user()->id,
                    'user_to_id' => User::find($request->user_to_id)->id,
                    'condition_id'=> $conditionBBDD->id,
                    'concept' => $request->concept,
                    'description'=> $request->description,
                    'type_loan_id'=>LoanT::find($request->type_loan_id)->id,
                    'limit_date' => $request->limit_date,
                    'loan_status_id' => 1,
                    'document_src'=> $src_document
                ]);
                $status = LoanS::find($newLoan->loan_status_id);
            }else{
                $validated->errors()->add('condition_type_id', 'Please give condition_type_id.');
            }

        } catch (\Illuminate\Database\QueryException $e) {
            return $this->sendError('Failed to update.',$e->getMessage());
        }
        $user_id = auth()->user()->id;
        return $this->sendRespons('qwd','Create de loan, de momento solo da el id del usuario.');
    }

    public function decodeDocumentSave($request){
        $filename_to_save_in_db = '';
        try {
            $validator = $request->validate([ 
                'file' => 'required|mimes:png,jpeg,doc,docx,pdf,txt,csv|max:2048',
            ]);
            $destinationPath = '/public/img/loans/';
            $file = $request->file('file');
            $filename = Str::random(15).$file->getClientOriginalName();
            $file->move(public_path() . $destinationPath, $filename);
            $filename_to_save_in_db = $destinationPath . $filename;
        } catch (\Throwable $th) {
            $this->sendError('Erro uplandig file',$th->getMessage());
        }finally{
            return $filename_to_save_in_db;
        }
    }
}
