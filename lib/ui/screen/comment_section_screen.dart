import 'package:creative_dalal/notifier/comment_service_notifier.dart';
import 'package:creative_dalal/ui/widgets/comment_widget.dart';
import 'package:flutter/material.dart';

import '../../data_models/comment.dart';

class CommentSectionScreen extends StatefulWidget {
  const CommentSectionScreen({super.key});

  @override
  State<CommentSectionScreen> createState() => _CommentSectionScreenState();
}

class _CommentSectionScreenState extends State<CommentSectionScreen> {
  late final TextEditingController _controller = TextEditingController();
  late final List<Comment> _comments;

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
      setState(() {
        _notifier.addComment(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListenableBuilder(
          listenable: _notifier,
          builder: (context, child) {
            print("rebuild commentsection: ");
            return Column(
              children: [
                _buildCommentTextField(),
                _buildCommentsList(_comments),
              ],
            );
          },
        ),
      ),
    );
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
    );
  }

  Widget _buildCommentsList(List<Comment> comments) {
    final latestComments = comments;

    return Expanded(
      child: ListView.builder(
        itemCount: latestComments.length,
        itemBuilder: (context, index) {
          final singleComment = latestComments[index];
          return CommentWidget(
            comment: singleComment,
          );
        },
      ),
    );
  }
}
