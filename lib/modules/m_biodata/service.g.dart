// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Service)
final serviceProvider = ServiceProvider._();

final class ServiceProvider
    extends $AsyncNotifierProvider<Service, List<MBiodata>> {
  ServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceHash();

  @$internal
  @override
  Service create() => Service();
}

String _$serviceHash() => r'e39d50ba1aeda41c2c2c64545fcc5d24442e2fe9';

abstract class _$Service extends $AsyncNotifier<List<MBiodata>> {
  FutureOr<List<MBiodata>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<MBiodata>>, List<MBiodata>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MBiodata>>, List<MBiodata>>,
              AsyncValue<List<MBiodata>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
