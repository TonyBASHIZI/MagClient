import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:MagClient/Models/pub.dart';

class Services {
  static const ROOT = 'http://localhost/Projects/MyAPI/pub.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_PUB_ACTION = 'ADD_PUB';
  static const _UPDATE_PUB_ACTION = 'UPDATE_PUB';
  static const _DELETE_PUB_ACTION = 'DELETE_PUB';

  //method to create the table Pub
  static Future<String> createTable() async {
    try {
      //add the parameters to pass to the request
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final reponse = await http.post(ROOT, body: map);
      print('Create table Response: ${reponse.body}');
      return reponse.body;
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Pub>> getPub() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final reponse = await http.post(ROOT, body: map);
      print('getAllPub Response: ${reponse.body}');
      if (200 == reponse.statusCode) {
        List<Pub> list = parseResponse(reponse.body);
        return list;
      }
    } catch (e) {
      return List<Pub>();
    }
  }

  static List<Pub> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pub>((json) => Pub.fromJson(json).toString());
  }

  //method to add pub to the data base
  static Future<String> addPub(
      String titre, String detail, String photo) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_PUB_ACTION;
      map['titre'] = titre;
      map['detail'] = detail;
      map['titre'] = photo;
      final reponse = await http.post(ROOT, body: map);
      print('addPub response: ${reponse.body}');
      if (200 == reponse.statusCode) {
        return reponse.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //method to update
  static Future<String> updatePub(
      int pubId, String titre, String detail, String photo) async{
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_PUB_ACTION;
      map['id'] = pubId;
      map['titre'] = titre;
      map['detail'] = detail;
      map['titre'] = photo;
      final reponse = await http.post(ROOT, body: map);
      print('UpdatePub response: ${reponse.body}');
      if (200 == reponse.statusCode) {
        return reponse.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
  //method delete
  static Future<String> deletePub(
      int pubId) async{
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_PUB_ACTION;
      map['id'] = pubId;
 
      final reponse = await http.post(ROOT, body: map);
      print('deletePub response: ${reponse.body}');
      if (200 == reponse.statusCode) {
        return reponse.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
