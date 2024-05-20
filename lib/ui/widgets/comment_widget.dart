import 'package:flutter/material.dart';

import '../../data_models/comment.dart';
import '../../notifier/comment_service_notifier.dart';
import '../../utils/date_format_extension.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  const CommentWidget({
    super.key,
    required this.comment,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late final _replyController = TextEditingController();
  late final CommentServiceNotifier _notifier;
  List<Comment> _replies = <Comment>[];

  bool _showReplyTextField = false;

  @override
  void initState() {
    super.initState();
    _notifier = CommentServiceNotifier();
  }

  @override
  void dispose() {
    super.dispose();
    _replyController.dispose();
  }

  void _replyToComment() {
    if (_replyController.text.isNotEmpty) {
      _notifier.addComment(
        _replyController.text,
        parentId: widget.comment.id,
      );
    }
    setState(() {
      _showReplyTextField = !_showReplyTextField;
    });
    _replyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    _replies = _notifier.getReplies(widget.comment.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Icon(
                Icons.person_pin,
                size: 32,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      widget.comment.content,
                      style: textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      widget.comment.timestamp.toFormattedDate(),
                      style: textTheme.bodySmall,
                    ),
                  ),
                  _showReplyTextField
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
                        ),
                ],
              ),
            ),
          ],
        ),
        _showReplyTextField
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
                ),
              )
            : const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            children: _replies.map((reply) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: CommentWidget(
                  comment: reply,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
