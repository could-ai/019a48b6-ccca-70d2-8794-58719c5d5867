import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:couldai_user_app/screens/results_screen.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
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
  bool _isProcessing = false;
  bool _analysisComplete = false;
  File? _selectedVideoFile;
  String? _selectedFileName;

  Future<void> _pickAndProcessVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedVideoFile = File(result.files.single.path!);
        _selectedFileName = result.files.single.name;
        _isProcessing = true;
        _analysisComplete = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Starting analysis on $_selectedFileName... This will take a few moments.'),
          duration: const Duration(seconds: 3),
        ),
      );

      // Simulate processing time.
      await Future.delayed(const Duration(seconds: 5));

      if (mounted) {
        setState(() {
          _isProcessing = false;
          _analysisComplete = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Analysis complete! You can now view the results.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No video selected.'),
        ),
      );
    }
  }

  void _viewResults() {
    if (_selectedVideoFile == null) return;
    // In a real app, you would pass the path to the processed video.
    // Here, we pass a placeholder asset path.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ResultsScreen(
          videoAssetPath: 'assets/videos/result.mp4',
        ),
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
                'This application provides a comprehensive 6-panel visualization for chair occupancy detection, including the Eagle Eye Tactical Overlay.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              if (_selectedFileName != null)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.movie, color: Colors.blueAccent),
                    title: const Text('Selected Video'),
                    subtitle: Text(_selectedFileName!),
                  ),
                ),
              const SizedBox(height: 40),
              if (_isProcessing)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Processing video, please wait...'),
                  ],
                )
              else
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickAndProcessVideo,
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
                        disabledBackgroundColor: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
