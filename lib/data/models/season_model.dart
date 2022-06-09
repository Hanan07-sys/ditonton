import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;

  SeasonModel(
      {required this.episodeCount,
      required this.id,
      required this.overview,
      required this.name,
      required this.posterPath,
      required this.seasonNumber});

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
      episodeCount: json["episode_count"] ?? 'Unkown',
      id: json["id"],
      name: json["name"],
      overview: json["overview"] ?? '',
      posterPath: json["poster_path"] ?? "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
      seasonNumber: json["season_number"]);
  Map<String, dynamic> toJson() => {
    "episode_count": episodeCount,
    "id": id,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "season_number": seasonNumber
  };

  Season toEntity(){
    return Season(
      episodeCount: this.episodeCount,
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

  @override
  List<Object?> get props => [
    episodeCount,
    id,
    name,
    overview,
    posterPath,
    seasonNumber
  ];
}
