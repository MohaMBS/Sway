<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use App\Models\Contact;


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
        return $this->sendRespons('This are the users, you can add.',User::where([['is_public','=',true],['id','=',auth()->user()->id]])->get());
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
