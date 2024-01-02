import 'dart:io';

class  AppHobbies{

  static final List<AppHobbies> data = [
    AppHobbies(hobbies:'Game online',state:false),
    AppHobbies(hobbies:'Đi biển',state:false),
    AppHobbies(hobbies:'Bóng rổ',state:false),
    AppHobbies(hobbies:'Bóng đá',state:false),
    AppHobbies(hobbies:'Bóng chuyền',state:false),
    AppHobbies(hobbies:'Anime',state:false),
    AppHobbies(hobbies:'Manga',state:false),
    AppHobbies(hobbies:'Phim hàn quốc',state:false),
    AppHobbies(hobbies:'Phim ngôn tình',state:false),
    AppHobbies(hobbies:'Liên minh huyền thoại',state:false),
  ];
  final hobbies ;
  bool state;

   AppHobbies({required this.hobbies,required this.state});

  static List<AppHobbies?> init(){
    return data;
  }

  // List<String> hobbies ;
  //
  //  AppHobbies({required this.hobbies});

  // static List<String> getHobbiesList(){
  //   return [
  //     'Game online',
  //     'Đi biển',
  //     'Bóng rổ',
  //     'Bóng đá',
  //     'Bóng chuyền',
  //     'Anime',
  //     'Manga',
  //     'Phim hàn quốc',
  //     'Phim ngôn tình',
  //     'Liên minh huyền thoại',
  //   ];
  // }

}