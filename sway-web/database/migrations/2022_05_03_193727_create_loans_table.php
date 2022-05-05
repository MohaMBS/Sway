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
            $table->text('document_src')->nullable();
            $table->integer('user_from_id');
            $table->integer('user_to_id');
            $table->integer('condition_id');
            $table->integer('type_loan_id');
            $table->integer('loan_status_id');
            $table->integer('penalty_id')->nullable();
            $table->boolean('is_deleted')->default(0);
            $table->date('limit_date')->nullable();
            $table->timestamps();
        
            //referencias a la tabla de usuarios para la relacion
            $table->foreign('user_from_id')->references('id')->on('users');
            $table->foreign('user_to_id')->references('id')->on('users');
            $table->foreign('type_loan_id')->references('id')->on('loan_types');
            $table->foreign('penalty_id')->references('id')->on('penalties');
            $table->foreign('condition_id')->references('id')->on('conditions');
            $table->foreign('loan_status_id')->references('id')->on('loan_statuses');
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
