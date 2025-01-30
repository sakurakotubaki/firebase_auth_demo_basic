enum AuthjExceptoin {
  invalidEmail('メールアドレスの形式が正しくありません'),
  weakPassword('パスワードは6文字以上で入力してください'),
  emailAlreadyInUse('メールアドレスがすでに使用されています'),
  userNotFound('メールアドレスまたはパスワードが正しくありません'),
  invalidCredentials('メールアドレスまたはパスワードが正しくありません');

  const AuthjExceptoin(this.message);
  final String message;
}
