import 'package:flutter/material.dart';
import 'package:flutter/services.dart';         
import 'package:provider/provider.dart';
import 'package:zero_vault/backend/providers/vault_provider.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';   
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import 'package:go_router/go_router.dart';

class SeePassPageWidget extends StatefulWidget {
  final int credentialId;
  const SeePassPageWidget({super.key, required this.credentialId});

  static String routeName = 'SeePassPage';
  static String routePath = '/seePassPage';

  @override
  State<SeePassPageWidget> createState() => _SeePassPageWidgetState();
}

class _SeePassPageWidgetState extends State<SeePassPageWidget> {
  Map<String, dynamic>? _credential;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Step 4: edge case – no valid ID was passed
    if (widget.credentialId < 0) {
      setState(() {
        _loading = false;
        _credential = null;
      });
      return;
    }

    final provider = context.read<VaultProvider>();
    setState(() {
      _credential = provider.getCredentialById(widget.credentialId);
      _loading = false;
    });
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Consistent dark theme like add_pass_page
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 30.0, 0.0),
            child: Text(
              'View Password',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 30.0, 30.0, 0.0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 20.0,
              buttonSize: 44.0,
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.09,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _credential == null
              ? const Center(child: Text('Credential not found', style: TextStyle(color: Colors.white)))
              : SafeArea(
                  top: true,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 25),
                            // Title
                            _buildLabel('Website or app'),
                            const SizedBox(height: 10),
                            _buildCopyRow(_credential!['title']),
                            const SizedBox(height: 30),
                            // Email/username
                            _buildLabel('Email or username'),
                            const SizedBox(height: 10),
                            _buildCopyRow(_credential!['username_or_email']),
                            const SizedBox(height: 30),
                            // Password
                            _buildLabel('Password'),
                            const SizedBox(height: 10),
                            _buildCopyRow(_credential!['password']),
                            const SizedBox(height: 30),
                            // Notes
                            _buildLabel('Notes'),
                            const SizedBox(height: 10),
                            _buildCopyRow(
                              _credential!['notes'] ?? 'No notes',
                              showIfEmpty: true,
                            ),
                            const SizedBox(height: 42),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF0077FF),   // same as add_pass_page label color
        fontSize: 17.0,
      ),
    );
  }

  Widget _buildCopyRow(String text, {bool showIfEmpty = false}) {
    if (!showIfEmpty && text.trim().isEmpty) {
      return const Text(
        'Not set',
        style: TextStyle(color: Colors.grey, fontSize: 15),
      );
    }
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),   // dark container
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.copy, color: Color(0xFF0077FF)),
          onPressed: () => _copyToClipboard(text),
        ),
      ],
    );
  }
}