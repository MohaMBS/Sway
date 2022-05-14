<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Contact;
use App\Models\StatusContact as ContactS;
use App\Models\User;

class FriendController extends BaseController
{
    //

    
    public function makeContact(Request $request){
        if(!$request->user_to_id){
            return $this->sendError('user_to_id not found.','No found id of the user to connect.');
        }

        $statusOfConnection = ContactS::where('description', 'like','Waiting confirmation')->first();
        $userAdd = User::find($request->user_to_id);

        if(auth()->user()->company_id and $userAdd->company_id){
            $user_id = auth()->user()->id;
            $contact = Contact::create(['user_from_id'=>$user_id,'user_to_id'=>$request->user_to_id,'connection_status_id'=>$statusOfConnection->id]);
            return $this->sendRespons($contact,'Company connection done.');
        }else if (auth()->user()->company_id == null and $userAdd->company_id == null){
            $user_id = auth()->user()->id;
            $contact = Contact::create(['user_from_id'=>$user_id,'user_to_id'=>$request->user_to_id,'connection_status_id'=>$statusOfConnection->id]);
            return $this->sendRespons($contact,'Connection done.');
        }else{
            return $this->sendError('Diferent type of users.','We cannt connect two diferents of type the users.');
        } 
    }

    public function myConnections(){
        $data = [];

        $statusConnected = ContactS::where('description', 'like','Connected')->first();
        $statusWaiting = ContactS::where('description', 'like','Waiting confirmation')->first();

        $contactsConnecteds = Contact::where('connection_status_id','=',$statusConnected->id)->where('user_from_id','=',auth()->user()->id)->get();
        $contactWaiting = Contact::where('connection_status_id','=',$statusWaiting->id)->where('user_from_id','=',auth()->user()->id)->get();
        
        
        $data = ['connecteds'=>$contactsConnecteds,'waitng_connection'=>$contactWaiting];
        
        return $this->sendRespons($data,'Your connections');
    }
}
