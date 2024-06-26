import 'package:creative_dalal/data_models/user.dart';
import 'package:flutter/material.dart';

import '../data_models/comment.dart';
import '../utils/unique_id.dart';

class CommentServiceNotifier extends ChangeNotifier {
  final List<Comment> _comments = [];

  List<Comment> getComments() {
    final comments =
        _comments.where((comment) => comment.parentId == '').toList();
    return comments;
  }

  void addComment({
    required String content,
    required User user,
    String? parentId,
  }) {
    final uid = UniqueId.generateUniqueId();
    final comment = Comment(
      id: uid,
      parentId: parentId ?? '',
      content: content,
      timestamp: DateTime.now(),
      userId: user.id,
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
    final index = _comments.indexWhere((comment) => comment.id == id);
    if (index != -1) {
      _comments[index] = _comments[index].copyWith(content: newContent);
    }
    notifyListeners();
  }

  List<Comment> getReplies(String parentId) {
    return _comments.where((comment) => comment.parentId == parentId).toList();
  }
}
