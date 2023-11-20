import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  double amount = 0.0;
  double result = 0.0;

  TextEditingController amountController = TextEditingController();
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount in Euros',
                errorText: showError ? 'Please enter a valid number' : null,
              ),
              onChanged: (value) {
                setState(() {
                  showError = false;
                  if (value.isEmpty) {
                    amount = 0.0;
                  } else {
                    try {
                      amount = double.parse(value);
                    } catch (e) {
                      showError = true;
                    }
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (amount > 0) {
                  convertToLei();
                } else {
                  setState(() {
                    showError = true;
                  });
                }
              },
              child: const Text('Convert to Lei'),
            ),
            const SizedBox(height: 20),
            Text('$result Lei', style: const TextStyle(fontSize: 25.0)),
          ],
        ),
      ),
    );
  }

  void convertToLei() {
    const double euroToLeiRate = 4.9;

    setState(() {
      result = amount * euroToLeiRate;
      showError = false;
    });
  }
}