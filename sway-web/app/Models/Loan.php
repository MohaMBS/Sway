<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Loan extends Model
{
    use HasFactory;

    protected $fillable = ['user_from_id','loan_status_id','user_to_id','condition_id','concept','description','type_loan_id','limit_date','document_src','penalty_id'];

    public function user(){
        return  $this->belongsTo(User::class,'user_from_id', 'id');
    }
    public function userFrom(){
        return  $this->hasOne(User::class, 'id','user_from_id');
    }
    public function userTo(){
        return  $this->hasOne(User::class, 'id','user_to_id');
    }

    public function status(){
        return $this->hasOne(LoanStatus::class,'id','loan_status_id');
    }

    public function condition(){
       return $this->hasOne(Condition::class,'id','condition_id');
    }
    
    public function penalty(){
       return $this->hasOne(Penalty::class,'id','penalty_id');
    }
}
