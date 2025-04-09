import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Calendar package

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>{
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<String>> _appointments = {};

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: Color(0xFF638C6D),
      ),
      backgroundColor: Color(0xFFE7FBB4),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //next appt
            Text(
               'Next Appointment: ${_getNextAppointment()}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFDF6D2D),
            ),
            ),
            SizedBox(height: 10),

             TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
                _showAddAppointmentDialog(selectedDay);
              },
              eventLoader: (day) => _appointments[day] ?? [],
            ),
          ],
        ), 
      ),
    );
  }
  String _getNextAppointment(){
    if(_appointments.isEmpty) return "None";
    List<DateTime> sortedDates = _appointments.keys.toList()
    ..sort((a, b) => a.compareTo(b));
    for(var date in sortedDates) {
      if(date.isAfter(DateTime.now())){
        return "${date.toLocal()} - ${_appointments[date]!.join((" , "))}";
      }
    }
    return "None";
  }
  void _showAddAppointmentDialog(DateTime selectedDate){
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("New Appointment"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter Appointment Details"),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
             child: Text("Cancel")
             ),
             TextButton(
              onPressed: (){
                if(_controller.text.isNotEmpty){
                  setState(() {
                      _appointments[selectedDate] ??= [];
                    _appointments[selectedDate]!.add(_controller.text);
                  });
                }
                 Navigator.pop(context);
              },
              child: Text("Save"),
             ),
          ],
        );
      }
    );
  }
}