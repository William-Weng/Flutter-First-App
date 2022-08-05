import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _item = SizedBox(
    height: 128.0,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://pinkoi-wp-blog.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/sites/6/2021/12/13155150/角落生物-1-1021x1024.webp',
          fit: BoxFit.fitWidth,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(64, 0, 0, 0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                )),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(32, 0, 0, 0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('DEMO'),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  late ListView listView = ListView.separated(
    itemCount: 8,
    itemBuilder: ((context, index) {
      return _item;
    }),
    separatorBuilder: ((context, index) {
      return const Divider(
        height: 1,
        thickness: 2,
        color: Colors.blueGrey,
      );
    }),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ListView',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.amber.shade100,
      body: listView,
    );
  }
}
