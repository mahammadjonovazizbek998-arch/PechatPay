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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addObserver(this);
    _focusNode.addListener(_focusListener);
  }

  @override
  void didChangeMetrics() {
    final bootm = View.of(context).viewInsets.bottom;
    setState(() {
      isKeyboardOpen = bootm > 0;
    });
    // TODO: implement didChangeMetrics
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

    // TODO: implement dispose
    super.dispose();
  }

  String? phone;
  String? parol;

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
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Positioned(
              top: isKeyboardOpen ? 134.h : 190.h,
              left: 55.w,
              right: 55.w,
              child: Image.asset(
                alignment: .center,
                "assets/pechat_pay_logo.png",
                width: 250.w,
              ),
            ),
            Positioned(
              top: isKeyboardOpen ? 262.h : 327.h,
              left: 20.w,
              right: 20.w,
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (builderContext, holat) {
                  return TextFormField(
                    keyboardType: .phone,
                    style: AppTextStyles.style16.copyWith(color: myTheme.text),
                    cursorColor: myTheme.unselctedColor,
                    cursorErrorColor: myTheme.unselctedColor,
                    textAlign: TextAlign.center,
                    decoration: AppTextFormStyle.style(
                      color: myTheme.unselctedColor,
                      text: "Telfon raqamni kiriting",
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
            Positioned(
              top: isKeyboardOpen ? 333.h : 398.h,
              left: 20.w,
              right: 20.w,
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (builderContext, holat) {
                  return TextFormField(
                    style: AppTextStyles.style16.copyWith(color: myTheme.text),
                    cursorColor: myTheme.unselctedColor,
                    cursorErrorColor: myTheme.unselctedColor,
                    focusNode: _focusNode,
                    textAlign: TextAlign.center,
                    obscureText: holat.toHider,
                    decoration: AppTextFormStyle.style(
                      color: myTheme.unselctedColor,
                      text: "Parolni kiriting",
                      visibilityOff: true,
                      eye: _focusNode.hasFocus,
                      state: holat.toHider,
                      onTap: () => context.read<LoginCubit>().hider(),
                      errorText: holat is LoginError && holat.error.data != null
                          ? (holat.error.data!.password.isNotEmpty
                                ? holat.error.data!.password[0]
                                : null)
                          : null,
                    ),
                    validator: (value) => AppValidator.password(value: value),
                    onSaved: (value) {
                      parol = value!;
                    },
                  );
                },
              ),
            ),
            Positioned(
              top: isKeyboardOpen ? 415.h : 480.h,
              left: 20.w,
              right: 20.w,
              height: 53.h,
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
                            "Kirish",
                            style: AppTextStyles.style20.copyWith(
                              color: myTheme.textColor,
                            ),
                          ),
                  );
                },
                listener: (ctx, holat) {
                  if (holat is LoginError && holat.error.data == null) {
                    {
                      showiDalog(holat.error.message, ctx);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
