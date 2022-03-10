part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class DataRequested extends OrderEvent {
  const DataRequested({
    required this.user,
  });
  final User user;

  @override
  List<Object> get props => [user];
}
