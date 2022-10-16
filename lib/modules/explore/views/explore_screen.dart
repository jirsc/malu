import 'package:malu/app/app.dart';
import 'package:malu/constants/app_constants.dart';
import 'package:malu/models/models.dart';
import 'package:malu/repositories/repositories.dart';
import 'package:malu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:malu/modules/modules.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malu/widgets/widgets.dart';
import 'dart:io';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final vendorRepository = VendorRepository(service: VendorService());

  @override
  Widget build(BuildContext context) {
    var user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocProvider(
      create: (context) => ExploreBloc(repository: vendorRepository),
      child: Scaffold(
        body: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return ExploreSkeleton();
            } else if (state.status.isLoaded) {
              sleep(const Duration(milliseconds: 2000));
              return ListView(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Ads(),
                          const SizedBox(height: 40),
                          RecommendedUlam(),
                        ],
                      ),
                      Positioned(
                        top: 140,
                        child: SearchBarButton(),
                      ),
                    ],
                  ),
                  TrendingVendor(
                    user: state.user,
                  ),
                ],
              );
            } else if (state.status.isError) {
              return const Text('May error ka. sorry');
            }
            context.read<ExploreBloc>().add(DataRequested(user: user));
            return Container();
          },
        ),
      ),
    );
  }
}

class ScreenSize {
  double width;
  double height;

  ScreenSize({
    required this.width,
    required this.height,
  });
}

class ExploreSkeleton extends StatelessWidget {
  ExploreSkeleton({Key? key}) : super(key: key);

  final screenSize = ScreenSize(width: 0, height: 0);

  @override
  Widget build(BuildContext context) {
    screenSize.width = MediaQuery.of(context).size.width;
    screenSize.height = MediaQuery.of(context).size.height;
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton(height: 210, width: screenSize.width),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Skeleton(height: 120, width: 120),
                    SizedBox(height: 4),
                    Skeleton(height: 7, width: 70),
                    SizedBox(height: 4),
                    Skeleton(height: 7, width: 40),
                  ],
                ),
              ),
              const SizedBox(width: defaultPadding),
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Skeleton(height: 120, width: 120),
                    SizedBox(height: 4),
                    Skeleton(height: 7, width: 70),
                    SizedBox(height: 4),
                    Skeleton(height: 7, width: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          width: screenSize.width,
          child: Skeleton(
            height: 7,
            width: screenSize.width * 0.7,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Skeleton(width: 120, height: 120),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 7),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 7),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 7),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 7),
                            Skeleton(height: 7, width: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  children: [
                    const Skeleton(width: 120, height: 120),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 12),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 12),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 12),
                            Skeleton(height: 7, width: 120),
                            SizedBox(height: 12),
                            Skeleton(height: 7, width: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
