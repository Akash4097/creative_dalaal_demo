import 'package:creative_dalal/data_models/comment.dart';
import 'package:creative_dalal/utils/date_format_extension.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final List<Comment> replies;
  const CommentWidget({
    super.key,
    required this.comment,
    required this.replies,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(widget.comment.content),
          subtitle: Text(widget.comment.timestamp.toFormattedDate()),
        ),
      ],
    );
  }
}
