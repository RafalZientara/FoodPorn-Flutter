class Food {
  String name;
  String description;

  Food(this.name, this.description);

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    json["name"],
    json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
  };
}