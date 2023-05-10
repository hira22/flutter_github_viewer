import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_viewer/detail/detail_page.dart';
import 'package:flutter_github_viewer/list/ui/list_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) => GoRouter(
  routes: $appRoutes,
  debugLogDiagnostics: kDebugMode,
);

final $router = GoRouter(routes: $appRoutes, debugLogDiagnostics: kDebugMode);

@TypedGoRoute<ListPageRoute>(
  path: '/',
  routes: [
    TypedGoRoute<DetailPageRoute>(
      path: 'detail/:title/:url',
    ),
  ],
)

@immutable
class ListPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ListPage();
  }
}


@immutable
class DetailPageRoute extends GoRouteData {
  final String title;
  final String url;

  const DetailPageRoute({required this.title, required this.url});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DetailPage(title: title, url: url);
  }
}
