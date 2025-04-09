import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class MedicalRecordsScreen extends StatefulWidget {
  @override
  _MedicalRecordsScreenState createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  List<Map<String, String>> _medicalRecords = [];

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _medicalRecords.add({
          "name": result.files.single.name,
          "path": file.path,
        });
      });
    }
  }

  void _deleteFile(int index) {
    setState(() {
      _medicalRecords.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Records"),
        backgroundColor: Color(0xFF638C6D),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDF6D2D),
              ),
              child: Text("Upload Document", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Text("Uploaded Documents:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _medicalRecords.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFFE7FBB4),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(_medicalRecords[index]["name"]!),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Color(0xFFC84C05)),
                        onPressed: () => _deleteFile(index),
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
