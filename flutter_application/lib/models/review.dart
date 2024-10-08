import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_application/models/user.dart';

class ReviewModel {
  final String id;
  final String userId;
  final String mosqueId;
  final String message;
  final int rating;
  final DateTime createdAt;
  final String imageUrl;

  ReviewModel(
      {required this.id,
      required this.userId,
      required this.mosqueId,
      required this.message,
      required this.rating,
      required this.createdAt,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "_id": id,
      "userId": userId,
      "mosqueId": mosqueId,
      "message": message,
      "rating": rating,
      "createdAt": createdAt.toString(),
      "imageUrl": imageUrl
    };
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['_id'] as String,
      userId: map['userId'] as String,
      mosqueId: map['mosqueId'] as String,
      message: map['message'] as String,
      rating: map['rating'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
      imageUrl: map['imageUrl'] as String,
    );
  }
}
