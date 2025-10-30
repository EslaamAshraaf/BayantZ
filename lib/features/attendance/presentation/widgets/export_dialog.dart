import 'package:flutter/material.dart';

/// Dialog widget that allows users to export attendance data to Excel.
/// Includes file name input, validation, and confirmation UI.

class ExportDialog extends StatefulWidget {
  const ExportDialog({super.key});

  @override
  State<ExportDialog> createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  final _formKey = GlobalKey<FormState>();
  final _fileController = TextEditingController();

  void _download() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _fileController.text.trim());
    }
  }

  @override
  void dispose() {
    _fileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.file_download_outlined, color: Colors.black54),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Export",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // File Name field
                TextFormField(
                  controller: _fileController,
                  decoration: InputDecoration(
                    labelText: 'File Name',
                    hintText: 'Text here',
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'File name is required';
                    }
                    if (val.contains(RegExp(r'[\\/:*?"<>|]'))) {
                      return 'Invalid characters in file name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _grayButton('Discard', () => Navigator.pop(context)),
                    _grayButton('Download', _download),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _grayButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 120,
      height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFBDBDBD),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(text),
      ),
    );
  }
}
