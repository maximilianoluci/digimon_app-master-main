import 'package:digimon_app/digimon_model.dart';
import 'digimon_detail_page.dart';
import 'package:flutter/material.dart';


class DigimonCard extends StatefulWidget {
  final Digimon digimon;

  DigimonCard(this.digimon);

  @override
  _DigimonCardState createState() => _DigimonCardState(digimon);
}

class _DigimonCardState extends State<DigimonCard> {
  Digimon digimon;
  String renderUrl;

  _DigimonCardState(this.digimon);

  void initState() {
    super.initState();
    renderDigimonPic();
  }

  Widget get digimonImage {
    var digimonAvatar = new Hero(
      tag: digimon,
      child: new Container(
        width: 100.0,
        height: 100.0,
        decoration:
            new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.cover, image: new NetworkImage(renderUrl ?? ''))),
      ),
    );

    var placeholder = new Container(
      width: 100.0,
      height: 100.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              new LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.black54, Colors.black, Colors.blueGrey[600]])),
      alignment: Alignment.center,
      child: new Text(
        'DIGI',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = new AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: digimonAvatar,
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderDigimonPic() async {
    await digimon.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = digimon.imageUrl;
      });
    }
  }

  Widget get digimonCard {
    return new Positioned(
      right: 0.0,
      child: new Container(
        width: 290,
        height: 115,
        child: new Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Color(0xFFF8F8F8),
          child: new Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 64),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text(
                  widget.digimon.name,
                  style: TextStyle(color: Color(0xFF000600), fontSize: 27.0),
                ),
                new Row(
                  children: <Widget>[
                    new Icon(Icons.star, color: Color(0xFF000600)),
                    new Text(': ${widget.digimon.rating}/10', style: TextStyle(color: Color(0xFF000600), fontSize: 14.0))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDigimonDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return new DigimonDetailPage(digimon);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => showDigimonDetailPage(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: new Container(
          height: 115.0,
          child: new Stack(
            children: <Widget>[
              digimonCard,
              new Positioned(top: 7.5, child: digimonImage),
            ],
          ),
        ),
      ),
    );
  }
}
