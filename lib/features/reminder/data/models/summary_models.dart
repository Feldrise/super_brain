import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_brain/features/reminder/domain/entities/summary.dart';

class SummaryModel {
  final String id;
  final String title;
  final String content;
  final int estimatedReadingTime;
  final List<String> keyPoints;
  final DateTime createdAt;
  final bool isActive;

  const SummaryModel({
    required this.id,
    required this.title,
    required this.content,
    this.estimatedReadingTime = 0,
    this.keyPoints = const [],
    required this.createdAt,
    this.isActive = true,
  });

  // Convert to domain entity
  Summary toDomain() => Summary(id: id, title: title, content: content, estimatedReadingTime: estimatedReadingTime, keyPoints: keyPoints, createdAt: createdAt, isActive: isActive);

  // Create from domain entity
  factory SummaryModel.fromDomain(Summary summary) => SummaryModel(
    id: summary.id,
    title: summary.title,
    content: summary.content,
    estimatedReadingTime: summary.estimatedReadingTime,
    keyPoints: summary.keyPoints,
    createdAt: summary.createdAt,
    isActive: summary.isActive,
  );

  factory SummaryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SummaryModel(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      estimatedReadingTime: data['estimatedReadingTime']?.toInt() ?? 5,
      keyPoints: List<String>.from(data['keyPoints'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? true,
    );
  }

  factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
    id: json['id'] ?? '',
    title: json['title'] ?? '',
    content: json['content'] ?? '',
    estimatedReadingTime: json['estimatedReadingTime']?.toInt() ?? 5,
    keyPoints: List<String>.from(json['keyPoints'] ?? []),
    createdAt: DateTime.parse(json['createdAt']),
    isActive: json['isActive'] ?? true,
  );

  Map<String, dynamic> toFirestore() {
    final data = toJson();
    data.remove('id'); // Remove ID for Firestore document
    data['createdAt'] = Timestamp.fromDate(createdAt);
    return data;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'estimatedReadingTime': estimatedReadingTime,
      'keyPoints': keyPoints,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }
}
