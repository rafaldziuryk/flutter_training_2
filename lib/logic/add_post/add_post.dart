import 'package:json_annotation/json_annotation.dart';

part 'add_post.g.dart';

@JsonSerializable(nullable: false)
class AddPost {
  @JsonKey(name: "user_id")
  final String id;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "body")
  final String body;

  AddPost(this.id, this.title, this.body);

  factory AddPost.fromJson(Map<String, dynamic> json) => _$AddPostFromJson(json);

  Map<String, dynamic> toJson() => _$AddPostToJson(this);
}