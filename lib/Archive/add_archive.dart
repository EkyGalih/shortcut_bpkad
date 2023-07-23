import 'package:flutter/material.dart';

class AddArchive extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  AddArchive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Archive"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "masukkan jenis file",
                  labelText: "Nama File",
                  icon: const Icon(Icons.file_upload),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
