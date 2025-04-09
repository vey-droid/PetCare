import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeightTrackingScreen extends StatefulWidget {
  @override
  _WeightTrackingScreenState createState() => _WeightTrackingScreenState();
}

class _WeightTrackingScreenState extends State<WeightTrackingScreen> {
  final TextEditingController _weightController = TextEditingController();
  List<Map<String, String>> _weightLog = [];

  void _addWeightEntry() {
    if (_weightController.text.isNotEmpty) {
      setState(() {
        _weightLog.add({
          "weight": _weightController.text + " kg",
          "time": DateFormat('hh:mm a, MMM d').format(DateTime.now()),
        });
      });
      _weightController.clear();
    }
  }

  void _deleteEntry(int index) {
    setState(() {
      _weightLog.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weight Tracking"),
        backgroundColor: Color(0xFF638C6D),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addWeightEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDF6D2D),
              ),
              child: Text('Log Weight', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Text('Weight History:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _weightLog.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFFE7FBB4),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(_weightLog[index]["weight"]!),
                      subtitle: Text("Time: ${_weightLog[index]["time"]}"),
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
