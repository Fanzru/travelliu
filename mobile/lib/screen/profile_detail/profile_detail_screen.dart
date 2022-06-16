import 'package:flutter/material.dart';
import "dart:math" as math;
import 'package:mobile/model/profile.dart';
import 'package:mobile/api/user.dart';
import 'package:mobile/screen/_global/components/profile_card.dart';
import 'package:mobile/screen/home/components/profile/myprofile/my_profile.dart';

class ProfilePeopleScreenArguments {
  final int id;
  ProfilePeopleScreenArguments({required this.id});
}

class ProfilePeopleScreen extends StatefulWidget {
  ProfilePeopleScreen({Key? key}) : super(key: key);
  static String routeName = "/profile-detail";
  @override
  State<ProfilePeopleScreen> createState() => _ProfilePeopleScreenState();
}

class _ProfilePeopleScreenState extends State<ProfilePeopleScreen> {
  late Future<Profile> futureProfile;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments
        as ProfilePeopleScreenArguments;

    var id = arg.id;
    futureProfile = getUserProfileById(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Reviewer"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text("Loading Profile"),
              );
            } else {
              return Center(
                  child: ProfileCard(data: snapshot.data! as Profile));
            }
          },
        ),
      ),
    );
  }
}
