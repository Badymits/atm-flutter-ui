// ignore: file_names
import 'package:flutter/material.dart';
import 'package:atm_ui_activity_2/main.dart' as main;
import 'package:atm_ui_activity_2/globals.dart' as globals;

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final TextEditingController _amountController = TextEditingController();

  bool _isAmountConfirmed = false;

  void subtractAmountToBalance(double amount) {
    print("Subtract $amount to balance");
    globals.balance -= amount;
  }

  void subtractAmountToSavings(double amount) {
    globals.savings -= amount;
  }

  void showDepositDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Withdraw"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  bool _isAmountExceedsBalance() {
    double? enteredAmount = double.tryParse(_amountController.text);
    if (enteredAmount == null) return false;

    double currentBalance = globals.selectedAccount == "Balance"
        ? globals.balance
        : globals.savings;

    return enteredAmount > currentBalance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Withdraw Page',
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
                        Text(
                          "Current Balance: ${globals.selectedAccount == "Balance" ? main.formattedBalance : main.formattedSavings}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Change the text color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            DropdownButton<String>(
              value: globals.selectedAccount,
              items: ['Balance', 'Savings'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) =>
                  setState(() => globals.selectedAccount = newValue!),
            ),

            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter amount to withdraw",
                hintText: "Enter amount",
                contentPadding: const EdgeInsets.all(16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),

            Builder(
              builder: (context) {
                if (_amountController.text.isNotEmpty) {
                  double? enteredAmount = double.tryParse(
                    _amountController.text,
                  );
                  double currentAmount = globals.selectedAccount == "Balance"
                      ? globals.balance
                      : globals.savings;
                  if (enteredAmount != null && enteredAmount > currentAmount) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Amount cannot exceed your ${globals.selectedAccount.toLowerCase()} balance.",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),

            Row(
              children: [
                Checkbox(
                  value: _isAmountConfirmed,
                  onChanged: _isAmountExceedsBalance()
                      ? null // Disable checkbox if amount exceeds balance
                      : (bool? value) {
                          setState(() {
                            _isAmountConfirmed = value ?? false;
                          });
                        },
                  // onChanged: (bool? value) {
                  //   setState(() {
                  //     _isAmountConfirmed = value ?? false;
                  //   });
                  // },
                ),
                const Text("The amount that I entered is correct"),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isAmountConfirmed
                    ? () {
                        // Deposit logic here
                        if (globals.selectedAccount == "Balance") {
                          subtractAmountToBalance(
                            double.parse(_amountController.text),
                          );
                        } else if (globals.selectedAccount == "Savings") {
                          subtractAmountToSavings(
                            double.parse(_amountController.text),
                          );
                        }
                        showDepositDialog("Withdraw successful!");
                        _amountController.clear();
                        setState(() {});
                      }
                    : null,
                child: const Text("Withdraw"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
