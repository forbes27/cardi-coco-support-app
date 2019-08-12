import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
  home: new Search(),
));

class Search extends StatefulWidget {
  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {

  Widget appBarTitle =
  new Text(
    "Search",
    style: new TextStyle(color: Colors.white),
  );

  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list;
  bool _searchFor;
  //String _searchForText = "";
  List searchRes = new List();

  _SearchState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _searchFor = false;
          //_searchForText = "";
        });
      } else {
        setState(() {
          _searchFor = true;
          //_searchForText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchFor = false;
    values();
  }

  void values() {
    _list = List();
    _list.add("Ambrosia Beetle");
    _list.add("Red Ring Nematode");
    _list.add("Lethal Yellowing");
    _list.add("Scales");
    _list.add("Rhinoceros Beetle");
    _list.add("Leafspots(Pestalotia)");
    _list.add("Damping Off");
    _list.add("Red Palm Mite");
    _list.add("Mealy Bug");
    _list.add("Bud Rot");
    _list.add("Leafspots(Drechslera)");
    _list.add("Army Worm");
    _list.add("Coconut Caterpillar");
    _list.add("Leafspots(Anthracnose)");
    _list.add("Coconut Eriophyid Mite");
    _list.add("Coconut Moth Borer");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: globalKey,
        appBar: buildAppBar(context),
        body: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Flexible(
                  child: searchRes.length != 0 || _controller.text.isNotEmpty
                      ? new ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchRes.length,
                    itemBuilder: (BuildContext context, int index) {
                      String listData = searchRes[index];
                      return new ListTile(
                        title: new Text(listData.toString()),
                      );
                    },
                  )
                      : new ListView.builder(
                    shrinkWrap: true,
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) {
                      String listData = _list[index];
                      return new ListTile(
                        title: new Text(listData.toString()),
                      );
                    },
                  ))
            ],
          ),
        ));
  }


//this method is developed to design the actual structure of the search engine
  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (this.icon.icon == Icons.search) {
              this.icon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _controller,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white)),
                onChanged: searchOperation,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

//this method is used to start a search in the textfield provided
  void _handleSearchStart() {
    setState(() {
      _searchFor = true;
    });
  }

//this method is used to design the search button icon onto the appbar
  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search",
        style: new TextStyle(color: Colors.white),
      );
      _searchFor = false;
      _controller.clear();
    });
  }

//this method is used to determine the performance of the search operation which continuously changes
//whenever the text changes, which enables the search result to be seen instantly
  void searchOperation(String searchForText) {
    searchRes.clear();
    if (_searchFor != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchForText.toLowerCase())) {
            searchRes.add(data);
        }
      }
      //return _searchResDisplay();
    }
  }

  /*
  void _searchResDisplay() {
    setState(() {
      return new MaterialButton(
        onPressed: () async {
          if(selected != null && selected != _searchForText){
            setState((){
              searchForText = selected;
            });
          }

          /*
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => PestsPage()),
            );
            */
          },
          );
        }
      );
    }
    */

}


