// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chat/widgets/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  bool _isAuthenticating = false;

  final _formKey = GlobalKey<FormState>();

  String userEmail = '';
  String userPassword = '';
  String userName = ''; // ✅ NEW: store username on signup

  File? _userImage;

  Future<void> submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid || (!_isLogin && _userImage == null)) {
      if (!_isLogin && _userImage == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please pick an image.')));
      }
      return;
    }

    _formKey.currentState!.save();

    setState(() => _isAuthenticating = true);

    try {
      if (_isLogin) {
        await _firebase.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );

        final uid = userCredentials.user!.uid;

        // ✅ Upload image
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('$uid.jpg');

        await ref.putFile(_userImage!);
        final imageUrl = await ref.getDownloadURL();

        // ✅ Save user document (NOW includes username)
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'email': userEmail,
          'username': userName, // ✅ NEW
          'imageUrl': imageUrl,
        });
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Authentication failed')),
      );
    } catch (e) {
      // ✅ NEW: catch any other errors (Firestore/Storage etc)
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong: $e')));
    } finally {
      if (!mounted) return;
      setState(() => _isAuthenticating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                child: Image.asset(
                  'assets/images/chat.jpeg',
                  fit: BoxFit.cover,
                  width: 250,
                ),
              ),

              Card(
                margin: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    // ✅ Disable interactions while authenticating
                    IgnorePointer(
                      ignoring: _isAuthenticating,
                      child: Opacity(
                        opacity: _isAuthenticating ? 0.6 : 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              if (!_isLogin)
                                UserImage(
                                  onImagePicked: (pickedImage) {
                                    _userImage = pickedImage;
                                  },
                                ),

                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // ✅ NEW: Username field on signup
                                    if (!_isLogin)
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: 'Username',
                                        ),
                                        onSaved: (newValue) =>
                                            userName = newValue?.trim() ?? '',
                                        validator: (value) {
                                          if (_isLogin) return null;
                                          final v = value?.trim() ?? '';
                                          if (v.length < 3) {
                                            return 'Username must be at least 3 characters.';
                                          }
                                          return null;
                                        },
                                      ),

                                    TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Email Address',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (newValue) =>
                                          userEmail = newValue?.trim() ?? '',
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty ||
                                            !value.contains('@')) {
                                          return 'Please enter a valid email address.';
                                        }
                                        return null;
                                      },
                                    ),

                                    TextFormField(
                                      onSaved: (newValue) =>
                                          userPassword = newValue ?? '',
                                      decoration: const InputDecoration(
                                        labelText: 'Password',
                                      ),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value == null || value.length < 6) {
                                          return 'Password must be at least 6 characters long.';
                                        }
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 12),

                                    ElevatedButton(
                                      onPressed: submit,
                                      child: Text(
                                        _isLogin ? 'Login' : 'Sign Up',
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _isLogin = !_isLogin;
                                        });
                                      },
                                      child: Text(
                                        _isLogin
                                            ? 'Create an account'
                                            : 'I already have an account',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ✅ FULL overlay loader
                    if (_isAuthenticating)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black26,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
