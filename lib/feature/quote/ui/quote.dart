import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app/feature/quote/bloc/quote_bloc.dart';
import 'package:quote_app/models/quote.dart';
import 'package:quote_app/widget/quote_card.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({Key? key}) : super(key: key);

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  late QuoteBloc quoteBloc = BlocProvider.of<QuoteBloc>(context);

  @override
  void initState() {
    quoteBloc.add(QuoteInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? text = '';
    Quote? quote;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2cac73),
              Color(0xFF1d3f67),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Flex(direction: Axis.vertical, children: [
            Expanded(
              child: BlocConsumer<QuoteBloc, QuoteState>(
                listenWhen: (previous, current) => current is QuoteActionState,
                buildWhen: (previous, current) => current is! QuoteActionState,
                listener: (context, state) {},
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case QuoteLoading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case QuoteError:
                      text =
                          'Can\'t load data from server. Please check again.';
                      break;
                    case QuoteFetchingSuccessfulState:
                      final snapshot = state as QuoteFetchingSuccessfulState;
                      quote = snapshot.quotes?[0];
                      text = null;
                      print("XXXXXXXXXX $text ----- $snapshot ");
                    default:
                      print(
                          "XXXXXXXXXX0 ${state is QuoteFetchingSuccessfulState}");
                      text = '${state is QuoteFetchingSuccessfulState}';
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        (text != null)
                            ? Text(text!)
                            : QuoteCard(
                                quote: quote),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    text = '';
                    Navigator.pop(context);
                  },
                  child: const Text("Back"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    quoteBloc.add(QuoteRefreshFetchEvent());
                  },
                  child: const Text("Refresh"),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

// FutureBuilder(
// future: QuoteAPI().fetchQuote(),
// builder: (context, snapshot) {
// switch (snapshot.connectionState) {
// case ConnectionState.none:
// case ConnectionState.waiting:
// case ConnectionState.active:
// return const Center(
// child: CircularProgressIndicator(),
// );
// case ConnectionState.done:
// var text = '';
// if (snapshot.hasError || snapshot.data == null) {
// text = 'Error: ${snapshot.error}';
// } else {
// text = snapshot.data?[0].quote ?? "";
// }
// return Center(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: <Widget>[
// Text(
// text,
// ),
// ],
// ),
// );
// }
// },
// )
