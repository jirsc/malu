import 'package:doeat/config/config.dart';
import 'package:doeat/models/models.dart';
import 'package:doeat/utils/ui/icons/font_awesome_icons.dart';
import 'package:doeat/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../order.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({
    Key? key,
    required this.vendor,
    required this.basket,
  }) : super(key: key);

  final Vendor vendor;
  final List<Order> basket;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final double totalPrice = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildScrollableContent(),
          _buildPersistentFooter(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.vendor.name,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Distance from you: 2.2km',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          FontAwesome4.angle_left,
          color: Colors.grey.shade400,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildScrollableContent() {
    return Container(
      height: MediaQuery.of(context).size.height - 190,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              height: 7,
              child: const Skeleton(),
            ),
            _buildDeliveryOptionsSection(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              height: 7,
              child: const Skeleton(),
            ),
            _buildOrderSummarySection(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              height: 7,
              child: const Skeleton(),
            ),
            _buildPaymentDetailsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPersistentFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      //color: Colors.white,
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 12,
            offset: Offset(0, -10), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total'),
              Text(
                'P ${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FullWidthButton(
                  'Place Order',
                  textColor: Colors.white,
                  color: theme.primaryColor,
                  elevation: 2,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Deliver to'),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Text('Home'),
          ],
        )
      ],
    );
  }

  Widget _buildOrderSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order Summary'),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Text('Order 1'),
          ],
        )
      ],
    );
  }

  Widget _buildPaymentDetailsSection() {
    return Text('data');
  }
}
