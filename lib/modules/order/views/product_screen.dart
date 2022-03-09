import 'package:doeat/config/config.dart';
import 'package:doeat/models/models.dart';
import 'package:collection/collection.dart';
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
      'required': true,
      'option': [
        {'name': 'Regular', 'additionalPrice': 0.00, 'available': true},
        {'name': 'Large', 'additionalPrice': 10.00, 'available': true},
      ],
      'description': 'Pick 1',
    },
    {
      'name': 'Sugar Level',
      'selectionType': 'single',
      'required': true,
      'option': [
        {
          'name': '1.2 (120% sugar)',
          'additionalPrice': 0.00,
          'available': true
        },
        {'name': '1 (100% sugar)', 'additionalPrice': 0.00, 'available': true},
        {'name': '0.7 (70% sugar)', 'additionalPrice': 0.00, 'available': true},
        {'name': '0.5 (50% sugar)', 'additionalPrice': 0.00, 'available': true},
        {'name': '0.3 (30% sugar)', 'additionalPrice': 0.00, 'available': true},
        {
          'name': '0 (No sugar added)',
          'additionalPrice': 0.00,
          'available': true
        },
      ],
      'description': 'Pick 1',
    },
    {
      'name': 'Ice options',
      'selectionType': 'single',
      'required': true,
      'option': [
        {'name': 'Normal ice', 'additionalPrice': 0.00, 'available': true},
        {'name': 'Less ice', 'additionalPrice': 0.00, 'available': true},
        {'name': 'More ice', 'additionalPrice': 0.00, 'available': true},
        {'name': 'Cold but no ice', 'additionalPrice': 0.00, 'available': true},
      ],
      'description': 'Pick 1',
    },
    {
      'name': 'Add ons',
      'selectionType': 'multiple',
      'required': false,
      'option': [
        {'name': 'Pearl', 'additionalPrice': 10.00, 'available': true},
        {'name': 'Coconut Jelly', 'additionalPrice': 10.00, 'available': true},
        {'name': 'Grass Jelly', 'additionalPrice': 20.00, 'available': false},
        {'name': 'Pudding', 'additionalPrice': 20.00, 'available': true},
        {'name': 'Salty Cream', 'additionalPrice': 20.00, 'available': true},
      ],
      'description': 'Optional',
    }
  ];

  Map<int, int> selectedOptions = {};
  Map<int, double> selectedOptionPrice = {};
  double basePrice = 0.00;
  double totalPrice = 0.00;
  double totalPricePerQuantity = 0.00;
  int quantity = 1;
  bool enabled = false;
  List<int?> requiredSpecifications = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    totalPrice =
        totalPricePerQuantity = basePrice = widget.product.price as double;
    requiredSpecifications = specification
        .mapIndexed(
            (index, element) => element['required'] == true ? index : null)
        .where((element) => element != null)
        .toList();
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
              enabled: enabled,
              textColor: Colors.white,
              color: theme.primaryColor,
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
          padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    FontAwesome4.cancel,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
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
                      fontSize: 20,
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Base price',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,
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
      bool isOptionAvailable = specification[specificationIndex]['option']
          [optionIndex - 1]['available'];

      return RadioListTile<int>(
        value: optionIndex - 1,
        groupValue: selectedOptions[specificationIndex] ?? -1,
        activeColor: theme.primaryColor,
        title: Text(
          optionName,
          style: TextStyle(
            color: isOptionAvailable ? Colors.black : Colors.grey.shade400,
            fontSize: 14,
          ),
        ),
        subtitle: isOptionAvailable
            ? null
            : Text(
                'Unavailable',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
              ),
        secondary: optionAdditionalPrice == 0
            ? Text(
                optionAdditionalPrice.toStringAsFixed(2),
                style: TextStyle(
                  color:
                      isOptionAvailable ? Colors.black : Colors.grey.shade400,
                ),
              )
            : Text(
                '+${optionAdditionalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  color:
                      isOptionAvailable ? Colors.black : Colors.grey.shade400,
                ),
              ),
        onChanged: (value) => isOptionAvailable
            ? _handleRadioButtonSelected(
                value, specificationIndex, optionAdditionalPrice)
            : null,
      );
    }
  }

  Widget _buildOptionHeader(index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          index == specification.length + 1
              ? 'Note to vendor'
              : specification[index]['name'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          index == specification.length + 1
              ? 'Optional'
              : specification[index]['description'],
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  _handleRadioButtonSelected(int? value, int specificationIndex, double price) {
    setState(() {
      selectedOptions[specificationIndex] = value ?? -1;
      selectedOptionPrice[specificationIndex] = price;
      enabled = selectedOptions.keys
          .toSet()
          .containsAll(requiredSpecifications.toSet());
      var list =
          selectedOptionPrice.entries.map((element) => element.value).toList();
      totalPricePerQuantity = basePrice + list.sum;
      totalPrice = totalPricePerQuantity * quantity;
    });
  }

  Widget _buildLastRow(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          _buildOptionHeader(index),
          const SizedBox(height: 12),
          _buildNoteField(),
          _buildQuantityField(),
        ],
      ),
    );
  }

  Widget _buildNoteField() {
    return TextField(
      controller: _controller,
      readOnly: true,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      onTap: () async {
        await showDialog<void>(
          context: context,
          useRootNavigator: false,
          builder: (BuildContext context) {
            return _buildNoteInputDialog();
          },
        );
      },
    );
  }

  Widget _buildNoteInputDialog() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      FontAwesome4.cancel,
                      color: Colors.grey.shade700,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 21),
                  Text(
                    'Note to vendor',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Text(
                      'Optional',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 7),
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.all(12),
                        hintText:
                            'Add your request (subject to restaurant\'s discretion)',
                        hintStyle: TextStyle(fontSize: 12),
                      ),
                      cursorColor: theme.primaryColor,
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: FullWidthButton(
                            'Confirm',
                            color: theme.primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSubtractQuantityButton(),
          SizedBox(width: 30),
          Text(
            quantity.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 30),
          _buildAddQuantityButton(),
        ],
      ),
    );
  }

  Widget _buildSubtractQuantityButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: IconButton(
        padding: const EdgeInsets.all(2),
        icon: Icon(
          FontAwesome4.minus,
          color: theme.primaryColor,
        ),
        onPressed: () {
          setState(() {
            if (quantity > 1) {
              totalPrice -= totalPricePerQuantity;
              quantity--;
            }
          });
        },
      ),
    );
  }

  Widget _buildAddQuantityButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: IconButton(
        padding: const EdgeInsets.all(3),
        icon: Icon(
          FontAwesome4.plus,
          color: theme.primaryColor,
        ),
        onPressed: () {
          setState(() {
            if (quantity < 20) {
              ++quantity;
              totalPrice += totalPricePerQuantity;
            }
          });
        },
      ),
    );
  }
}
