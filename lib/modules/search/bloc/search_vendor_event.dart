part of 'search_vendor_bloc.dart';

abstract class SearchVendorEvent extends Equatable {
  const SearchVendorEvent();

  @override
  List<Object> get props => [];
}

class VendorsDataFetched extends SearchVendorEvent {}

class SearchTextChanged extends SearchVendorEvent {
  const SearchTextChanged({
    required this.text,
  });
  final String text;

  @override
  List<Object> get props => [text];
}

class SearchDone extends SearchVendorEvent {
  const SearchDone({
    required this.text,
  });
  final String text;

  @override
  List<Object> get props => [text];
}
