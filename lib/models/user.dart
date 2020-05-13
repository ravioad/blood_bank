import 'package:firebase_database/firebase_database.dart';

class User {
  String key;
  String userId;
  String name;
  String phone;
  String email;
  String bloodgroup;
  User({this.userId, this.name, this.phone, this.email, this.bloodgroup});

  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        userId = snapshot.value['userId'],
        name = snapshot.value['name'],
        phone = snapshot.value['phone'],
        email = snapshot.value['email'],
        bloodgroup = snapshot.value['bloodgroup'];

  toJson() {
    return {
      'userId': userId,
      'name': name,
      'phone': phone,
      'email': email,
      'phone': phone,
      'bloodgroup':bloodgroup
    };
  }
}
