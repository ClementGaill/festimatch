// ignore_for_file: non_constant_identifier_names, file_names
import 'package:festimatch/Widgets/Frontend/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextFormField CustomizedTextField({
  required TextInputAction textInputAction,
  required int length,
  required int minLines,
  required int maxLines,
  required Widget? icon,
  required String label,
  required TextInputType textInputType,
  required TextCapitalization textCapitalization,

  //  Optionnal
  TextEditingController? controller,
  bool autoFocus = false,
  Function(String)? onChanged,
  String? Function(String?)? validator,
  AutovalidateMode? autoValidateMode,
  Function(String)? onFieldSubmitted,
  List<TextInputFormatter>? inputFormatters,
  String? errorText,
  FocusNode? focusNode,
  bool? filled = true,
  bool obscureText = false,
  bool viewIcon = true,
}) {
  return TextFormField(
    controller: controller,
    onChanged: onChanged,
    validator: validator,
    autovalidateMode: autoValidateMode,
    onFieldSubmitted: onFieldSubmitted,
    textInputAction: textInputAction,
    maxLength: length,
    autofocus: autoFocus,
    maxLines: maxLines,
    minLines: minLines,
    focusNode: focusNode,
    inputFormatters: inputFormatters,
    obscureText: obscureText,
    decoration: InputDecoration(
      errorText: errorText,
      isDense: true,
      prefixIcon: viewIcon ? icon : null,
      labelText: label,
      counterText: '',
      filled: filled,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: greyColor.withOpacity(0.25),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    ),
    keyboardType: textInputType,
    textCapitalization: textCapitalization,
    
  );
}
