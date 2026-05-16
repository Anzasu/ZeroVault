import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:zero_vault/backend/providers/auth_provider.dart';
import 'package:zero_vault/backend/providers/vault_provider.dart';
import 'package:zero_vault/backend/services/auth_service.dart';
import 'package:zero_vault/backend/services/encryp_service.dart';
import 'package:zero_vault/backend/services/master_key_provider.dart';
import 'package:zero_vault/frontend/flutter_flow/flutter_flow_theme.dart';
import 'package:zero_vault/frontend/flutter_flow/flutter_flow_widgets.dart';
import 'package:zero_vault/frontend/pages/vault/vault_widget.dart';

class PinSetupPage extends StatefulWidget {
  const PinSetupPage({super.key});
  static String routeName = 'PinSetup';
  static String routePath = '/pinSetup';
  @override
  State<PinSetupPage> createState() => _PinSetupPageState();
}

class _PinSetupPageState extends State<PinSetupPage> {
  final _pinController = TextEditingController();
  final _confirmController = TextEditingController();
  String? _error;
  bool _isConfirmStep = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      resizeToAvoidBottomInset: false,

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.25,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 60.0, 0.0, 0.0),
                      child: Text(
                        'Welcome to ',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.montserrat(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 40.0,
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
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/zerovaultLogo2.JPG',
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.1,
                            fit: BoxFit.cover,
                            alignment: Alignment(0.0, 0.0),
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
              const SizedBox(height: 30),

            Text(
              _isConfirmStep ? 'Confirm your PIN' : 'Set your 6‑digit PIN',
              style: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.montserrat(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 25.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
              child: Text(
              'Please store your PIN in a safe place. \nWithout it the app cannot be opened again and all your data is lost.',
              textAlign: TextAlign.center,
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
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                            ),
            ),
            ),
            
            const SizedBox(height: 30),
            PinCodeTextField(
              key: ValueKey(_isConfirmStep),
              appContext: context,
              length: 6,
              obscureText: false,
              obscuringCharacter: '*',
              keyboardType: TextInputType.number,
              controller: _isConfirmStep ? _confirmController : _pinController,
              onChanged: (_) => setState(() => _error = null),
              pinTheme: PinTheme(
                activeColor: FlutterFlowTheme.of(context).primary,
                inactiveColor: Colors.white,
              ),
              cursorColor: Colors.white,
            ),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 40),
            FFButtonWidget(
              text: _isConfirmStep ? 'Save PIN' : 'Next', 
              onPressed: _isConfirmStep ? _confirmPin : _goToConfirm, 
              options: FFButtonOptions(
                    height: 45.0,
                    width: 99,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: Colors.white,
                          fontSize: 17.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),)
            
          ],
        ),
      ),
    );
  }

  void _goToConfirm() {
    if (_pinController.text.length != 6) {
    setState(() => _error = 'PIN must be 6 digits');
    return;
  }
  _confirmController.clear();
  setState(() {
    _isConfirmStep = true;
    _error = null;
  });
  }

  Future<void> _confirmPin() async {
    if (_confirmController.text != _pinController.text) {
    setState(() => _error = 'PINs do not match');
    return;
  }

  // Generate the master key and create the PIN‑protected blob
  final masterKey = EncryptionService.generateMasterKey();
  final auth = AuthService();
  await auth.createPin(_pinController.text, masterKey);

  // Set the key and initialise the vault
  MasterKeyProvider.setKey(masterKey);
  final vault = VaultProvider();
  await vault.init(masterKey);

  // Notify the auth provider
  context.read<AuthProvider>().pinCreated();

  if (mounted) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: vault,
          child: const VaultWidget(),
        ),
      ),
      (route) => false,
    );
  }
  }
}