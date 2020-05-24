class Movie {
  Movie(this.id, this.title, this.overview, this.posterPath);

  final String id;
  final String title;
  final String overview;
  final String posterPath;

  Movie.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'],
        overview = json['overview'],
        posterPath = json['poster_path'];

  Map<String, dynamic> toJson() => {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
    };
}
