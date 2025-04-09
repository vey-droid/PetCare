import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class PetDetailsScreen extends StatefulWidget {
  final String userId;

  const PetDetailsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _PetDetailsScreenState createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petBreedController = TextEditingController();
  final TextEditingController _petAgeController = TextEditingController();
  bool _isLoading = false;
  bool _isVerified = false;

  @override
  void initState() {
    super.initState();
    _checkEmailVerification();
  }

  /// Function to check if the email is verified
  Future<void> _checkEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload(); // Refresh user status
    setState(() {
      _isVerified = user?.emailVerified ?? false;
    });

    if (!_isVerified) {
      _sendVerificationEmail();
    }
  }

  /// Function to send a verification email
  Future<void> _sendVerificationEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification email sent! Please check your inbox.')),
      );
    }
  }

  /// Function to save pet details to Firestore
  Future<void> _savePetDetails() async {
    if (!_isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please verify your email before proceeding!')),
      );
      return;
    }

    String petName = _petNameController.text.trim();
    String petBreed = _petBreedController.text.trim();
    String petAge = _petAgeController.text.trim();

    if (petName.isEmpty || petBreed.isEmpty || petAge.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(petAge)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid pet age')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('pets').doc(widget.userId).set({
        'petName': petName,
        'petBreed': petBreed,
        'petAge': petAge,
        'userId': widget.userId,
        'createdAt': Timestamp.now(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save pet details: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
        backgroundColor: Color(0xFF638C6D),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isVerified)
              Column(
                children: [
                  Text(
                    'Please verify your email before continuing!',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _sendVerificationEmail,
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFC84C05)),
                    child: Text('Resend Verification Email', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            SizedBox(height: 20),
            TextField(
              controller: _petNameController,
              decoration: InputDecoration(labelText: 'Pet Name', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _petBreedController,
              decoration: InputDecoration(labelText: 'Pet Breed', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _petAgeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Pet Age', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _savePetDetails,
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFDF6D2D)),
                    child: Text('Save & Continue', style: TextStyle(color: Colors.white)),
                  ),
          ],
        ),
      ),
    );
  }
}
