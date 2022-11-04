import 'package:malu/modules/modules.dart';
import 'package:malu/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malu/utils/utils.dart';

import '../../../repositories/food_repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
    this.searchResultType = SearchResultType.none,
  }) : super(key: key);
  final SearchResultType searchResultType;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final foodRepository = FoodRepository(service: FirebaseFirestoreService());
  final textEditingController = TextEditingController();
  String? searchText;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchFoodBloc(repository: foodRepository),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              FontAwesome4.angle_left,
              color: Colors.black54,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Row(
            children: [
              BlocBuilder<SearchFoodBloc, SearchFoodState>(
                builder: (context, state) {
                  return SearchBar(
                    controller: textEditingController,
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                      context
                          .read<SearchFoodBloc>()
                          .add(SearchTextChanged(text: value));
                    },
                    onSubmitted: (value) {
                      context
                          .read<SearchFoodBloc>()
                          .add(SearchDone(text: value));
                    },
                  );
                },
              ),
            ],
          ),
        ),
        body: SearchResult(
          searchText: searchText ?? '',
          searchResultType: widget.searchResultType,
        ),
      ),
    );
  }
}
