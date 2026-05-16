import 'package:zero_vault/backend/providers/vault_provider.dart';
import 'package:zero_vault/frontend/pages/vault/vault_widget.dart';

import '../../../flutter_flow/flutter_flow_choice_chips.dart';
import '../../../flutter_flow/flutter_flow_icon_button.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_util.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_sub_page_model.dart';
export 'edit_sub_page_model.dart';

class EditSubPageWidget extends StatefulWidget {
  final int subId;
  const EditSubPageWidget({super.key, required this.subId});

  static String routeName = 'EditSubPage';
  static String routePath = '/editSubPage';

  @override
  State<EditSubPageWidget> createState() => _EditSubPageWidgetState();
}

class _EditSubPageWidgetState extends State<EditSubPageWidget> {
  late EditSubPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();



  Map<String, dynamic>? _subscription;
  bool _loading = true;

  Future<void> _loadData() async {
    if (widget.subId < 0) {
      setState(() {
        _loading = false;
        _subscription = null;
      });
      return;
    }

    final provider = context.read<VaultProvider>();
    final sub = provider.getSubscriptionById(widget.subId);
    setState(() {
      _subscription = sub;
      _loading = false;
    });

    if(sub != null){
      _model.textController1.text = sub['newsletter_name'] ?? '';
      _model.textController2.text = sub['email'] ?? '';
      _selectedFrequency = sub?['frequency'] as String?;
    }
  }

  @override
  void initState() {
    super.initState(); 
    _model = createModel(context, () => EditSubPageModel());

    // Only two fields: newsletter name & email
    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  

    _loadData();

  }


  // ---------- Frequency selection state ----------
  String? _selectedFrequency;
  final List<String> _frequencies = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

 
  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF121212),
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.sizeOf(context).height * 0.09),
          child: AppBar(
            backgroundColor: const Color(0xFF121212),
            automaticallyImplyLeading: false,
            title: Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 10.0, 0.0),
                child: Text(
                  'Edit subscription entry',
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
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 30.0, 30.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 20.0,
                  buttonSize: 44.0,
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30.0),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
            centerTitle: false,
            toolbarHeight: MediaQuery.sizeOf(context).height * 0.09,
            elevation: 0.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top spacing
                Container(width: 100.0, height: 25.0, decoration: const BoxDecoration()),

                // ---- Newsletter name ----
                Text(
                  'Newsletter name',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primary,
                        fontSize: 17.0,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                Container(width: 100.0, height: 10.0, decoration: const BoxDecoration()),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: TextFormField(
                    controller: _model.textController1,           // newsletter name
                    focusNode: _model.textFieldFocusNode1,
                    autofocus: false,
                    enabled: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                          ),
                      hintText: 'Enter newsletter name',
                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0x00000000), width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0x00000000), width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                    enableInteractiveSelection: true,
                    validator: _model.textController1Validator.asValidator(context),
                  ),
                ),
                Container(width: 100.0, height: 30.0, decoration: const BoxDecoration()),

                // ---- Email ----
                Text(
                  'Email',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primary,
                        fontSize: 17.0,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                Container(width: 100.0, height: 10.0, decoration: const BoxDecoration()),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: TextFormField(
                    controller: _model.textController2,         
                    focusNode: _model.textFieldFocusNode2,
                    autofocus: false,
                    enabled: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                          ),
                      hintText: 'Enter email address',
                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0x00000000), width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0x00000000), width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).error, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                    enableInteractiveSelection: true,
                    validator: _model.textController2Validator.asValidator(context),
                  ),
                ),
                Container(width: 100.0, height: 30.0, decoration: const BoxDecoration()),

                // ---- Frequency ----
                Text(
                  'Frequency',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primary,
                        fontSize: 17.0,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                Container(width: 100.0, height: 10.0, decoration: const BoxDecoration()),
                Wrap(
                  spacing: 12.0,
                  children: _frequencies.map((freq) {
                    final isSelected = _selectedFrequency == freq;
                    return ChoiceChip(
                      label: Text(freq),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFrequency = selected ? freq : null;
                        });
                      },
                      selectedColor: const Color(0xFF0077FF),
                      backgroundColor: const Color(0xFF1F2937),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 14.0,
                      ),
                      side: BorderSide(
                        color: isSelected ? const Color(0xFF0077FF) : Colors.transparent,
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    );
                  }).toList(),
                ),
                Container(width: 100.0, height: 42.39, decoration: const BoxDecoration()),

                // ---- Save button ----
                FFButtonWidget(
                  onPressed: () async {
                    final newsletterName = _model.textController1.text.trim();
                    final email = _model.textController2.text.trim();
                    final frequency = _selectedFrequency;

                    final missing = <String>[];
                    if (newsletterName.isEmpty) missing.add('Newsletter name');
                    if (email.isEmpty) missing.add('Email');

                    if (missing.isNotEmpty) {
                      await showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Missing fields'),
                          content: Text('Please fill in: ${missing.join(", ")}'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }
 
                    await context.read<VaultProvider>().updateSubscription(
                      widget.subId,
                      newsletterName: newsletterName,
                      email: email,
                      frequency: frequency,
                    );
                    
                    await showDialog(
                      context: context, 
                      builder: (ctx) => AlertDialog(
                        title: const Text('Success'),
                        content: const Text('Changes saved successfully'),
                        actions: [
                          TextButton(onPressed: () => Navigator.of(ctx).pop(), 
                          child: const Text('OK')),
                        ],
                      ),
                    );
                    
                    if (mounted) Navigator.of(context).pop();
                  },
                  text: 'Save',
                  options: FFButtonOptions(
                    height: 40.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                          ),
                          color: Colors.white,
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Container(width: 100.0, height: 42.19, decoration: const BoxDecoration()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
