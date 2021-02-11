import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/common/platformalertdialog.dart';
import 'package:flutterhackathon_firecode/exceptions.dart';
import 'package:flutterhackathon_firecode/ui/rewardpage.dart';
import 'package:flutterhackathon_firecode/ui/uploadpage.dart';
import 'package:flutterhackathon_firecode/viewmodel/viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging=FirebaseMessaging.instance;
 
  @override
  void initState(){
    _firebaseMessaging.subscribeToTopic("all");
    _firebaseMessaging.getInitialMessage();
    getPermission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
    final _userviewmodel = Provider.of<ViewModel>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("CIVIL", style: Theme.of(context).textTheme.headline6),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(FontAwesomeIcons.heart,color: Theme.of(context).primaryColor), onPressed:() {}),
                Text("0",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20.0),)
              ],
              
            ),
          ),
          
          IconButton(
              icon: Icon(
                FontAwesomeIcons.medal,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>RewardPage()));
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.logout, color: Theme.of(context).primaryColor),
              onPressed: () => _confirmExit(context),
            ),
          )
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/img/logo.png')),
            Text(_userviewmodel.userModel.email.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold, fontSize: 15.0)),
            
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Hoşgeldin!",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 35.0)),
            ),
          
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              
                  child: Text(
                "Çevreni iyileştirmek ister misin?\nHadi başlayalım!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.camera, size: 30),
        onPressed: () {
           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>UploadPage()));
           
        },
      ),
    );
  }

  Future _confirmExit(BuildContext context) async {
    try {
      final _result = await PlatformAlertDialog(
        title: "Emin misin?",
        content: "Çıkış yapmak üzeresin...",
        mainaction: "Çık",
        secondaction: "İptal",
      ).show(context);
      if (_result == true) {
        _logOut(context);
      }
    } on FirebaseAuthException catch (e) {
      PlatformAlertDialog(
              title: "Kullanıcı Çıkışı Hata !!!",
              content: Exceptions.show(e.code),
              mainaction: "Tamam")
          .show(context);
    }
  }

  Future<bool> _logOut(BuildContext context) async {
    final _userviewmodel = Provider.of<ViewModel>(context, listen: false);
    bool sonuc = await _userviewmodel.signOut();
    return sonuc;
  }
  void getPermission() async {
    try {
      LocationPermission _permission = await Geolocator.checkPermission();
      debugPrint("permission: " + _permission.toString());

      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      debugPrint("++" + isLocationServiceEnabled.toString());

      if (_permission == LocationPermission.always ||
          _permission == LocationPermission.whileInUse) {
        getLocation();
      } else {
        // Future _per = GeolocatorPlatform.instance.isLocationServiceEnabled();
        LocationPermission permission = await Geolocator.checkPermission();
        bool _bool = await Geolocator.openLocationSettings();
        if (permission == LocationPermission.denied && _bool == false) {
          await Geolocator.requestPermission();
          await Geolocator.openLocationSettings();
        } else {
          getLocation();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getLocation() async {
    try {
      Position _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var _position = _currentPosition;

      
    } catch (e) {
      PlatformAlertDialog(
              title: "Hata!!!",
              content: "Konum bilginiz sağlanamıyor",
              mainaction: "Tamam")
          .show(context);
    }
  }
}
