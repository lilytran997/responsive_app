
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'check_platform.dart';

class ApplicationNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double height;
  final double width;
  final Widget placeholder;
  final bool turnOffReIndicator;
  ApplicationNetworkImage(
      {@required this.url,
      this.fit,
      this.height,
      this.width,
      this.placeholder,
      this.turnOffReIndicator = false})
      : assert(url != null);

  @override
  Widget build(BuildContext context) {
    return (width != null && height != null)
        ? Container(
            child: !turnOffReIndicator
                ? FutureBuilder(
                    future: Future.delayed(Duration(milliseconds: 500)),
                    builder: (c, s) => s.connectionState == ConnectionState.done
                        ? _cachedImageWidget()
                        : Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()..scale(0.5, 0.5),
                            child: CupertinoActivityIndicator()),
                  )
                : _cachedImageWidget(),
          )
        : Container(
            child: !turnOffReIndicator
                ? FutureBuilder(
                    future: Future.delayed(Duration(milliseconds: 500)),
                    builder: (c, s) => s.connectionState == ConnectionState.done
                        ? _cachedImageWidget()
                        : Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()..scale(0.5, 0.5),
                            child: CupertinoActivityIndicator()))
                : _cachedImageWidget());
  }

  Widget _cachedImageWidget() {
    if(ApplicationPlatform.isIOS||ApplicationPlatform.isAndroid){
      return _mobileCache();
    }else{
      return _webCache();
    }
  }

  FadeInImage _webCache() {
    return (width != null && height != null)
        ? FadeInImage.assetNetwork(
            image: url,
            fit: fit,
            placeholder: "",
            height: height,
            width: width,
          )
        : FadeInImage.assetNetwork(
            image: url,
            fit: fit,
            placeholder: "",
          );
  }

  CachedNetworkImage _mobileCache() {
    return (width != null && height != null)
        ? CachedNetworkImage(
            imageUrl: url,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            cacheManager: CustomCacheManager.instance,
            placeholder: (context, url) => Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()..scale(0.5, 0.5),
                child: CupertinoActivityIndicator()),
            errorWidget: (context, url, error) =>
                placeholder ??
                Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.identity()..scale(0.5, 0.5),
                    child: Icon(
                      Icons.error,
                      color: Colors.black,
                    )))
        : CachedNetworkImage(
            imageUrl: url,
            fit: fit ?? BoxFit.cover,
            cacheManager: CustomCacheManager.instance,
            placeholder: (context, url) => Transform(
                alignment: FractionalOffset.center,
                transform: Matrix4.identity()..scale(0.5, 0.5),
                child: CupertinoActivityIndicator()),
            errorWidget: (context, url, error) =>
                placeholder ??
                Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.identity()..scale(0.5, 0.5),
                    child: Icon(
                      Icons.error,
                      color: Colors.black,
                    )));
  }
}

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );
}