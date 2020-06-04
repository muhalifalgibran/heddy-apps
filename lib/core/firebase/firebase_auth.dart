import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return user;
}

Future<FirebaseUser> getUserAccount() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  return currentUser;
}

Future<bool> isLoggedIn() async {
  final FirebaseUser currentUser = await _auth.currentUser();
  if (currentUser.uid.isNotEmpty) {
    return true;
  }
  return false;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
