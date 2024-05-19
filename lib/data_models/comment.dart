class Comment {
  String id;
  String parentId;
  String content;
  DateTime timestamp;

  Comment({
    required this.id,
    required this.parentId,
    required this.content,
    required this.timestamp,
  });

  Comment copyWith({
    String? id,
    String? parentId,
    String? content,
    DateTime? timestamp,
  }) {
    return Comment(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() {
    return 'Comment(id: $id, parentId: $parentId, content: $content, timestamp: $timestamp)';
  }
}
