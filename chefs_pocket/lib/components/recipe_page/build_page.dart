import 'dart:async';

import 'package:chefs_pocket/components/recipe_page/image_sliders.dart';
import 'package:chefs_pocket/models/recipe_step.dart';
import 'package:flutter/material.dart';

class BuildPage extends StatefulWidget {

  final RecipeStep step;
  BuildPage({required this.step});
  

  @override
  State<BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  bool _isTimerRunning = false;
  int _remainingTime = 0;
   Timer? _timer;
  @override
  void initState() {
    super.initState();
    _remainingTime = widget.step.timer?.inSeconds ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: AlignmentDirectional(-1.25, -1.01),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ImageSliders(imageUrls: widget.step.imageUrls!))),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(24),
              shape: BoxShape.rectangle,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.step.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Color(0xFF557F9F), // Specify the desired color
                      )
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.step.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ElevatedButton(
              onPressed: () {
                if (!_isTimerRunning) {
              _startTimer();
            }
              },
              child: _isTimerRunning ?
              Text(_formatTime(_remainingTime), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white))
              : Text('Timer', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF557F9F),
                disabledForegroundColor: Color(0xFFF557F9F),
                disabledBackgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }


  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _isTimerRunning = false;
          _remainingTime = 10; // Reset timer if needed
        }
      });
    });
  }

String _formatTime(int seconds) {
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }
}

