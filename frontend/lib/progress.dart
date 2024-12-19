import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home.dart';
import './Models/Exercise.dart';

class WorkoutProgressPage extends StatefulWidget {
  @override
  _WorkoutProgressPageState createState() => _WorkoutProgressPageState();
}

class _WorkoutProgressPageState extends State<WorkoutProgressPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? scheduleData;
  int selectedDayIndex = 0;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadScheduleData();
  }

  Future<void> loadScheduleData() async {
    try {
      final response = await http.get(
        Uri.parse('https://fitnessschedule.s3.us-east-1.amazonaws.com/schedule.json'),
      );

      if (response.statusCode == 200) {
        setState(() {
          scheduleData = json.decode(response.body);
          isLoading = false;
          errorMessage = null;
        });
      } else {
        throw Exception('Failed to load schedule data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load workout data. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingScreen();
    }

    if (errorMessage != null) {
      return _buildErrorScreen();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildDaySelector(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildWorkoutList('weightLoss'),
                  _buildWorkoutList('weightGain'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(color: Colors.orange),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(
              errorMessage!,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  errorMessage = null;
                });
                loadScheduleData();
              },
              child: Text('Retry'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade400, Colors.deepOrange.shade600],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  ),
                ),
                Text(
                  'Workout Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Weight Loss'),
              Tab(text: 'Weight Gain'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => setState(() => selectedDayIndex = index),
            child: Container(
              width: 80,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: selectedDayIndex == index ? Colors.orange : Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Day ${index + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWorkoutList(String type) {
    if (scheduleData == null) return Container();
    
    final exercises = scheduleData!['fitnessApp']['exercises'][type]['schedule']
        [selectedDayIndex]['exercises'] as List;
    
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final exercise = Exercise.fromJson(exercises[index]);
        return _buildExerciseCard(exercise);
      },
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.orange.withOpacity(0.2),
                  child: Icon(Icons.fitness_center, color: Colors.orange),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Reps: ${exercise.reps} | Duration: ${exercise.duration}',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.play_circle_fill, color: Colors.orange),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 12),
            LinearProgressIndicator(
              value: 0.0,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}