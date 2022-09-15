import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../constraints/common_size.dart';
import '../../states/select_image_notifier.dart';

class multi_image_select extends StatefulWidget {
  multi_image_select({
    Key? key,
  }) : super(key: key);

  @override
  State<multi_image_select> createState() => _multi_image_selectState();
}

class _multi_image_selectState extends State<multi_image_select> {
  bool _isPickingImages = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      SelectImageNotifier selectImageNotifier =
          context.watch<SelectImageNotifier>();
      Size _size = MediaQuery.of(context).size;
      var imageSize = (_size.width / 3) - common_padding * 2;
      var imageCorner = 16.0;
      return SizedBox(
        height: _size.width / 3,
        width: _size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.all(common_padding),
              child: Container(
                child: InkWell(
                  onTap: () async {
                    _isPickingImages = true;
                    setState(() {});
                    final ImagePicker _picker = ImagePicker();
                    final List<XFile>? images =
                        await _picker.pickMultiImage(imageQuality: 10);
                    if (images != null && images.isNotEmpty) {
                      await context
                          .read<SelectImageNotifier>()
                          .setNewImages(images);
                    }
                    _isPickingImages = false;
                    setState(() {});
                  },
                  child: Container(
                    child: _isPickingImages
                        ? CircularProgressIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.grey,
                              ),
                              Text(
                                '0/10',
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ],
                          ),
                  ),
                ),
                width: (_size.width / 3) - common_padding * 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(imageCorner),
                    border: Border.all(color: Colors.grey, width: 1)),
              ),
            ),
            ...List.generate(
                selectImageNotifier.images.length,
                (index) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: common_padding,
                              top: common_padding,
                              bottom: common_padding),
                          child: ExtendedImage.memory(
                            selectImageNotifier.images[index],
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.cover,
                            loadStateChanged: (state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return Container(
                                      padding: EdgeInsets.all(imageSize / 3),
                                      width: imageSize,
                                      height: imageSize,
                                      child: CircularProgressIndicator());
                                case LoadState.completed:
                                  return null;
                                case LoadState.failed:
                                  return Icon(Icons.cancel);
                              }
                            },
                            borderRadius: BorderRadius.circular(imageCorner),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          width: 40,
                          height: 40,
                          child: IconButton(
                            padding: EdgeInsets.all(8),
                            onPressed: () {
                              selectImageNotifier.removeImage(index);
                            },
                            icon: Icon(Icons.remove_circle),
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ))
          ],
        ),
      );
    });
  }
}
