import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// 今回はproviderは使用せずに、クラス内にあるstreamを監視することでログイン状態を確認している
class AuthenticationProvider {
  final FirebaseAuth firebaseAuth;
  AuthenticationProvider(this.firebaseAuth);

  // Streamを使用してユーザーの認証状況を監視する
  Stream<User?> get authState => firebaseAuth.idTokenChanges();

  Future<UserCredential> signInWithGoogle() async {
    // Googleの認証を使用する
    final googleUser = await GoogleSignIn(scopes: [
      'email',
    ]).signIn();
    // リクエストから、認証情報を取得
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  // サインアウト
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
