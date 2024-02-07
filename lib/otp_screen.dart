import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  Future<void> _generateOTP() async {
    final response = await http.post(
      Uri.parse('https://lmsdemo.testpress.in/api/v2.5/auth/generate-otp/'),
      body: {'phone_number': _phoneNumberController.text , 'country_code': "+91"},
    );

    if (response.statusCode == 200) {
      print("Sent");
      // OTP sent successfully
      // You can handle the response accordingly
    } else {
      print(response.statusCode);
      print("Not recived");
      // Error occurred
      // Handle the error response
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Enter Phone Number'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter OTP'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _generateOTP,
              child: const Text('Get OTP'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement code to verify OTP
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
