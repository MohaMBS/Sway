import 'package:flutter/material.dart';

class LoanCenter extends StatefulWidget {
  const LoanCenter({ Key? key }) : super(key: key);

  @override
  State<LoanCenter> createState() => _LoanCenterState();
}

class _LoanCenterState extends State<LoanCenter> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('LoanCenter'),
      ),
    );
  }
}