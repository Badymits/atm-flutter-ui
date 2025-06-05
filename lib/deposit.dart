// ignore: file_names
import 'package:flutter/material.dart';
import 'package:atm_ui_activity_2/main.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage>{

  final TextEditingController _amountController = TextEditingController();

  String selectedAccount = 'Balance';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Deposit Page',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Change the title color
          ),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the color of the back button
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Center(
                child: Card(
                  color: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Current Balance: ${selectedAccount == "Balance" ? formattedBalance : formattedSavings}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Change the text color
                          ),
                        ),
                      ],
                    ),
                  ),
                )   
              )
            ),
            DropdownButton<String>(
              value: selectedAccount,
              items:['Balance', 'Savings'].map(( String value ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) => setState(() => selectedAccount = newValue!),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter amount",
                contentPadding: const EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              )
            )
          ],
        )
       
      ),
    );
  }

}