import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_hifi_prototype/main.dart';
import 'package:provider/provider.dart';



class HomeView extends StatelessWidget {
  const HomeView({super.key});
  
  @override 
  Widget build(BuildContext context) {
    var datapoints = Provider.of<DataPointsProvider>(context).dataPoints;
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          Expanded(child: DynamicChart(),)
        ],
      ),
    );
  }
}

class DynamicChart extends StatefulWidget {
  @override
  _DynamicChartState createState() => _DynamicChartState();
}

class _DynamicChartState extends State<DynamicChart> {
  List<FlSpot> _dataPoints = [FlSpot(0, 1), FlSpot(1, 2), FlSpot(2, 3)];

  void _addDataPoint() {
    setState(() {
      final lastX = _dataPoints.isNotEmpty ? _dataPoints.last.x : 0;
      _dataPoints.add(FlSpot(lastX + 1, (lastX + 1) * 2)); // Example formula
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mental Load Distribution')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: _dataPoints,
                isCurved: true,
                barWidth: 4,
                //colors: [Colors.blue],
              ),
            ],
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: true),
          ),
        ),
      ),
      
    );
  }
}