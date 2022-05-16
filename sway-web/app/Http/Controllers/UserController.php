<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use App\Models\Contact;
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
                $contact = Contact::where('user_to_id','=',$user_id)->where('id','=',$request->contact_id)->update(['connection_status_id'=>0]);
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
            return $this->sendRespons('This are the users, you can add.',User::where([['is_public','=',true],['name','like','%'.$request->input('query').'%'],['id','!=',auth()->user()->id]])->get());
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

}
