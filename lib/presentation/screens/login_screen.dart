import 'package:ctucl_mobile_manager/main.dart';
import 'package:ctucl_mobile_manager/providers/auth_provider.dart';
import 'package:ctucl_mobile_manager/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String errorMessage = '';


  Future<void> signIn() async {

    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final String email  = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? token = await userCredential.user?.getIdToken();
      var response  = await apiService.loginQuery(email,password,token! , context);
      final response_result = response['result']['localData'];
      final Map<String,dynamic> data_formated ={
        'id':response_result['id'],
        'username':response_result['username'],
        'email':response_result['email'],
        'phone':response_result['phone'],
        'register':response_result['register'],
        'address':response_result['address'],
        'name':response_result['name'],
        'lastname':response_result['lastname'],
        'token':token
      };
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(response: data_formated)));
      
      if (mounted) {
        context.showSnackBar('Successfully signed in!');
      }
    } catch (e) {
      if (mounted) context.showSnackBar('Error al iniciar sesión: ${e.toString()}', isError: true);
    }finally {
      if (mounted) {

        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ), const SizedBox(height: 24),
                    Text(
                      _isSignUp ? 'Create Account' : 'SIMTRA',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isSignUp
                          ? 'Sign up to get started with our app'
                          : 'Inicia Sesion para continuar con la app',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email_outlined)
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Falta el Email';
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                            const SizedBox(height: 16),TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText: !_isPasswordVisible,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Falta la Contrasena';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: signIn,
                              child: _isLoading
                                  ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : Text(_isSignUp ? 'Sign Up' : 'Sign In'),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ))
                  ],
                ),

              ),
            ),
      )),
    );
  }
}
