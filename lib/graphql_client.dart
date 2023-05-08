import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'graphql_client.g.dart';

@riverpod
GraphQLClient graphQLClient(GraphQLClientRef ref) {
  // TODO: Replace with your own GitHub token
  const token = "GITHUB_TOKEN";
  final link = HttpLink('https://api.github.com/graphql', defaultHeaders: {
    'Authorization': 'Bearer $token',
  });

  return GraphQLClient(
    link: link,
    cache: GraphQLCache(),
  );
}
