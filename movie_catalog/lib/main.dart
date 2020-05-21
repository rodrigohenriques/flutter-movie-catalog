import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:moviecatalog/pages/movies_page.dart';

void main() async {
  await GlobalConfiguration().loadFromAsset("local_properties");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MoviesPage(),
    );
  }
}
