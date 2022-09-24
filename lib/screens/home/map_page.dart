import 'package:dangma/data/user_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class MapPage extends StatefulWidget {

  final UserModel userModel;

  const MapPage(this.userModel, {Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final _mapController;

  Offset? _dragStart;
  double _scaleData = 1.0;

// 터치하는 순간만 실행, 드래그 해도 최초 터치 지점을 표시,
  _scaleStart(ScaleStartDetails details) {
    // focalPoint: Offset(191.2, 426.9), 스크린을 터치한 시작점,
    _dragStart = details.focalPoint;
    _scaleData = 1.0;
  }

// 드레그 하는 동안 계속 실행됨,
  _scaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    var _scaleDiff = details.scale - _scaleData;
    _scaleData = details.scale;
    _mapController.zoom += _scaleDiff;

    if (_scaleDiff > 0) {
      _mapController.zoom += 0.02;
    } else if (_scaleDiff < 0) {
      _mapController.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      transformer.drag(diff.dx, diff.dy);
    }
    setState(() {});
  }

  @override
  void initState() {
    _mapController = MapController(
      location:  LatLng(widget.userModel.geoFirePoint.latitude, widget.userModel.geoFirePoint.longitude),
    );
    // TODO: implement initState
    super.initState();
  }

  // 버전이 업데이트 되며서 변경된 위젯명, Map -> TileLayer, MapLayoutBuilder -> MapLayout
  @override
  Widget build(BuildContext context) {
// 강좌에서는 MapLayout 을 사용하지 않지만, drag 메소드가 transformer 에서 사용가능해져서 MapLayout 추가함.
    return MapLayout(
      builder: (context, transformer) {
        return GestureDetector(
          onScaleStart: _scaleStart,
          onScaleUpdate: (details) => _scaleUpdate(details, transformer),
          // <<==== 이 부분이 핵심입니다
          child: TileLayer(
            builder: (context, x, y, z) {
              //Google Maps
              final url =
                  'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

              return ExtendedImage.network(
                url,
                fit: BoxFit.cover,
              );
            },
          ),
        );
      },
      controller: _mapController,
    );
  }
}