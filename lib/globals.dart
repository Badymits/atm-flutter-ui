double balance = 35000.0;
double savings = 25000.0;

String selectedAccount = "Balance";

class UserAccount {
  String userName;
  double balance;
  String accountNumber;

  UserAccount({
    required this.userName,
    required this.balance,
    required this.accountNumber,
  });
}

List<UserAccount> userAccounts = [
  UserAccount(userName: "Alice", balance: 35000.0, accountNumber: "1234567890"),
  UserAccount(userName: "Bob", balance: 25000.0, accountNumber: "0987654321"),
];
