import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';
import 'providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonDataAsyncValue = ref.watch(jsonDataProvider);
    final registry = JsonWidgetRegistry.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: jsonDataAsyncValue.when(
        data: (data) {
          final widget = JsonWidgetData.fromDynamic(data, registry: registry);
          return widget.build(context: context);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Error: $error")),
      ),
    );
  }
}


// import 'dart:convert';
// import 'package:json_dynamic_widget/json_dynamic_widget.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: const TextTheme(
//           titleLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ),
//       home: const MyHomePage(title: 'Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final registry = JsonWidgetRegistry.instance;
//
//   Future<Map<String, dynamic>> readJson() async {
//     await Future.delayed(const Duration(seconds: 3)); // Задержка 3 секунды
//     final String jsonString = await rootBundle.loadString("assets/json/widgets.json");
//     return jsonDecode(jsonString);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: readJson(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (snapshot.hasData) {
//             final widgetsData = snapshot.data!;
//             final widget = JsonWidgetData.fromDynamic(widgetsData, registry: registry);
//             return widget.build(context: context);
//           } else {
//             return const Center(child: Text("No data"));
//           }
//         },
//       ),
//     );
//   }
// }
