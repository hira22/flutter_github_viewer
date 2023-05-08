import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_viewer/repo/repo_page.dart';
import 'package:flutter_github_viewer/repos/ui/repos_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) => GoRouter(
  routes: $appRoutes,
  debugLogDiagnostics: kDebugMode,
);

@TypedGoRoute<ReposPageRoute>(
  path: '/',
  routes: [
    TypedGoRoute<RepoPageRoute>(
      path: 'repo/:title/:url',
    ),
  ],
)

@immutable
class ReposPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ReposPage();
  }
}


@immutable
class RepoPageRoute extends GoRouteData {
  final String title;
  final String url;

  const RepoPageRoute({required this.title, required this.url});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RepoPage(title: title, url: url);
  }
}
