import 'package:doeat/modules/modules.dart';
import 'package:collection/collection.dart';

class Basket {
  final List<Order> orderList;

  const Basket({
    this.orderList = const [],
  });

  /// Empty basket
  static const empty = Basket();

  /// Convenience getter to determine whether the current basket is empty.
  bool get isEmpty => this == Basket.empty;

  /// Convenience getter to determine whether the current basket is not empty.
  bool get hasData => this != Basket.empty;

  /// Convenience getter to calculate the total price of all items in the current basket
  double get totalPrice => orderList.map((e) => e.totalPrice).toList().sum;
}
