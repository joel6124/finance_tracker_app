import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/model/category/category_model.dart';

ValueNotifier<CategoryType> selected_cat = ValueNotifier(CategoryType.income);
final _cat_name = TextEditingController();

Future<void> ShowCatAddPopUp(BuildContext context) async {
  showDialog(
    context: context,
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SimpleDialog(
          title: Text('Add Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _cat_name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Category Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_cat_name.text.isEmpty) {
                    return;
                  }
                  final _samp = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _cat_name.text,
                    type: selected_cat.value,
                  );
                  CategoryDB().insertcategories(_samp);
                  Navigator.of(ctx).pop();
                },
                child: Text('Add'),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  //final CategoryType current_type;
  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selected_cat,
          builder: (context, value, child) {
            return Radio<CategoryType>(
              value: type, //value: actual value of radio button
              groupValue: selected_cat
                  .value, //groupvalue: current value of radio button
              onChanged: (value) {
                print(value);
                if (value == null) {
                  return;
                }
                selected_cat.value = value;
                selected_cat.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
