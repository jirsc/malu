import 'package:doeat/config/config.dart';
import 'package:doeat/models/models.dart';
import 'package:doeat/modules/order/order.dart';
import 'package:doeat/utils/ui/ui.dart';
import 'package:doeat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class VendorScreen extends StatefulWidget {
  final Vendor vendor;

  const VendorScreen({Key? key, required this.vendor}) : super(key: key);

  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final _controller = ScrollController();

  double get maxHeight => 120 + MediaQuery.of(context).padding.top;

  double get minHeight => kToolbarHeight + MediaQuery.of(context).padding.top;

  bool isEmpty = false;
  bool isCollapsed = false;
  Size vendorDetailsCardSize = const Size(0, 0);
  List<ProductSection> productSections =
      ProductSection.generateProductSectionList();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomStack(
        children: [
          IgnorePointer(
            ignoring: isCollapsed,
            child: const VendorScreenHeader(),
          ),
          NotificationListener<ScrollUpdateNotification>(
            onNotification: (_) {
              _snapAppbar();
              return false;
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              slivers: [
                SliverAppBar(
                  iconTheme: IconThemeData(
                    opacity: isCollapsed ? 1 : 0,
                  ),
                  leading: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      FontAwesome4.angle_left,
                      color: Colors.black87,
                      size: 25,
                    ),
                  ),
                  pinned: isCollapsed,
                  //stretch: true,
                  backgroundColor:
                      isCollapsed ? Colors.white : Colors.transparent,
                  /* flexibleSpace: Header(
                    maxHeight: 400, //maxHeight,
                    minHeight: minHeight,
                  ), */
                  collapsedHeight: 100,
                  expandedHeight:
                      maxHeight - MediaQuery.of(context).padding.top,
                  title: isCollapsed
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.vendor.name + " - address",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Icon(
                              FontAwesome4.ellipsis,
                              size: 13,
                            ),
                          ],
                        )
                      : const Text(''),
                ),
                SliverToBoxAdapter(
                  child: _buildVendorDetailsCard(),
                ),
                if (!isEmpty)
                  MultiSliver(
                    children: buildSectionList(sections: productSections),
                  )
                /* SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var section = productSections[index];
                        return _buildCard(index);
                      },
                      childCount: productSections.length,
                    ),
                  ) */
                else
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        "List is empty",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorDetailsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: WidgetSizeListener(
          onChange: (Size size) {
            setState(() {
              vendorDetailsCardSize = size;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.vendor.name + ' - address',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(
                      FontAwesome4.star,
                      color: Colors.yellow,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.vendor.score.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        print('text button pressed');
                      },
                      child: const Text(
                        'See Details',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    print('deliver now tapped');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/ad2.jpg'),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.vendor.distance,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Deliver now',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        FontAwesome4.angle_right,
                        color: Colors.grey.shade700,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    print('check available offers tapped');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesome4.tag,
                            size: 13,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Check for available offers',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              //fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        FontAwesome4.angle_right,
                        color: Colors.grey.shade700,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Text('Scroll View Horizontal dito'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildSectionList({required List<ProductSection> sections}) =>
      sections
          .map((productSection) => VendorProductSection(
              section: productSection, product: productSection.product))
          .toList();

  Widget _buildCard(int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Text("Item $index"),
      ),
    );
  }

  void _snapAppbar() {
    /*final scrollDistance = maxHeight - minHeight;

    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final double snapOffset =
          _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;

      Future.microtask(() => _controller.animateTo(snapOffset,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn));
    } */

    setState(() {
      isCollapsed = _controller.offset > vendorDetailsCardSize.height;
    });
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    return expandRatio;
  }
}

/* class Header extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  const Header({Key? key, required this.maxHeight, required this.minHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final expandRatio = _calculateExpandRatio(constraints);
        final animation = AlwaysStoppedAnimation(expandRatio);

        /* return Stack(
          fit: StackFit.expand,
          children: [
            //_buildGradient(animation),
            _buildTitle(animation),
          ],
        ); */
        return Container();
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    return expandRatio;
  }

  Align _buildTitle(Animation<double> animation) {
    return Align(
      alignment: AlignmentTween(
              begin: Alignment.bottomCenter, end: Alignment.bottomLeft)
          .evaluate(animation),
      child: Container(
        margin: EdgeInsets.only(bottom: 12, left: 12),
        child: Text(
          "THE WEEKEND",
          style: TextStyle(
            fontSize: Tween<double>(begin: 18, end: 36).evaluate(animation),
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Container _buildGradient(Animation<double> animation) {
    return Container(
      decoration: BoxDecoration(
        color:
            ColorTween(begin: Colors.black.withOpacity(0.7), end: Colors.white)
                .evaluate(animation),
      ),
    );
  }
} */
