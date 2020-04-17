// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPost _$AddPostFromJson(Map<String, dynamic> json) {
  return AddPost(
    json['user_id'] as String,
    json['title'] as String,
    json['body'] as String,
  );
}

Map<String, dynamic> _$AddPostToJson(AddPost instance) => <String, dynamic>{
      'user_id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
