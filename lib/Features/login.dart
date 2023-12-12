
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  final String? callbackScreen;
  const LoginScreen({Key? key, this.callbackScreen}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    //context.read<AuthCubit>().onInit();
    super.initState();
  }

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    // final cubit = context.read<AuthCubit>();
    // initSendCodeToVerifyEmailUseCase();
    // initRegisterUseCase();
    // initLoginUseCase();
    return BlocListener<AuthCubit, AuthState>(
      listener: _listener,
      child: Form(
        autovalidateMode: autovalidateMode,
        key: cubit.loginFormKey,
        child: DefaultScaffold(
          statusBarColor: ColorsManager.whiteFF,
          child: WillPopScope(
            onWillPop: () async {
              if (widget.callbackScreen == 'projectDetails') {
                final projectCubit = context.read<ProjectCubit>();
                projectCubit.getProjectDetails(
                    projectCubit.slugProjectDetails.toString());
                navigateReplacement(context, Routes.projectDetail,
                    arguments: projectCubit.slugProjectDetails);
                return false;
              } else {
                context.read<AuthCubit>().clearLogin();
                context.read<MainCubit>().currentIndex = 0;
                navigateToAndFinish(context, Routes.mainLayoutRoute)
                    .then((value) {});
                return true;
              }
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: DefaultBackIcon(
                  onTap: () {
                    // context.read<AuthCubit>().clearRegisterControllers();
                    // context.read<AuthCubit>().clearLogin();
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, Routes.mainLayoutRoute, (_) => false);
                  },
                ),
              ),
              backgroundColor: ColorsManager.whiteFF,
              body: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 16,
                  //PaddingManager.p16,
                  end: 16,
                  //PaddingManager.p16,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                        ),
                        Image.asset("ImagesManager.logo"),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 8,
                              //PaddingManager.p8,
                              top:8 ,
                             // PaddingManager.p23
                          ),
                          child: Text(
                            "S.current.welcomeBackAgain",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16),
                          child: DefaultTextFormField(
                            title: "S.current.emailOrUserName",
                            hintText: "S.current.enterEmailOrUsername",
                            //controller: cubit.userNameOrEmailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            messageValidate: "S.of(context).requiredEmail",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: PaddingManager.p16),
                          child: BlocBuilder<AuthCubit, AuthState>(
                            buildWhen: (previous, current) =>
                            current is ToggleAuthObscurePasswordState,
                            builder: (context, state) {
                              return DefaultTextFormField(
                                title: S.current.password,
                                hintText: S.current.enterPassword,
                                controller: cubit.passwordLoginController,
                                obscureText: cubit.obscureText,
                                maxLines: 1,
                                keyboardType: TextInputType.visiblePassword,
                                messageValidate: S.of(context).requiredPassword,
                                prefixIcon: IconButton(
                                  onPressed: cubit.toggleObscurePassword,
                                  icon: SvgIcon(
                                      path: cubit.obscureText
                                          ? IconsManager.eye
                                          : IconsManager.eyeSlash),
                                ),
                              );
                            },
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () {
                              cubit.loginFormKey.currentState!.reset();
                              cubit.forgotPasswordUserNameOrEmailController.clear();
                              Navigator.pushNamed(
                                  context, Routes.forgotPasswordRoute);
                            },
                            child: Text(
                              S.of(context).forgetPassword,
                            ),
                          ),
                        ),
                        BlocBuilder<AuthCubit, AuthState>(
                          buildWhen: (previous, current) =>
                          current is! ToggleAuthObscurePasswordState,
                          builder: (context, state) {
                            if (state is LoginLoadingState) {
                              return ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      S.current.login,
                                    ),
                                    const Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          top: 1.5, start: 8, end: 2),
                                      child: SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: ColorsManager.whiteFF,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      '...',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {},
                              );
                            }
                            return DefaultButton(
                              title: "S.current.login",
                              onPressed: () {
                                if (cubit.loginFormKey.currentState!
                                    .validate()) {
                                  cubit.login();
                                }else{
                                  autovalidateMode =
                                      AutovalidateMode.always;
                                  setState(() {});
                                }
                              },
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "S.current.dontHaveAccount",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            DefaultTextButton(
                              title: "S.of(context).CreateNewOne",
                              onPressed: () {
                                // cubit.loginFormKey.currentState!.reset();
                                // navigateReplacement(context, Routes.registerRoute);

                              },
                            ),
                          ],
                        ),
                        // Text(
                        //   S.current.signinWith,
                        //   style: Theme.of(context).textTheme.titleMedium,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     top: PaddingManager.p16,
                        //     bottom: PaddingManager.p64,
                        //   ),
                        //   child: BlocConsumer<AuthCubit, AuthState>(
                        //     listener: (context, state) {
                        //       if (state is LoginWithSocialFailureState) {
                        //         dialogBuilder(
                        //           context: context,
                        //           title: S.of(context).Error,
                        //           body: state.message!,
                        //         );
                        //       }
                        //     },
                        //     // builder: (context, state) {
                        //     //   return Row(
                        //     //     children: [
                        //     //       Expanded(
                        //     //         child: SocialButton(
                        //     //           logo: IconsManager.facebook,
                        //     //           name: S.current.facebook,
                        //     //           onTap: () {
                        //     //             AuthCubit.get(context).facebookLogin();
                        //     //           },
                        //     //         ),
                        //     //       ),
                        //     //       // Expanded(
                        //     //       //   child: SocialButton(
                        //     //       //     logo: IconsManager.google,
                        //     //       //     name: S.current.google,
                        //     //       //     onTap: () {
                        //     //       //       AuthCubit.get(context).googleLogin();
                        //     //       //     },
                        //     //       //   ),
                        //     //       // ),
                        //     //       // if (Platform.isIOS)
                        //     //       //   Expanded(
                        //     //       //     child: SocialButton(
                        //     //       //       logo: IconsManager.apple,
                        //     //       //       name: S.of(context).apple,
                        //     //       //       onTap: () {
                        //     //       //         AuthCubit.get(context).appleLogin();
                        //     //       //       },
                        //     //       //     ),
                        //     //       //   ),
                        //     //     ],
                        //     //   );
                        //     // },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _listener(BuildContext context, AuthState state) {
  //   if (state is LoginSuccessState || state is LoginWithSocialSuccessState) {
  //     context.read<AuthCubit>().clearLogin();
  //     printLog('NOW I WILL GO TO ${widget.callbackScreen}');
  //     if (widget.callbackScreen == 'profile') {
  //       // navigateReplacement(context, Routes.userProfile);
  //     } else if (widget.callbackScreen == 'serviceDetails') {
  //       final serviceCubit = context.read<ServiceCubit>();
  //       serviceCubit
  //           .getServiceDetailBySlug(serviceCubit.slugServiceDetails.toString());
  //       navigateReplacement(context, Routes.serviceDetails);
  //     } else if (widget.callbackScreen == 'projectDetails') {
  //       final projectCubit = context.read<ProjectCubit>();
  //       projectCubit
  //           .getProjectDetails(projectCubit.slugProjectDetails.toString());
  //       navigateReplacement(context, Routes.projectDetail,
  //           arguments: projectCubit.slugProjectDetails);
  //     } else {
  //       context.read<MainCubit>().currentIndex = 0;
  //       navigateToAndFinish(context, Routes.mainLayoutRoute).then((value) {});
  //     }
  //   } else if (state is LoginFailureState) {
  //     if (state.failure.message == 'auth.notVerified') {
  //
  //
  //       context.read<AuthCubit>().sendCodeToVerifyEmail();
  //       context.read<AuthCubit>().emailController.text =
  //           context.read<AuthCubit>().userNameOrEmailController.text;
  //       // context.read<AuthCubit>().clearLogin();
  //
  //       Navigator.pushNamed(
  //         context,
  //         Routes.activeAccountRoute,
  //       );
  //       context.read<AuthCubit>().loginFormKey.currentState!.initState();
  //     } else {
  //       dialogBuilder(
  //         context: context,
  //         title: S.of(context).Error,
  //         body: state.failure.message,
  //       );
  //     }
  //   }
  // }
}

