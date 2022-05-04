<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLoansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('loans', function (Blueprint $table) {
            $table->id();
            $table->string('concept');
            $table->text('description');
            $table->text('document_src');
            $table->integer('condition_id');
            $table->integer('user_lender_id');
            $table->integer('user_taker_id');
            $table->integer('type_loan_id');
            $table->integer('loan_status_id');
            $table->boolean('is_deleted')->default(0);
            $table->date('limit_date');
            $table->timestamps();
        
            //referencias a la tabla de usuarios para la relacion
            $table->foreign('user_lender_id')->references('id')->on('users');
            $table->foreign('user_taker_id')->references('id')->on('users');
            $table->foreign('type_loan_id')->references('id')->on('penalties');
            $table->foreign('condition_id')->references('id')->on('conditions');
            $table->foreign('loan_status_id')->references('id')->on('conditions');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('loans');
    }
}
