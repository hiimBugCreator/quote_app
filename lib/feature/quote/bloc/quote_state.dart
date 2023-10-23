part of 'quote_bloc.dart';

@immutable
abstract class QuoteState {}

abstract class QuoteActionState extends QuoteState {}

class QuoteInitial extends QuoteState {
  QuoteInitial();
}

class QuoteLoading extends QuoteState {
  final bool onBackground;
  QuoteLoading({this.onBackground = false});}

class QuoteError extends QuoteState {}

class QuoteFetchingSuccessfulState extends QuoteState {
  final List<Quote>? quotes;

  QuoteFetchingSuccessfulState({required this.quotes});
}
