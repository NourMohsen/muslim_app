import 'package:atmemly/core/constants/colors_manager.dart';
import 'package:atmemly/modules/auth_route/auth_view/controller/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


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
          countries: context
              .read<AuthCubit>()
              .countries
              .map((e) => e.countryISO)
              .toList(),
          countrySelectorScrollControlled: true,
          onInputChanged: onInputChanged,
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          ),
          ignoreBlank: false,
          cursorColor: ColorsManager.primary,
          searchBoxDecoration: const InputDecoration(
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffc62828),
                )),
            labelStyle: TextStyle(
              color: ColorsManager.primary,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.primary,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.primary,
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
