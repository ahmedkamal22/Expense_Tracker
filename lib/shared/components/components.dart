import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

navigateTo(context, widget) => Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          }),
    );

navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          }),
      (route) => false,
    );

Widget defaultTextButton({
  required String text,
  required Function()? onPressed,
  bool isUpper = true,
}) =>
    TextButton(
        onPressed: onPressed,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ));

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  double radius = 0.0,
  bool isUpper = true,
  required String text,
  required Function()? onPressed,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  required TextInputType keyboard,
  required TextEditingController controller,
  required TextInputAction action,
  required String? Function(String?)? validator,
  Function(String)? onFieldSubmitted,
  required IconData prefixIcon,
  required String? labelText,
  IconData? suffixIcon,
  Function()? suffixPressed,
  Function()? onTap,
  Function(String)? onChanged,
  bool isPassword = false,
  required Color color,
}) =>
    TextFormField(
      keyboardType: keyboard,
      obscureText: isPassword,
      controller: controller,
      textInputAction: action,
      validator: validator,
      onChanged: onChanged,
      autocorrect: true,
      obscuringCharacter: "*",
      onTap: onTap,
      style: TextStyle(
        color: color,
      ),
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: color,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: color,
        ),
        labelText: labelText,
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: color,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: color,
          ),
        ),
      ),
    );

Widget defaultTestScreen({
  required String text,
}) =>
    Center(
        child: Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ));

showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { Success, Warning, Error }

changeToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.Success:
      color = Colors.green;
      break;
    case ToastStates.Warning:
      color = Colors.amberAccent;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    default:
      color = Colors.black;
  }
  return color;
}

Widget defaultLine() => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 2,
        color: Colors.grey,
      ),
    );
