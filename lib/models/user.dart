class MyUser {
  String userName, selfIntroduction, twitterLink, githubAccount;

  MyUser({
    this.userName = '',
    this.selfIntroduction = '',
    this.twitterLink = '',
    this.githubAccount = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'selfIntroduction': selfIntroduction,
      'twitterLink': twitterLink,
      'githubAccount': githubAccount
    };
  }
}
