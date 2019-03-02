class Food {
  String id;
  int index;
  String name;
  String description;
  bool liked;
  int calories;
  String picture;

  Food(this.id, this.index, this.name, this.description, this.liked, this.calories,
      this.picture);

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    json["_id"],
    json["index"],
    json["name"],
    json["description"],
    json["liked"],
    json["calories"],
    json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "index": index,
    "name": name,
    "description": description,
    "liked": liked,
    "calories": calories,
    "picture": picture,
  };
}