import 'package:malu/app/app.dart';
import 'package:malu/repositories/repositories.dart';
import 'package:malu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:malu/modules/modules.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../../../models/food.dart';
import '../widgets/explore_screen_skeleton.dart';

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
      create: (context) => ExploreBloc(),
      child: Scaffold(
        body: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return ExploreScreenSkeleton();
            } else if (state.status.isLoaded) {
              return ListView(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Ads(),
                          const SizedBox(height: 40),
                          RecommendedUlam(Food.randomizeList(state.foods)),
                        ],
                      ),
                      const Positioned(
                        top: 140,
                        child: SearchBarButton(),
                      ),
                    ],
                  ),
                  TrendingUlam(
                    user: state.user,
                    foodList: state.foods,
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
