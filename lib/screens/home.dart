import 'package:flutter/material.dart';
import 'package:mntd_mobile/components/menu_and_search.dart';
import 'package:mntd_mobile/models/secret_model.dart';
import 'package:mntd_mobile/providers/SecretCardProvider.dart';
import 'package:mntd_mobile/services/secrets_service.dart';
import 'package:mntd_mobile/utils/data.dart';
import 'package:provider/provider.dart';

import 'SecretsList/components/card_secret.dart';
import 'SecretsList/components/category_secrets_list.dart';

class Home extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (cotext) => Home());
  }

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Search state
  TextEditingController _searchController = new TextEditingController();
  bool _isSearching = false;
  List<Secret> secrets = [];
  void searching() {}

  void onSearchCancel() {
    setState(() {
      _isSearching = false;
      _searchController.text = "";
    });
  }

  void startSearching() {
    setState(() {
      _isSearching = true;
      print(_isSearching);
    });
  }
  //End Search state

  var currentPage = images.length - 1.0;
  final SecretsService secretsService = SecretsService();
  @override
  Widget build(BuildContext context) {
    Provider.of<SecretCardProvider>(context).initialState();
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
      // backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // menu & search actions
            _isSearching
                ? search(onSearchCancel, searching, _searchController)
                : navBar(startSearching),
            // SecretsPageScreen name text when will be show total of secrets by username
            SizedBox(
              height: 20,
            ),
            // Validate if secretCardProvider have data.
            (Provider.of<SecretCardProvider>(context).getSecretsdLength() > 0
                ? Consumer<SecretCardProvider>(
                    builder: (context, secrets, child) => SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Secrets #${secrets.getSecretsdLength()}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 46,
                                      fontFamily: "Calibre-Semibold",
                                      letterSpacing: 1.0),
                                ),
                                Icon(Icons.storage)
                                // IconButton(icon: Icon(CustomIcons.option,size: 12.0,color: Colors.white,), onPressed: (){})
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // List of categories
                          Categorylist(),
                          SizedBox(
                            height: 20,
                          ),
                          // Stack of CardViews for a secrets by username
                          Stack(
                            children: <Widget>[
                              CardScrollWidget(
                                secrets: secrets.allSecrets,
                                currentPage: currentPage,
                              ),
                              Positioned.fill(
                                  child: PageView.builder(
                                itemCount: secrets.getSecretsdLength(),
                                controller: controller,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return Container();
                                },
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                  )

                // if not have data make a sync request to API and render the same logic, Add snackbar that provide message to the user for this process
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: FutureBuilder(
                            future: secretsService.getSecrets('kalix'),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Secret>> snapshot) {
                              if (snapshot.hasData) {
                                secrets = snapshot.data;
                                Provider.of<SecretCardProvider>(context,
                                        listen: false)
                                    .addSecrets(secrets);
                                return SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Secrets #${secrets.length}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 46,
                                                  fontFamily:
                                                      "Calibre-Semibold",
                                                  letterSpacing: 1.0),
                                            ),
                                            Icon(Icons.sync)
                                            // IconButton(icon: Icon(CustomIcons.option,size: 12.0,color: Colors.white,), onPressed: (){})
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // List of categories
                                      Categorylist(),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // Stack of CardViews for a secrets by username
                                      Stack(
                                        children: <Widget>[
                                          CardScrollWidget(
                                            secrets: secrets,
                                            currentPage: currentPage,
                                          ),
                                          Positioned.fill(
                                              child: PageView.builder(
                                            itemCount: secrets.length,
                                            controller: controller,
                                            reverse: true,
                                            itemBuilder: (context, index) {
                                              return Container();
                                            },
                                          ))
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        )
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
