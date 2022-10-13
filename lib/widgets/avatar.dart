import 'package:flutter/material.dart';

const _avatarSize = 48.0;
typedef OnTapImageEventCallback = void Function();

class Avatar extends StatefulWidget {
  final String? photo;
  final bool withBadge;
  final bool canChangeImage;
  final OnTapImageEventCallback? imageOnTapFunction;

  const Avatar(
      {Key? key,
      this.photo,
      this.withBadge = false,
      this.canChangeImage = false,
      this.imageOnTapFunction})
      : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  late bool _isOnHover;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isOnHover = false;
  }

  @override
  Widget build(BuildContext context) {
    final photo = widget.photo;

    Widget? animatedAvatar() {
      if (_isOnHover) {
        return CircleAvatar(
            radius: _avatarSize,
            backgroundColor: Colors.black87,
            child: CircleAvatar(
              radius: _avatarSize - 5.0,
              backgroundColor: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: const Text(
                  'UPLOAD NEW',
                  textAlign: TextAlign.center,
                  style: (TextStyle(
                      fontWeight: FontWeight.w900,
                      backgroundColor: Colors.transparent,
                      color: Colors.white)),
                ),
              ),
            ));
      } else {
        return CircleAvatar(
            radius: _avatarSize,
            backgroundColor: Colors.white,
            child: photo == null
                ? const Icon(Icons.person_outline, size: _avatarSize)
                : CircleAvatar(
                    radius: _avatarSize - 5.0,
                    backgroundImage: NetworkImage(photo),
                  ));
      }
    }

    if (widget.withBadge) {
      return Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      width: 4, color: Theme.of(context).primaryColorDark)),
              child: widget.canChangeImage
                  ? GestureDetector(
                      onPanDown: (_) {
                        setState(() {
                          _isOnHover = true;
                        });
                      },
                      onPanEnd: (_) {
                        setState(() {
                          _isOnHover = false;
                        });
                      },
                      onTap: () {
                        widget.imageOnTapFunction!();

                        setState(() {
                          _isOnHover = false;
                        });
                      },
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          child: animatedAvatar()),
                    )
                  : animatedAvatar()),
          Positioned(
            right: 5,
            bottom: 2,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.star_border_outlined,
                size: 16,
              ),
            ),
          )
        ],
      );
    } else {
      return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                  width: 4, color: Theme.of(context).primaryColorDark)),
          child: animatedAvatar());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
