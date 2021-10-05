class Post {
  String title, plan;
  String tech, apeal;

  Post({
    this.title = '',
    this.apeal = '',
    this.plan = '',
    this.tech = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'apeal': apeal,
      'plan': plan,
      'tech': tech,
    };
  }
}
