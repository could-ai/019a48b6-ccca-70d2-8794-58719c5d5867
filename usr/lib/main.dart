import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chair Occupancy Detector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const OccupancyHomePage(),
    );
  }
}

class OccupancyHomePage extends StatefulWidget {
  const OccupancyHomePage({super.key});

  @override
  State<OccupancyHomePage> createState() => _OccupancyHomePageState();
}

class _OccupancyHomePageState extends State<OccupancyHomePage> {
  bool _analysisComplete = false;

  void _startAnalysis() {
    // In a real app, this would trigger file selection and video processing.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Starting analysis... This will take a few moments.'),
        duration: Duration(seconds: 3),
      ),
    );

    // Simulate processing time.
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _analysisComplete = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Analysis complete! You can now view the results.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  void _viewResults() {
    // In a real app, this would navigate to a results screen.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Analysis Results'),
        content: const Text('This is where the 6-panel comprehensive visualization with the Eagle Eye overlay would be displayed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Chair Occupancy Detector'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Comprehensive Visualization',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'This application provides a comprehensive visualization for chair occupancy detection, including:',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Live Webcam Feed Processing'),
              ),
              const ListTile(
                leading: Icon(Icons.movie),
                title: Text('Video File Analysis'),
              ),
              const ListTile(
                leading: Icon(Icons.grid_on),
                title: Text('6-Panel Comprehensive View'),
              ),
               const ListTile(
                leading: Icon(Icons.visibility),
                title: Text('Eagle Eye Tactical Overlay for accuracy'),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _startAnalysis,
                icon: const Icon(Icons.upload_file),
                label: const Text('Select Video & Start Analysis'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _analysisComplete ? _viewResults : null,
                icon: const Icon(Icons.remove_red_eye),
                label: const Text('View Analysis Results'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  disabledBackgroundColor: Colors.grey.shade300,
                  disabledForegroundColor: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
