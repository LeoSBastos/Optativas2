import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_firebase/model/curso.dart';

class CursoDao {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User currentUser;
  CursoDao() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      currentUser = user;
    });
  }
  getUser() async {
    if (currentUser != null) {
      return currentUser;
    }
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      final User user = userCredential.user;
      return user;
    } catch (e) {}
  }

  final databaseReference = FirebaseFirestore.instance;
  final String COLECAO = "cursos";
  Future<String> inserir(Curso curso) async {
    try {
      DocumentReference ref =
          await databaseReference.collection(COLECAO).add(curso.toMap());
      return ref.id;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> alterar(Curso curso) async {
    try {
      await databaseReference
          .collection(COLECAO)
          .doc(curso.id)
          .update(curso.toMap());
      return "Registro atualizado";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Curso>> findAll() async {
    QuerySnapshot cursos = await databaseReference.collection("cursos").get();
    List<Curso> listaCursos = List();
    cursos.docs.forEach((elemento) {
      listaCursos.add(Curso.fromJson(elemento.data(), elemento.id));
    });
    return listaCursos;
  }

  Future<String> excluir(String id) async {
    try {
      await databaseReference.collection(COLECAO).doc(id).delete();
      return "Registro excluído com projeto";
    } catch (e) {
      return e.toString();
    }
  }
}
