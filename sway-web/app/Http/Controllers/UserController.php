<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\User;


class UserController extends BaseController
{
    //

    /**
     * Funcion de api para dar de alta a un usuario 
     * @param array $request Los datos que nos llegan para poder tratarlos
     */
    public function store(Request $request){
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
            'data' => User::with('company')->with('contacts')->find(auth()->user()->id)
        ], 200);
    }

}
