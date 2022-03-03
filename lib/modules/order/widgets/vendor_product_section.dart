import 'package:doeat/models/models.dart';
import 'package:doeat/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'dart:math' as math;

class VendorProductSection extends StatelessWidget {
  final ProductSection section;
  final List<Product> product;

  const VendorProductSection({
    Key? key,
    required this.section,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiSliver(
        pushPinnedChildren: true,
        children: [
          /* SliverStack(
              insetOnOverlap: true,
              children: [
                SliverPositioned.fill(
                  top: 16,
                  child: CardBackgroundWidget(),
                ),
                buildCard(context),
              ],
            ), */
          buildCard(context),
        ],
      );

  Widget buildCard(BuildContext context) => MultiSliver(
        children: <Widget>[
          SliverPinnedHeader(
            child: Header(
              title: section.title,
              productCategory: section.productCategory,
            ),
          ),
          SliverClip(
            child: /* MultiSliver(
              children: <Widget>[
                buildProductList(),
                Container(
                  height: 12,
                  color: Colors.white,
                  child: Divider(
                    color: Colors.grey.shade700,
                    thickness: 7,
                  ),
                ),
                //SliverToBoxAdapter(child: buildLoadMore(context)),
              ],
            ), */
                section.productCategory == ProductCategory.recommended
                    ? buildRecommendedProductGrid()
                    : buildProductList(),
          ),
          SliverToBoxAdapter(child: Container(height: 12, color: Colors.white)),
        ],
      );

  Widget buildProductList() => SliverList(
        // SliverList with Separator
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final int itemIndex = index ~/ 2;
            if (index.isEven) {
              return HorizontalProductTile(product: product[itemIndex]);
            }
            return Container(
              padding: const EdgeInsets.all(12.0),
              color: Colors.white,
              child:
                  Divider(height: 0, thickness: 1, color: Colors.grey.shade300),
            );
          },
          semanticIndexCallback: (Widget widget, int localIndex) {
            if (localIndex.isEven) {
              return localIndex ~/ 2;
            }
            return null;
          },
          childCount: math.max(0, product.length * 2 - 1),
          /* (context, index) => HorizontalProductTile(product: product[index]),
          childCount: product.length, */
        ),
      );

  Widget buildRecommendedProductGrid() => SliverGrid.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        children: List.generate(product.length, (index) {
          return VerticalProductTile(product: product[index]);
        }),
      );
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.title,
    required this.productCategory,
  }) : super(key: key);

  final String title;
  final ProductCategory productCategory;

  @override
  Widget build(BuildContext context) => Material(
        child: Container(
          padding: const EdgeInsets.only(top: 7),
          color: productCategory == ProductCategory.recommended
              ? Colors.white
              : Colors.grey.shade200,
          child: Container(
            alignment: Alignment.bottomLeft,
            //margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            /* decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ), */
            color: Colors.white,
            child: Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      );
}

class VerticalProductTile extends StatelessWidget {
  const VerticalProductTile({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductScreen(product: product),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 140,
                    width: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${product.price}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /* Text(
                              product.description,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 7),
                            _buildIconText(
                              Icons.star,
                              Colors.orange[300]!,
                              '${vendor.score}(${vendor.ratingCount}k)',
                            ),
                            const SizedBox(width: 10),
                            _buildIconText(
                              Icons.visibility,
                              Colors.grey,
                              '${vendor.weeklyOrderCount}K Orders this week',
                            ), */
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalProductTile extends StatelessWidget {
  const HorizontalProductTile({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductScreen(product: product),
              ),
            );
          },
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            //fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          '${product.price}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /* Text(
                          product.description,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 7),
                        _buildIconText(
                          Icons.star,
                          Colors.orange[300]!,
                          '${vendor.score}(${vendor.ratingCount}k)',
                        ),
                        const SizedBox(width: 10),
                        _buildIconText(
                          Icons.visibility,
                          Colors.grey,
                          '${vendor.weeklyOrderCount}K Orders this week',
                        ), */
                      ],
                    ),
                  ),
                ],
              ),
              /* Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
