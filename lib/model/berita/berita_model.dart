class BeritaModel {
  final id;
  final image;
  final title;
  final content;
  final author;
  final publishedAt;

  BeritaModel({
    this.id = 0,
    this.image,
    this.title,
    this.content,
    this.author,
    this.publishedAt,
  });

  // factory BeritaModel.fromJson(Map<String, dynamic> json) {
  //   return BeritaModel(
  //     id: json['id'],
  //     image: json['image'],
  //     title: json['title'],
  //     content: json['content'],
  //     author: json['author'],
  //   );
  // }
}
