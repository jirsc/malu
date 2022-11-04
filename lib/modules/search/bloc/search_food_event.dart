part of 'search_food_bloc.dart';

abstract class SearchFoodEvent extends Equatable {
  const SearchFoodEvent();

  @override
  List<Object> get props => [];
}

class FoodDataFetched extends SearchFoodEvent {}

class SearchTextChanged extends SearchFoodEvent {
  const SearchTextChanged({
    required this.text,
  });
  final String text;

  @override
  List<Object> get props => [text];
}

class SearchDone extends SearchFoodEvent {
  const SearchDone({
    required this.text,
  });
  final String text;

  @override
  List<Object> get props => [text];
}
