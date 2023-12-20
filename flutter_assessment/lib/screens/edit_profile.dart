import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/contact_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditProfile extends StatefulWidget {
  final Contacts contact;

  const EditProfile({Key? key, required this.contact}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.name);
    _emailController = TextEditingController(text: widget.contact.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(widget.contact.image),
              radius: 50,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                // _updateContactDetails(_nameController, _emailController);
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

// void _updateContactDetails(
//   TextEditingController nameController,
//   TextEditingController emailController,
// ) {
//   final contactsBox = Hive.box<Contacts>('contacts');
//   final updatedContact = Contacts(
//     name: nameController.text,
//     email: emailController.text,
//     image: contact.image,
//     isFavorite: contact.isFavorite,
//   );

//   contactsBox.put(widget.contact.key as int, updatedContact);

//   setState(() {
//     contact.name = nameController;
//     contact.email = emailController;
//   });
// }
