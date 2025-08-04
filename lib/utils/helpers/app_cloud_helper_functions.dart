import 'package:flutter/material.dart';

abstract class AppCloudHelperFunctions {
  static Widget? checkMultiRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return loader ?? const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return error ?? const Center(child: Text('Something went wrong.'));
    } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      return const Center(child: Text('No Data found'));
    } else {
      return null;
    }
  }
}
