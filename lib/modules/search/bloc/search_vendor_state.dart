part of 'search_vendor_bloc.dart';

enum SearchVendorStatus {
  initial,
  suggesting, // autocomplete suggestions
  loading,
  loaded, // also means "success"
  error,
  searchDone,
}

extension SearchVendorStatusX on SearchVendorStatus {
  bool get isInitial => this == SearchVendorStatus.initial;
  bool get isSuggesting => this == SearchVendorStatus.suggesting;
  bool get isLoading => this == SearchVendorStatus.loading;
  bool get isLoaded => this == SearchVendorStatus.loaded;
  bool get isError => this == SearchVendorStatus.error;
  bool get isDoneSearching => this == SearchVendorStatus.searchDone;
}

class SearchVendorState extends Equatable {
  const SearchVendorState({
    this.status = SearchVendorStatus.initial,
    List<Vendor>? vendors,
    List<String>? suggestionList,
    String? searchText,
  })  : vendors = vendors ?? const [],
        suggestionList = suggestionList ?? const [],
        searchText = searchText ?? '';

  final SearchVendorStatus status;
  final List<Vendor> vendors;
  final List<String> suggestionList;
  final String searchText;

  @override
  List<Object> get props => [status, vendors, suggestionList, searchText];

  SearchVendorState copyWith({
    List<Vendor>? vendors,
    SearchVendorStatus? status,
    List<String>? suggestionList,
    String? searchText,
  }) {
    return SearchVendorState(
      vendors: vendors ?? this.vendors,
      status: status ?? this.status,
      suggestionList: suggestionList ?? this.suggestionList,
      searchText: searchText ?? this.searchText,
    );
  }

  /* const SearchVendorState._({
    required this.status,
    this.vendor = Vendor.empty,
  }); 

  final SearchVendorStatus status;
  final Vendor vendor;

  const SearchVendorState.initial()
      : this._(status: SearchVendorStatus.initial);
  const SearchVendorState.suggesting()
      : this._(status: SearchVendorStatus.suggesting);
  const SearchVendorState.loading()
      : this._(status: SearchVendorStatus.loading);
  const SearchVendorState.loaded() : this._(status: SearchVendorStatus.loaded);
  const SearchVendorState.error() : this._(status: SearchVendorStatus.error);

  @override
  List<Object> get props => [status, vendor];
  
  */
}
