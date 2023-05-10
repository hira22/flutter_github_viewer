import 'package:flutter_github_viewer/list/repositories/list_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../entities/item.dart';

part 'list.freezed.dart';
part 'list.g.dart';

// State Holder
@riverpod
Future<ListState> fetchList(FetchListRef ref) async {
  final items = await ref.read(listRepositoryProvider).fetch();

  return ListState(
    items: items,
  );
}

// State
@freezed
class ListState with _$ListState {
  const ListState._();

  const factory ListState({
    required List<Item> items,
  }) = _ListState;
}
