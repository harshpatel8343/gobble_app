class CuisinesModel {
  CuisinesModel({
    required this.results,
    required this.offset,
    required this.number,
    required this.totalResults,
  });
  late final List<Results> results;
  late final int offset;
  late final int number;
  late final int totalResults;

  CuisinesModel.fromJson(Map<String, dynamic> json){
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
    offset = json['offset'];
    number = json['number'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['results'] = results.map((e)=>e.toJson()).toList();
    _data['offset'] = offset;
    _data['number'] = number;
    _data['totalResults'] = totalResults;
    return _data;
  }
}

class Results {
  Results({
    required this.instruction,
    required this.title,
    required this.image,
    required this. cuisine,
  });

  late final String title;
  late final String? image;
  late final String? instruction;
  late final List? cuisine;

  Results.fromJson(Map<String, dynamic> json){
    title= json['title'];
    image= json['image'];
    instruction=json['instructions'];
    cuisine=json['cuisine'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['instructions'] = instruction;
    _data['image'] = image;
    _data['cuisine'] = cuisine;
    return _data;
  }
}