import 'package:moneytrack/Constants/color.dart';
import 'package:moneytrack/data/utilty.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneytrack/domain/models/transaction_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  late List<Transaction> filteredTransactions;
  TextEditingController searchController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filterTransactions('', '', '', '');
  }

  void filterTransactions(String query, String day, String month, String year) {
    final box = Hive.box<Transaction>('transactions');
    
    filteredTransactions = box.values.where((transaction) {
      final matchesNotes = transaction.notes.toLowerCase().contains(query.toLowerCase());

      // Kiểm tra ngày tháng năm
      bool matchesDay = day.isEmpty || transaction.createAt.day.toString() == day;
      bool matchesMonth = month.isEmpty || transaction.createAt.month.toString() == month;
      bool matchesYear = year.isEmpty || transaction.createAt.year.toString() == year;

      return matchesNotes && matchesDay && matchesMonth && matchesYear;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Tìm kiếm'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  cursorColor: primaryColor,
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Tìm theo ghi chú',
                    labelStyle: const TextStyle(color: primaryColor),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      color: primaryColor,
                      onPressed: () {
                        searchController.clear();
                        dayController.clear();
                        monthController.clear();
                        yearController.clear();
                        filterTransactions('', '', '', '');
                        setState(() {});
                      },
                    ),
                  ),
                  onChanged: (value) {
                    filterTransactions(value, dayController.text, monthController.text, yearController.text);
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: dayController,
                        decoration: InputDecoration(
                          labelText: 'Ngày',
                          labelStyle: const TextStyle(color: primaryColor),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          filterTransactions(searchController.text, value, monthController.text, yearController.text);
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: monthController,
                        decoration: InputDecoration(
                          labelText: 'Tháng',
                          labelStyle: const TextStyle(color: primaryColor),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          filterTransactions(searchController.text, dayController.text, value, yearController.text);
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: yearController,
                        decoration: InputDecoration(
                          labelText: 'Năm',
                          labelStyle: const TextStyle(color: primaryColor),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          filterTransactions(searchController.text, dayController.text, monthController.text, value);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = filteredTransactions[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'images/${transaction.category.categoryImage}',
                      height: 40,
                    ),
                  ),
                  title: Text(
                    transaction.notes,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${transaction.createAt.day}/${transaction.createAt.month}/${transaction.createAt.year}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    formatCurrency(int.parse(transaction.amount)),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: transaction.type == 'Expense'
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
