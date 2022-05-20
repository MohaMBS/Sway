import 'package:flutter/material.dart';

class HomeDas extends StatefulWidget {
  const HomeDas({ Key? key }) : super(key: key);

  @override
  State<HomeDas> createState() => _HomeDasState();
}

class _HomeDasState extends State<HomeDas> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}