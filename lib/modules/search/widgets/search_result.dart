import 'package:malu/models/vendor.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/repositories/repositories.dart';
import 'package:malu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResult extends StatefulWidget {
  final String searchText;
  const SearchResult({Key? key, required this.searchText}) : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Vendor> vendors = [Vendor.empty];
  //final textEditingController = TextEditingController();
  final vendorRepository = VendorRepository(service: VendorService());
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
    if (vendors.isNotEmpty) {
      var text = textEditingController.text;
      suggestionList = vendors
          .where((element) =>
              element.name.toLowerCase().startsWith(text.toLowerCase()))
          .map((e) => e.name)
          .toList();
      suggestionList.add('Search for "$text"');
    }
  } */

  Widget _buildSuggestionListView() {
    return BlocBuilder<SearchVendorBloc, SearchVendorState>(
      builder: (context, state) {
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            final vendor = suggestionList[index];
            return GestureDetector(
              onTap: () {
                if (index == suggestionList.length - 1) {
                  context
                      .read<SearchVendorBloc>()
                      .add(SearchDone(text: widget.searchText));
                } else {
                  context
                      .read<SearchVendorBloc>()
                      .add(SearchDone(text: vendor));
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
                          vendor,
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 13,
                          ),
                        )
                      : TextButton.icon(
                          onPressed: () {
                            context
                                .read<SearchVendorBloc>()
                                .add(SearchDone(text: vendor));
                          },
                          icon: const Icon(
                            FontAwesome4.search,
                            color: Colors.grey,
                            size: 16,
                          ),
                          label: Text(
                            vendor,
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
    return BlocBuilder<SearchVendorBloc, SearchVendorState>(
      builder: (context, state) {
        if (state.status.isSuggesting) {
          vendors = state.vendors;
          suggestionList = state.suggestionList;
          return _buildSuggestionListView();
        } else if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status.isLoaded) {
          vendors = state.vendors;
          context
              .read<SearchVendorBloc>()
              .add(const SearchTextChanged(text: ''));
          return Container();
        } else if (state.status.isError) {
          return const Text('Sorry, may error ka');
        } else if (state.status.isDoneSearching) {
          vendors = state.vendors;
          return Column(
            children: [
              SizedBox(height: 57, child: SearchFilter()),
              Expanded(
                child: ListView(
                  children: [
                    SearchList(list: vendors),
                  ],
                ),
              ),
            ],
          );
        } else {
          context.read<SearchVendorBloc>().add(VendorsDataFetched());
          return Container();
        }
      },
    );
  }
}
