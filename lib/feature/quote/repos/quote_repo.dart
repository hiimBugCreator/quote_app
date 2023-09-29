import 'dart:convert';

import 'package:quote_app/api/base_restful_api.dart';
import 'package:quote_app/models/quote.dart';

class QuoteRepo {
  Quote quoteFromJson(String str) => Quote.fromJson(jsonDecode(str));

  static Future<List<Quote>> fetchQuote() async {
    var resp = await BaseRestfulAPI().httpGet("quotes?category=");
    List<Quote> quotes = [];
    if (resp.statusCode == 200) {
      if (resp.statusCode == 200) {
        resp.data.forEach((data) {
          Quote quote = Quote.fromMap(data);
          quotes.add(quote);
        });
      }
    }
    return quotes;
  }
}
