import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:leaf_hub/pages/expenses_page.dart';
import 'package:leaf_hub/pages/home_page.dart';
import 'package:leaf_hub/pages/inventory_page.dart';
import 'package:image_picker/image_picker.dart';

import '../components/profile_box.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF10DA24),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () async {},
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                  backgroundImage: AssetImage('assets/profile_image.png'),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const ProfileBox(title: "Privacy Policy"),
            const SizedBox(height: 9),
            const ProfileBox(title: "Password"),
            const SizedBox(height: 9),
            const ProfileBox(title: "Profile"),
            const SizedBox(height: 9),
            const ProfileBox(title: "Settings"),
            const SizedBox(height: 9),
            const ProfileBox(title: "Theme"),
          ],
        ),
      ),

      //Navigation

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
