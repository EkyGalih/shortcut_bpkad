import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:instabpkad/Archive/add_archive.dart';
import 'package:instabpkad/Pegawai/add_pegawai.dart';
// import 'package:instabpkad/berita/berita.dart';
import 'package:instabpkad/home.dart';
import 'package:instabpkad/nav-drawer.dart';

import 'Archive/archive.dart';
import 'Pegawai/pegawai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Instan's",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const MyHomePage(),
      initialRoute: '/',
      routes: {
        '/pegawai': (context) => const Pegawai(),
        // '/berita': (context) => const Berita(),
        '/add_pegawai': (context) => AddPegawai(),
        '/archive': (context) => const Archive(),
        '/add_archive': (context) => AddArchive(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 0;
  final _pageOption = [
    const Home(),
    // const Berita(),
    const Pegawai(),
    const Archive(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Instans's",
          style: TextStyle(
            fontFamily: 'OoohBaby',
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.blueAccent.shade400,
        toolbarHeight: 45,
      ),
      // drawer: Sidebar(),
      endDrawer: const Sidebar(),
      body: _pageOption[selectedPage],
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.people, title: 'Pegawai'),
          TabItem(icon: Icons.archive, title: "Arsip"),
          TabItem(icon: Icons.person, title: "Profile"),
        ],
        backgroundColor: Colors.blueAccent.shade400,
        height: 45,
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
