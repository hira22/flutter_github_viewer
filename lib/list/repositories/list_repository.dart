import 'package:flutter_github_viewer/graphql_client.dart';
import 'package:flutter_github_viewer/list/entities/item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'list_repository.g.dart';

@Riverpod(keepAlive: true)
ListRepository listRepository(ListRepositoryRef ref) => ListRepository(client: ref.read(graphQLClientProvider));

class ListRepository {
  final GraphQLClient client;

  ListRepository({required this.client});

  Future<List<Item>> fetch() async {
    final result = await client.query(
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

    final json = (result.data!['viewer']['repositories']['nodes'] as List)
        .cast<Map<String, dynamic>>();

    return json.map(Item.fromJson).toList();
  }
}
