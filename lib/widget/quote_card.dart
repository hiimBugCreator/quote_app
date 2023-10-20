import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quote_app/models/quote.dart';

class QuoteCard extends StatefulWidget {
  const QuoteCard({super.key, required this.quote});

  final Quote? quote;

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  late var size = MediaQuery.of(context).size;
  late var height = size.height;
  late var width = size.width;

  @override
  Widget build(BuildContext context) {
    return buildCard();
    return SizedBox.expand(
      child: buildCard(),
    );
  }

  Widget buildCard() => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: width * 0.8,
          height: height * 0.7,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      widget.quote?.category ?? "",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: width * 0.6,
                    height: height * 0.5,
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      widget.quote?.quote ?? "",
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      style: const TextStyle(fontSize: 50),
                    )),
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(widget.quote?.author ?? "")),
              ),
            ],
          ),
        ),
      );
}
