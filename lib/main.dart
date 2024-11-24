import 'views/home.dart';
import 'views/thoughts.dart';
import 'views/tasks.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';
import 'package:fl_chart/fl_chart.dart';

class DataPointsProvider with ChangeNotifier {
  List<int> _dataPoints = [];
  List<int> get dataPoints => _dataPoints;
  void addDataPoint(int point) {
    _dataPoints.add(point);
    notifyListeners(); // Notify views to rebuild
  }
}



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_)=> DataPointsProvider(),
      child: MyApp()
    )
  );
}

// Define reusable constants
const double phoneWidth   =  400;
const double phoneHeight  =  800;
const double phoneMargins =   50; 
const double viewHeight   =   720;
const double navBarHeight = phoneHeight - viewHeight;
const double navBarFontSize = 12;
const double navBarMargins = 15;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First Phone
              PhoneContainer(
                color: Colors.blueAccent,
                views: [
                  HomeView(),
                  ThoughtsView(),
                  TasksView(),
                ],
              ),
              // Second Phone
              const PhoneContainer(
                color: Colors.greenAccent,
                views: [
                  Center(child: Text('Notifications View', style: viewTextStyle)),
                  Center(child: Text('', style: viewTextStyle)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define a common text style for views
const TextStyle viewTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 16,
);

// Reusable widget for the phone container
class PhoneContainer extends StatefulWidget {
  final Color color;
  final List<Widget> views;

  const PhoneContainer({
    super.key,
    required this.color,
    required this.views,
  });

  @override
  State<PhoneContainer> createState() => _PhoneContainerState();
}

class _PhoneContainerState extends State<PhoneContainer> {
  int _currentIndex = 0; // Track the currently selected view

  @override
  Widget build(BuildContext context) {
    return Container(
      width: phoneWidth,
      height: phoneHeight,
      color: widget.color,
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Display the current view based on _currentIndex
          Expanded(
            child: widget.views[_currentIndex],
          ),
          // Bottom Navigation Bar
          SizedBox(
            height: navBarHeight, // Fixed height for the bottom navigation bar
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.lightbulb),
                  label: 'Thoughts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: 'Tasks',
                ),
              ],
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index; // Update the view based on the tap
                });
              },
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              backgroundColor: widget.color,
            ),
          ),
        ],
      ),
    );
  }
}
