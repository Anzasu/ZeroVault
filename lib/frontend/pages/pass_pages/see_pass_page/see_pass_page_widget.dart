import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';         
import 'package:provider/provider.dart';
import 'package:zero_vault/backend/providers/vault_provider.dart';
import 'package:zero_vault/frontend/flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';

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
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Color(0xFF121212),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 30.0, 0.0),
            child: Text(
                  'View password',
                  style: FlutterFlowTheme.of(context).displaySmall.override(
                        font: GoogleFonts.montserrat(
                          fontWeight: FlutterFlowTheme.of(context)
                              .displaySmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .displaySmall
                              .fontStyle,
                        ),
                        color: Colors.white,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .displaySmall
                            .fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).displaySmall.fontStyle,
                      ),
                ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(50.0, 29.0, 30.0, 0.0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 20.0,
              buttonSize: 44.0,
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30.0),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
        toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _credential == null
              ? const Center(child: Text('Credential not found', style: TextStyle(color: Colors.white)))
              : SafeArea(
                  top: false,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 40),
                            // Title
                            _buildLabel('Website or app'),
                            const SizedBox(height: 10),
                            _buildCopyRow(_credential!['title']),
                            const SizedBox(height: 50),
                            // Email/username
                            _buildLabel('Email or username'),
                            const SizedBox(height: 10),
                            _buildCopyRow(_credential!['username_or_email']),
                            const SizedBox(height: 50),
                            // Password
                            _buildLabel('Password'),
                            const SizedBox(height: 10),
                            _buildCopyRow(_credential!['password']),
                            const SizedBox(height: 50),
                            // Notes
                            _buildLabel('Notes'),
                            const SizedBox(height: 10),
                            _buildCopyRow(
                              _credential!['notes'] ?? 'No notes',
                              showIfEmpty: true,
                            ),
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
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primary,
                        fontSize: 17.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
              color: FlutterFlowTheme.of(context).secondaryBackground,  
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              text,
              style: FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(Icons.copy, color: FlutterFlowTheme.of(context).primary),
          onPressed: () => _copyToClipboard(text),
        ),
      ],
    );
  }
}