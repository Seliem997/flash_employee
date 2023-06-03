import 'dart:io';

import 'package:flash_employee/ui/widgets/custom_container.dart';
import 'package:flash_employee/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;
  const PdfViewerPage({required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text: "Preview Pdf"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Share.shareXFiles([XFile(path)], text: "");
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: CustomContainer(
        height: double.infinity,
        width: double.infinity,
        child: SfPdfViewer.file(
          File(path),
          canShowPageLoadingIndicator: true,
        ),
      ),
    );
  }
}
