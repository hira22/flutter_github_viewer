import 'package:flutter_github_viewer/graphql_client.dart';
import 'package:flutter_github_viewer/repos/entities/github_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repos.freezed.dart';
part 'repos.g.dart';

// State Holder
@riverpod
Future<GitHubRepos> repos(ReposRef ref) async {
  // TODO: move to repository
  final result = await ref.watch(graphQLClientProvider).query(
        QueryOptions(
          document: gql(r'''
            query {
              viewer {
                repositories(first: 100) {
                  nodes {
                    name
                    url
                  }
                }
              }
            }
          '''),
        ),
      );

  if (result.hasException) {
    throw result.exception!;
  }

  final json = (result.data!['viewer']['repositories']['nodes'] as List).cast<Map<String, dynamic>>();

  return GitHubRepos(
    repos: json
        .map(GitHubRepo.fromJson)
        .toList(),
  );
}

// State
@freezed
class GitHubRepos with _$GitHubRepos {
  const GitHubRepos._();

  const factory GitHubRepos({
    required List<GitHubRepo> repos,
  }) = _GitHubRepos;
}
