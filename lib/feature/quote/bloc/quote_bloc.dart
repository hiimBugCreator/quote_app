import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:quote_app/feature/quote/repos/quote_repo.dart';
import 'package:quote_app/models/quote.dart';

part 'quote_event.dart';

part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteInitial()) {
    on<QuoteInitialFetchEvent>(quoteFetchEvent);
    on<QuoteRefreshFetchEvent>(quoteFetchEvent);
  }

  FutureOr<void> quoteFetchEvent(
      QuoteFetchEvent event, Emitter<QuoteState> emit) async {
    emit(QuoteLoading());
    try {
      var response = await QuoteRepo.fetchQuote();
      emit(QuoteFetchingSuccessfulState(quotes: response));
    } on DioException catch (e) {
      print(e.error);
      print(e.message);
      emit(QuoteError());
    }
  }
}
