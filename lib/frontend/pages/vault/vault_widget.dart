import 'package:zero_vault/backend/providers/vault_provider.dart';
import 'package:zero_vault/frontend/index.dart';
import 'package:zero_vault/frontend/pages/sub_pages/edit_sub_page/edit_sub_page_widget.dart';
import 'package:zero_vault/frontend/pages/sub_pages/add_sub_page/add_sub_page_widget.dart';

import 'package:zero_vault/frontend/pages/pass_pages/see_pass_page/see_pass_page_widget.dart';

import '../../flutter_flow/flutter_flow_drop_down.dart';
import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'vault_model.dart';
export 'vault_model.dart';
import 'package:go_router/go_router.dart';

class VaultWidget extends StatefulWidget {
  const VaultWidget({super.key});

  static String routeName = 'Vault';
  static String routePath = '/vault';

  @override
  State<VaultWidget> createState() => _VaultWidgetState();
}

class _VaultWidgetState extends State<VaultWidget>
    with TickerProviderStateMixin {
  late VaultModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VaultModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  final vaultProvider = context.watch<VaultProvider>();
  final credentials = vaultProvider.credentials;
  final subscriptions = vaultProvider.subscriptions;

  return GestureDetector(
    onTap: () {
      FocusScope.of(context).unfocus();
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF121212),
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.sizeOf(context).height * 0.09),
        child: AppBar(
          backgroundColor: Color(0xFF121212),
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 36.0, 0.0, 0.0),
              child: Text(
                'Vault',
                style: FlutterFlowTheme.of(context).displaySmall.override(
                      font: GoogleFonts.montserrat(
                        fontWeight: FlutterFlowTheme.of(context)
                            .displaySmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .displaySmall
                            .fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primary,
                      fontSize: 45.0,
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
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(80.0, 36.0, 78.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 44.0,
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    print('Settings pressed ...');
                  },
                ),
              ),
            ),
          ],
          centerTitle: false,
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
          elevation: 0.0,
        ),
      ),
      // *********************************************************** TABS *****************************************************************************
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 100.0,
              height: MediaQuery.sizeOf(context).height * 0.03,
              decoration: BoxDecoration(),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: TabBar(
                          labelColor: FlutterFlowTheme.of(context).primary,
                          unselectedLabelColor: Color(0xFF7E7E7E),
                          labelStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                          unselectedLabelStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                          indicatorColor: FlutterFlowTheme.of(context).primary,
                          tabs: [
                            Tab(
                              text: 'Passwords',
                              icon: Icon(
                                Icons.password_rounded,
                              ),
                            ),
                            Tab(
                              text: 'Newsletters & \nSubscriptions',
                              icon: Icon(
                                Icons.calendar_month_outlined,
                              ),
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            //****************************************************** PASSWORDS TAB *****************************************************
                            SingleChildScrollView(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(9.0, 20.0, 16.0, 10.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                        // ---------------------------------------------- PASS ADD BUTTON --------------------------------------------------
                                              Align(
                                                alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                                child: Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 16.0, 0.0),
                                                child: Container(
                                                  width: MediaQuery.sizeOf(context).width *0.37,
                                                  height: MediaQuery.sizeOf(context).height *0.07,
                                                  decoration: BoxDecoration(),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(0.0, 0.0),
                                                    child: Padding(
                                                      padding:EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                                    child: FFButtonWidget( 
                                                      icon: Icon(Icons.add, color: Colors.white,),
                                                    onPressed: () async {
                                                      await context.pushNamed(AddPassPageWidget.routeName);
                                                      context.read<VaultProvider>().refresh();
                                                    },
                                                    text: 'Password',
                                                    options: FFButtonOptions(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.25,
                                                          padding:
                                                              EdgeInsets.all(8.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0.0,
                                                                      0.0, 0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme.of(context).primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .interTight(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 2.0,
                                                          borderSide: BorderSide(
                                                            color:
                                                                Colors.transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  // -------------------------------------------------- PASSWORD SEARCH ------------------------------------------------
                                                  child: TextFormField(
                                                    controller: _model.textController1,
                                                    focusNode: _model.textFieldFocusNode1,
                                                    onChanged: (value) {
                                                      context.read<VaultProvider>().setCredentialSearch(value);
                                                    },
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration:
                                                        InputDecoration(
                                                      isDense: false,
                                                      hintText: 'Search...',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors.white,
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(
                                                              0x00000000),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              FlutterFlowTheme.of(context).primary,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(12.0,
                                                                  12.0, 12.0,
                                                                  12.0),
                                                      prefixIcon: Icon(
                                                        Icons.search_rounded,
                                                        color:
                                                            Color(0xFFFCFEFE),
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .montserrat(
                                                            fontWeight: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                          ),
                                                          color:
                                                              FlutterFlowTheme.of(context).primary,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                        ),
                                                    cursorColor:
                                                        FlutterFlowTheme.of(context).primary,
                                                    validator: _model
                                                        .textController1Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ),
                                              
                                            ],
                                          ),
                                        ),                                        
                                        // ------------------------------------------------------------ PASSWORD ENTRIES ---------------------------------------------------------
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 9.0),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: credentials.length,
                                            itemBuilder: (context, index) {
                                              final item = credentials[index];
                                              return Padding(
                                                padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16.0, 8.0,
                                                            16.0, 8.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF1F2937),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              item['title'], // .................................  
                                                              style: FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .interTight(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFFE5E7EB),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      0.0),
                                                              child: Text(
                                                                item['username_or_email'] ?? '',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(
                                                                          0xFFE5E7EB),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            FlutterFlowIconButton(
                                                              borderRadius:
                                                                  20.0,
                                                              buttonSize:
                                                                  40.0,
                                                              fillColor: FlutterFlowTheme.of(
                                                                      context)
                                                                  .accent1,
                                                              icon: Icon(
                                                                Icons.edit,
                                                                color: FlutterFlowTheme.of(context).primary,
                                                                size: 20.0,
                                                              ),
                                                               onPressed: () {
                                                                final id = item['id'] as int;
                                                                GoRouter.of(context).push('${EditPassPageWidget.routePath}?id=$id');
                                                                context.read<VaultProvider>().refresh();

                                                              },
                                                            ),
                                                            FlutterFlowIconButton(
                                                              borderRadius:
                                                                  20.0,
                                                              buttonSize:
                                                                  40.0,
                                                              fillColor: FlutterFlowTheme.of(
                                                                      context)
                                                                  .accent1,
                                                              icon: Icon(
                                                                Icons
                                                                    .visibility_outlined,
                                                                color: FlutterFlowTheme.of(context).primary,
                                                                size: 20.0,
                                                              ),
                                                              onPressed: () {
                                                                final id = item['id'] as int;
                                                                GoRouter.of(context).push('${SeePassPageWidget.routePath}?id=$id');
                                                                context.read<VaultProvider>().refresh();

                                                              },
                                                            ),
                                                            FlutterFlowIconButton(
                                                              borderRadius:
                                                                  20.0,
                                                              buttonSize:
                                                                  40.0,
                                                              fillColor: FlutterFlowTheme.of(
                                                                      context)
                                                                  .accent1,
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_forever,
                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                size: 20.0,
                                                              ),
                                                              onPressed: () async {
                                                                await showDialog(
                                                                  context: context, 
                                                                  builder: (ctx) => AlertDialog(
                                                                    title: Text('Delete entry'),
                                                                    content: Text('Delete this entry permanently?'),
                                                                    actions: [
                                                                      TextButton(onPressed: () => Navigator.of(ctx).pop(),
                                                                      child: const Text('No'),
                                                                      ),
                                                                      TextButton(onPressed: () async {
                                                                        if (mounted){
                                                                          Navigator.of(context).pop();
                                                                          await context.read<VaultProvider>().deleteCredential(item['id'] as int);
                                                                        }
                                                                      }, child: const Text('Yes'),)
                                                                    ],
                                                                  )
                                                                );
                                                              }
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 12.0)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //*********************************************** SUB TAB *********************************************************************************************
                            SingleChildScrollView(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 15.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(19.0, 20.0, 16.0, 10.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // ----------------------------------------------------------------------- SUB ADD BUTTON -----------------------------------------
                                                Align(
                                                  alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                  child: Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 16.0, 0.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(context).width *0.4,
                                                    height: MediaQuery.sizeOf(context).height *0.07,
                                                    decoration: BoxDecoration(),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(0.0, 0.0),
                                                      child: Padding(
                                                        padding:EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                                      child: FFButtonWidget( 
                                                        icon: Icon(Icons.add, color: Colors.white),
                                                      onPressed: () async {
                                                      await context.pushNamed(AddSubPageWidget.routeName);
                                                      context.read<VaultProvider>().refresh();
                                                    },
                                                      text: 'Subscription',
                                                      options: FFButtonOptions(
                                                            width:
                                                                MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    1.0,
                                                            height:
                                                                MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.25,
                                                            padding:
                                                                EdgeInsets.all(8.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(0.0,
                                                                        0.0, 0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme.of(context).primary,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .interTight(
                                                                        fontWeight: FlutterFlowTheme.of(
                                                                                context)
                                                                            .titleSmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(
                                                                                context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                            elevation: 2.0,
                                                            borderSide: BorderSide(
                                                              color:
                                                                  Colors.transparent,
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    10.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        // ------------------------------------------------------------------------ SUB SEARCH BAR ---------------------------------------------
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: TextFormField( 
                                                    controller: _model.textController2,
                                                    focusNode: _model.textFieldFocusNode2,
                                                    onChanged: (value) {
                                                      context.read<VaultProvider>().setSubscriptionSearch(value);
                                                    },
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration:
                                                        InputDecoration(
                                                      isDense: false,
                                                      hintText: 'Search...',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color(
                                                              0x00000000),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              FlutterFlowTheme.of(context).primary,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(12.0,
                                                                  12.0, 12.0,
                                                                  12.0),
                                                      prefixIcon: Icon(
                                                        Icons.search_rounded,
                                                        color:
                                                            Color(0xFFFCFEFE),
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .montserrat(
                                                            fontWeight: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                          ),
                                                          color:
                                                              FlutterFlowTheme.of(context).primary,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                        ),
                                                    cursorColor:
                                                        FlutterFlowTheme.of(context).primary,
                                                    validator: _model
                                                        .textController2Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                              ),
                            
                                            ],
                                          ),
                                        ),
                                        //--------------------------------------------------------- SUB ENTRIES ------------------------------------------------------
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(0.0, 0.0, 0.0, 9.0),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: subscriptions.length,
                                            itemBuilder: (context, index) {
                                              final item = subscriptions[index];
                                              return Padding(
                                                padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(16.0, 8.0,
                                                            16.0, 8.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF1F2937),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text( // .................................................... NEWSLETTER NAME ................................
                                                              item['newsletter_name'],
                                                              style: FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .interTight(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFFE5E7EB),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            Text('${item['frequency'] ?? 'Not defined'}',
                                                              style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(
                                                                          0xFFE5E7EB),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      0.0),
                                                              child: Text( // ............................................................ EMAIL ................................
                                                                item['email'],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(
                                                                          0xFFE5E7EB),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row( // -------------------------------------------------------- SUB BUTTONS ----------------------------------------------
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            FlutterFlowIconButton(
                                                              borderRadius:
                                                                  20.0,
                                                              buttonSize:
                                                                  40.0,
                                                              fillColor: FlutterFlowTheme.of(
                                                                      context)
                                                                  .accent1,
                                                              icon: Icon(
                                                                Icons.edit,
                                                                color: FlutterFlowTheme.of(context).primary,
                                                                size: 20.0,
                                                              ),
                                                              onPressed: () {
                                                                final id = item['id'] as int;
                                                                GoRouter.of(context).push('${EditSubPageWidget.routePath}?id=$id');
                                                                context.read<VaultProvider>().refresh();

                                                              },
                                                              ),
                                                            FlutterFlowIconButton(
                                                              borderRadius:
                                                                  20.0,
                                                              buttonSize:
                                                                  40.0,
                                                              fillColor: FlutterFlowTheme.of(
                                                                      context)
                                                                  .accent1,
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_forever,
                                                                color: FlutterFlowTheme.of(context).tertiary,
                                                                size: 20.0,
                                                              ),
                                                              onPressed: () async {
                                                                await showDialog(
                                                                  context: context, 
                                                                  builder: (ctx) => AlertDialog(
                                                                    title: Text('Delete entry'),
                                                                    content: Text('Delete this entry permanently?'),
                                                                    actions: [
                                                                      TextButton(onPressed: () => Navigator.of(ctx).pop(),
                                                                      child: const Text('No'),
                                                                      ),
                                                                      TextButton(onPressed: () async {
                                                                        if (mounted){
                                                                          Navigator.of(context).pop();
                                                                          await context.read<VaultProvider>().deleteSubscription(item['id'] as int);
                                                                        }
                                                                      }, child: const Text('Yes'),)
                                                                    ],
                                                                  )
                                                                );
                                                              }
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 12.0)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
