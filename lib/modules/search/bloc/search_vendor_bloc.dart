import 'package:bloc/bloc.dart';
import 'package:malu/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:malu/repositories/repositories.dart';

part 'search_vendor_event.dart';
part 'search_vendor_state.dart';

class SearchVendorBloc extends Bloc<SearchVendorEvent, SearchVendorState> {
  /* SearchVendorBloc() : super(const SearchVendorState.initial()) {
    on<VendorsDataFetched>(_getVendors);
  } */
  SearchVendorBloc({
    required this.repository,
  }) : super(const SearchVendorState()) {
    on<VendorsDataFetched>(_onVendorsDataFetched);
    on<SearchTextChanged>(_onSearchTextChanged);
    on<SearchDone>(_onSearchDone);
  }

  final VendorRepository repository;

  void _onVendorsDataFetched(
      VendorsDataFetched event, Emitter<SearchVendorState> emit) async {
    emit(state.copyWith(status: SearchVendorStatus.loading));
    try {
      final vendors = await repository.getVendors();
      emit(
        state.copyWith(
          status: SearchVendorStatus.loaded,
          vendors: vendors,
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: SearchVendorStatus.error));
    }
  }

  void _onSearchTextChanged(
      SearchTextChanged event, Emitter<SearchVendorState> emit) async {
    emit(state.copyWith(status: SearchVendorStatus.loading));
    try {
      final vendors = await repository.getVendors();
      emit(
        state.copyWith(
            status: SearchVendorStatus.suggesting,
            vendors: vendors,
            suggestionList: _getSuggestionList(event.text, vendors)),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: SearchVendorStatus.error));
    }
  }

  void _onSearchDone(SearchDone event, Emitter<SearchVendorState> emit) async {
    emit(state.copyWith(status: SearchVendorStatus.loading));
    try {
      final vendors = await repository.getVendors();
      emit(
        state.copyWith(
          status: SearchVendorStatus.searchDone,
          vendors: _getSearchResultList(vendors, event.text),
        ),
      );
    } catch (error, stacktrace) {
      //print(stacktrace);
      emit(state.copyWith(status: SearchVendorStatus.error));
    }
  }

  List<String> _getSuggestionList(String text, List<Vendor> vendors) {
    var list = ['test1'];
    if (vendors.isNotEmpty) {
      list = vendors
          .where((element) =>
              element.name.toLowerCase().startsWith(text.toLowerCase()))
          .take(7)
          .map((e) => e.name)
          .toList();
      list.add('Search for "$text"');
    }
    return list;
  }

  List<Vendor> _getSearchResultList(List<Vendor> vendors, String searchText) {
    //var list = Vendor.generateTrendingVendor()
    var list = vendors.where((element) {
      return element.name.toLowerCase().contains(searchText.toLowerCase()
          /* RegExp(
              r'' + searchText.toLowerCase() + '',
              //caseSensitive: false,
            ), */
          );
    }).toList();
    return list;
  }
}
