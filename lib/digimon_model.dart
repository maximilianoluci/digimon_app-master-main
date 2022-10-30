import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Digimon {
  final String name;
  String imageUrl;
  String gameSeries;

  int rating = 10;

  Digimon(this.name) {
    getDigimonData();
  }

  Future getDigimonData() async {
    HttpClient http = new HttpClient();
    try {
      var queryParams = {'name': this.name.toLowerCase()};
      var uri = new Uri.https('amiiboapi.com', 'api/amiibo/', queryParams);
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      Map<String, dynamic> data = jsonDecode(responseBody);
      List<dynamic> detailsList = data["amiibo"];
      imageUrl = detailsList[1]["image"];
      gameSeries = detailsList[1]["gameSeries"];

      //print(gameSeries);
    } catch (exception) {
      print(exception);
    }
  }

  String getDigimonName() {
    return this.name;
  }

  Future getDigimonImgUrl() async {
    if (this.imageUrl == null) {
      await getDigimonData();
    }
    return this.imageUrl;
  }

  String getGameSeries() {
    return this.gameSeries;
  }
}
