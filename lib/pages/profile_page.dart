import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/pages/editprofilepage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  /// Fetch current user's data from Firestore
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection("users").doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Editprofilepage()),
              );
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No user data found."));
          }

          final userData = snapshot.data!.data() ?? {};

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _getAvatarImage(userData),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userData['name'] ?? "No name",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userData['address'] ?? "No address",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Email: ${userData['email'] ?? ''}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Phone: ${userData['phoneNumber'] ?? ''}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Helper function for avatar
  ImageProvider _getAvatarImage(Map<String, dynamic> userData) {
    if (userData['avatarUrl'] != null &&
        userData['avatarUrl'].toString().isNotEmpty) {
      return NetworkImage(userData['avatarUrl']);
    } else {
      return const AssetImage('assets/images/default_avatar.png');
    }
  }
}
