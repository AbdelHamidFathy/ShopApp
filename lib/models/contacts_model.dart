import 'package:flutter/material.dart';

class ContactsModel {
  late bool status;
  late Data data;

  ContactsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late int currentPage;
  List<Contact> data=[];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
        data.add(Contact.fromJson(element));
    });
  }
}

class Contact {
  late int id;
  late int type;
  late String value;
  late String image;

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    image = json['image'];
  }
}