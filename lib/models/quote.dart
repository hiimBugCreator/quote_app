class Quote {
  Quote(String quote, String author, String category) {
    this.quote = _capitalize(quote);
    this.author = _capitalize(author);
    this.category = _capitalize(category);
  }

  late final String quote;
  late final String author;
  late final String category;

  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'author': author,
      'category': category,
    };
  }

  String _capitalize(String str) =>
      str.isNotEmpty ? str[0].toUpperCase() + str.substring(1) : str;

  factory Quote.fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return Quote('', '', '');

    return Quote(
      map['quote'],
      map['author'],
      map['category'],
    );
  }

  Quote.fromJson(Map<String, dynamic> json) {
    quote = _capitalize(json['quote']);
    author = _capitalize(json['author']);
    category = _capitalize(json['category']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['quote'] = quote;
    data['author'] = author;
    data['category'] = category;
    return data;
  }
}
