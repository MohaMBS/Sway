<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use Laravel\Passport\TokenRepository;

class PassportController extends BaseController
{
    /**
     * Register user.
     *
     * @return json
     */
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'name'=>'required',
            'email'=>'required|email|unique:users,email',
            'password'=>'required',
            'confirm_password'=>'required|same:password'
        ]);
        if ($validator->fails()) {  
            // return "Error";
            return $this->sendError(
                    'Error de validacion',
                    $validator->errors(),
                    422);
        }

        $input = $request->all();
        //ciframos el password
        $input['password'] = bcrypt($request->get('password'));
        $user = User::create($input);
        //creamos un nuevo token de autenticación
        $token = $user->createToken('laravel-passport')->accessToken;
        $data = [
            'token'=>$token,
            'user'=>$user
        ];
        // return "Exito";
        return $this->sendRespons($data,"Usuario registrado exitosa mente");
    }

    /**
     * Login user.
     *
     * @return json
     */
    public function login(Request $request)
    {
        $input = $request->only(['email', 'password']);

        $validate_data = [
            'email' => 'required|email',
            'password' => 'required|min:8',
        ];

        $validator = Validator::make($input, $validate_data);
        
        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Please see errors parameter for all errors.',
                'errors' => $validator->errors()
            ]);
        }

        // authentication attempt
        if (auth()->attempt($input)) {
            $token = auth()->user()->createToken('passport_token')->accessToken;
            return $this->sendRespons(["token"=> $token],'User login succesfully, Use token to authenticate.');
        } else {
            return $this->sendError('User authentication failed.','Wrong credentials, Try again login.',401);
        }
    }

    /**
     * Logout user.
     *
     * @return json
     */
    public function logout()
    {
        $access_token = auth()->user()->token();

        // logout from only current device
        $tokenRepository = app(TokenRepository::class);
        $tokenRepository->revokeAccessToken($access_token->id);

        // use this method to logout from all devices
        // $refreshTokenRepository = app(RefreshTokenRepository::class);
        // $refreshTokenRepository->revokeRefreshTokensByAccessTokenId($$access_token->id);

        return response()->json([
            'success' => true,
            'message' => 'User logout successfully.'
        ], 200);
    }

    
}
