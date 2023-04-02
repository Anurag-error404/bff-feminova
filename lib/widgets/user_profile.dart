import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class UserProfileWidget extends StatelessWidget {
  final String? img;
  final String? fullName;
  final String? userName;
  const UserProfileWidget({super.key, this.img, this.fullName, this.userName});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.screenWidth * 0.5,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: Image.asset("assets/avatar.png"),
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName ?? '',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                userName ?? '',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
