import 'package:flutter/material.dart';
import 'package:malu/modules/modules.dart';
import 'package:malu/widgets/custom_alert_dialog.dart';

class CategoryTitle extends StatelessWidget {
  const CategoryTitle(this.title, {Key? key}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: (() {
              // SnackBar snackBar = const SnackBar(
              //   content: Text('Let\'s see more food later ah, okay lang?'),
              // );

              // ScaffoldMessenger.of(context).showSnackBar(snackBar);

              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return CustomAlertDialog(
              //           title: "More food.. later po",
              //           content: "Okay lang? Milktea muna tayo. hehe.",
              //           cancelButtonText: 'Ayaw, unless libre mo',
              //           confirmButtonText: 'Sige tara!',
              //           onConfirm: () {
              //             Navigator.pop(context);
              //           });
              //     });
              Navigator.of(context) /*!*/ .push(
                MaterialPageRoute<void>(
                    builder: (_) => const SearchScreen(
                          searchResultType: SearchResultType.all,
                        )),
              );
            }),
            child: const Text(
              'See more',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
