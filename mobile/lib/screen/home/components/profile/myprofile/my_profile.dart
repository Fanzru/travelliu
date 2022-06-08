import 'package:flutter/material.dart';
import 'package:mobile/api/user.dart';
import 'package:mobile/model/profile.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/home/components/profile/myprofile/card_profile.dart';
import 'package:mobile/screen/home/home_screen.dart';
import "dart:math" as math;

import 'package:mobile/utils/show_snackbar.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);
  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {
  late Future<List<ReviewProfile>> futureReview;
  late Future<Profile> futureProfile;
  final int randomForProfile = math.Random().nextInt(1000);
  @override
  void initState() {
    futureReview = getMyReviewById();
    futureProfile = getMyProfileById();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReviewProfile>>(
      future: futureReview,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData) {
          return ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async {
                      try {
                        await userLogout();
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeScreen.routeName, (route) => false);
                        ShowSnackBar(context, "Logout berhasil");
                      } catch (err) {
                        ShowSnackBar(context, err.toString());
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "logout ",
                        ),
                        Icon(
                          Icons.logout_outlined,
                          size: 15.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "https://www.thiswaifudoesnotexist.net/example-$randomForProfile.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: futureProfile,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: Text("Loading ..."),
                          );
                        } else {
                          return ProfileCard(data: snapshot.data);
                        }
                      }),
                  // Navigator(
                  //   key: _navKey,
                  //   onGenerateRoute: (_) =>
                  //       MaterialPageRoute(builder: (_) {
                  //     return FutureBuilder<Profile>(
                  //       builder: futureProfile,
                  //     );
                  //   }),
                  // )
                ],
              ),
              for (var data in snapshot.data!)
                TimelineCard(
                  data: data,
                )
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class ProfileCard extends StatelessWidget {
  final data;
  // final GlobalKey<NavigatorState> navKey;
  final int randomForProfile = math.Random().nextInt(1000);
  ProfileCard({
    Key? key,
    required this.data,
    // required this.navKey
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            data.user.name.toString(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text("Total Review"),
                    Text(data.totalReview.toString()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text("Rataan Rating"),
                    Text(data.avgRating.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
