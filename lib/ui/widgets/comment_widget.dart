import 'dart:math';

import 'package:creative_dalal/data_models/user.dart';
import 'package:flutter/material.dart';

import '../../data_models/comment.dart';
import '../../notifier/comment_service_notifier.dart';
import '../../utils/date_format_extension.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final List<Comment> replies;
  final CommentServiceNotifier notifier;
  const CommentWidget({
    super.key,
    required this.comment,
    required this.notifier,
    required this.replies,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late final _replyController = TextEditingController();
  late final _editController = TextEditingController();

  bool _showReplyTextField = false;
  bool _isEditing = false;
  bool _showReplies = false;

  @override
  void dispose() {
    super.dispose();
    _replyController.dispose();
  }

  void _replyToComment() {
    if (_replyController.text.isNotEmpty) {
      final parentUser = usersList.firstWhere(
        (user) => user.id == widget.comment.userId,
      );
      final replyUser = usersList
          .where((user) => user.id != parentUser.id)
          .toList()[Random().nextInt(4)];
      widget.notifier.addComment(
        content: _replyController.text,
        user: replyUser,
        parentId: widget.comment.id,
      );
    }
    setState(() {
      _showReplyTextField = !_showReplyTextField;
    });
    _replyController.clear();
  }

  void _editComment() {
    if (_editController.text.isNotEmpty) {
      widget.notifier.editComment(widget.comment.id, _editController.text);
    }
    setState(() {
      _isEditing = false;
    });
  }

  void _deleteComment() {
    widget.notifier.deleteComment(widget.comment.id);
  }

  void _toggleReplies() {
    setState(() {
      _showReplies = !_showReplies;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCommentContent(textTheme),
        _buildReplyCommentTextField(),
        _buildReplyComment(),
      ],
    );
  }

  Widget _buildReplyComment() {
    if (_showReplies) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          children: widget.replies.map((reply) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CommentWidget(
                comment: reply,
                notifier: widget.notifier,
                replies: widget.notifier.getReplies(reply.id),
              ),
            );
          }).toList(),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildReplyCommentTextField() {
    return _showReplyTextField
        ? Padding(
            padding: const EdgeInsets.only(left: 40),
            child: TextField(
              controller: _replyController,
              decoration: InputDecoration(
                labelText: 'Reply',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _replyToComment,
                ),
              ),
              onSubmitted: (_) => _replyToComment(),
            ),
          )
        : const SizedBox.shrink();
  }

  Row _buildCommentContent(TextTheme textTheme) {
    return Row(
      children: [
        _commentUserIcon(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: _commentContentTitle(textTheme),
                subtitle: _commentFormattedDate(textTheme),
                trailing: _commentEditAndDeleteButton(),
              ),
              _showAndHideReplyTextField(),
              if (widget.replies.isNotEmpty)
                TextButton(
                  onPressed: _toggleReplies,
                  child: Text(
                    _showReplies
                        ? 'Hide replies'
                        : 'Show replies (${widget.replies.length})',
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showAndHideReplyTextField() {
    return _showReplyTextField
        ? IconButton(
            onPressed: () {
              setState(() {
                _showReplyTextField = false;
              });
            },
            icon: const Icon(Icons.close),
          )
        : TextButton(
            onPressed: () {
              setState(() {
                _showReplyTextField = true;
              });
            },
            child: const Text("Reply"),
          );
  }

  Text _commentFormattedDate(TextTheme textTheme) {
    return Text(
      widget.comment.timestamp.toFormattedDate(),
      style: textTheme.bodySmall,
    );
  }

  PopupMenuButton<String> _commentEditAndDeleteButton() {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Text('Edit'),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
      onSelected: (value) {
        if (value == 'edit') {
          setState(() {
            _isEditing = true;
          });
        } else if (value == 'delete') {
          _deleteComment();
        }
      },
    );
  }

  Widget _commentContentTitle(TextTheme textTheme) {
    final user =
        usersList.firstWhere((user) => user.id == widget.comment.userId);
    return _isEditing
        ? TextField(
            controller: _editController..text = widget.comment.content,
            onSubmitted: (_) => _editComment(),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () => _editComment(),
              ),
            ),
          )
        : Row(
            children: [
              Text(
                user.name,
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.comment.content,
                style: textTheme.titleMedium,
              ),
            ],
          );
  }

  Padding _commentUserIcon() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 24.0),
      child: Icon(
        Icons.person_pin,
        size: 32,
      ),
    );
  }
}
