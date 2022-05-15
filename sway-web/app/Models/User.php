<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password','company_id','is_public',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];


    /**
     * Relacion con la compañia
     */
    public function company(){
        return $this->hasOne(Company::class);
    }

    public function myContacts(){
        return $this->hasMany(Contact::class,'user_from_id','id');
    }

    public function connectedWith(){
        return $this->hasMany(Contact::class,'user_to_id','id');
    }

    public function contacts(){
        return $this->myContacts()->union($this->connectedWith())->where('connection_status_id','=',0);
    }

    public function loaned(){
        return $this->hasMany(Loan::class,'user_from_id','id');
    }

    public function loans(){
        return $this->hasMany(Loan::class,'user_to_id','id');
    }
}
