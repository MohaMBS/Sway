<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\PassportController;
use App\Http\Controllers\LoanController;
use App\Http\Controllers\FriendController;

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
//Metodo para iniciar la session 
Route::get('login', [PassportController::class, 'login'])->name('passport.login');

Route::group(['middleware' => 'auth:api'], function() {

    // RUTAS PARA GESTIONES DE USUARIOS
    Route::post('user/connect/',[FriendController::class,'makeContact'])->name('passport.makeContactUser'); //Ruta para poder agregar a un usuario.
    Route::get('logout', [PassportController::class, 'logout'])->name('passport.logout'); //Ruta para poder cerrar session
    Route::get('user/info', [UserController::class, 'userDetail'])->name('passport.userInfo'); //Ruta para obtener toda la informacion de un usuario
    Route::put('user/connect/accept',[UserController::class,'acceptConnection'])->name('passport.acceptConnection'); //Aceptar conexcionde un usuario
    Route::get('users/',[UserController::class,'getPublicUser'])->name('passport.getUSers'); // Usuarios que tiene el perfil en public y puedes agregarlos
    Route::get('user/connect',[FriendController::class,'myConnections'])->name('passport.myCcontacts'); // Para saber tu amistades
    Route::delete('user/connect/',[FriendController::class,'deleteConnection'])->name('passport.myCcontacts'); // Para borar una amistad
    Route::put('user/privacy/',[UserController::class,'myProfilePrivateMode'])->name('passport.myCcontacts'); // Para borar una amistad
    //Route::delete('user/privacy/',[FriendController::class,'deleteConnection'])->name('passport.myCcontacts'); // Para borar una amistad

    // RUTAS PARA GESTIONAR LOS PRESTAMOS
    Route::get('loan/',[LoanController::class, 'index'])->name('passport.indexLoans');//Obtener todos los prestamos del usuario;
    Route::put('loan/{id}',[LoanController::class, 'store'])->name('passport.sotreLoans'); //Actulizar una prestamos, en caso de ser necesario;
    Route::delete('loan/',[LoanController::class, 'delete'])->name('passport.deleteLoans');//Borrar un prestamo
    Route::post('loan/',[LoanController::class, 'create'])->name('passport.createLoans');//Crear una prestamos


    //RUTAS DE TESTEO
    Route::get('test',function(Request $request){
        return $request->a;
    })->name('passport.test');

});