import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}


class LoginPage extends StatefulWidget{
  @override
  State createState() => new LoginPageState();
}


class LoginPageState extends State<LoginPage>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage('images/coconuts.jpg'), fit: BoxFit.fill),
            ),
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(bottom: 300.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80.0,
                        child: new Image.asset(
                          'images/cardilogo.png',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "CARDI Coconut Support Centre",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          //Row for login button
          new Container(
            padding: new EdgeInsets.only(top: 650.0),
            margin: new EdgeInsets.all(50.0),
            child: new Row(
              children: <Widget>[
                new MaterialButton(
                  height: 40.0,
                  minWidth: 300.0,
                  color: Colors.white,
                  textColor: Colors.black,
                  child: new Text("Login/Register",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  onPressed: ()=>{},
                  splashColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//---------------REFACTORING CORNER-------------------------

// _buildAppLogo(){
//    new Image.asset(
//      'images/cardilogo.png',
//    )
//}




//import 'package:meta/meta.dart';
//import 'dart:async';
//import 'package:flutter/rendering.dart';


//EnsureVisibleWhenFocused(
//focusNode: _usernameFocusNode,
//child: new TextFormField(
//focusNode: _usernameFocusNode,
//decoration: new InputDecoration(
//labelText: 'Username',),
////                      child: new TextFormField(
////                        decoration: new InputDecoration(
////                          labelText: "Enter Email",
////                        ),
//keyboardType: TextInputType.emailAddress,
//),
//),


///// A widget that ensures it is always visible when focused.
//class EnsureVisibleWhenFocused extends StatefulWidget {
//  const EnsureVisibleWhenFocused({
//    Key key,
//    @required this.child,
//    @required this.focusNode,
//    this.curve: Curves.ease,
//    this.duration: const Duration(milliseconds: 100),
//  }) : super(key: key);
//
//  /// The node we will monitor to determine if the child is focused
//  final FocusNode focusNode;
//
//  /// The child widget that we are wrapping
//  final Widget child;
//
//  /// The curve we will use to scroll ourselves into view.
//  ///
//  /// Defaults to Curves.ease.
//  final Curve curve;
//
//  /// The duration we will use to scroll ourselves into view
//  ///
//  /// Defaults to 100 milliseconds.
//  final Duration duration;
//
//  EnsureVisibleWhenFocusedState createState() => new EnsureVisibleWhenFocusedState();
//}
//
//class EnsureVisibleWhenFocusedState extends State<EnsureVisibleWhenFocused> {
//  @override
//  void initState() {
//    super.initState();
//    widget.focusNode.addListener(_ensureVisible);
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    widget.focusNode.removeListener(_ensureVisible);
//  }
//
//  Future<Null> _ensureVisible() async {
//    // Wait for the keyboard to come into view
//    // TODO: position doesn't seem to notify listeners when metrics change,
//    // perhaps a NotificationListener around the scrollable could avoid
//    // the need insert a delay here.
//    await new Future.delayed(const Duration(milliseconds: 600));
//
//    if (!widget.focusNode.hasFocus)
//      return;
//
//    final RenderObject object = context.findRenderObject();
//    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);
//    assert(viewport != null);
//
//    ScrollableState scrollableState = Scrollable.of(context);
//    assert(scrollableState != null);
//
//    ScrollPosition position = scrollableState.position;
//    double alignment;
//    if (position.pixels > viewport.getOffsetToReveal(object, 0.0).offset) {
//      // Move down to the top of the viewport
//      alignment = 0.0;
//    } else if (position.pixels < viewport.getOffsetToReveal(object, 1.0).offset) {
//      // Move up to the bottom of the viewport
//      alignment = 1.0;
//    } else {
//      // No scrolling is necessary to reveal the child
//      return;
//    }
//    position.ensureVisible(
//      object,
//      alignment: alignment,
//      duration: widget.duration,
//      curve: widget.curve,
//    );
//  }
//
//  Widget build(BuildContext context) => widget.child;
//}
