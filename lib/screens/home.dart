import 'package:flutter/material.dart';
import 'apmt.dart';
import 'food.dart';
import 'medical.dart';
import 'weight.dart';
import 'profile.dart';
import 'info.dart'; // Add this import


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeContent(), // Main Home Content
    ProfileScreen(), // Profile Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7FBB4),
      appBar: AppBar(
        title: const Text('Welcome Pet!'),
        backgroundColor: const Color(0xFF638C6D),
      ),
      body: _screens[_selectedIndex], // Changes content based on tab
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF638C6D),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Separated Home Content for better structure
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Access',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF638C6D),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                _buildFeatureCard('Appointments', Icons.calendar_today, context, AppointmentsScreen()),
                _buildFeatureCard('Medical Records', Icons.medical_services, context, MedicalRecordsScreen()),
                _buildFeatureCard('Weight Tracking', Icons.monitor_weight, context, WeightTrackingScreen()),
                _buildFeatureCard('Food Tracking', Icons.pets, context, FoodTrackingScreen()),
                _buildFeatureCard('Pet Breed Info', Icons.info, context, PetBreedInfoScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to build feature cards and handle navigation
  static Widget _buildFeatureCard(String title, IconData icon, BuildContext context, Widget targetScreen) {
    return Card(
      color: const Color(0xFFDF6D2D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
