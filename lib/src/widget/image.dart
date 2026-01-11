import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';
import 'package:portakal/src/theme/theme.dart';

class PersistentImageCache {
  static final Map<String, Uint8List> _memoryCache = {};
  static final Map<String, Future<Uint8List?>> _inFlight = {};
  static Box<List<int>>? _box;

  static Future<Box<List<int>>> _ensureBox() async {
    if (_box != null && _box!.isOpen) return _box!;
    _box = await Hive.openBox<List<int>>('imageCache');
    return _box!;
  }

  static Future<Uint8List?> getBytes(String url) async {
    if (_memoryCache.containsKey(url)) return _memoryCache[url];
    final key = url.trim();
    if (_inFlight[key] != null) return _inFlight[key]!;
    final future = _loadBytes(key);
    _inFlight[key] = future;
    final result = await future;
    _inFlight.remove(key);
    return result;
  }

  static Future<Uint8List?> _loadBytes(String url) async {
    final box = await _ensureBox();
    final cachedBytes = box.get(url);
    if (cachedBytes != null && cachedBytes.isNotEmpty) {
      final bytes = Uint8List.fromList(cachedBytes);
      _memoryCache[url] = bytes;
      return bytes;
    }

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 8));
      final bytes = response.bodyBytes;
      if (response.statusCode == 200 && bytes.isNotEmpty) {
        _memoryCache[url] = bytes;
        await box.put(url, bytes);
        return bytes;
      }
    } catch (_) {}
    return null;
  }

  static Future<void> prefetch(Iterable<String> urls) async {
    final tasks = <Future<void>>[];
    for (final raw in urls) {
      if (raw.isEmpty || _memoryCache.containsKey(raw)) continue;
      tasks.add(getBytes(raw).then((_) {}));
    }
    await Future.wait(tasks);
  }
}

class PersistentImage extends StatefulWidget {
  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const PersistentImage(
    this.url, {
    super.key,
    this.fit,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<PersistentImage> createState() => _PersistentImageState();
}

class _PersistentImageState extends State<PersistentImage> {
  final ValueNotifier<Uint8List?> _bytesNotifier = ValueNotifier(null);
  final ValueNotifier<bool> _errorNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(covariant PersistentImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _bytesNotifier.value = null;
      _errorNotifier.value = false;
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    final bytes = await PersistentImageCache.getBytes(widget.url);
    if (!mounted) return;
    if (bytes != null) {
      _bytesNotifier.value = bytes;
    } else {
      _errorNotifier.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Uint8List?>(
      valueListenable: _bytesNotifier,
      builder: (context, bytes, _) {
        if (bytes != null) {
          return Image.memory(
            bytes,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            gaplessPlayback: true,
          );
        }
        return ValueListenableBuilder<bool>(
          valueListenable: _errorNotifier,
          builder: (context, error, _) {
            if (error) {
              return Image.network(
                widget.url,
                width: widget.width,
                height: widget.height,
                fit: widget.fit,
                gaplessPlayback: true,
                errorBuilder: (context, er, stackTrace) {
                  return widget.errorWidget ??
                      Image.asset(
                        "assets/429.jpg",
                        width: widget.width,
                        height: widget.height,
                        fit: widget.fit,
                        gaplessPlayback: true,
                      );
                },
              );
            } else {
              return widget.placeholder ??
                  SizedBox(
                    width: widget.width,
                    height: widget.height,
                    child: Center(
                      child: CupertinoActivityIndicator(
                        color: PortakalTheme.textColor().withOpacity(0.05),
                        radius: 10,
                      ),
                    ),
                  );
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _bytesNotifier.dispose();
    _errorNotifier.dispose();
    super.dispose();
  }
}

class PortakalImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Color? color;

  const PortakalImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (imageSourceType() == "Network Image") {
            return PersistentImage(
              path,
              width: width,
              height: height,
              fit: fit,
              errorWidget: errorWidget,
            );
          } else if (imageSourceType() == "File Image") {
            return Image.file(
              File(path),
              width: width,
              height: height,
              fit: fit,
              gaplessPlayback: true,
              errorBuilder: (context, error, stackTrace) {
                return errorWidget ??
                    SizedBox(
                      width: width,
                      height: height,
                      child: Placeholder(),
                    );
              },
            );
          } else if (imageSourceType() == "Memory Image") {
            return Image.memory(
              UriData.parse(path).contentAsBytes(),
              width: width,
              height: height,
              fit: fit,
              gaplessPlayback: true,
              errorBuilder: (context, error, stackTrace) {
                return errorWidget ??
                    SizedBox(
                      width: width,
                      height: height,
                      child: Placeholder(),
                    );
              },
            );
          } else {
            return Image.asset(
              path,
              width: width,
              height: height,
              fit: fit,
              color: color,
              gaplessPlayback: true,
              errorBuilder: (context, error, stackTrace) {
                return errorWidget ??
                    SizedBox(
                      width: width,
                      height: height,
                      child: Placeholder(),
                    );
              },
            );
          }
        },
      ),
    );
  }

  String imageSourceType() {
    if (path.startsWith("http") || path.startsWith("https")) {
      return "Network Image";
    } else if (path.startsWith("file://") ||
        path.startsWith("/") ||
        (path.length > 1 && path[1] == ":")) {
      return "File Image";
    } else if (path.startsWith("data:")) {
      return "Memory Image";
    } else {
      return "Asset Image";
    }
  }
}
