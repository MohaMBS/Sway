<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class BaseController extends Controller
{
    //

     // return exito
    public function sendRespons($result, $message){
        $response = [
            'success'=>	true,
            'message'=>$message,
            'data' => $result
        ];
        return response()->json($response,200);
    }  

    // return "Error"
    public function sendError($error, $errorMessage = [], $code = 404){
        $response = [
            'success' => false,
            'error' => $error,
            'message' => $errorMessage
        ];

        return response()->json($response, $code);
    }
}
