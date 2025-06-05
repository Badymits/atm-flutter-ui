// ignore: file_names
import 'package:flutter/material.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depositaaaaaaaaa'),
      ),
      body: Center(
        child: Text(
          'Deposit Page',
          
        ),
      ),
    );
  }

}