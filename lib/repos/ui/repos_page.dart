import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../router.dart';
import '../state/repos.dart';

class ReposPage extends ConsumerWidget {
  const ReposPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repos = ref.watch(reposProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Repositories'),
      ),
      body: repos.when(
        data: (repos) {
          return ListView.builder(
            itemCount: repos.repos.length,
            itemBuilder: (context, index) {
              final repo = repos.repos[index];

              return ListTile(
                title: Text(repo.name),
                subtitle: Text(repo.url),
                onTap: () => RepoPageRoute(title: repo.name, url: repo.url).go(context),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}