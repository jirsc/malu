import 'package:flutter/material.dart';
import 'package:doeat/utils/utils.dart';

class SearchBarStateless extends StatelessWidget {
  const SearchBarStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(1, 0),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              prefixIcon: Icon(
                Icons.search_outlined,
                color: Theme.of(context).colorScheme.onSurface,
                size: 30,
              ),
              hintText: 'What are you craving for?',
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
