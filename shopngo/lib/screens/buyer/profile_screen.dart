// lib/screens/profile_screen.dart

import 'package:shopngo/models/user_model.dart';
import 'package:shopngo/services/auth_service.dart';
import 'package:shopngo/utils/constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final userData = await _authService.getUserData();
    setState(() {
      _user = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Profile'),
      ),
      body: Center(
        child: _user == null
            ? FutureBuilder(
                future: _getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error loading profile data.');
                  } else if (_user == null) {
                    return const Text('No user data found.');
                  } else {
                    return _buildProfileContent();
                  }
                },
              )
            : _buildProfileContent(),
      ),
    );
  }

  Widget _buildProfileContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _user!.photoUrl != null
              ? NetworkImage(_user!.photoUrl!)
              : const AssetImage('assets/images/default_avatar.png')
                  as ImageProvider,
        ),
        const SizedBox(height: 20),
        Text(
          '${_user!.name ?? 'User Name'}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          _user!.email ?? 'No Email',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
