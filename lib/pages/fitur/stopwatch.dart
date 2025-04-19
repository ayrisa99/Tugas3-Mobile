// File: stopwatch.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;
  final List<int> _laps = [];

  void _start() {
    if (_isRunning) return;
    _timer = Timer.periodic(Duration(milliseconds: 30), (_) {
      setState(() => _milliseconds += 30);
    });
    setState(() => _isRunning = true);
  }

  void _stop() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _lap() {
    if (!_isRunning) return;
    setState(() => _laps.add(_milliseconds));
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
      _laps.clear();
    });
  }

  String _format(int ms) {
    final d = Duration(milliseconds: ms);
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inMinutes)}:" // MENIT
        "${two(d.inSeconds.remainder(60))}:" // DETIK
        "${two((d.inMilliseconds ~/ 10).remainder(100))}"; // RATUSAN
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CustomPaint(
                        painter: _CirclePainter(
                          progress: (_milliseconds / (60 * 1000)) % 1,
                        ),
                      ),
                    ),
                    // PENTING: pastikan ini memanggil fungsi format, bukan string literal
                    Text(
                      _format(_milliseconds),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Daftar Lap
            if (_laps.isNotEmpty)
              Column(
                children: List.generate(_laps.length, (i) {
                  final time = _laps[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lap ${i + 1}', style: TextStyle(fontSize: 16)),
                        Text(_format(time), style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                }),
              ),

            SizedBox(height: 16),

            // Tombol Lap/Reset & Start/Pause
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: _isRunning ? _lap : _reset,
                  child: Container(
                    width: 80,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orangeAccent],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      _isRunning ? Icons.stop : Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _isRunning ? _stop : _start,
                  child: Container(
                    width: 80,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepOrange, Colors.orangeAccent],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(
                      _isRunning ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double progress;
  _CirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final bgPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..color = Colors.grey.shade300;

    final fgPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..shader = SweepGradient(
            startAngle: 0,
            endAngle: 2 * pi,
            colors: [Colors.orangeAccent, Colors.deepOrange],
          ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, bgPaint);
    final sweep = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweep,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CirclePainter old) => old.progress != progress;
}
