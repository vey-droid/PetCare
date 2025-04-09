import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodTrackingScreen extends StatefulWidget {
  @override
  _FoodTrackingScreenState createState() => _FoodTrackingScreenState();
}

class _FoodTrackingScreenState extends State<FoodTrackingScreen> {
  final TextEditingController _foodController = TextEditingController();
  List<Map<String, String>> _foodlog = [];

  void _addFoodEntry() {
    if (_foodController.text.isNotEmpty) {
      setState(() {
        _foodlog.add({
          "food": _foodController.text,
          "time": DateFormat('hh:mm a, MMM d').format(DateTime.now()),
        });
      });
      _foodController.clear();
    }
  }

  void _deleteEntry(int index) {
    setState(() {
      _foodlog.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Tracking"),
        backgroundColor: Color(0xFF638C6D),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _foodController,
              decoration: InputDecoration(
                labelText: 'Enter Food Item',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addFoodEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDF6D2D),
              ),
              child: Text('Log Meal', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Text('Meal History:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _foodlog.length, // ✅ Fixed variable name
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFFE7FBB4),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(_foodlog[index]["food"]!), // ✅ Fixed variable name
                      subtitle: Text("Time: ${_foodlog[index]["time"]}"), // ✅ Fixed variable name
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Color(0xFFC84C05)),
                        onPressed: () => _deleteEntry(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
