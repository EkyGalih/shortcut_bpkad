// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class DetailPegawai extends StatelessWidget {
  final name;
  final nip;
  final jabatan;
  final foto;

  const DetailPegawai({
    super.key,
    this.name,
    this.nip,
    this.jabatan,
    this.foto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pegawai"),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            foto != null
                ? Image.network(
                    'https://bpkad.ntbprov.go.id/uploads/pegawai/$foto',
                    fit: BoxFit.fill,
                  )
                : SizedBox(
                    height: 250,
                    child: Image.asset('assets/images/male.png'),
                  ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      nip ?? '--------',
                      style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  const Divider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      jabatan ?? '----------',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
