import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginAnonymously() async {
    _setLoading(true);
    try {
      await FirebaseAuth.instance.signInAnonymously();
      _navigateToChat();
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loginWithEmail() async {
    _setLoading(true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      _navigateToChat();
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    } finally {
      _setLoading(false);
    }
  }

  void _navigateToChat() {
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/chat');
    }
  }

  void _navigateToRegister() {
    Navigator.of(context).pushNamed('/register');
  }

  void _showError(String? message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: ${message ?? 'Произошла неизвестная ошибка.'}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _setLoading(bool value) {
    if (mounted) {
      setState(() {
        _isLoading = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вход'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Пароль'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loginWithEmail,
                    child: const Text('Войти'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _loginAnonymously,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    child: const Text('Войти анонимно'),
                  ),
                  TextButton(
                    onPressed: _navigateToRegister,
                    child: const Text('Нет аккаунта? Зарегистрируйтесь'),
                  ),
                ],
              ),
            ),
    );
  }
}