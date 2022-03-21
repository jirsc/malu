class Order {
  final String itemName;
  final int qty;
  final double totalPrice;

  const Order({
    required this.itemName,
    required this.qty,
    required this.totalPrice,
  });

  /// Empty order
  static const empty = Order(itemName: '', qty: 0, totalPrice: 0);

  /// Convenience getter to determine whether the current order is empty.
  bool get isEmpty => this == Order.empty;

  /// Convenience getter to determine whether the current order is not empty.
  bool get hasData => this != Order.empty;
}
