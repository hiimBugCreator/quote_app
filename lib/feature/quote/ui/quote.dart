import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:quote_app/feature/quote/bloc/quote_bloc.dart';
import 'package:quote_app/widget/quote_card.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({Key? key}) : super(key: key);

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  late QuoteBloc quoteBloc = BlocProvider.of<QuoteBloc>(context);
  final CardSwiperController controller = CardSwiperController();
  late var size = MediaQuery.of(context).size;
  late var height = size.height;
  late var width = size.width;
  List<QuoteCard> cards = [];
  var cardIndex = 0;

  @override
  void initState() {
    quoteBloc.add(QuoteInitialFetchEvent());
    super.initState();
  }

  bool onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    if (currentIndex! + 1 >= cards.length - 5) {
      var cardIndex = currentIndex+1;
      quoteBloc.add(QuoteFetchMoreEvent());
    }
    debugPrint("Size: ${cards.length}");
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String? text = '';
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
                listener: (context, state) {
                  if (state is QuoteFetchingSuccessfulState) {}
                },
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case QuoteLoading:
                      if (!(state as QuoteLoading).onBackground) {
                        return const Center(
                        child: CircularProgressIndicator(),
                      );
                      }
                    case QuoteError:
                      text =
                          'Can\'t load data from server. Please check again.';
                      break;
                    case QuoteFetchingSuccessfulState:
                      final snapshot = state as QuoteFetchingSuccessfulState;
                      var newCards = snapshot.quotes!
                          .map((q) => QuoteCard(quote: q))
                          .toList();
                      if (cards.isEmpty) {
                        cards = newCards;
                      } else {
                        cards.addAll(newCards);
                      }
                      text = null;
                  }
                  return Center(
                    child: (cards.isEmpty)
                        ? Text(text!)
                        : SizedBox(
                            width: width * 0.8,
                            height: height * 0.7,
                            child: CardSwiper(
                              controller: controller,
                              initialIndex: cardIndex,
                              cardsCount: cards.length,
                              onSwipe: onSwipe,
                              numberOfCardsDisplayed: 4,
                              backCardOffset: const Offset(30, 30),
                              cardBuilder: (
                                context,
                                index,
                                horizontalThresholdPercentage,
                                verticalThresholdPercentage,
                              ) =>
                                  cards[index],
                            ),
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
