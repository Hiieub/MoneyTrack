import 'package:easy_localization/easy_localization.dart';
import 'package:moneytrack/domain/models/category_model.dart';

List<CategoryModel> createDefaultIncomeCategories() {
  return [
    CategoryModel("Salary".tr(), 'Salary.png', 'Income'),
    CategoryModel("Gifts".tr(), 'Gifts.png', 'Income'),
    CategoryModel("Investments".tr(), 'Investments.png', 'Income'),
    CategoryModel("Rentals".tr(), 'Rentals.png', 'Income'),
    CategoryModel("Savings".tr(), 'Savings.png', 'Income'),
    CategoryModel("Others Income".tr(), 'Others.png', 'Income'),
  ];
}

List<CategoryModel> createDefaultExpenseCategories() {
  return [
    CategoryModel("Food".tr(), 'Food.png', 'Expense'),
    CategoryModel("Transportation".tr(), 'Transportation.png', 'Expense'),
    CategoryModel("Education".tr(), 'Education.png', 'Expense'),
    CategoryModel("Bills".tr(), 'Bills.png', 'Expense'),
    CategoryModel("Travels".tr(), 'Travels.png', 'Expense'),
    CategoryModel("Pets".tr(), 'Pets.png', 'Expense'),
    CategoryModel("Tax".tr(), 'Tax.png', 'Expense'),
    CategoryModel("Others Expense".tr(), 'Others.png', 'Expense'),
  ];
}
