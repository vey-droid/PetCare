import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      if (snapshot.exists) {
        setState(() {
          userData = snapshot.data() as Map<String, dynamic>;
        });
      }
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7FBB4),
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF638C6D),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // FIX OVERFLOW
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 8,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF638C6D),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  _profileDetail('Name', userData?['name'] ?? 'Not Set'),
                  _profileDetail('Email', userData?['email'] ?? 'Not Set'),
                  _profileDetail('Pet\'s Name', userData?['petName'] ?? 'Not Set'),
                  _profileDetail('Pet\'s Breed', userData?['petBreed'] ?? 'Not Set'),
                  _profileDetail('Pet\'s Age', userData?['petAge'] ?? 'Not Set'),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _logout,
                    icon: Icon(Icons.logout, color: Colors.white),
                    label: Text('Logout', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDF6D2D),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileDetail(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF638C6D))),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
