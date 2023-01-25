import 'package:flutter/material.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

class SaveSavedAccounts extends StatefulWidget {
  const SaveSavedAccounts({super.key});

  @override
  State<SaveSavedAccounts> createState() => _SaveSavedAccountsState();
}

class _SaveSavedAccountsState extends State<SaveSavedAccounts> {
  /// create a new list of data
  final items = List<int>.generate(1, (index) => index);

  /// when the reorder completes remove the list entry from its old position
  /// and insert it at its new index
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ReorderableGridView.extent(
          maxCrossAxisExtent: 150,
          onReorder: _onReorder,
          childAspectRatio: 1,
          children: items.map((item) {
            /// map every list entry to a widget and assure every child has a
            /// unique key
            return Card(
              key: ValueKey(item),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.facebook, color: Colors.redAccent),
                    const SizedBox(height: 8),
                    Text(
                      'Account - $item',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        floatingActionButton: Visibility(
          child: SizedBox(
            width: 42,
            height: 42,
            child: FloatingActionButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              onPressed: () {
                setState(() {
                  items.add(items.length);
                });
              },
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.qr_code),
            ),
          ),
        ),
      ),
    );
  }
}
