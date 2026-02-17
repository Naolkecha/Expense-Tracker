import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart';
import 'presentation/bloc/expense/expense_bloc.dart';
import 'presentation/bloc/theme/theme_bloc.dart';
import 'presentation/pages/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  try {
    print('Starting app initialization...');
    await initializeDependencies();
    print('Dependencies initialized successfully');
    runApp(const MyApp());
  } catch (e, stackTrace) {
    print('Error initializing app: $e');
    print('Stack trace: $stackTrace');
    runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Initialization Error',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$e',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building MyApp widget...');
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) {
          print('Creating ThemeBloc...');
          return sl<ThemeBloc>();
        }),
        BlocProvider(create: (_) {
          print('Creating ExpenseBloc...');
          return sl<ExpenseBloc>()..add(LoadExpensesEvent());
        }),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          print('Building MaterialApp...');
          
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: themeState.isDarkMode ? Brightness.light : Brightness.dark,
              statusBarBrightness: themeState.isDarkMode ? Brightness.dark : Brightness.light,
              systemNavigationBarColor: themeState.isDarkMode 
                  ? const Color(0xFF121212) 
                  : Colors.white,
              systemNavigationBarIconBrightness: themeState.isDarkMode ? Brightness.light : Brightness.dark,
            ),
            child: MaterialApp(
              title: 'Expense Tracker',
              debugShowCheckedModeBanner: false,
              theme: themeState.lightTheme,
              darkTheme: themeState.darkTheme,
              themeMode: themeState.themeMode,
              home: const SplashPage(),
            ),
          );
        },
      ),
    );
  }
}
