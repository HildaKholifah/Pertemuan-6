import 'package:moneyappsqllite/data/db/transaction_dao.dart';
import 'package:moneyappsqllite/data/model/transaction.dart';

class TransactionRepository {
  final transactionDao = TransactionDao();

  Future<int> insertTransaction(Transaction transaction) async {
    return await transactionDao.insertTransaction(transaction);
  }

  Future<List<Transaction>> getAllTransaction() async {
    return await transactionDao.getAllTransaction();
  }

  Future<double> getBalance() async {
    return await transactionDao.getBalance();
  }

  Future<int> updateTransactions(int id, Transaction transaction) async {
    return await transactionDao.updateTransactions(id, transaction);
  }

  Future<int> deleteTransaction(int id) async {
    return await transactionDao.deleteTransaction(id);
  }

  Future<double> getIncome() async {
    return await transactionDao.getIncome();
  }

  Future<double> getExpense() async {
    return await transactionDao.getExpense();
  }
}