import 'package:flutter/material.dart';
import 'package:doeat/utils/utils.dart';
import 'package:doeat/config/config.dart';
import 'package:doeat/modules/modules.dart';

class SearchBarButton extends StatefulWidget {
  const SearchBarButton({Key? key}) : super(key: key);

  @override
  State<SearchBarButton> createState() => _SearchBarButtonState();
}

class _SearchBarButtonState extends State<SearchBarButton>
    with SingleTickerProviderStateMixin {
  final String string = 'seafood';
  final List<String> foodList = ['seafood', 'chicken', 'doughnut', 'pizza'];

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

    animation =
        IntTween(begin: 0, end: string.length).animate(_animationController);

    _animationController.addListener(() async {
      if (_animationController.isCompleted) {
        await Future.delayed(const Duration(seconds: 2));

        if (!animationControllerDisposed) {
          _animationController.reverse();
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
          string: string,
          animation: animation,
        ), /* GestureDetector(
          child: TypingText(
            string: string,
            animation: animation,
          ),
          onTap: () => _pushPage(context, SearchScreen()),
        ), */
      ),
    );
  }
}

/* Stack(
            children: [
              TextField(
                enabled: true,
                cursorColor: theme.primaryColor,
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
                    size: 25,
                  ),
                  /* hintText: 'What are you craving for?',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[400],
                    ), */
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                ),
                //onTap: () => Navigator.of(context).push(const SearchScreen()),
              ),
              /* Positioned(
                  top: 13,
                  left: 50,
                  child: GestureDetector(
                    child: TypingText(
                      string: string,
                      animation: animation,
                    ),
                    onTap: () => MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  ),
                ), */
            ],
          ), */