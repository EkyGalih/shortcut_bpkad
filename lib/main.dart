import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:instabpkad/Archive/add_archive.dart';
import 'package:instabpkad/Pegawai/add_pegawai.dart';
import 'package:instabpkad/berita/berita.dart';
import 'package:instabpkad/home.dart';
import 'package:instabpkad/model/berita/berita_model.dart';
import 'package:instabpkad/nav-drawer.dart';
import 'Pegawai/pegawai.dart';
import 'Archive/archive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Insta BPKAD",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/pegawai': (context) => Pegawai(),
        '/berita': (context) => Berita(),
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
  final _pageOption = [Home(), Berita(), Archive(), Pegawai()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'instabpkad',
          style: TextStyle(
            fontFamily: 'OoohBaby',
            fontSize: 30,
          ),
        ),
        toolbarHeight: 45,
      ),
      // drawer: Sidebar(),
      endDrawer: Sidebar(),
      body: _pageOption[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.newspaper, title: "Berita"),
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
