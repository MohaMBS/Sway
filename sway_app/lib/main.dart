import 'package:flutter/material.dart';
import 'package:sway_app/bloc/formProvider.dart';
import 'package:sway_app/bloc/services/authService.dart';
import 'package:sway_app/views/app/dashboard.dart';
import 'package:sway_app/views/auth/login.dart';
import 'package:sway_app/views/auth/register.dart';
import 'package:sway_app/views/auth/resetPassword.dart';
import 'package:sway_app/views/welcome/welcome.dart';


void main() {
  //runApp(const DashboardV());
  runApp(FromProvider(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Welcome back to Sway",
      //initialRoute: '/login',
      home: FutureBuilder(
        future: AuthService.getToken(),
        builder:(_, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }else if( snapshot.hasData){
            return const Dashboard();
          }else{
            return const LoginScreen();
          }
        }, 
        ),
      routes: {
        '/':(context) => const Welcome(),
        '/login':(context) => const LoginScreen(),
        '/dashboard'  :(context) =>const DashboardV(),
        '/register': ((context) =>const Register()),
        '/reset_password': ((context) =>const ResetPassword())
      },
    ),
  ));
}
