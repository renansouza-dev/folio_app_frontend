import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:folio_app_backend/src/constants/color_constants.dart';
import 'package:folio_app_backend/src/features/auth/components/display_image_widget.dart';
import 'package:folio_app_backend/src/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  void initState() {
    super.initState();
  }

  Future<UserModel> getUserInfo() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    String? jsonUser = sharedPreferences.getString('UserModel');
    return UserModel.fromMap(json.decode(jsonUser ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: getUserInfo(),
      builder: (context, snapshot) {
        final user = snapshot;
        if (snapshot.hasData) {
          return Container(
            decoration: const BoxDecoration(
              color: scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            height: 135,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      child: DisplayImage(
                        imagePath: user.data!.photoUrl,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          user.data!.displayName,
                          style: const TextStyle(
                            color: scaffoldTextBackgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.data!.email,
                          style: const TextStyle(
                            color: scaffoldTextBackgroundColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Row(
                          children: [
                            Wrap(
                              children: [
                                Icon(
                                  Icons.money,
                                  color: scaffoldTextBackgroundColor,
                                ),
                                Text(
                                  'R\$ 10.000,00',
                                  style: TextStyle(
                                    color: scaffoldTextBackgroundColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Wrap(
                              children: [
                                Icon(
                                  Icons.add_chart,
                                  color: scaffoldTextBackgroundColor,
                                ),
                                Text(
                                  'R\$ 100,00',
                                  style: TextStyle(
                                    color: scaffoldTextBackgroundColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
