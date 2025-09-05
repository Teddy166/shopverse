import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Editprofilepage extends StatefulWidget {
  const Editprofilepage({super.key});

  @override
  State<Editprofilepage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<Editprofilepage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  File? selectedImageFile;
  String? avatarUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists) {
      final data = snapshot.data()!;
      nameController.text = data['name'] ?? '';
      addressController.text = data['address'] ?? '';
      aboutController.text = data['about'] ?? '';
      avatarUrl = data['avatarUrl'] ?? '';
    }

    setState(() => isLoading = false);
  }

  Future<void> pickImage(ImageSource source) async {
    // Request permission depending on source
    if (source == ImageSource.camera) {
      var status = await Permission.camera.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Camera permission denied")),
        );
        return;
      }
    } else {
      var status = await Permission.photos.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gallery permission denied")),
        );
        return;
      }
    }

    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 75,
    );

    if (pickedFile != null) {
      setState(() => selectedImageFile = File(pickedFile.path)); // 👈 Update preview immediately
    }
  }

  Future<String?> uploadImage(File file) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final ref =
    FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> saveChanges() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    if (selectedImageFile != null) {
      avatarUrl = await uploadImage(selectedImageFile!);
    }

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': nameController.text.trim(),
      'address': addressController.text.trim(),
      'about': aboutController.text.trim(),
      'avatarUrl': avatarUrl ?? '',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );

    Navigator.pop(context); // 👈 Go back to ProfilePage
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    ImageProvider profileImage;
    if (selectedImageFile != null) {
      profileImage = FileImage(selectedImageFile!);
    } else if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      profileImage = NetworkImage(avatarUrl!);
    } else {
      profileImage = const AssetImage('assets/images/default_avatar.png');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(radius: 60, backgroundImage: profileImage),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (_) => _buildImagePickerOptions(),
                    ),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.edit, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Address"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: aboutController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "About"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveChanges,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerOptions() {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take Photo'),
            onTap: () {
              Navigator.pop(context);
              pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
