part of 'order_bloc.dart';

enum OrderStatus {
  initial,
  loading,
  dataLoaded, // also means "success"
  basketUpdated,
  error,
}

extension OrderStatusX on OrderStatus {
  bool get isInitial => this == OrderStatus.initial;
  bool get isLoading => this == OrderStatus.loading;
  bool get isDataLoaded => this == OrderStatus.dataLoaded;
  bool get isBasketUpdated => this == OrderStatus.basketUpdated;
  bool get isError => this == OrderStatus.error;
}

class OrderState extends Equatable {
  const OrderState({
    this.status = OrderStatus.initial,
    List<Vendor>? vendors,
    User? user,
    //Basket? basket,
    List<Order>? basket,
  })  : vendors = vendors ?? const [],
        user = user ?? User.empty,
        basket = basket ?? const [];

  final OrderStatus status;
  final List<Vendor> vendors;
  final User user;
  //final Basket basket;
  final List<Order> basket;

  @override
  List<Object> get props => [status, vendors, user];

  OrderState copyWith({
    OrderStatus? status,
    List<Vendor>? vendors,
    User? user,
    //Basket? basket,
    List<Order>? basket,
  }) {
    return OrderState(
      status: status ?? this.status,
      vendors: vendors ?? this.vendors,
      user: user ?? this.user,
      basket: basket ?? this.basket,
    );
  }
}
