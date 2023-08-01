// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:instabpkad/api/archive_api.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:instabpkad/model/archive/archive_model.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Archive());
}

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  List archive = [];
  int page = 1;
  late double scrollMark;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchArchive();

    // fab
    fab = FloatingActionButton(
      child: const Icon(Icons.arrow_upward),
      onPressed: () {
        scrollController.animateTo(
          0.0,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 500),
        );
      },
    );

    // scroll listener for FAB
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          reversing = true;
        });
      } else {
        setState(() {
          reversing = false;
        });
      }
    });
  }

  // get data
  Future<void> fetchArchive() async {
    final url = 'https://bpkad.ntbprov.go.id/api/kip?page=$page';
    print(url);
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['data']['data'] as List;
      setState(() {
        archive = archive + json;
      });
    } else {
      print('Unexpected response');
    }
  }

  // scroll load function
  Future<void> _scrollListener() async {
    if (isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      page = page + 1;
      await fetchArchive();
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  // back to top
  bool reversing = false;
  late FloatingActionButton fab;

  FloatingActionButton? getFab() {
    if (reversing && scrollController.position.pixels > 0.0) {
      return fab;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: getFab(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(seconds: 1),
          );
          archive = archive;
          setState(() {});
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(10),
          controller: scrollController,
          itemCount: isLoadingMore ? archive.length + 1 : archive.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < archive.length) {
              final berita = archive[index];
              final nama = berita['nama_informasi'];
              final jenis = berita['jenis_informasi'];
              final tahun = berita['tahun'];
              final files = berita['files'];
              return Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 292,
                      child: ListTile(
                        leading: const Image(
                          image: AssetImage('assets/images/archive.png'),
                          height: 35,
                          width: 35,
                        ),
                        title: Text(nama),
                        subtitle: Text(
                          "Informasi $jenis ($tahun)".toString(),
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(nama),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () async {
                        final String baseUrl = files;
                        final url = Uri.parse(baseUrl);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                      icon: const Icon(Icons.download),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //     Navigator.of(context).pushNamed('/add_archive');
    //   },
    //   backgroundColor: Colors.blue,
    //   child: const Icon(Icons.add),
    // ),
  }
}

double abs(double value) {
  if (value < 0.0) {
    return -value;
  }
  return value;
}
