import 'dart:convert';

class BeritaModel {
  final id;
  final image;
  final title;
  final content;
  final author;
  final publishedAt;

  BeritaModel({
    required this.id,
    required this.image,
    required this.title,
    required this.content,
    required this.author,
    required this.publishedAt,
  });

  factory BeritaModel.fromJson(Map<String, dynamic> map) {
    return BeritaModel(
      id: map['id'],
      image: map['image'],
      title: map['title'],
      content: map['content'],
      author: map['author'],
      publishedAt: map['publishedAt'],
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
    };
  }

  @override
  String toString() {
    return 'BeritaModel{id: $id, image: $image, title: $title, content: $content, author: $author, publihedAt: $publishedAt}';
  }
}

List<BeritaModel> beritaFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<BeritaModel>.from(
      data.map((berita) => new BeritaModel.fromJson(berita)).toList());
}

String beritaToJson(BeritaModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
