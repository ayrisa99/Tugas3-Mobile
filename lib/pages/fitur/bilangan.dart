import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BilanganPage extends StatefulWidget {
  @override
  _BilanganPageState createState() => _BilanganPageState();
}

class _BilanganPageState extends State<BilanganPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  final NumberFormat _formatter = NumberFormat.decimalPattern('id');

  bool _isPrime(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void _checkNumber() {
    final input = _controller.text.replaceAll('.', '').replaceAll(',', '.');
    final value = double.tryParse(input);

    if (value == null) {
      setState(() {
        _result = 'Masukkan angka yang valid';
      });
      return;
    }

    List<String> types = [];

    if (value % 1 != 0) {
      types.add('Bilangan Desimal');
      if (value < 0) {
        types.add('Bilangan Negatif');
      }
    } else {
      int intValue = value.toInt();
      if (intValue >= 0) {
        types.add('Bilangan Cacah');
        if (intValue > 0) {
          types.add('Bilangan Bulat Positif');
        }
      } else {
        types.add('Bilangan Bulat Negatif');
      }

      // Cek bilangan prima
      if (_isPrime(intValue)) {
        types.add('Bilangan Prima');
      }
    }

    setState(() {
      _result = '${_controller.text} → ${types.join(', ')}';
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
        title: Text('Jenis Bilangan'),
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
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Masukkan Angka',
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
              onPressed: _checkNumber,
              child: Text('Cek Bilangan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7F50),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: TextStyle(fontSize: 18),
              ),
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
