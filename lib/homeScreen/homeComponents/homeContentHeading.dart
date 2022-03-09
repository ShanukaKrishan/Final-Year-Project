import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_store/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContentHeading extends StatelessWidget {
  final String mainHeading;
  const ContentHeading({
    Key? key,
    required this.mainHeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          mainHeading,
          style: kSubTitle,
        ),
        Row(
          children: [
            const Text(
              "See all",
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(3),
            ),
            const Icon(
              FontAwesomeIcons.angleDoubleRight,
              size: 14,
              color: kPrimaryColor,
            ),
          ],
        )
      ],
    );
  }
}
