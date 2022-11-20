
class Favs{
  String id;
  String? title;
  String? time;
  String? image;
  String? info;
  String? cuisine;

  Favs({
    required this.id ,
    required this.title,
    required this.time,
    required this.image,
    required this.info,
    required this.cuisine,
  });

  Map<String,dynamic> toJson()=>{
    'id':id,
    'title':title,
    'time':time,
    'image': image,
    'info': info,
    'cuisine':cuisine,
  };

  static Favs fromJson(Map<String,dynamic>json)=>Favs(
      title:json["title"],
      time:json["time"],
      image: json["image"],
      id: json["id"],
      info: json["info"],
      cuisine: json["cuisine"]
  );
}