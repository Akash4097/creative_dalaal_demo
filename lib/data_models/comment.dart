class Comment {
  final String id;
  final String? parentId;
  final String content;
  final DateTime timestamp;
  final String userId;

  Comment({
    required this.userId,
    required this.id,
    required this.content,
    required this.timestamp,
    this.parentId,
  });

  Comment copyWith({
    String? id,
    String? parentId,
    String? content,
    DateTime? timestamp,
    String? userId,
  }) {
    return Comment(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'Comment(id: $id, parentId: $parentId,'
        ' content: $content, timestamp: $timestamp, userId: $userId)';
  }
}
