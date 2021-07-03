import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatelessWidget {
  File file;

  PdfScreen(this.file);

    final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(basename(file.path)),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),
          ],
        ),
        body: SfPdfViewer.file(
          file,
          key: _pdfViewerKey,
        ),
      );
    }

}
