import 'dart:io';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/common/loginbutton.dart';
import 'package:flutterhackathon_firecode/common/platformalertdialog.dart';
import 'package:flutterhackathon_firecode/models/positionmodel.dart';
import 'package:flutterhackathon_firecode/models/usermodel.dart';
import 'package:flutterhackathon_firecode/ui/rewardpage.dart';
import 'package:flutterhackathon_firecode/viewmodel/viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/provider.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File _photo1;
  File _photo2;
  final ImagePicker _picker = ImagePicker();
  bool _locate = false;
  Position _position;

  @override
  void initState() {
    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _userviewmodel = Provider.of<ViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Fotoğraf Yükle',
            style: Theme.of(context).textTheme.headline6),
      ),
      body: _locate == true
          ? Stack(
              children: [
                Positioned(
                  child: Container(
                    width: size.width,
                    height: size.height,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.camera,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Fotoğraflar"),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Theme.of(context).primaryColor,
                              ),
                              GridView.count(
                                shrinkWrap: true,
                                primary: false,
                                padding: EdgeInsets.all(20),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                children: [
                                  GestureDetector(
                                    onTap: () => photoShot1(context),
                                    child: Container(
                                      color: Colors.black12,
                                      child: _photo1 == null
                                          ? Icon(
                                              FontAwesomeIcons.plus,
                                              color: Colors.black,
                                            )
                                          : Image.file(
                                              _photo1,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => photoShot2(context),
                                    child: Container(
                                        color: Colors.black12,
                                        child: _photo2 == null
                                            ? Icon(FontAwesomeIcons.plus,
                                                color: Theme.of(context)
                                                    .primaryColor)
                                            : Image.file(
                                                _photo2,
                                                fit: BoxFit.fill,
                                              )),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Center(
                                        child: Text("Önce",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0))),
                                    Center(
                                        child: Text("Sonra",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0)))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SocialLoginButton(
                                  buttonText: "Yükle",
                                  buttonColor: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    if (_photo1 == null || _photo2 == null) {
                                      PlatformAlertDialog(
                                              title: "Geçersiz İşlem",
                                              content: "Fotoğraf Boş Olamaz",
                                              mainaction: "Tamam")
                                          .show(context);
                                    } else {
                                      uploadFile(context);
                                      savePosition(PositionModel(
                                          user: _userviewmodel.userModel,
                                          position: LatLng(_position.latitude,
                                              _position.longitude)));
                                    }
                                  },
                                  buttonIcon: Icon(Icons.send),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 400,
                  child: Container(
                    width: size.width,
                    child: Text("Nasıl Çalışır?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0)),
                  ),
                ),
                Positioned(
                    top: 450,
                    child: Container(
                      width: size.width,
                      height: size.width,
                      child: ListView.builder(
                        itemCount: _how.length,
                        itemBuilder: (context, i) {
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10,
                                child: ListTile(
                                  leading: Icon(Icons.nature_people_sharp),
                                  title: Text(
                                    _how[i].title,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
              ],
            )
          : Container(
              width: size.width,
              height: size.height,
              child: Stack(alignment: AlignmentDirectional.center, children: [
                Positioned(
                  child: Container(
                    child: FlareActor("assets/img/lightbulb.flr",
                        fit: BoxFit.scaleDown,
                        isPaused: false,
                        shouldClip: true,
                        animation: "lightOff",
                        alignment: Alignment.center),
                  ),
                ),
                Positioned(
                  top: 630,
                  child: Container(
                    child: Text("Konum izni vermeniz gerekmektedir!",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 15.0)),
                  ),
                ),
              ]),
            ),
    );
  }

  Future photoShot1(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 70,
            child: Column(
              children: [
                ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Kamera ile Çek"),
                    onTap: () {
                      _cameraPhotoTake1();
                    }),
              ],
            ),
          );
        });
  }

  void _cameraPhotoTake1() async {
    try {
      var _newPhoto = await _picker.getImage(source: ImageSource.camera);
      //Exif ile photo bilgisi alınmaya çalışıldı
      /* var bytes =await _newPhoto.readAsBytes();
                                      var tags = await readExifFromBytes(bytes);
                                      tags.forEach((key, value) => print("$key : $value"));*/
      setState(() {
        _photo1 = File(_newPhoto.path);
        Navigator.of(context).pop();
      });
    } catch (e) {
      debugPrint("Hata Yakalandı" + e.toString());
    }
  }

  Future photoShot2(BuildContext context) {
    try {
      return showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 70,
              child: Column(
                children: [
                  ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("Kamera ile Çek"),
                      onTap: () {
                        _cameraPhotoTake2();
                      }),
                ],
              ),
            );
          });
    } catch (e) {
      debugPrint("Hata Yakalandı" + e.toString());
    }
  }

  void _cameraPhotoTake2() async {
    try {
      var _newPhoto = await _picker.getImage(source: ImageSource.camera);
      setState(() {
        _photo2 = File(_newPhoto.path);
        Navigator.of(context).pop();
      });
    } catch (e) {
      debugPrint("Hata Yakalandı" + e.toString());
    }
  }

  void uploadFile(BuildContext context) async {
    List<File> images = [];
    List<String> urlList = [];
    final _userViewModel = Provider.of<ViewModel>(context, listen: false);
    if (_photo1 != null && _photo2 != null) {
      images.add(_photo1);
      images.add(_photo2);
      for (var i = 0; i < images.length; i++) {
        var url = await _userViewModel.uploadFile(
            _userViewModel.userModel.userID, "nature_photo_$i", images[i]);
        urlList.add(url);
      }
      if (urlList.length == 2) {
        PlatformAlertDialog(
                title: "Sonuç Başarılı",
                content: "Fotoğraflar başarıyla gönderildi",
                mainaction: "Tamam")
            .show(context)
            .then((value) => Future.delayed(Duration(milliseconds: 10), () {
                  Navigator.of(context).popUntil(ModalRoute.withName("/"));
                }));
      }
    }
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
      setState(() {
        _position = _currentPosition;
      });

      setState(() {
        _locate = true;
      });
    } catch (e) {
      PlatformAlertDialog(
              title: "Hata!!!",
              content: "Konum bilginiz sağlanamıyor",
              mainaction: "Tamam")
          .show(context);
    }
  }

  void savePosition(PositionModel positionModel) async {
    final _userViewModel = Provider.of<ViewModel>(context, listen: false);
    await _userViewModel.savePosition(positionModel);
  }
}

class How {
  final String title;
 

  How({this.title});
}

List<How> _how = <How>[
  How(
      title: "Kirli Gördüğünüz Alanın Fotoğrafını Çekin",
      ),
  How(
      title: "Temizlediğiniz Alanın Fotoğranı Çekin",
     ),
  How(
      title: "Kontrol Sonrasında Puanınız Yüklenecektir",
    ),
  How(
      title: "Puanlarınızla Hediyelerin Keyfini Çıkarın",
      )
];
