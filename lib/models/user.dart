import 'dart:core';

import 'package:validators/validators.dart';

class MyUser {
  String _userName = '',
      _selfIntroduction = '',
      _twitterLink = '',
      _githubAccount = '',
      _pictureURL = '';

  String get useName => _userName;
  String get selfIntroduction => _selfIntroduction;
  String get twitterLink => _twitterLink;
  String get githubAccount => _githubAccount;
  String get pictureURL => _pictureURL;

  set setUserName(String userName) {
    if (userName.length <= 20) {
      _userName = userName;
    }
  }

  set setSelfIntroduction(String selfIntroduction) {
    if (selfIntroduction.length <= 150) {
      _selfIntroduction = selfIntroduction;
    }
  }

  set setTwitterLink(String twitterLink) {
    if ((isAlphanumeric(twitterLink)) && (twitterLink.length <= 100)) {
      _twitterLink = twitterLink;
    }
  }

  set setGithubAccount(String githubAccount) {
    if ((isAlphanumeric(githubAccount)) && (githubAccount.length <= 100)) {
      _githubAccount = githubAccount;
    }
  }

  set setPictureURL(String pictureURL) {
    if ((isURL(pictureURL)) && (pictureURL.length <= 500)) {
      _pictureURL = pictureURL;
    }
  }

//firebaseからの情報の受け取り
  void fromJson(Map<String, dynamic> json) {
    setUserName = json['userName'] ?? "";
    setSelfIntroduction = json['selfIntroduction'] ?? "";
    setTwitterLink = json['twitterLink'] ?? "";
    setGithubAccount = json['githubAccount'] ?? "";
    setPictureURL = json['pictureURL'] ?? "";
  }

  Map<String, dynamic> toJson(String? userId) {
    return {
      'userName': _userName,
      'selfIntroduction': _selfIntroduction,
      'twitterLink': _twitterLink,
      'githubAccount': _githubAccount,
      'pictureURL': _pictureURL,
      'userId': userId,
    };
  }
}
