part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

/* class DataRequested extends OrderEvent {
  const DataRequested({
    required this.user,
  });
  final User user;

  @override
  List<Object> get props => [user];
} */

class OrderAdded extends OrderEvent {
  const OrderAdded({
    required this.basket,
  });
  //final Basket basket;
  final List<Order> basket;

  @override
  List<Object> get props => [basket];
}

class OrderPlaced extends OrderEvent {
  const OrderPlaced({
    required this.user,
  });
  final User user;

  @override
  List<Object> get props => [user];
}
