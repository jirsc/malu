import 'package:doeat/modules/modules.dart';
import 'package:doeat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doeat/utils/utils.dart';
import 'package:doeat/repositories/repositories.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final vendorRepository = VendorRepository(service: VendorService());
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
      create: (context) => SearchVendorBloc(repository: vendorRepository),
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
              BlocBuilder<SearchVendorBloc, SearchVendorState>(
                builder: (context, state) {
                  return SearchBar(
                      controller: textEditingController,
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                        context
                            .read<SearchVendorBloc>()
                            .add(SearchTextChanged(text: value));
                      });
                },
              ),
            ],
          ),
        ),
        body: SearchResult(searchText: searchText ?? ''),
      ),
    );
  }
}
