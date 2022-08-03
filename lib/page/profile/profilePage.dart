import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber.shade100,
        body: ListView.builder(
          itemExtent: 64,
          itemCount: 100,
          itemBuilder: ((context, index) {
            return Card(
              child: ListTile(
                title: Text('$index'),
              ),
            );
          }),
        ));
  }
}
