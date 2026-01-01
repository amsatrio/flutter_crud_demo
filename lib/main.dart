import 'package:flutter/material.dart';
import 'package:flutter_crud_demo/config/environment.dart';
import 'package:flutter_crud_demo/config/logger.dart';
import 'package:flutter_crud_demo/modules/counter/view.dart';
import 'package:flutter_crud_demo/modules/m_biodata/view.dart';
import 'package:flutter_crud_demo/modules/todo/view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

final class AppObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    final providerName = context.provider.name ?? context.provider.runtimeType;

    logger.d(
      'Provider $providerName updated:\n'
      'Prev: $previousValue\n'
      'New: $newValue',
    );
  }

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    logger.t('Provider ${context.provider.runtimeType} was initialized');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    logger.t('Provider ${context.provider.runtimeType} was disposed');
  }
}

void main() {
  runApp(ProviderScope(observers: [AppObserver()], child: const MyApp()));
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MenuScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'counter',
          builder: (BuildContext context, GoRouterState state) {
            return const CounterView();
          },
        ),
        GoRoute(
          path: 'todo',
          builder: (BuildContext context, GoRouterState state) {
            return const TodoView();
          },
        ),
        GoRoute(
          path: 'm-biodata',
          builder: (BuildContext context, GoRouterState state) {
            return const MBiodataView();
          },
        ),
      ],
    ),
  ],
);

final themeProvider = StateProvider<ThemeMode>(
  (ref) => Environment.darkThemeEnabled ? ThemeMode.dark : ThemeMode.light,
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'CRUD App',
      debugShowCheckedModeBanner: Environment.debugEnabled,
      routerConfig: _router,
      themeMode: themeMode,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
    );
  }
}

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> pages = ['counter', 'todo', 'm-biodata'];

    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Menu'),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(themeProvider.notifier)
                  .state = themeMode == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
            icon: Icon(
              themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: pages.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final pageName = pages[index];

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              context.push('/$pageName');
            },
            child: Text(pageName.toUpperCase()),
          );
        },
      ),
    );
  }
}
