// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

class BeritaModel {
  final id;
  final image;
  final title;
  final content;
  final author;
  final publishedAt;
  final tag;

  BeritaModel({
    required this.id,
    required this.image,
    required this.title,
    required this.content,
    required this.author,
    required this.publishedAt,
    required this.tag,
  });

  factory BeritaModel.fromJson(Map<String, dynamic> map) {
    return BeritaModel(
      id: map['id'],
      image: map['foto_berita'],
      title: map['title'],
      content: map['content'],
      author: map['author'],
      publishedAt: map['created_at'],
      tag: map['tags'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "title": title,
      "content": content,
      "author": author,
      "publishedAt": publishedAt,
      "tag": tag,
    };
  }

  @override
  String toString() {
    return 'BeritaModel{id: $id, image: $image, title: $title, content: $content, author: $author, publihedAt: $publishedAt, tag: $tag}';
  }
}

List<BeritaModel> beritaFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<BeritaModel>.from(
      data.map((berita) => BeritaModel.fromJson(berita)).toList());
}

String beritaToJson(BeritaModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
