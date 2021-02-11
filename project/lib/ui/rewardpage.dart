import 'package:flutter/material.dart';

class RewardPage extends StatefulWidget {
  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          title: Text('Ödüller', style: Theme.of(context).textTheme.headline6),
        ),
        body: Container(
            width: size.width,
            height: size.height,
            child: ListView.builder(
                itemCount: _rewards.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                      width: size.width,
                      height: size.height * 0.2,
                      child: Card(
                        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
                        
                        elevation: 10,
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.asset(
                                _rewards[index].icon,
                                scale: 5.0,
                              ),
                            ),
                            Expanded(
                                child: ListTile(
                              title: Text(
                                _rewards[index].title,
                                style: TextStyle(
                                    fontFamily: "MerriweatherSans",
                                    fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                _rewards[index].puan,
                                style: TextStyle(
                                    fontFamily: "Sriracha",
                                    fontSize: 25,
                                    color: Theme.of(context).primaryColor),
                                textAlign: TextAlign.center,
                              ),
                            ))
                          ],
                        ),
                      ));
                })));
  }
}

class Rewards {
  final String title;
  final String icon;
  final String puan;

  Rewards({this.title, this.icon, this.puan});
}

List<Rewards> _rewards = <Rewards>[
  Rewards(
      title: "1 Aylık Spotify Aboneliği",
      icon: 'assets/img/spotify.png',
      puan: "100 Puan"),
  Rewards(
      title: "1 Aylık Youtube Premium",
      icon: 'assets/img/youtube.png',
      puan: "130 Puan"),
  Rewards(
      title: "1 Aylık Netflix Aboneliği",
      icon: 'assets/img/netflix.png',
      puan: "150 Puan"),
  Rewards(
      title: "1 Aylık Amazon Prime Aboneliği",
      icon: 'assets/img/amazon.png',
      puan: "200 Puan"),
  Rewards(
      title: "Udemy Flutter Programlama",
      icon: 'assets/img/udemy-logo.png',
      puan: "170 Puan")
];
