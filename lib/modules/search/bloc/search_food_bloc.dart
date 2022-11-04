import 'package:bloc/bloc.dart';
import 'package:malu/models/models.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/food_repository.dart';

part 'search_food_event.dart';
part 'search_food_state.dart';

class SearchFoodBloc extends Bloc<SearchFoodEvent, SearchFoodState> {
  /* SearchFoodBloc() : super(const SearchFoodState.initial()) {
    on<FoodDataFetched>(_getFoods);
  } */
  SearchFoodBloc({
    required this.repository,
  }) : super(const SearchFoodState()) {
    on<FoodDataFetched>(_onFoodDataFetched);
    on<SearchTextChanged>(_onSearchTextChanged);
    on<SearchDone>(_onSearchDone);
  }

  final FoodRepository repository;

  void _onFoodDataFetched(
      FoodDataFetched event, Emitter<SearchFoodState> emit) async {
    emit(state.copyWith(status: SearchFoodStatus.loading));
    try {
      final foods = await repository.getFoods();
      emit(
        state.copyWith(
          status: SearchFoodStatus.loaded,
          foods: foods,
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: SearchFoodStatus.error));
    }
  }

  void _onSearchTextChanged(
      SearchTextChanged event, Emitter<SearchFoodState> emit) async {
    emit(state.copyWith(status: SearchFoodStatus.loading));
    try {
      final foods = await repository.getFoods();
      emit(
        state.copyWith(
            status: SearchFoodStatus.suggesting,
            foods: foods,
            suggestionList: _getSuggestionList(event.text, foods)),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: SearchFoodStatus.error));
    }
  }

  void _onSearchDone(SearchDone event, Emitter<SearchFoodState> emit) async {
    emit(state.copyWith(status: SearchFoodStatus.loading));
    try {
      final foods = await repository.getFoods();
      emit(
        state.copyWith(
          status: SearchFoodStatus.searchDone,
          foods: _getSearchResultList(foods, event.text),
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: SearchFoodStatus.error));
    }
  }

  List<String> _getSuggestionList(String text, List<Food> foods) {
    var list = ['test1'];
    if (foods.isNotEmpty) {
      list = foods
          .where((element) =>
              element.name.toLowerCase().startsWith(text.toLowerCase()))
          .take(7)
          .map((e) => e.name)
          .toList();
      if (text.isEmpty) {
        list.add('Search all food');
      } else {
        list.add('Search for "$text"');
      }
    }
    return list;
  }

  List<Food> _getSearchResultList(List<Food> foods, String searchText) {
    //var list = Food.generateTrendingFood()
    var list = foods.where((element) {
      return element.name.toLowerCase().contains(searchText.toLowerCase()
          /* RegExp(
              r'' + searchText.toLowerCase() + '',
              //caseSensitive: false,
            ), */
          );
    }).toList()
      ..sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    return list;
  }
}
