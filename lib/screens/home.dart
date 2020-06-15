import 'package:flutter/material.dart';
import 'package:mntd_mobile/models/secret_model.dart';
import 'package:mntd_mobile/services/secrets_service.dart';
import 'package:mntd_mobile/utils/customIcons.dart';
import 'package:mntd_mobile/utils/data.dart';
import 'dart:math';

class Home extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (cotext) => Home());
  }

  Home({Key key}) : super(key: key); 

  @override
  _HomeState createState() => _HomeState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeState extends State<Home> {
  //Search state
  TextEditingController _searchController = new TextEditingController();
    bool _isSearching = false;

     void searching(){

      }

      void onSearchCancel(){
    setState(() {
      _isSearching = false;
      _searchController.text = "";
    });
  }

    void startSearching(){
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
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
      // backgroundColor: Color(0xFF2d3447),
      body: FutureBuilder(
        future: secretsService.getSecrets(),
        builder: (BuildContext context, AsyncSnapshot<List<Secret>> snapshot) {
          if (snapshot.hasData) {
            List<Secret> secrets = snapshot.data;

            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // menu & search actions
                  _isSearching ? Search(onSearchCancel, searching, _searchController) : NavBar(startSearching),                
                  // SecretsPageScreen name
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Secrets",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 46,
                                fontFamily: "Calibre-Semibold",
                                letterSpacing: 1.0)),
                        // IconButton(icon: Icon(CustomIcons.option,size: 12.0,color: Colors.white,), onPressed: (){})
                      ],
                    ),
                  ),
                  // text showing total of secrets by username
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          "${secrets.length} Secrets",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        )
                      ],
                    ),
                  ),
                  // Stack of CardViews for secrets by username
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
    );
  }
}

Widget NavBar(Function startSearching){

    return    Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
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




Widget Search(Function cancelSearch, Function searching,TextEditingController searchController){
    
    return  AppBar(
          shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(19.0)
           ),

          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: () {
              cancelSearch();
            }
            ),

           title: Padding(
             padding: const EdgeInsets.only(bottom:10),
             child: Container(
               child: TextField(
               controller: searchController,
               onEditingComplete: (){
                 searching();
               },

              style: new TextStyle(color:Colors.white),
              cursorColor: Colors.white,
              autofocus: true,
              
              decoration: InputDecoration(
                hintText: "Search..." ,
                focusColor: Colors.red,

                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),),

                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)

                )
              ),
            ),
           ),
         ), 
        );
}

class CardScrollWidget extends StatelessWidget {
  final currentPage;
  final List<Secret> secrets;
  final padding = 20.0;
  final verticalInset = 20.0;

  CardScrollWidget({@required this.currentPage, @required this.secrets});

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < secrets.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0)
                ]),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(secrets[i].img, fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text("${secrets[i].name}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "SF-Pro-Text-Regular")),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text("Get Secret",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );

          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
