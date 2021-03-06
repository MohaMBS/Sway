<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Validation;
use App\Models\User;
use App\Models\Contact;
use App\Models\StatusContact;
use App\Models\Loan;
use App\Models\Penalty;
use App\Models\LoanType as LoanT;
use App\Models\LoanStatus as LoanS;
use App\Models\Condition;
use App\Models\ConditionType;
use Illuminate\Support\Str;

class LoanController extends BaseController
{
    //

    public function index(Request $request){
        $prestamos = Loan::with('condition')->with('penalty')->where('user_from_id',auth()->user()->id)->with('userTo')->get();
        $tomado = Loan::with('condition')->with('penalty')->where('user_to_id',auth()->user()->id)->with('userFrom')->get();
        return $this->sendRespons(['prestado'=>$prestamos, 'tomados'=> $tomado],'All the loans of the user autenticated.');
    }

    public function getLoan(Request $request){
        $validated = $request->validate([
            'id' => 'required',
        ]);
        $user = Loan::where('id','=',$request->id)->where('user_from_id','=',auth()->user()->id)->first();
        if($user){
            $final = Loan::with('condition')->with('penalty')->where('id','=',$request->id)->with('userFrom')->with('status')->get();
        }else{
            $final = Loan::with('condition')->with('penalty')->where('id','=',$request->id)->with('userTo')->with('status')->get();
        }
        return $this->sendRespons($final,'here tyou have');
    }

    public function acceptLoan(Request $request){
        $validated = $request->validate([
            'id' => 'required',
        ]);
        $status = LoanS::where('description','like','Accepted')->first();
        $loan = Loan::where('id','=',$request->id)->where('user_from_id','=',auth()->user()->id)->orWhere('user_from_id','=',auth()->user()->id);
        if($loan->update(['loan_status_id' => $status->id])){
            return $this->sendRespons('ok','Updated');
        }else{
            return $this->sendError('not good.','Error when try to update');
        }
    }

    public function store(Request $request){
        /*$user_id = auth()->user()->id;
        return $this->sendRespons(['id'=>$user_id],'Store de loan, de momento solo da el id del usuario.');*/

        return $this->sendError('Action not permited.','This action is not permited to update a loan.');
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
            'condition_condition_type_id' => 'required'
        ]);
        try {
            $src_document = $this->decodeDocumentSave($request);

            if($request->has('condition_condition_type_id')){
                $conditionType = ConditionType::find($request->condition_condition_type_id);
                $conditionBBDD = Condition::create([
                    'description'=>$request->condition_description,
                    'condition_type_id'=>$conditionType->id
                ]);
                $id_penal=null;
                if($request->has('penalty')){
                    $pennal = Penalty::create([
                        'description'=>$request->penalty,
                        'penalty_type_id'=>0]
                    );
                    $id_penal = $pennal->id;
                }
                $newLoan = Loan::create([
                    'user_from_id'=> auth()->user()->id,
                    'user_to_id' => User::find($request->user_to_id)->id,
                    'condition_id'=> $conditionBBDD->id,
                    'concept' => $request->concept,
                    'description'=> $request->description,
                    'type_loan_id'=>LoanT::find($request->type_loan_id)->id,
                    'limit_date' => $request->limit_date,
                    'loan_status_id' => LoanS::where('description','like','Waiting confirmation')->first()->id,
                    'document_src'=> $src_document,
                    'penalty_id'=>$id_penal
                ]);
                $status = LoanS::find($newLoan->loan_status_id);
                $user_id = auth()->user()->id;
                return $this->sendRespons($newLoan,'Create de loan, de momento solo da el id del usuario.');
            }else{
                $validated->errors()->add('condition_type_id', 'Please give condition_type_id.');
            }

        } catch (\Illuminate\Database\QueryException $e) {
            return $this->sendError('Failed to update.',$e->getMessage());
        }
    }

    public function decodeDocumentSave($request){
        $filename_to_save_in_db = null;
        try {
            $validator = $request->validate([ 
                'file' => 'required|mimes:png,jpeg,doc,docx,pdf,txt|max:2048',
            ]);
            $destinationPath = '/img/loans/';
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

    public function changeStatLoan(Request $request){
        $request->validate([
            'loan_id' => 'required',
            'status_id' => 'required',
        ]);

        try {
            $loan = Loan::where('id','=',$request->loan_id)->where('user_from_id','=',auth()->user()->id)->orWhere('user_to_id','=',auth()->user()->id)->first();    
            $loanS = LoanS::find($request->status_id);
            $loan->loan_status_id = $loanS->id;
            if($loan->save()){
                return $this->sendRespons(['loan'=>$loan,'status'=>$loanS],'Change succes.');
            }else{
                return $this->sendError('Unkow error.','Error ocured when updating the loan.');
            }
        } catch (\Throwable $th) {
            return $this->sendError('Error on update loan.',$th->getMessage());
        }

        return $this->sendRespons('Si','Si');
    }

    public function getPrepare(){
        $status = StatusContact::where('description','like','Connected')->first();
        $loanType = LoanT::all();
        $conditionType = ConditionType::all();
        $friends = Contact::where('user_from_id','=',auth()->user()->id)->where('connection_status_id','=',$status->id)->pluck('user_to_id')->toArray();
        $users = User::whereIn('id',$friends)->get();
        return $this->sendRespons(['loan_type'=>$loanType,'condition_type'=>$conditionType,'contacts'=>$users],'Here you have the info.');
    }
}
