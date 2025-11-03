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

class OccupancyHomePage extends StatelessWidget {
  const OccupancyHomePage({super.key});

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
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  // In a real app, this would trigger the video processing
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Processing would start in a real application.'),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Analysis'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
