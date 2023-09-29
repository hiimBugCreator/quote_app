class Quote {
  Quote({
    required this.quote,
    required this.author,
    required this.category,
  });

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

  factory Quote.fromMap(Map<String, dynamic>? map) {
    if (map == null) return Quote(quote: '', author: '', category: '');

    return Quote(
      quote: map['quote'],
      author: map['author'],
      category: map['category'],
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
