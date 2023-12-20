import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/contact_model.dart';
import 'package:flutter_assessment/screens/edit_profile.dart';

class ProfilePage extends StatelessWidget {
  final Contacts contact;

  const ProfilePage({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(
                          contact: contact,
                        ),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Color(0xff32BAA5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('profile_picture.png'),
                  radius: 50,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  contact.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                Stack(
                  children: [
                    Container(
                      width: 91,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                    Text(
                      contact.email,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 34, right: 34),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff32BAA5),
                    ),
                    width: 360,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Send Email',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
