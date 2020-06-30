import 'package:flutter/material.dart';
import 'package:mntd_mobile/utils/customIcons.dart';
import 'package:mntd_mobile/utils/themes/colors.dart';

Widget navBar(Function startSearching, bool darkMode) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            icon: Icon(
              CustomIcons.menu,
              color: darkMode ? GFColors.DARK : GFColors.LIGHT,
              size: 30.0,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.search,
              color: darkMode ? GFColors.DARK : GFColors.LIGHT,
              size: 30.0,
            ),
            onPressed: () {
              startSearching();
            }),
      ],
    ),
  );
}

Widget search(Function cancelSearch, Function searching,
    TextEditingController searchController, bool darkMode) {
  return AppBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19.0)),
    automaticallyImplyLeading: false,
    leading: IconButton(
        color: darkMode ? GFColors.DARK : GFColors.LIGHT,
        icon: Icon(
          Icons.arrow_back_ios,
          color: darkMode ? GFColors.DARK : GFColors.LIGHT,
        ),
        onPressed: () {
          cancelSearch();
        }),
    title: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        child: TextField(
          controller: searchController,
          onEditingComplete: () {
            searching();
          },
          style:
              new TextStyle(color: darkMode ? GFColors.DARK : GFColors.LIGHT),
          cursorColor: darkMode ? GFColors.DARK : GFColors.LIGHT,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search...",
            focusColor: GFColors.FOCUS,
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: darkMode ? GFColors.DARK : GFColors.LIGHT),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: darkMode ? GFColors.DARK : GFColors.LIGHT,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
