import 'package:crud_curso_firebase/view/lista_curso.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CursoApp());
}

class CursoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange[800],
        accentColor: Colors.orange[800],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.orange[800],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: ListaCurso(),
    );
  }
}
