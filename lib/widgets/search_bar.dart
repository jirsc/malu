import 'package:flutter/material.dart';
import 'package:doeat/utils/utils.dart';
import 'package:doeat/config/config.dart';

typedef _SearchEventCallback = void Function(String);

class SearchBar extends StatefulWidget {
  final _SearchEventCallback? onChanged;
  //final VoidCallback? onChanged();
  final TextEditingController? controller;
  const SearchBar({Key? key, this.onChanged, this.controller})
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextField(
        controller: widget.controller,
        cursorColor: theme.primaryColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
          prefixIcon: Icon(
            FontAwesome4.search,
            color: Colors.grey.shade400,
            size: 13,
          ),
          suffixIcon: widget.controller?.text == ''
              ? null
              : GestureDetector(
                  child: Icon(
                    FontAwesome4.cancel_circled,
                    color: Colors.grey.shade400,
                    size: 14,
                  ),
                  /* onTap: () {
                    widget.controller?.clear();
                    setState(() {
                      searchText == widget.controller?.text;
                    });
                  }, */
                  onTap: () => widget.controller?.clear(),
                ),
          hintText: 'What are you craving for?',
          hintStyle: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
/* 
class SearchBar extends StatelessWidget {
  final _SearchEventCallback? onChanged;
  //final VoidCallback? onChanged();
  final TextEditingController? controller;
  const SearchBar({Key? key, this.onChanged, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: MediaQuery.of(context).size.width * 0.75,
      child: TextField(
        controller: controller,
        cursorColor: theme.primaryColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
          prefixIcon: Icon(
            FontAwesome4.search,
            color: Colors.grey.shade400,
            size: 13,
          ),
          suffixIcon: controller?.text == ''
              ? null
              : GestureDetector(
                  child: Icon(
                    FontAwesome4.cancel_circled,
                    color: Colors.grey.shade400,
                    size: 14,
                  ),
                  onTap: () => controller?.clear(),
                ),
          hintText: 'What are you craving for?',
          hintStyle: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
} */
