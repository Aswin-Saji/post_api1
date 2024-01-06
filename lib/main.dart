import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController(); 
  final TextEditingController emailController = TextEditingController(); 
   Future<void> sendPostRequest() async {
    final Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> requestBody = {
      'name': nameController.text,
      'email': emailController.text,
      'userId': 1,
    };

    try {
      final http.Response response = await http.post(
        uri,
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 201) {
        print('Post request successful!');
        print('Response: ${response.body}');
      } else {
        print('Failed to send post request. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error during post request: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 98, 23, 48),
        title: Text('Your login credentials',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email Id'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                sendPostRequest();
              },
              child: Text('Send POST Request'),
            ),
          ],
        ),
      ),
    );
  }
}