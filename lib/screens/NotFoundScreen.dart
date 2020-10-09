import 'package:appnews/core/app.dart';
import 'package:appnews/widgets/drawer.dart';
import 'package:flutter/material.dart';

class NotFoundScreen extends StatefulWidget {
  @override
  _NotFoundScreenState createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$app_name"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.of(context).pushNamed("/search"))
        ],
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Text("រកមិនឃើញទំព័រនេះទេ"),
      ),
    );
  }
}
