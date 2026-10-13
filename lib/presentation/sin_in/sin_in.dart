import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pechat_pay/data/style/validaor.dart';
import 'package:pechat_pay/presentation/sin_in/showi_dalog.dart';

import '../../data/style/text_form_style.dart';
import '../../data/style/text_style.dart';
import '../../data/theme/theme_class.dart';
import '../../logon/login/login_cubit.dart';

class SinIn extends StatefulWidget {
  const SinIn({super.key});

  @override
  State<SinIn> createState() => _SinInState();
}

class _SinInState extends State<SinIn> with WidgetsBindingObserver {
  final formKey = GlobalKey<FormState>();

  late final FocusNode _focusNode;

  bool isKeyboardOpen = false;

  String? phone;
  String? parol;

  bool get isTablet => MediaQuery.sizeOf(context).shortestSide >= 600;

  // TELEFON VA PLANSHET UCHUN ALOHIDA O'LCHAMLAR

  double get logoTop => isTablet ? 263 : (isKeyboardOpen ? 172.h : 243.h);

  double get phoneTop => isTablet ? 449 : (isKeyboardOpen ? 336.h : 419.h);

  double get passwordTop => isTablet ? 540 : (isKeyboardOpen ? 427.h : 510.h);

  double get buttonTop => isTablet ? 645 : (isKeyboardOpen ? 532.h : 615.h);

  double get buttonHeight => isTablet ? 56 : 56.h;

  double get horizontalPadding => isTablet ? 40.w : 22.w;

  double get logoWidth => isTablet ? 271 : 271.w;

  double get fieldFontSize => isTablet ? 16 : 16.sp;

  double get buttonFontSize => isTablet ? 20 : 20.sp;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    WidgetsBinding.instance.addObserver(this);
    _focusNode.addListener(_focusListener);
  }

  @override
  void didChangeMetrics() {
    if (!mounted) return;

    final bottom = View.of(context).viewInsets.bottom;

    setState(() {
      isKeyboardOpen = bottom > 0;
    });

    super.didChangeMetrics();
  }

  void _focusListener() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();

    super.dispose();
  }

  Future<void> onTap() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      await context.read<LoginCubit>().sinIn(phone!, parol!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).extension<ThemeClass>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SizedBox(
          height: 884.h,
          width: MediaQuery.sizeOf(context).width,
          child: Form(
            key: formKey,
            child: Stack(
              children: [
                // LOGO
                Positioned(
                  top: logoTop,
                  left: isTablet ? 0 : 60.w,
                  right: isTablet ? 0 : 60.w,
                  child: Center(
                    child: Image.asset(
                      'assets/pechat_pay_logo.png',
                      alignment: Alignment.center,
                      width: logoWidth,
                    ),
                  ),
                ),

                // TELEFON RAQAM
                Positioned(
                  top: phoneTop,
                  left: horizontalPadding,
                  right: horizontalPadding,
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (builderContext, holat) {
                      return TextFormField(
                        keyboardType: TextInputType.phone,
                        style: AppTextStyles.style16.copyWith(
                          color: myTheme.text,
                          fontSize: fieldFontSize,
                        ),
                        cursorColor: myTheme.unselctedColor,
                        cursorErrorColor: myTheme.unselctedColor,
                        textAlign: TextAlign.center,
                        decoration: AppTextFormStyle.style(
                          color: myTheme.unselctedColor,
                          text: 'Telfon raqamni kiriting',
                          visibilityOff: false,
                          errorText:
                              holat is LoginError &&
                                  holat.error.data != null &&
                                  holat.error.data!.phone.isNotEmpty
                              ? holat.error.data!.phone[0]
                              : null,
                        ),
                        validator: (value) => AppValidator.phone(value: value),
                        onSaved: (value) {
                          phone = value!;
                        },
                      );
                    },
                  ),
                ),

                // PAROL
                Positioned(
                  top: passwordTop,
                  left: horizontalPadding,
                  right: horizontalPadding,
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (builderContext, holat) {
                      return TextFormField(
                        style: AppTextStyles.style16.copyWith(
                          color: myTheme.text,
                          fontSize: fieldFontSize,
                        ),
                        cursorColor: myTheme.unselctedColor,
                        cursorErrorColor: myTheme.unselctedColor,
                        focusNode: _focusNode,
                        textAlign: TextAlign.center,
                        obscureText: holat.toHider,
                        decoration: AppTextFormStyle.style(
                          color: myTheme.unselctedColor,
                          text: 'Parolni kiriting',
                          visibilityOff: true,
                          eye: _focusNode.hasFocus,
                          state: holat.toHider,
                          onTap: () {
                            context.read<LoginCubit>().hider();
                          },
                          errorText:
                              holat is LoginError && holat.error.data != null
                              ? (holat.error.data!.password.isNotEmpty
                                    ? holat.error.data!.password[0]
                                    : null)
                              : null,
                        ),
                        validator: (value) =>
                            AppValidator.password(value: value, name: 'Parol'),
                        onSaved: (value) {
                          parol = value!;
                        },
                      );
                    },
                  ),
                ),

                // KIRISH TUGMASI
                Positioned(
                  top: buttonTop,
                  left: horizontalPadding,
                  right: horizontalPadding,
                  height: buttonHeight,
                  child: BlocConsumer<LoginCubit, LoginState>(
                    builder: (ctx, holat) {
                      return ElevatedButton(
                        onPressed: holat is LoginLoding ? () {} : onTap,
                        style: AppTextFormStyle.buttonStyle(
                          background: myTheme.globalColor,
                          foreground: myTheme.textColor,
                        ),
                        child: holat is LoginLoding
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: myTheme.textColor,
                                ),
                              )
                            : Text(
                                'Kirish',
                                style: AppTextStyles.style20.copyWith(
                                  color: myTheme.textColor,
                                  fontSize: buttonFontSize,
                                ),
                              ),
                      );
                    },
                    listener: (ctx, holat) {
                      if (holat is LoginError && holat.error.data == null) {
                        showiDalog(holat.error.message, ctx);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
