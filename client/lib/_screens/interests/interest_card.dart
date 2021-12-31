import 'package:client/_controllers/other_controllers.dart';
import 'package:client/_models/interest_model.dart';
import 'package:client/_utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class InterestCard extends StatelessWidget {
  final InterestModel interest;
  InterestCard({Key? key, required this.interest}) : super(key: key);
  final OtherControllers _controller = OtherControllers();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Obx(() => GestureDetector(
          onTap: () {
            _controller.isSelected.toggle();
            OtherControllers.userInterests.add(interest.title);
          },
          child: Container(
            width: _size.width * 0.4,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: kBorderColor),
                color:
                    _controller.isSelected.isTrue ? kPrimaryColor : kBgColor),
            child: Row(
              children: [
                SvgPicture.asset(interest.icon,
                    color: _controller.isSelected.isTrue
                        ? kBgColor
                        : kPrimaryColor),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  interest.title,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: _controller.isSelected.isTrue
                          ? kBgColor
                          : Colors.grey[800],
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ));
  }
}
