import 'dart:io';


class UserHobbies {
  final hobbies;





  UserHobbies({required this.hobbies});

  static UserHobbies fromMap(Map<String, dynamic> map) {
    return UserHobbies(
     hobbies: map['hobbies'],

    );
  }
}
