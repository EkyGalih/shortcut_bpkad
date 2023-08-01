// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

class ArchiveModel {
  final id;
  final nama;
  final jenis;
  int tahun;
  final jfile;
  final files;

  ArchiveModel({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.tahun,
    required this.jfile,
    required this.files,
  });

  factory ArchiveModel.fromJson(Map<String, dynamic> map) {
    return ArchiveModel(
      id: map['id'],
      nama: map['nama_informasi'],
      jenis: map['jenis_informasi'],
      tahun: map['tahun'],
      jfile: map['jenis_file'],
      files: map['files'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "jenis": jenis,
      "tahun": tahun,
      "jfile": jfile,
      "files": files,
    };
  }

  @override
  String toString() {
    return 'ArchiveModel{id: $id, nama: $nama, jenis: $jenis, tahun: $tahun, jfile: $jfile, files: $files}';
  }
}

List<ArchiveModel> archiveFromjson(String jsonDataArchive) {
  final dataArchive = json.decode(jsonDataArchive)['data']['data'];
  return List<ArchiveModel>.from(
      dataArchive.map((archive) => ArchiveModel.fromJson(archive)).toList());
}

String archiveToJson(ArchiveModel dataArchive) {
  final jsonDataArchive = dataArchive.toJson();
  return json.encode(jsonDataArchive);
}
