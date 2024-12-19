import 'package:flutter/material.dart';
import 'package:sornaka/home.dart';

class SetGoalPage extends StatefulWidget {
  @override
  _SetGoalPageState createState() => _SetGoalPageState();
}

class _SetGoalPageState extends State<SetGoalPage> {
  final _weightController = TextEditingController();
  final _daysController = TextEditingController();
  final _hoursController = TextEditingController();
  final _workoutDaysController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    _daysController.dispose();
    _hoursController.dispose();
    _workoutDaysController.dispose();
    super.dispose();
  }

  Widget _buildInputField(String question, TextEditingController controller, String hint) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.grey[850],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.deepOrange],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/fitness.png'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Set Your Goal!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'We will create your fitness plan',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildInputField(
                  'What is your prefer weight to reduce?',
                  _weightController,
                  'Enter weight in kg'
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  'How many days you plan to workout?',
                  _daysController,
                  'Enter number of days'
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  'How much hours you can spent for a day?',
                  _hoursController,
                  'Enter hours per day'
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  'How many days you plan to workout?',
                  _workoutDaysController,
                  'Enter workout days'
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Center(
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}