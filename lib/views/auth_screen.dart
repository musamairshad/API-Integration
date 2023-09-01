import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  var _isAuthenticating = false;

  var _isLogin = true;

  Future<void> auth(String email, String password) async {
    // final url = Uri.https('reqres.in', '/api/register');
    final url = Uri.https('reqres.in', '/api/login');
    setState(() {
      _isAuthenticating = true;
    });
    try {
      final response = await http.post(url, body: {
        "email": email,
        "password": password,
      });
      setState(() {
        _isAuthenticating = false;
      });
      final resData = json.decode(response.body);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print(resData['token']);
        // print('Account created successfully');
      } else {
        // print('Failed to create an account!');
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'SignUp'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Enter Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Enter Password',
              ),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                auth(_emailController.text, _passwordController.text);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: Center(
                  child: _isAuthenticating
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(_isLogin ? 'Login' : 'SignUp'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(
                  _isLogin ? 'Create an account' : 'I already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}
