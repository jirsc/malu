part of 'order_bloc.dart';

enum OrderStatus {
  initial,
  loading,
  dataLoaded, // also means "success"
  error,
}

extension OrderStatusX on OrderStatus {
  bool get isInitial => this == OrderStatus.initial;
  bool get isLoading => this == OrderStatus.loading;
  bool get isDataLoaded => this == OrderStatus.dataLoaded;
  bool get isError => this == OrderStatus.error;
}

class OrderState extends Equatable {
  const OrderState({
    this.status = OrderStatus.initial,
    List<Vendor>? vendors,
    User? user,
  })  : vendors = vendors ?? const [],
        user = user ?? User.empty;

  final OrderStatus status;
  final List<Vendor> vendors;
  final User user;

  @override
  List<Object> get props => [status, vendors, user];

  OrderState copyWith({
    OrderStatus? status,
    List<Vendor>? vendors,
    User? user,
  }) {
    return OrderState(
      status: status ?? this.status,
      vendors: vendors ?? this.vendors,
      user: user ?? this.user,
    );
  }
}
