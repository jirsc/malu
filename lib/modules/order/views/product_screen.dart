import 'package:doeat/config/config.dart';
import 'package:doeat/models/models.dart';
import 'package:doeat/utils/ui/icons/font_awesome_icons.dart';
import 'package:doeat/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Map<String, dynamic>> specification = [
    {
      'name': 'Size',
      'selectionType': 'single',
      'option': [
        {'name': 'Regular', 'additionalPrice': 0.00},
        {'name': 'Large', 'additionalPrice': 10.00},
      ],
      'description': 'Pick 1',
    },
    {
      'name': 'Sugar Level',
      'selectionType': 'single',
      'option': [
        {'name': '1.2 (120% sugar)', 'additionalPrice': 0.00},
        {'name': '1 (100% sugar)', 'additionalPrice': 0.00},
        {'name': '0.7 (70% sugar)', 'additionalPrice': 0.00},
        {'name': '0.5 (50% sugar)', 'additionalPrice': 0.00},
        {'name': '0.3 (30% sugar)', 'additionalPrice': 0.00},
        {'name': '0 (No sugar added)', 'additionalPrice': 0.00},
      ],
      'description': 'Pick 1',
    },
    {
      'name': 'Ice options',
      'selectionType': 'single',
      'option': [
        {'name': 'Normal ice', 'additionalPrice': 0.00},
        {'name': 'Less ice', 'additionalPrice': 0.00},
        {'name': 'More ice', 'additionalPrice': 0.00},
        {'name': 'Cold but no ice', 'additionalPrice': 0.00},
      ],
      'description': 'Pick 1',
    },
    {
      'name': 'Add ons',
      'selectionType': 'multiple',
      'option': [
        {'name': 'Pearl', 'additionalPrice': 10.00},
        {'name': 'Coconut Jelly', 'additionalPrice': 10.00},
        {'name': 'Grass Jelly', 'additionalPrice': 20.00},
        {'name': 'Pudding', 'additionalPrice': 20.00},
        {'name': 'Salty Cream', 'additionalPrice': 20.00},
      ],
      'description': 'Optional',
    }
  ];

  int? _selection = -1;
  double totalPrice = 0.00;
  bool _showAuthSecretTextField = false;
  bool _showProviderTokenField = true;
  String _provider = 'GitHub';

  @override
  void initState() {
    totalPrice = widget.product.price as double;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 70,
            color: Colors.white,
            child: ListView.separated(
              itemCount:
                  specification.length + 2, // plus 2 for Header and footer
              itemBuilder: (context, index) => _buildSpecificationList(index),
              separatorBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 7,
                  child: const Skeleton()),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            color: Colors.white,
            width: double.infinity,
            height: 70,
            child: FullWidthButton(
              'Add to Basket - ${totalPrice.toStringAsFixed(2)}',
              enabled: false,
              textColor: Colors.white,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSpecificationList(index) {
    if (index == 0) {
      return _buildHeader();
    } else if (index == specification.length + 1) {
      return _buildLastRow(index);
    } else {
      return _buildSpecificationTile(index - 1);
    }
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            children: [
              Icon(FontAwesome4.cancel),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    widget.product.name + ' Milk Tea',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.price.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Base price',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSpecificationTile(specificationIndex) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: specification[specificationIndex]['option'].length + 1,
        itemBuilder: (context, index) =>
            _buildOptionTile(specificationIndex, index),
        separatorBuilder: (_, index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 2,
            child: const Skeleton()),
      ),
    );
  }

  Widget _buildOptionTile(specificationIndex, optionIndex) {
    if (optionIndex == 0) {
      return _buildOptionHeader(specificationIndex);
    } else {
      String optionName =
          specification[specificationIndex]['option'][optionIndex - 1]['name'];
      double optionAdditionalPrice = specification[specificationIndex]['option']
          [optionIndex - 1]['additionalPrice'];

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Radio<int>(
                value: optionIndex - 1,
                groupValue: _selection,
                activeColor: theme.primaryColor,
                onChanged: _handleRadioButtonSelected,
              ),
              Text(optionName),
            ],
          ),
          optionAdditionalPrice == 0
              ? Text(optionAdditionalPrice.toStringAsFixed(2))
              : Text('+${optionAdditionalPrice.toStringAsFixed(2)}'),
        ],
      );
    }
  }

  Widget _buildOptionHeader(index) {
    return Row(
      children: [
        Text(
          index == specification.length + 1
              ? 'Note to vendor'
              : specification[index]['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          index == specification.length + 1 ? 'Optional' : 'Pick 1',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  _handleRadioButtonSelected(int? value) {
    setState(() {
      _selection = value;

      switch (_selection) {
        case 1:
          {
            _provider = 'GitHub';
          }
          break;

        case 2:
          {
            _provider = 'Facebook';
          }
          break;

        default:
          {
            _provider = 'Google';
          }
      }
    });
  }

  Widget _buildLastRow(index) {
    return _buildOptionHeader(index);
  }
}
