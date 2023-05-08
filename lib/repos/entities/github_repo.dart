import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_repo.freezed.dart';
part 'github_repo.g.dart';

@freezed
class GitHubRepo with _$GitHubRepo {
  const GitHubRepo._();

  const factory GitHubRepo({
    required String name,
    required String url,
  }) = _GitHubRepo;

  factory GitHubRepo.fromJson(Map<String, dynamic> json) =>
      _$GitHubRepoFromJson(json);
}
