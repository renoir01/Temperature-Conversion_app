import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Set the brightness to light
        fontFamily: 'Poppins', // Custom font
      ),
      home: TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() => _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState extends State<TemperatureConverterScreen> {
  String conversionType = 'F to C'; // Default conversion type
  TextEditingController tempController = TextEditingController();
  double? convertedValue;
  List<String> history = [];

  // Function to convert temperature
  void _convertTemperature() {
    if (tempController.text.isEmpty) return;

    double inputTemp = double.parse(tempController.text);
    double result;

    if (conversionType == 'F to C') {
      result = (inputTemp - 32) * 5 / 9; // F to C conversion
      history.insert(0, 'F to C: ${inputTemp.toStringAsFixed(1)} => ${result.toStringAsFixed(2)} °C');
    } else {
      result = inputTemp * 9 / 5 + 32; // C to F conversion
      history.insert(0, 'C to F: ${inputTemp.toStringAsFixed(1)} => ${result.toStringAsFixed(2)} °F');
    }

    setState(() {
      convertedValue = result; // Update the converted value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Conversion selection (radio buttons)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'F to C',
                  groupValue: conversionType,
                  onChanged: (value) {
                    setState(() {
                      conversionType = value.toString();
                    });
                  },
                ),
                Text('Fahrenheit to Celsius', style: TextStyle(fontSize: 16)),
                SizedBox(width: 20),
                Radio(
                  value: 'C to F',
                  groupValue: conversionType,
                  onChanged: (value) {
                    setState(() {
                      conversionType = value.toString();
                    });
                  },
                ),
                Text('Celsius to Fahrenheit', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            // Temperature input field
            TextField(
              controller: tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Convert button
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text(
                'CONVERT',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            // Display converted value
            if (convertedValue != null)
              Text(
                'Converted Value: ${convertedValue!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20),
            // Conversion history title
            Text('History:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            // History of conversions
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(history[index], style: TextStyle(fontSize: 16)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
