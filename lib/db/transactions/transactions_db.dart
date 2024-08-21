import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/model/transactions/transactions_model.dart';

const TRANSACTION_DB_NAME = 'transaction_db';

abstract class TransactionDBFunctions {
  Future<void> insertTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getallTransactions();
  Future<void> RefreshUI();
  Future<void> deleteTransaction(String id);
}

class TransactionsDB implements TransactionDBFunctions {
  TransactionsDB.internal(); //singleton.................................................
  static TransactionsDB instance = TransactionsDB.internal();
  factory TransactionsDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> list_transactions = ValueNotifier([]);

  @override
  Future<void> insertTransaction(TransactionModel transaction) async {
    final _transactiondb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactiondb.put(transaction.id, transaction);
    RefreshUI();
    // TODO: implement insertTransaction
    //throw UnimplementedError();
  }

  @override
  Future<List<TransactionModel>> getallTransactions() async {
    final _transactiondb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactiondb.values.toList();
    // TODO: implement getallTransactions
    //throw UnimplementedError();
  }

  @override
  Future<void> RefreshUI() async {
    final _transactiondb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    list_transactions.value.clear(); // TODO: implement RefreshUI
    list_transactions.value = _transactiondb.values.toList();
    list_transactions.value.sort(
      (a, b) {
        return (b.date.compareTo(a.date));
      },
    );
    list_transactions.notifyListeners();
    //throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _transactiondb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactiondb.delete(id);
    RefreshUI();
    // TODO: implement deleteTransaction
    //throw UnimplementedError();
  }
}
