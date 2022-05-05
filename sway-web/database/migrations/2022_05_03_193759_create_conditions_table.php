<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateConditionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('conditions', function (Blueprint $table) {
            $table->id();
            $table->text('description');
            $table->text('document_src')->nullable();
            $table->integer('loan_id');
            $table->integer('condition_type_id');
            $table->timestamps();

            //referencias a la tabla de usuarios para la relacion
            $table->foreign('loan_id')->references('id')->on('loans');
            $table->foreign('condition_type_id')->references('id')->on('conditions');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('conditions');
    }
}
