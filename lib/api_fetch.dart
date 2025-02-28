import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String quote = "Press the button to fetch a quote";
  Future<void> fetchQuote() async {
    try {
    final url = Uri.parse('https://zenquotes.io/api/random'); //https://api.quotable.io/random {your api is not working so i use another one
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Response Body: ${response.body}');
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty && data[0].containsKey('q')) {
        setState(() {
          quote = data[0]['q'];
        });
      } else {
        setState(() {
          quote = 'Unexpected response format';
        });
      }
    } else {
      setState(() {
        quote = 'Failed to load quote';
      });
    }
  } catch (e) {
      setState(() {
        quote = 'Error occurred: $e';
      });
    }
  } 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Random Quote App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                quote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("Fetching new quote...");
                  fetchQuote();
                },
                child: const Text('Fetch Quote'),
              ),
            ],
          ),
        ));
  }
}

