import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_network_error/widgets/network_overlay.dart';
import 'package:retry/retry.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(const MyApp());
}

enum AppState {
  initial,
  loading,
  loaded,
  failed,
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppState _appState = AppState.initial;

  AppState get appState => _appState;

  set appState(AppState value) {
    if (_appState == value) return;
    setState(() => _appState = value);
  }

  bool get showNetworkError => _appState == AppState.failed;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    appState = AppState.loading;
    final url = Uri.parse('https://linkedin.com/in/tornike-kurdadze/');
    await Future.delayed(const Duration(seconds: 2));
    await retry(
      () => http.get(url),
      retryIf: (e) => e is SocketException,
      onRetry: (e) {
        appState = AppState.failed;
      },
    );
    appState = AppState.loaded;
  }

  @override
  Widget build(BuildContext context) {
    return NetworkOverlay(
      showOverlay: showNetworkError,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: Builder(
                builder: (_) {
                  if (appState == AppState.loaded) {
                    return const Text('Loaded');
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
