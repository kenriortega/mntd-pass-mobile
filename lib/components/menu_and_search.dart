import 'package:flutter/material.dart';
import 'package:mntd_mobile/utils/customIcons.dart';

Widget navBar(Function startSearching) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            icon: Icon(
              CustomIcons.menu,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
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
    TextEditingController searchController) {
  return AppBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19.0)),
    automaticallyImplyLeading: false,
    leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
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
          style: new TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          autofocus: true,
          decoration: InputDecoration(
              hintText: "Search...",
              focusColor: Colors.red,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
      ),
    ),
  );
}
