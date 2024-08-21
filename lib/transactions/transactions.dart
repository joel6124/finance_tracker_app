import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transactions/transactions_db.dart';
import 'package:money_management_app/model/category/category_model.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  void initState() {
    TransactionsDB.instance.RefreshUI();
    CategoryDB.instance.refreshUI();
    //final transac = TransactionsDB.instance.getallTransactions();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionsDB.instance.list_transactions,
      builder: (context, updated_transaction_list, child) {
        return ListView.separated(
            itemBuilder: (BuildContext ctx, int index) {
              final transac = updated_transaction_list[index];
              return Slidable(
                key: Key(transac.id!),
                startActionPane: ActionPane(
                  motion: DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionsDB.instance.deleteTransaction(transac.id!);
                      },
                      icon: (Icons.delete),
                      label: 'Delete',
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          parseDate(transac.date),
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        radius: 100,
                        backgroundColor: transac.cat_type == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text('Rs ${transac.amount}'),
                      subtitle: Text('${transac.category.name}'),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return Divider(
                thickness: 2,
              );
            },
            itemCount: updated_transaction_list.length);
      },
    );
  }

  String parseDate(DateTime date) {
    final dt = DateFormat.MMMd().format(date);
    final _splitteddate = dt.split(' ');
    return '${_splitteddate.last}\n${_splitteddate.first}';
    //return '${date.day}\n${date.month}';
  }
}
