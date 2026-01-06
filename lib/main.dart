import 'package:flutter/material.dart';
import 'package:flutter_crud_demo/config/environment.dart';
import 'package:flutter_crud_demo/config/logger.dart';
import 'package:flutter_crud_demo/modules/counter/view.dart';
import 'package:flutter_crud_demo/modules/m_biodata/view.dart';
import 'package:flutter_crud_demo/modules/portfolio/view.dart';
import 'package:flutter_crud_demo/modules/todo/view.dart' as todo;
import 'package:flutter_crud_demo/modules/todo_objectbox/injector.dart';
import 'package:flutter_crud_demo/modules/todo_objectbox/objectbox.dart';
import 'package:flutter_crud_demo/modules/todo_objectbox/view.dart'
    as todo_objectbox;
import 'package:flutter_crud_demo/modules/todo_sqflite/injector.dart';
import 'package:flutter_crud_demo/modules/todo_sqflite/view.dart'
    as todo_sqflite;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

final getIt = GetIt.instance;

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

late ObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  getItTodoSqflite();
  getItTodoObjectBox();

  objectBox = await ObjectBox.create();

  await windowManager.ensureInitialized();

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
            return const todo.TodoView();
          },
        ),
        GoRoute(
          path: 'todo-sqflite',
          builder: (BuildContext context, GoRouterState state) {
            return const todo_sqflite.TodoView();
          },
        ),
        GoRoute(
          path: 'todo-objectbox',
          builder: (BuildContext context, GoRouterState state) {
            return const todo_objectbox.TodoView();
          },
        ),
        GoRoute(
          path: 'm-biodata',
          builder: (BuildContext context, GoRouterState state) {
            return const MBiodataView();
          },
        ),
        GoRoute(
          path: 'portfolio',
          builder: (BuildContext context, GoRouterState state) {
            return const PortfolioView();
          },
        ),
      ],
    ),
  ],
);

final themeProvider = StateProvider<ThemeMode>(
  (ref) => Environment.darkThemeEnabled ? ThemeMode.dark : ThemeMode.light,
);
final fullscreenProvider = StateProvider<bool>(
  (ref) => Environment.fullscreenEnabled ? true : false,
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
    final List<String> pages = [
      'counter',
      'todo',
      'todo-sqflite',
      'todo-objectbox',
      'm-biodata',
      'portfolio',
    ];

    final themeMode = ref.watch(themeProvider);
    final screenMode = ref.watch(fullscreenProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Menu'),
        actions: [
          IconButton(
            onPressed: () async {
              final status = await windowManager.isFullScreen();
              ref.read(fullscreenProvider.notifier).state = !status;
              await windowManager.setFullScreen(!status);
            },
            icon: Icon(screenMode ? Icons.close_fullscreen : Icons.open_in_full),
            tooltip: 'Toggle Full Screen',
          ),
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
            tooltip: 'Toggle Theme Mode',
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
