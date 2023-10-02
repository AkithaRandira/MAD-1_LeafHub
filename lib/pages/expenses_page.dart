import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:leaf_hub/google_sheets_api.dart';
import 'package:leaf_hub/pages/home_page.dart';
import 'package:leaf_hub/pages/profile_page.dart';
import 'package:leaf_hub/pages/inventory_page.dart';
import 'package:leaf_hub/plus_button.dart';
import 'package:leaf_hub/top_card.dart';
import 'package:leaf_hub/transaction.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  //wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (Timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        Timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Start loading until the data arrives
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF10DA24),
        title: const Text(
          "Income/Expenses",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TopNeuCard(
              balance: '\ 20,000',
              income: '\100',
              expense: '\50',
            ),
            Expanded(
              child: Container(
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount:
                                GoogleSheetsApi.currentTransactions.length,
                            itemBuilder: (context, index) {
                              return MyTransaction(
                                transactionName: GoogleSheetsApi
                                    .currentTransactions[index][0],
                                money: GoogleSheetsApi
                                    .currentTransactions[index][1],
                                expenseOrIncome: GoogleSheetsApi
                                    .currentTransactions[index][2],
                              );
                            }))
                  ],
                )),
              ),
            ),
            PlusButton(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF10DA24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Color(0xFF10DA24),
            color: Color.fromARGB(255, 255, 255, 255),
            tabBackgroundColor: Colors.green.shade400,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                gap: 10,
                icon: Icons.home,
                text: 'Home',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              GButton(
                gap: 10,
                icon: Icons.account_balance_wallet,
                text: 'Inventory',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InventoryPage()),
                  );
                },
              ),
              GButton(
                gap: 10,
                icon: Icons.monetization_on_outlined,
                text: 'Expenses',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExpensesPage()),
                  );
                },
              ),
              GButton(
                gap: 10,
                icon: Icons.person,
                text: 'Profile',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
