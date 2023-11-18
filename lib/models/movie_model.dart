class Movie{
  final String title;
  final String overview;

  Movie({required this.title, required this.overview});

  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(
      title: json['title'] ?? 'No title found',
      overview: json['overview'] ?? 'No description found'
    );
  }
}