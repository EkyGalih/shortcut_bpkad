// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instabpkad/Pegawai/dettail_pegawai.dart';
import 'package:instabpkad/api/pegawai_api.dart';
import 'package:instabpkad/model/pegawai/pegawai_model.dart';
import 'package:http/http.dart' as http;
// import 'package:image_card/image_card.dart';

class Pegawai extends StatefulWidget {
  const Pegawai({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PegawaiState createState() => _PegawaiState();
}

class _PegawaiState extends State<Pegawai> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  List pegawai = [];
  int page = 1;
  late double scrollmark;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchPegawai();

    // fab
    fab = FloatingActionButton(
      child: const Icon(Icons.arrow_upward_sharp),
      onPressed: () {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );

    // scroll listener for fab
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
  Future<void> fetchPegawai() async {
    final url = 'https://bpkad.ntbprov.go.id/api/pegawai?page=$page';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)['data']['data'] as List;
      setState(() {
        pegawai = pegawai + json;
      });
    } else {
      print('Unexpected response');
    }
  }

  // scrolling load function
  Future<void> _scrollListener() async {
    if (isLoadingMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      page = page + 1;
      await fetchPegawai();
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
    // PegawaiService().getPegawai().then((value) => print("value: $value"));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: getFab(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(seconds: 1),
          );
          pegawai = pegawai;
          setState(() {});
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2 / 3,
          ),
          controller: scrollController,
          itemCount: isLoadingMore ? pegawai.length + 1 : pegawai.length,
          itemBuilder: (BuildContext context, int index) {
            if (index < pegawai.length) {
              final item = pegawai[index];
              final name = item['name'];
              final nip = item['nip'] ?? '-';
              final jabatan = item['jabatan'];
              final foto = item['foto'];
              return Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 800,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Material(
                          child: Ink.image(
                            image: foto != null
                                ? NetworkImage(
                                    "https://bpkad.ntbprov.go.id/uploads/pegawai/$foto")
                                : const NetworkImage(
                                    'https://bpkad.ntbprov.go.id/uploads/pegawai/e78ab5edc12d000ee2242204e6a744e1.jpg'),
                            fit: BoxFit.fill,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) => DetailPegawai(
                                      name: name,
                                      nip: nip,
                                      jabatan: jabatan,
                                      foto: foto,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          nip ?? '------',
                          style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
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
    //     Navigator.of(context).pushNamed('/add_pegawai');
    //   },
    //   backgroundColor: Colors.blue,
    //   child: const Icon(Icons.add),
    // ),
  }
}
