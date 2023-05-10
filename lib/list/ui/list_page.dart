import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../router.dart';
import '../state/list.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(fetchListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
      ),
      body: items.when(
        data: (state) {
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];

              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.url),
                onTap: () => DetailPageRoute(title: item.name, url: item.url).go(context),
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