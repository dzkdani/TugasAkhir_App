class Topic {
  final int topicId;
  final int userId;
  final String title;
  final String desc;
  final String dateCreated;
  final int likeCount;
  final int commentCount;

  Topic(this.topicId, this.userId, this.title, this.desc, this.dateCreated,
      this.likeCount, this.commentCount);

  factory Topic.fromJsonData(Map<String, dynamic> jsonObject) {
    return Topic(
        jsonObject['id'],
        jsonObject['user_id'],
        jsonObject['title'],
        jsonObject['description'],
        jsonObject['created_at'],
        jsonObject['likes_count'],
        jsonObject['comments_count']);
  }
}