class RequiredFieldTitle extends StatelessWidget {
  const RequiredFieldTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '*',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class DefaultPhoneField extends StatelessWidget {
  final String title;
  final String hintText;
  final String ? isoCode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<bool>? onInputValidated;
  final ValueChanged<PhoneNumber>? onInputChanged;
  final TextEditingController? textFieldController;
  const DefaultPhoneField({
    Key? key,
    required this.title,
    required this.hintText,
    this.validator,
    this.isoCode,
    required this.onInputValidated,
    required this.onInputChanged,
    this.textFieldController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequiredFieldTitle(
          title: title,
        ),
        InternationalPhoneNumberInput(
          initialValue: PhoneNumber(

              isoCode: isoCode,
              phoneNumber:
              textFieldController != null ? textFieldController!.text : ""),
          // countries: context
          //     .read<AuthCubit>()
          //     .countries
          //     .map((e) => e.countryISO)
          //     .toList(),
          countrySelectorScrollControlled: true,
          onInputChanged: onInputChanged,
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: false,
          cursorColor: Colors.red,
          searchBoxDecoration: const InputDecoration(
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffc62828),
                )),
            labelStyle: TextStyle(
              color: Colors.red,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          validator: validator,
          textFieldController: textFieldController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: const TextStyle(color: Colors.black),
          formatInput: true,
          onInputValidated: onInputValidated,
          hintText: hintText,
          inputDecoration: const InputDecoration(
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffc62828)),
            ),
          ),
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
        ),
      ],
    );
  }
}

class DefaultTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? messageValidate;
  final int? maxLines;
  final int? maxLength;
  final String? errorMessage;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  const DefaultTextFormField(
      {Key? key,
        required this.title,
        required this.hintText,
        this.prefixIcon,
        this.onTap,
        this.readOnly = false,
        this.controller,
        this.textInputAction,
        this.keyboardType,
        this.obscureText = false,
        this.errorMessage,
        this.messageValidate,
        this.maxLines,
        this.maxLength,
        this.suffixIcon,
        this.onChanged,
        this.inputFormatters,
        this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '*',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          inputFormatters: inputFormatters,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          cursorHeight: 20,
          onTap: onTap,
          obscureText: obscureText,
          textInputAction: textInputAction,
          readOnly: readOnly,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          maxLength: maxLength,
          onChanged: onChanged,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.start,
          validator: validator ??
                  (String? value) {
                if (value == null || value.isEmpty) {
                  return messageValidate;
                }
                return null;
              },
          decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              counterText: ''),
        ),
        if (errorMessage != null) ...[
          //8.ph,
          Text(
            '$errorMessage',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ],
    );
  }
}

class DefaultBackIcon extends StatelessWidget {


  final VoidCallback? onTap;
  const DefaultBackIcon({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap??(){
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back_ios,color: Colors.black),
    );
  }
}