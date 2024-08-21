//use abstract in OOP languages

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/model/category/category_model.dart';

const CATEGORY_DB_NAME = 'cat_db';

abstract class CategoryDBfunctions {
  Future<List<CategoryModel>> getallcategories();
  Future<void> insertcategories(CategoryModel value);
  Future<void> deletecategories(String cat_ID);
}

class CategoryDB implements CategoryDBfunctions {
  //To make a singleton object for CategoryDB
  CategoryDB.internal();
  static CategoryDB instance = CategoryDB.internal();
  factory CategoryDB() {
    //factory maintains only one CategoryDB object throughout the process
    return instance;
  }
  //singleton object

  ValueNotifier<List<CategoryModel>> income_cat_list = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expense_cat_list = ValueNotifier([]);

  @override
  Future<List<CategoryModel>> getallcategories() async {
    final catDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return catDb.values.toList();
    //throw UnimplementedError();
  }

  @override
  Future<void> insertcategories(CategoryModel value) async {
    final catDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await catDb.put(value.id,
        value); //use put for storing our key value to map and add to give auto incremented keys to map in db
    refreshUI();
    // TODO: implement insertcategories
    //throw UnimplementedError();
  }

  Future<void> refreshUI() async {
    final _all_cat = await getallcategories();
    income_cat_list.value.clear();
    expense_cat_list.value.clear();

    await Future.forEach(_all_cat, (CategoryModel category_ele) {
      if (category_ele.type == CategoryType.income) {
        income_cat_list.value.add(category_ele);
      } else {
        expense_cat_list.value.add(category_ele);
      }
      income_cat_list.notifyListeners();
      expense_cat_list.notifyListeners();
    });
  }

  @override
  Future<void> deletecategories(String id) async {
    final catDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await catDb.delete(id);
    refreshUI();
    // TODO: implement deletecategories
    //throw UnimplementedError();
  }
}
