import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pegawai/Archive/add_archive.dart';
import 'package:pegawai/Pegawai/add_pegawai.dart';
import 'package:pegawai/home.dart';
import 'package:pegawai/nav-drawer.dart';
import 'Pegawai/pegawai.dart';
import 'Archive/archive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shortcut BPKAD",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/home': (context) => MyHomePage(),
        '/pegawai': (context) => Pegawai(),
        '/add_pegawai': (context) => AddPegawai(),
        '/archive': (context) => Archive(),
        '/add_archive': (context) => AddArchive(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 0;
  final _pageOption = [MyHomePage(), Archive(), Pegawai()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shortcut BPKAD'),
      ),
      drawer: Sidebar(),
      endDrawer: Sidebar(),
      body: _pageOption[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.archive, title: "Arsip"),
          TabItem(icon: Icons.people, title: 'Pegawai')
        ],
        initialActiveIndex: selectedPage,
        onTap: (int index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
