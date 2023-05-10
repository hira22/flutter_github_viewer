import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends HookWidget {
  final String title;
  final String url;

  const DetailPage({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);

    // TODO: Replace with your own GitHub token
    const token = "GITHUB_TOKEN";

    final controller = useMemoized(
      () => WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
              onPageStarted: (_) => isLoading.value = true,
              onPageFinished: (_) => isLoading.value = false),
        )
        ..loadRequest(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }),
      [url],
    );

    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
