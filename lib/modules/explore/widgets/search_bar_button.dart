import 'package:flutter/material.dart';
import 'package:malu/utils/utils.dart';
import 'package:malu/modules/modules.dart';

class SearchBarButton extends StatefulWidget {
  const SearchBarButton({Key? key}) : super(key: key);

  @override
  State<SearchBarButton> createState() => _SearchBarButtonState();
}

class _SearchBarButtonState extends State<SearchBarButton>
    with SingleTickerProviderStateMixin {
  String animationString = 'adobo';
  final List<String> foodList = ['adobo', 'sinigang', 'sisig', 'chopsuey'];

  late AnimationController _animationController;
  late Animation<int> animation;
  bool animationControllerDisposed = false;

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 300),
    )..forward();

    animation = IntTween(begin: 0, end: foodList.first.length)
        .animate(_animationController);

    _animationController.addListener(() async {
      if (_animationController.isCompleted) {
        await Future.delayed(const Duration(seconds: 2));

        if (!animationControllerDisposed) {
          await _animationController.reverse();

          setState(() {
            var item = foodList.removeAt(0);
            foodList.add(item);
            animationString = foodList.first;
            animation = IntTween(begin: 0, end: animationString.length)
                .animate(_animationController);
          });
        }
      } else if (_animationController.isDismissed) {
        _animationController.forward();
      }
    });

    /* WidgetsBinding.instance.addPostFrameCallback(
        (_) => animateTypingText(context));  */
  }

  /* Future<void> animateTypingText() async {
    /* String food = '';
    int lastIndex = foodList.length - 1;

    for (int i = 0; i <= lastIndex; i++) {
      food = foodList[i];
      animation =
          IntTween(begin: 0, end: food.length).animate(_animationController);
      _animationController.forward();
      await Future.delayed(const Duration(seconds: 2));
      _animationController.reverse();

      if (i == lastIndex) {
        //i = 0;
      }
    } */
    //_animationController.repeat(reverse: true);

    _animationController.forward();
    _animationController.addListener(() async {
      if (_animationController.isCompleted) {
        await Future.delayed(const Duration(seconds: 2));
        _animationController.reverse();
      } else if (_animationController.isDismissed) {
        _animationController.forward();
      }
    });
  } */

  @override
  void dispose() {
    animationControllerDisposed = true;
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onSurface: Colors.grey,
          elevation: 3,
          alignment: Alignment.centerLeft,
          //fixedSize: Size(MediaQuery.of(context).size.width, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
        onPressed: () => _pushPage(context, SearchScreen()),
        icon: Icon(
          Icons.search_outlined,
          color: Colors.grey.shade700,
          size: 25,
        ),
        label: TypingText(
          string: animationString,
          animation: animation,
        ),
      ),
    );
  }
}
