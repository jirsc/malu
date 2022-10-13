import 'package:malu/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malu/app/app.dart';

import 'user_account_details.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    ///Dapat ilabas itong variable na ito at ipunta sa initState.
    final user = context.select((AppBloc bloc) => bloc.state.user);

    final List<String> firstList = ['Rewards', 'Challengers', 'Invite Friends'];
    final List<String> secondList = [
      'Silver',
      'Scheduled',
      'Saved Places',
      'Emergency Contacts',
      'Business Profile'
    ];
    final List<String> thirdList = [
      'Help Centre',
      'Settings',
      'Share Feedbacks',
    ];
    final List<String> fourthList = [
      'Apply as a rider',
    ];

    Widget rowListWithHeader(
        {String? header, List<String>? listTitles, EdgeInsets? margin}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: margin,
            child: Text(header!,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listTitles?.length,
            itemBuilder: (context, position) {
              return GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
                        child: Text(
                          listTitles![position],
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.chevron_right,
                        size: 21,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  SnackBar snackBar = SnackBar(
                    content:
                        Text('${listTitles[position]} is not yet available'),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              );
            },
          )
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Wrap(
              children: [
                Row(
                  children: [
                    Avatar(photo: user.photo),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name ?? 'Sample Name',
                              style: textTheme.headline6),
                          GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 5.0),
                                    child: Text('Edit Profile',
                                        style: textTheme.bodyText2)),
                                const Icon(
                                  Icons.chevron_right,
                                  size: 21,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            onTap: (() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AccountDetailsScreen(),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    rowListWithHeader(
                        header: 'For more value',
                        listTitles: firstList,
                        margin:
                            const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 10.0)),
                    rowListWithHeader(
                        header: 'My Account',
                        listTitles: secondList,
                        margin:
                            const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 10.0)),
                    rowListWithHeader(
                        header: 'General',
                        listTitles: thirdList,
                        margin:
                            const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 10.0)),
                    rowListWithHeader(
                        header: 'Opportunities',
                        listTitles: fourthList,
                        margin:
                            const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 10.0)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
