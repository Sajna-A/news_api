import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:news/newsmodel.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this.context) : super(NewsInitial());
  BuildContext context;
  fetchdata() async {
    final url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=875a72de91ec49e8b24c453adf22da8b";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      final res = jsonDecode(response.body);
      final data = Newsapi.fromJson(res);
      emit(viewData(data: data));
    }
  }
}
