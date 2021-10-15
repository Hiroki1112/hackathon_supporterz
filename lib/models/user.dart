import 'dart:core';

import 'package:validators/validators.dart';

class MyUser {
  String _userName = '',
      _selfIntroduction = '',
      _twitterLink = '',
      _githubAccount = '',
      _pictureURL = '',
      _userId = '';

  String get useName => _userName;
  String get selfIntroduction => _selfIntroduction;
  String get twitterLink => _twitterLink;
  String get githubAccount => _githubAccount;
  String get pictureURL => _pictureURL;
  String get userId => _userId;

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

  set setUserId(String userId) {
    if (userId.length < 20) {
      _userId = userId;
    }
  }

//firebaseからの情報の受け取り
  void fromJson(Map<String, dynamic> json) {
    setUserName = json['userName'] ?? '';
    setSelfIntroduction = json['selfIntroduction'] ?? '';
    setTwitterLink = json['twitterLink'] ?? '';
    setGithubAccount = json['githubAccount'] ?? '';
    setPictureURL = json['pictureURL'] ?? '';
    setUserId = json['userId'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': _userName,
      'selfIntroduction': _selfIntroduction,
      'twitterLink': _twitterLink,
      'githubAccount': _githubAccount,
      'pictureURL': _pictureURL,
      'userId': _userId,
    };
  }
}
