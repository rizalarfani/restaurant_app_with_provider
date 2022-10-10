import 'package:flutter/material.dart';

import '../utils/colors_theme.dart';

class ListCategory extends StatelessWidget {
  final String? title;
  final String? img;
  final Function()? onTap;
  final int index;
  final int? selected;
  const ListCategory(
      {Key? key,
      required this.index,
      this.title,
      this.img,
      this.onTap,
      this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Ink(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          margin: const EdgeInsets.only(right: 15),
          height: 98,
          width: 58,
          decoration: BoxDecoration(
            color: selected == index ? ColorsTheme.primaryColor : Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(254, 114, 76, 0.25),
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 49,
                width: 49,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: Image.asset(
                    img!,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title ?? '',
                style: TextStyle(
                  color: selected == index
                      ? Colors.white
                      : ColorsTheme.secundaryTextColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
