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
            widget.vendor.name + ' - address nito',
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deliver to',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          ListView(
            padding: EdgeInsets.symmetric(vertical: 7),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 7, 12.0, 7),
                        child: Icon(
                          FontAwesome4.location,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Home',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Address mo',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.grey.shade200),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Address mo rin',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11,
                                          ),
                                        ),
                                        Text(
                                          'No chuchu added',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SmallBlueTextButton(
                                      'Edit',
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 21),
                height: 2,
                child: Skeleton(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 7, 12.0, 7),
                        child: Icon(
                          FontAwesome4.location,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              'Deliver now (40 mins)',
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                        SmallBlueTextButton(
                          'Change options',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildOrderSummarySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Summary',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SmallBlueTextButton(
                'Add items',
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 12,
            itemBuilder: (context, index) {
              return _buildOrderItemTile(index);
            },
            separatorBuilder: (_, index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              height: 2,
              child: const Skeleton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemTile(int index) {
    return Row(
      children: [
        Column(
          children: [
            _buildQuantityIcon(),
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ' + index.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SmallBlueTextButton(
                    'Edit',
                    onPressed: () {},
                  ),
                ],
              ),
              Text('105.00'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityIcon() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Text(
          '1x',
          style: TextStyle(
            color: theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          GestureDetector(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Icon(
                    FontAwesome4.credit_card_alt,
                    color: theme.primaryColor,
                  ),
                ),
                SizedBox(width: 7),
                Text('P 100.00'),
              ],
            ),
            onTap: () {
              // TODO: Punta sa Payment Methods options page
              print('payment details napindot ay.');
            },
          )
        ],
      ),
    );
  }
}
