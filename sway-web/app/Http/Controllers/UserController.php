<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use App\Models\Contact;
use App\Models\Loan;
use App\Models\LoanType as LoanT;
use App\Models\LoanStatus as LoanS;
use Illuminate\Support\Str;
use Auth;

class UserController extends BaseController
{
    //

    /**
     * Funcion de api para dar de alta a un usuario 
     * @param array $request Los datos que nos llegan para poder tratarlos
     */
    public function store(Request $request){
    }



    public function acceptConnection(Request $request){
        if($request->contact_id){
            $user_id = auth()->user()->id;
            try {
                $contact = Contact::where('id','=',$request->contact_id)->update(['connection_status_id'=>1]);
                return $this->sendRespons($contact,'Updated.');
            } catch (\Illuminate\Database\QueryException $e) {
                return $this->sendError('Failed to update.',$e->getMessage());
            }
        }else {
            return $this->sendError('contact_id not found.','No found id of the contact to accept.');
        }
    }


    public function getPublicUser(Request $request){
        try {
            $request->validate([
                'query'=>'required'
            ]);
            return $this->sendRespons(User::where([['is_public','=',true],['name','ilike','%'.$request->input('query').'%'],['id','!=',auth()->user()->id]])->get(),'This are the users, you can add.');
        } catch (\Throwable $th) {
            return $this->sendError('Erro loking for user.',$th->getMessage());
        }
        
    }

    public function myProfilePrivateMode(Request $request){
        try {
            $user = Auth::user();
            if($request->has('is_public')){
                $user->is_public = $request->is_public;
            }else{
                $user->is_public = false;
            }
            $user->save();
            
            return $this->sendRespons('Perfil updated.',$user);
        } catch (\Throwable $th) {
            return $this->sendError('Erro to update.',$th->getMessage());
        }
    }

    public function myProfilePublic(){

    }

    /**
     * Access method to authenticate.
     *
     * @return json
     */
    public function userDetail()
    {
        return response()->json([
            'success' => true,
            'message' => 'Data fetched successfully.',
            'data' => User::with('company')->with('contacts')->with('loaned')->with('loans')->find(auth()->user()->id)
        ], 200);
    }


    function updateInfo(Request $request){
        $user =Auth::user();
        $validator;
        if($request->has('name')){
            $validator = Validator::make(
                $request->all(),[
                    'name'=>'required|min:4',
                ]);
        }
        if ($validator->fails()) {  
            // return "Error";
            return $this->sendError(
                    'Error de validacion',
                    $validator->errors(),
                    422);
        }else{
            $user->name = $request['name'];
        }

        if($request->has('email')){
            if(auth()->user()->email != $request->email){

                $validator = Validator::make(
                    $request->all(),[
                        'email'=>'required|email|unique:users,email',
                    ]);
                
                if ($validator->fails()) {  
                    // return "Error";
                    return $this->sendError(
                            'Error de validacion',
                            $validator->errors(),
                            422);
                }else{
                    $user->email = $request['email'];
                }
            }
        }
        $user->save();
        $user['phone'] = (auth()->user()->phone) ? auth()->user()->phone : '';
        $user['token'] = $request->bearerToken();
        return $this->sendRespons($user,'Updated');
    }

    function getScores(Request $request){
        $condition_done =LoanS::where('description','like','Accepted')->first();
        $condition_done =LoanS::where('description','like','Accepted')->first();
        $loans = Loan::where([['user_from_id','=',auth()->user()->id],['loan_status_id','=',$condition_done->id]])->get();
        $loansCount = $loans->count();
        $loaneds = Loan::where([['user_to_id','=',auth()->user()->id],['loan_status_id','=',$condition_done->id]])->get();
        return $this->sendRespons(['loans'=>$loansCount,'loaneds'=>$loaneds->count()],'Here you have');
    }
}
