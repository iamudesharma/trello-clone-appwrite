import 'dart:io';

// import 'package:appwrite/appwrite.dart';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'logger.dart';

// import 'package:motion_toast/motion_toast.dart';

class RepositoryException implements Exception {
  final String message;
  final Exception? exception;
  final StackTrace? stackTrace;

  RepositoryException({required this.message, this.exception, this.stackTrace});

  @override
  String toString() {
    return "RepositoryExcept :$message";
  }
}

mixin RepositoryExceptionMixin {
  Future<T> exceptionHandler<T>(Future computation,
      {String unKnownMessage = "Exception"}) async {
    try {
      return await computation;
    } on AppwriteException catch (e) {
      logger.e(e.message, e);

      Fluttertoast.showToast(
          msg: e.message ?? "some thing went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // return Future.error(e);
      throw RepositoryException(
        message: e.message ?? "some thing went wrong",
      );
    } on IOException catch (e, st) {
      logger.e(e, st);

      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      throw RepositoryException(
          message: unKnownMessage, exception: e, stackTrace: st);
    } on Exception catch (e, st) {
      logger.e(e, st);

      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      throw RepositoryException(
          message: unKnownMessage, exception: e, stackTrace: st);
    }
  }
}
