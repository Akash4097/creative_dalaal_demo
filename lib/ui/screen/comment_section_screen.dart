import 'package:flutter/material.dart';

class CommentSectionScreen extends StatefulWidget {
  const CommentSectionScreen({super.key});

  @override
  State<CommentSectionScreen> createState() => _CommentSectionScreenState();
}

class _CommentSectionScreenState extends State<CommentSectionScreen> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCommentTextField(),
          ],
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
          onPressed: () {},
        ),
      ),
    );
  }
}
