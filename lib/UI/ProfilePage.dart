import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpix/UI/Widgets/CircleImageHolder.dart';
import 'package:wallpix/Utility/Constants.dart';

import '../controllers/carosoleController.dart';

class ProfilePAge extends GetView<Controllers> {
  const ProfilePAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: const CustomScrollView(
        // ignore: prefer_const_literals_to_create_immutables
        slivers: [
          _ProfileHeader(),
        ],
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset("assets/icons/hamburger.png")),
    title: Text(
      "Wallpix",
      style: GoogleFonts.nunito(
          //   color: Color.fromRGBO(65, 84, 252, 0.44),
          fontSize: 26,
          letterSpacing: 1,
          fontWeight: FontWeight.w600),
    ),
    actions: [
      HeroIcon(
        HeroIcons.bell,
        solid: true, // Outlined icons are used by default.
        color: theme.neoncolor,
        size: 20.sp,
      ),
      SizedBox(
        width: 4.w,
      )
    ],
  );
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      height: 25.h,
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: 20.h,
            decoration: const BoxDecoration(
                // color: Colors.black,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/headerDefault.png"))),
          ),
          Positioned(
              bottom: 2.h,
              left: 0,
              right: 0,
              child: CircleHolder(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image.asset("assets/icons/avatar.png")),
                height: 10.h,
                width: 30.w,
                color: HexColor("#F1F1F1"),
              )),
        ],
      ),
    ));
  }
}
