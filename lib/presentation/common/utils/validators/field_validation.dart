import 'package:smart_assistant_app/core/extensions/context_extensions.dart';
import 'package:smart_assistant_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

extension CustomValidationBuilder on ValidationBuilder {
  ValidationBuilder isValidEmail({required String invalidEmailMsg}) => add((value) {
        RegExp emailRegExp = RegExp(
            r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
        if (!emailRegExp.hasMatch(value!)) return invalidEmailMsg;
        return null;
      });
  ValidationBuilder notEmpty(String errorMsg) => add((value) {
        return value == null || value.isEmpty ? errorMsg : null;
      });

  ValidationBuilder confirmPwMatchesPw(String match, String mistachErrorMsg) => add((value) {
        return value != match ? mistachErrorMsg : null;
      });
  ValidationBuilder newPwDiffersToOldPw(String match, String mistachErrorMsg) => add((value) {
        return value == match ? mistachErrorMsg : null;
      });
  ValidationBuilder newPhoneNumberDiffersFromOld(String match, BuildContext context) =>
      add((value) {
        return value == match ? context.t.errors.fields.differentPhone : null;
      });
  ValidationBuilder isInteger(BuildContext context) => add((value) {
        if (int.tryParse(value!) == null) return context.t.errors.fields.validInteger;
        return null;
      });

  ValidationBuilder customPasswordValidation(BuildContext context) => add((value) {
        RegExp lowercaseRegex = RegExp(r'[a-z]');
        RegExp uppercaseRegex = RegExp(r'[A-Z]');
        RegExp numbersRegex = RegExp(r'[0-9]');
        if (!lowercaseRegex.hasMatch(value!)) {
          return context.t.errors.fields.customPassword.lowerCase;
        }
        if (!uppercaseRegex.hasMatch(value)) {
          return context.t.errors.fields.customPassword.upperCase;
        }
        if (!numbersRegex.hasMatch(value)) {
          return context.t.errors.fields.customPassword.number;
        }
        return null;
      });
}
