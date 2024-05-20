import 'dart:math';

import 'package:creative_dalal/notifier/comment_service_notifier.dart';
import 'package:creative_dalal/ui/widgets/comment_widget.dart';
import 'package:flutter/material.dart';

import '../../data_models/comment.dart';
import '../../data_models/user.dart';

class CommentSectionScreen extends StatefulWidget {
  const CommentSectionScreen({super.key});

  @override
  State<CommentSectionScreen> createState() => _CommentSectionScreenState();
}

class _CommentSectionScreenState extends State<CommentSectionScreen> {
  late final TextEditingController _controller = TextEditingController();
  late final List<Comment> _comments;

  bool _showAllComments = false;
  final _notifier = CommentServiceNotifier();

  @override
  void initState() {
    super.initState();
    _comments = _notifier.getComments();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _addComment() {
    if (_controller.text.isNotEmpty) {
      final user = usersList[Random().nextInt(5)];
      setState(() {
        _notifier.addComment(content: _controller.text, user: user);
        _controller.clear();
      });
    }
  }

  void _toggleCommentsVisibility() {
    setState(() {
      _showAllComments = !_showAllComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListenableBuilder(
            listenable: _notifier,
            builder: (context, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCommentTextField(),
                  _buildShowAllCommentButton(),
                  _buildCommentsList(_comments),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildShowAllCommentButton() {
    final comments = _notifier.getComments();
    if (comments.length > 4) {
      return TextButton(
        onPressed: _toggleCommentsVisibility,
        child: _showAllComments
            ? const Text("Hide Previous Comments")
            : const Text("Show Previous Comments"),
      );
    }
    return const SizedBox.shrink();
  }

  TextField _buildCommentTextField() {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Add a comment',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: _addComment,
        ),
      ),
      onSubmitted: (_) => _addComment(),
    );
  }

  Widget _buildCommentsList(List<Comment> comments) {
    final comments = _notifier.getComments()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    final latestComments =
        _showAllComments ? comments : comments.take(4).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: latestComments.length,
        itemBuilder: (context, index) {
          final singleComment = latestComments[index];
          final replies = _notifier.getReplies(singleComment.id);
          return CommentWidget(
            comment: singleComment,
            notifier: _notifier,
            replies: replies,
          );
        },
      ),
    );
  }
}
