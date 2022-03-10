import 'package:doeat/app/app.dart';
import 'package:doeat/config/config.dart';
import 'package:doeat/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Management extends StatefulWidget {
  const Management({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: Management());

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sige go lang ;)',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            key: const Key('managementPage_logout_iconButton'),
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              //Scaffold.of(context).appBarMaxHeight!.toDouble(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                    TextField(),
                    SizedBox(height: 7),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(7.0),
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: FullWidthButton(
                      'Okay na ako, send!',
                      color: theme.primaryColor,
                      onPressed: () => _insertData(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _insertData() {
    print('insert data na tayo');
  }
}
