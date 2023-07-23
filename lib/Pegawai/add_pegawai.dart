import 'package:flutter/material.dart';

class AddPegawai extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  AddPegawai({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pegawai"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "masukkan nama lengkap pegawai",
                  labelText: "Nama Pegawai",
                  icon: const Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
