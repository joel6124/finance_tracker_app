import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transactions/transactions_db.dart';
import 'package:money_management_app/model/category/category_model.dart';
import 'package:money_management_app/model/transactions/transactions_model.dart';

/*
purpose
date
amount
income/expense
category type
*/

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  DateTime? selecteddate;
  CategoryType? selectedtype;
  String? selected_cat_ID;
  CategoryModel? _selectedCatModel;

  final _purposecontroller = TextEditingController();
  final _amtcontroller = TextEditingController();
  @override
  void initState() {
    selectedtype = CategoryType.income;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
        centerTitle: false,
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _purposecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Purpose',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _amtcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Amount',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                onPressed: () async {
                  final _selected_date_temp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (_selected_date_temp == null) {
                    return;
                  } else {
                    //for statefull widget
                    setState(() {
                      selecteddate = _selected_date_temp;
                    });
                  }
                },
                icon: Icon(Icons.calendar_today),
                label: Text(
                  //tertiary operator
                  selecteddate == null
                      ? 'Select the Date'
                      : selecteddate.toString(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: selectedtype,
                        onChanged: (value) {
                          setState(() {
                            selectedtype = CategoryType.income;
                          });
                        },
                      ),
                      Text('Income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType
                            .expense, //only if value and groupvalue matches the blue hole will be coloured else no
                        groupValue: selectedtype,
                        onChanged: (value) {
                          setState(() {
                            selectedtype = CategoryType.expense;
                            selected_cat_ID =
                                null; //vey important step to make it as null to reload the UI and ask for selction of category again
                          });
                        },
                      ),
                      Text('Expense'),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                value:
                    selected_cat_ID, //IF VALUE selected_cat_ID IS NULL THE ITLL SHOW ONLY THE HINT ELSE IT WILL COMAPRE IF ID IS PRESENT IN ANY ELEMNT IN THE DROPDOEN
                hint: Text('Select the Category'),
                items: (selectedtype == CategoryType.income
                        ? CategoryDB.instance.income_cat_list
                        : CategoryDB.instance.expense_cat_list)
                    .value //map func is used to create a drop down menu class from the CategoryModel to DropDown Class
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedCatModel = e;
                    },
                  );
                }).toList(),
                onChanged: (selected_value) {
                  setState(() {
                    selected_cat_ID = selected_value;
                  });
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                AddTranscation();
              },
              icon: Icon(Icons.check),
              label: Text('Submit'),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> AddTranscation() async {
    final _purpose = _purposecontroller.text;
    final _amount = _amtcontroller.text;
    if (_purpose.isEmpty ||
        _amount.isEmpty ||
        selected_cat_ID == null ||
        selecteddate == null) {
      return;
    }
    final _amt = double.tryParse(_amount);
    if (_amt == null) {
      return;
    }
    final transaction = TransactionModel(
        purpose: _purpose,
        amount: _amt,
        date: selecteddate!,
        cat_type: selectedtype!,
        category: _selectedCatModel!);
    TransactionsDB.instance.insertTransaction(transaction);
    Navigator.of(context).pop();
  }
}
