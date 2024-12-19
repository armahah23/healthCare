import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DailyPlanPage(),
  ));
}

class DailyPlanPage extends StatefulWidget {
  @override
  _DailyPlanPageState createState() => _DailyPlanPageState();
}

class _DailyPlanPageState extends State<DailyPlanPage> {
  // List to track switch states
  List<bool> taskSwitches = List.generate(9, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section with Back Button and Profile Avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      // Handle back button press
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Daily plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/fitness.png'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Task List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: taskSwitches.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.shade900.withOpacity(0.6),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Task Text
                        Expanded(
                          child: Text(
                            '${index + 1}. ${_tasks[index]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Toggle Switch
                        Switch(
                          value: taskSwitches[index],
                          activeColor: Colors.orange,
                          onChanged: (value) {
                            setState(() {
                              taskSwitches[index] = value;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  // Add functionality for progress button
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepOrangeAccent, Colors.orange],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'See your progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Task descriptions
  final List<String> _tasks = [
    "Workout for 1 hour",
    "Drink warm water 30 minutes before and after meal",
    "Drink green tea 2 times daily",
    "Eat less and slowly",
    "Walk 20 minutes after dinner",
    "Have fruit in the morning",
    "Avoid fast food",
    "Add more protein in your diet",
    "Eliminate sugary drinks",
  ];
}
