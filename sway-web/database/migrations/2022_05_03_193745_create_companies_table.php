<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCompaniesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('companies', function (Blueprint $table) {
            $table->id();
            $table->string('cif',12)->unique();
            $table->integer('user_id');
            $table->text('fix_number',15);
            $table->text('address');
            $table->text('city');
            $table->text('pc');
            $table->text('country');
            $table->boolean('is_deleted')->default(0);
            $table->timestamps();
        
            //referencias a la tabla de usuarios para la relacion
            $table->foreign('user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('companies');
    }
}
