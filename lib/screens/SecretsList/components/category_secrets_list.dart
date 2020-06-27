import 'package:flutter/material.dart';
import 'package:mntd_mobile/utils/constants.dart';

class Categorylist extends StatefulWidget {
  Categorylist({Key key}) : super(key: key);

  @override
  _CategorylistState createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  int selectedCategory = 0;
  List<String> categories = ["personal", "payments", "socials", "services"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildCategory(index, context),
      ),
    );
  }

  Padding buildCategory(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = index;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index].toUpperCase(),
              style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w600,
                  color: index == selectedCategory
                      ? Colors.white
                      : Colors.grey.withOpacity(0.4)),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: index == selectedCategory
                    ? kSecondaryColor
                    : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
