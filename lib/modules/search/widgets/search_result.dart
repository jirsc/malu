import 'package:malu/models/food.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/food_repository.dart';

enum SearchResultType {
  all,
  none,
  specific,
}

extension SearchResultTypeX on SearchResultType {
  bool get isAll => this == SearchResultType.all;
  bool get isNone => this == SearchResultType.none;
  bool get isSpecific => this == SearchResultType.specific;
}

class SearchResult extends StatefulWidget {
  const SearchResult({
    Key? key,
    required this.searchText,
    this.searchResultType = SearchResultType.none,
  }) : super(key: key);
  final String searchText;
  final SearchResultType searchResultType;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Food> foods = [Food.empty];
  //final textEditingController = TextEditingController();
  final foodRepository = FoodRepository(service: FirebaseFirestoreService());
  List<String> suggestionList = ['test'];

  @override
  void initState() {
    super.initState();
    //textEditingController.addListener(() => _getSuggestionList());
  }

  @override
  void dispose() {
    //textEditingController.dispose();
    super.dispose();
  }

  /* void _getSuggestionList() {
    if (foods.isNotEmpty) {
      var text = textEditingController.text;
      suggestionList = foods
          .where((element) =>
              element.name.toLowerCase().startsWith(text.toLowerCase()))
          .map((e) => e.name)
          .toList();
      suggestionList.add('Search for "$text"');
    }
  } */

  Widget _buildSuggestionListView() {
    return BlocBuilder<SearchFoodBloc, SearchFoodState>(
      builder: (context, state) {
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            final food = suggestionList[index];
            return GestureDetector(
              onTap: () {
                if (index == suggestionList.length - 1) {
                  context
                      .read<SearchFoodBloc>()
                      .add(SearchDone(text: widget.searchText));
                } else {
                  context.read<SearchFoodBloc>().add(SearchDone(text: food));
                }
                /* Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AccountScreen(),
                  ),
                ); */
              },
              child: SizedBox(
                height: 43,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: index == suggestionList.length - 1
                      ? Text(
                          food,
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 13,
                          ),
                        )
                      : TextButton.icon(
                          onPressed: () {
                            context
                                .read<SearchFoodBloc>()
                                .add(SearchDone(text: food));
                          },
                          icon: const Icon(
                            FontAwesome4.search,
                            color: Colors.grey,
                            size: 16,
                          ),
                          label: Text(
                            food,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                        ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey.shade200,
            height: 4,
            thickness: 1,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFoodBloc, SearchFoodState>(
      builder: (context, state) {
        if (state.status.isSuggesting) {
          foods = state.foods;
          suggestionList = state.suggestionList;
          return _buildSuggestionListView();
        } else if (state.status.isLoading) {
          // TODO: SKELETON LOADING
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isLoaded) {
          foods = state.foods;
          if (widget.searchResultType.isAll) {
            context.read<SearchFoodBloc>().add(const SearchDone(text: ''));
          } else {
            context
                .read<SearchFoodBloc>()
                .add(const SearchTextChanged(text: ''));
          }
          return Container();
        } else if (state.status.isError) {
          return const Text('Sorry, may error ka');
        } else if (state.status.isDoneSearching) {
          foods = state.foods;
          return Column(
            children: [
              SizedBox(height: 57, child: SearchFilter()),
              Expanded(
                child: ListView(
                  children: [
                    SearchList(list: foods),
                  ],
                ),
              ),
            ],
          );
        } else {
          context.read<SearchFoodBloc>().add(FoodDataFetched());
          return Container();
        }
      },
    );
  }
}
