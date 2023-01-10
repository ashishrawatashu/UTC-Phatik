import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utc_flutter_app/screens/navigation_drawer.dart';
import 'package:utc_flutter_app/utils/colors_code.dart';
import 'package:utc_flutter_app/utils/hex_color.dart';

class MealOnWheelScreen extends StatefulWidget {
  const MealOnWheelScreen({Key? key}) : super(key: key);

  @override
  State<MealOnWheelScreen> createState() => _MealOnWheelScreenState();
}

class _MealOnWheelScreenState extends State<MealOnWheelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      endDrawer: NavigationDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: HexColor(MyColors.primaryColor),
        title: Text(
          "Meal on wheel", style: GoogleFonts.nunito(fontSize: 18),),
      ),
      body: Container(
        color: HexColor(MyColors.grey2),
        child: Stack(
          children: [

          ],
        ),
      ),
    );
  }
}
