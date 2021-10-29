class Cast {
  List<Actor> actores = [];
  Cast.fromJson(List<dynamic> json) {
    json.forEach((element) {
      final actor = new Actor.fromJsonMap(element);
      actores.add(actor);
    });
    // for (var item in json) {
    //   final pelicula = new Actor.fromJsonMap(item);
    //   actores.add(pelicula);
    // }
  }
}

class Actor {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  String? department;
  String? job;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'] / 1;
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    department = json['department'];
    job = json['job'];
  }

  getProfileImg() {
    if (profilePath != null) {
      return "https://image.tmdb.org/t/p/w500$profilePath";
    }
    return "https://i.ibb.co/0Jmshvb/no-image.png";
  }
}
