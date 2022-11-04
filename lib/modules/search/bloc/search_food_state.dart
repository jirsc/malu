part of 'search_food_bloc.dart';

enum SearchFoodStatus {
  initial,
  suggesting, // autocomplete suggestions
  loading,
  loaded, // also means "success"
  error,
  searchDone,
}

extension SearchFoodStatusX on SearchFoodStatus {
  bool get isInitial => this == SearchFoodStatus.initial;
  bool get isSuggesting => this == SearchFoodStatus.suggesting;
  bool get isLoading => this == SearchFoodStatus.loading;
  bool get isLoaded => this == SearchFoodStatus.loaded;
  bool get isError => this == SearchFoodStatus.error;
  bool get isDoneSearching => this == SearchFoodStatus.searchDone;
}

class SearchFoodState extends Equatable {
  const SearchFoodState({
    this.status = SearchFoodStatus.initial,
    List<Food>? foods,
    List<String>? suggestionList,
    List<String>? searchResultList,
  })  : foods = foods ?? const [],
        suggestionList = suggestionList ?? const [],
        searchResultList = searchResultList ?? const [];

  final SearchFoodStatus status;
  final List<Food> foods;
  final List<String> suggestionList;
  final List<String> searchResultList;

  @override
  List<Object> get props => [status, foods, suggestionList, searchResultList];

  SearchFoodState copyWith({
    List<Food>? foods,
    SearchFoodStatus? status,
    List<String>? suggestionList,
    List<String>? searchResultList,
  }) {
    return SearchFoodState(
      foods: foods ?? this.foods,
      status: status ?? this.status,
      suggestionList: suggestionList ?? this.suggestionList,
      searchResultList: searchResultList ?? this.searchResultList,
    );
  }

  /* const SearchFoodState._({
    required this.status,
    this.food = Food.empty,
  }); 

  final SearchFoodStatus status;
  final Food food;

  const SearchFoodState.initial()
      : this._(status: SearchFoodStatus.initial);
  const SearchFoodState.suggesting()
      : this._(status: SearchFoodStatus.suggesting);
  const SearchFoodState.loading()
      : this._(status: SearchFoodStatus.loading);
  const SearchFoodState.loaded() : this._(status: SearchFoodStatus.loaded);
  const SearchFoodState.error() : this._(status: SearchFoodStatus.error);

  @override
  List<Object> get props => [status, food];
  
  */
}
