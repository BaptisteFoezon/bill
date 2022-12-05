import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BillFirebaseUser {
  BillFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

BillFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BillFirebaseUser> billFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<BillFirebaseUser>(
      (user) {
        currentUser = BillFirebaseUser(user);
        return currentUser!;
      },
    );
