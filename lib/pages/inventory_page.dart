import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:leaf_hub/pages/expenses_page.dart';
import 'package:leaf_hub/pages/home_page.dart';
import 'package:leaf_hub/pages/profile_page.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<String> inventoryItems = [
    "Tea Leaves",
    "Tea Bags",
    "Tea Powder",
    "Tea Accessories",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF10DA24),
        title: const Text(
          "Inventory Management",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Inventory Items",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: inventoryItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(inventoryItems[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Add functionality to edit inventory items
                        _editInventoryItem(index);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255,
                    255), // Set the background color of the container to green
                borderRadius:
                    BorderRadius.circular(50.0), // Adjust the radius as needed
              ), // Set the background color of the container to green
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality to add new inventory items
                  _addInventoryItem();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF10DA24),
                ),
                child: const Center(
                    child: Text(
                  "Add Inventory Item",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF10DA24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: const Color(0xFF10DA24),
            color: const Color.fromARGB(255, 255, 255, 255),
            tabBackgroundColor: Colors.green.shade400,
            padding: const EdgeInsets.all(16),
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
              const GButton(
                gap: 10,
                icon: Icons.account_balance_wallet,
                text: 'Inventory',
              ),
              GButton(
                gap: 10,
                icon: Icons.monetization_on_outlined,
                text: 'Expenses',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpensesPage()),
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
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addInventoryItem() {
    // Add logic to add a new inventory item
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Inventory Item"),
          content: const TextField(
            decoration: InputDecoration(
              labelText: "Item Name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Add functionality to save the new inventory item
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _editInventoryItem(int index) {
    // Add logic to edit an existing inventory item
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Inventory Item"),
          content: TextField(
            decoration: const InputDecoration(
              labelText: "Item Name",
            ),
            controller: TextEditingController(text: inventoryItems[index]),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Add functionality to save the edited inventory item
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
