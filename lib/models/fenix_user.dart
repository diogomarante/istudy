import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class FenixUser {
  String name;
  String istID;
  Uint8List photo;

  FenixUser({@required Map<String, dynamic> user}) {
    this.name = user["name"];
    this.istID = user["username"]?.substring(3);
    this.photo =
        user["photo"] == null ? null : base64Decode(user["photo"]["data"]);
    print(name);
    print(istID);
  }
}
