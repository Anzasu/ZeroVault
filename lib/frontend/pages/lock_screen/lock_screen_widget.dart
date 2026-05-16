import 'package:zero_vault/backend/providers/auth_provider.dart';
import 'package:zero_vault/backend/providers/vault_provider.dart';
import 'package:zero_vault/backend/services/auth_service.dart';
import 'package:zero_vault/backend/services/master_key_provider.dart';
import 'package:zero_vault/frontend/pages/lock_screen/pin_setup_page.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '../../index.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'lock_screen_model.dart';
export 'lock_screen_model.dart';

class LockScreenWidget extends StatefulWidget {
  const LockScreenWidget({super.key});

  static String routeName = 'LockScreen';
  static String routePath = '/lockScreen';

  @override
  State<LockScreenWidget> createState() => _LockScreenWidgetState();
}

class _LockScreenWidgetState extends State<LockScreenWidget> {
  late LockScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
void initState() {
  super.initState();
  _model = createModel(context, () => LockScreenModel());
  _model.pinCodeFocusNode ??= FocusNode();
//fi no pin the redirect to Onboarding
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final auth = context.read<AuthProvider>();

    /**
     * TODO:
     * Before redirected to Pin setup the lock screen is displayed for a second
     * --> add a loading page or smth that covers that up
     * Also everytime the lock or pin page opens the keyboard flashes open and closes
     * --> stop that. keybaord only opens when clicked on the field
     * 
     * ALSO: Add Splash PAge with Zero Vault Logo and Zero Vault App Icon
     * When I save a new password I get redirected to the lock screen because that was the last page on the stack 
     * --> it has to go to Vault
     */
    if (!auth.hasPin) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const PinSetupPage()),
      );
    }
  });
}

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
        backgroundColor: Color(0xFF121212),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.15,
                decoration: BoxDecoration(),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.35,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 15.0, 15.0, 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/zerovaultLogo2.JPG',
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.15,
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, 0.0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'Zero tracking. Zero cloud. 100% privacy',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.montserrat(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: Color(0xFFE5E7EB),
                              fontSize: 17.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.3,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 0.0),
                      child: PinCodeTextField(
                        autoDisposeControllers: false,
                        appContext: context,
                        length: 6,
                        textStyle:
                            FlutterFlowTheme.of(context).labelLarge.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: Color(0xFF0D9488),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        enableActiveFill: false,
                        autoFocus: true,
                        focusNode: _model.pinCodeFocusNode,
                        enablePinAutofill: false,
                        errorTextSpace: 16.0,
                        showCursor: true,
                        cursorColor: FlutterFlowTheme.of(context).primary,
                        obscureText: true,
                        obscuringCharacter: '*',
                        hintCharacter: '●',
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          fieldHeight: 44.0,
                          fieldWidth: 44.0,
                          borderWidth: 2.0,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0),
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                          ),
                          shape: PinCodeFieldShape.box,
                          activeColor: FlutterFlowTheme.of(context).primary,
                          inactiveColor: Color(0xFF656565),
                          selectedColor: Colors.white,
                        ),
                        controller: _model.pinCodeController,
                        onChanged: (_) {},
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: _model.pinCodeControllerValidator
                            .asValidator(context),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.01,
                        decoration: BoxDecoration(),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                        child: FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 100.0,
                          icon: Icon(
                            Icons.login_rounded,
                            color: Color(0xFF0077FF),
                            size: 50.0,
                          ),
                          onPressed: () async {
                            final pin = _model.pinCodeController.text;
                            if (pin.length != 6) return;

                            final authService = AuthService();
                            final masterKey = await authService.verifyPin(pin);
                            if (masterKey == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Wrong PIN')),
                              );
                              return;
                            }

                            MasterKeyProvider.setKey(masterKey);
                            final vault = VaultProvider();
                            await vault.init(masterKey);
                            context.read<AuthProvider>().unlock();

                            if (mounted) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (_) => ChangeNotifierProvider.value(
                                  value: vault,
                                  child: const VaultWidget(),
                                )),
                                (route) => false,
                              );
                            }
                          },

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


