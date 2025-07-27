import 'package:flutter/material.dart';
import 'package:glowing_wave_button/glowing_wave_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glowing Wave Button Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  bool _isActive = true;
  bool _emitWords = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Glowing Wave Button Examples'),
        backgroundColor: Color(0xFF6B73FF),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6B73FF).withOpacity(0.1),
              Color(0xFF9BA3FF).withOpacity(0.05),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Controls
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Controls',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      SwitchListTile(
                        title: Text('Active'),
                        value: _isActive,
                        onChanged: (value) {
                          setState(() {
                            _isActive = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: Text('Emit Words'),
                        value: _emitWords,
                        onChanged: (value) {
                          setState(() {
                            _emitWords = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40),

              // Basic Example
              _buildExampleSection(
                title: 'Basic Example',
                description: 'Default glowing wave button',
                child: GlowingWaveButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Basic button pressed!')),
                    );
                  },
                  isActive: _isActive,
                  emitWords: _emitWords,
                ),
              ),

              SizedBox(height: 40),

              // Meditation Button
              _buildExampleSection(
                title: 'Meditation Button',
                description: 'Peaceful colors with relaxation words',
                child: GlowingWaveButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Starting meditation...')),
                    );
                  },
                  primaryColor: Color(0xFF4CAF50),
                  waveColor: Color(0xFF81C784),
                  icon: Icons.self_improvement,
                  isActive: _isActive,
                  emitWords: _emitWords,
                  floatingWords: ['Breathe', 'Relax', 'Peace', 'Calm', 'Focus'],
                ),
              ),

              SizedBox(height: 40),

              // Like Button
              _buildExampleSection(
                title: 'Like Button',
                description: 'Heart icon with pink theme',
                child: GlowingWaveButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Liked!')),
                    );
                  },
                  primaryColor: Color(0xFFE91E63),
                  waveColor: Color(0xFFF48FB1),
                  icon: Icons.favorite,
                  size: 48.0,
                  waveCount: 3,
                  isActive: _isActive,
                  emitWords: _emitWords,
                  floatingWords: ['Love', 'Like', 'Heart', 'Joy'],
                ),
              ),

              SizedBox(height: 40),

              // Large Button
              _buildExampleSection(
                title: 'Large Button',
                description: 'Bigger size with more waves',
                child: GlowingWaveButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Large button pressed!')),
                    );
                  },
                  primaryColor: Color(0xFFFF6B35),
                  waveColor: Color(0xFFFFB07A),
                  icon: Icons.star,
                  size: 80.0,
                  waveCount: 6,
                  isActive: _isActive,
                  emitWords: _emitWords,
                  floatingWords: ['Amazing', 'Great', 'Super', 'Wow', 'Cool'],
                ),
              ),

              SizedBox(height: 40),

              // Custom Duration
              _buildExampleSection(
                title: 'Fast Animation',
                description: 'Quicker wave cycles',
                child: GlowingWaveButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Fast button pressed!')),
                    );
                  },
                  primaryColor: Color(0xFF9C27B0),
                  waveColor: Color(0xFFCE93D8),
                  icon: Icons.flash_on,
                  waveDuration: Duration(seconds: 2),
                  isActive: _isActive,
                  emitWords: _emitWords,
                  floatingWords: ['Fast', 'Quick', 'Speed', 'Rush'],
                ),
              ),

              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6B73FF),
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(child: child),
        ),
      ],
    );
  }
}
