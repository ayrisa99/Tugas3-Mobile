import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KonversiWaktuPage extends StatefulWidget {
  const KonversiWaktuPage({super.key});

  @override
  _KonversiWaktuPageState createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  final NumberFormat _formatter = NumberFormat.decimalPattern('id');

  void _convertTime() {
    final input = _controller.text.replaceAll('.', '');
    final int? years = int.tryParse(input);

    if (years == null || years < 0) {
      setState(() {
        _result = 'Masukkan jumlah tahun yang valid!';
      });
      return;
    }

    final int hours = years * 365 * 24;
    final int minutes = hours * 60;
    final int seconds = minutes * 60;

    setState(() {
      _result =
          '$years Tahun =\n${_formatter.format(hours)} Jam,\n${_formatter.format(minutes)} Menit,\n${_formatter.format(seconds)} Detik';
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Waktu'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Masukkan jumlah tahun',
                ),
                style: TextStyle(fontSize: 16),
                onChanged: (text) {
                  final clean = text.replaceAll('.', '');
                  if (clean.isEmpty) return;
                  final value = int.tryParse(clean);
                  if (value != null) {
                    final formatted = _formatter.format(value);
                    _controller.value = TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(
                        offset: formatted.length,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _convertTime,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7F50),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Konversi'),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
