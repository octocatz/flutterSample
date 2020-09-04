import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:developer' as developer;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random(); // Add this li§ne.

    return MaterialApp(
      title: 'Startup Name generator',
      home: RandomWords(),
      // Scaffold(
      // appBar: AppBar(
      // title: Text('Welcome to Flutter'),
      // ),
      // body: Center(
      //child: Text('Hello World'),   // Replace this text...
      //child: Text(wordPair.asPascalCase), // With this text.

      // child: RandomWords(),

      // child: Text(
      //   wordPair.asPascalCase,
      //   style: TextStyle(
      //     fontWeight: FontWeight.bold,
      //     fontSize: 50,
      //     color: Theme.of(context).primaryColor,
      //   ),
      //),
      // ),
      // ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>(); // NEW
  final _biggerFont = TextStyle(fontSize: 18.0);
  // final List<WordPair> _suggestions = <WordPair>[];
  // final TextStyle _biggerFont = const TextStyle(fontSize: 18);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          // print('i: $i');
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          // print('index: $index');
          final int sugIndex = _suggestions.length;
          // print('_suggestions.length: $sugIndex');
          // developer.log('test01', name: 'index');
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        // NEW from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ), // ... to here.
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}
