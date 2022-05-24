<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Contact extends Model
{
    use HasFactory;
    
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'user_from_id', 'user_to_id', 'connection_status_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class,'user_from_id','id');
    }

    public function connection_status(){
        return $this->hasOne(StatusConnection::class,'connections_status_id','id');
    }

    public function friendInfo(){
        return $this->hasMany(User::class,'id','user_to_id');
    }
}
