// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TodoState)
final todoStateProvider = TodoStateProvider._();

final class TodoStateProvider
    extends $AsyncNotifierProvider<TodoState, List<Todo>> {
  TodoStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoStateHash();

  @$internal
  @override
  TodoState create() => TodoState();
}

String _$todoStateHash() => r'47f705e8003da0680e9f731ccd6c4b254432b67a';

abstract class _$TodoState extends $AsyncNotifier<List<Todo>> {
  FutureOr<List<Todo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Todo>>, List<Todo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Todo>>, List<Todo>>,
              AsyncValue<List<Todo>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
