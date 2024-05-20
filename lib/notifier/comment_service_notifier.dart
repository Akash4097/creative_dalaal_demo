import '../utils/unique_id.dart';
import 'package:flutter/material.dart';

import '../data_models/comment.dart';

class CommentServiceNotifier extends ChangeNotifier {
  final List<Comment> _comments = [];

  List<Comment> getComments() {
    final comments =
        _comments.where((comment) => comment.parentId == '').toList();
    print("getcomment: $comments");
    return comments;
  }

  void addComment(String content, {String? parentId}) {
    final uid = UniqueId.generateUniqueId();
    final comment = Comment(
      id: uid,
      parentId: parentId ?? '',
      content: content,
      timestamp: DateTime.now(),
    );
    _comments.add(comment);
    notifyListeners();
  }

  void deleteComment(String id) {
    _comments.removeWhere(
      (comment) => comment.id == id || comment.parentId == id,
    );
    notifyListeners();
  }

  void editComment(String id, String newContent) {
    final comment = _comments.firstWhere((comment) => comment.id == id);
    comment.content = newContent;
    notifyListeners();
  }

  List<Comment> getReplies(String parentId) {
    return _comments.where((comment) => comment.parentId == parentId).toList();
  }
}
