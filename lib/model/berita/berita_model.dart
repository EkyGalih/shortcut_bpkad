class Berita {
  final id;
  final image;
  final title;
  final content;
  final author;
  final publishedAt;

  Berita({
    this.id = 0,
    this.image,
    this.title,
    this.content,
    this.author,
    this.publishedAt,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      id: json['id'],
      image: json['image'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
    );
  }
}
