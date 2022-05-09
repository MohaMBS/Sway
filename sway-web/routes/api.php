<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\PassportController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
/*
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('register', [UserController::class, 'store'])
       ->name('user.store');

Route::middleware('auth:api')->group(function (){
    Route::post('test', function(Request $request){
        return $request->a;
    });
});*/

//Metodo para darse de alta
Route::post('register', [PassportController::class, 'register'])->name('passport.register');
Route::get('login', [PassportController::class, 'login'])->name('passport.login');

Route::group(['middleware' => 'auth:api'], function() {
    // Metodo para cerrar session en el dispositivo
    Route::get('logout', [PassportController::class, 'logout'])->name('passport.logout');

    Route::get('user/info', [UserController::class, 'userDetail'])->name('passport.userInfo');

    Route::get('test',function(Request $request){
        return $request->a;
    })->name('passport.test');

});