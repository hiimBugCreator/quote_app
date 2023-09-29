part of 'quote_bloc.dart';

@immutable
abstract class QuoteEvent {}

abstract class QuoteFetchEvent extends QuoteEvent {}

class QuoteInitialFetchEvent extends QuoteFetchEvent {}

class QuoteRefreshFetchEvent extends QuoteFetchEvent {}
