import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isImageCapturedProvider = StateProvider<bool>((ref) => false);

String imagePath = "";
//this key is used to dispose the widget
final takePictureScreenKey = GlobalKey<_TakePictureScreenState>();

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Dispose of the previous controller if it exists
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
    }

    try {
      final cameras = await availableCameras();
      _controller = CameraController(
        cameras.first,
        ResolutionPreset.medium,
      );
      await _controller!.initialize();
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  // this is the function we call with the key to force dispose
  void disposeController() {
    _controller?.dispose();
    super.dispose();
  }

//this doesnt get called unless we display with a navigator
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.done) {
        if (_controller == null || !_controller!.value.isInitialized) {
          // Handle error state
          print("no bueno");
          return Container(); //const Center(child: CircularProgressIndicator());
        }

        return Consumer(
          builder: (context, ref, child) {
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipRect(
                            child: Transform.scale(
                              scale: _controller!.value.aspectRatio / 1,
                              child: Center(
                                child: CameraPreview(_controller!),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CupertinoButton.filled(
                          child: Text(
                            "Capture",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              await _controller!.setFocusMode(FocusMode.locked);
                              await _controller!
                                  .setExposureMode(ExposureMode.locked);

                              XFile image = await _controller!.takePicture();

                              await _controller!.setFocusMode(FocusMode.auto);
                              await _controller!
                                  .setExposureMode(ExposureMode.auto);

                              if (!mounted) return;

                              imagePath = image.path;

                              ref.read(isImageCapturedProvider.notifier).state =
                                  true;
                              print("ImagePath:" + imagePath);
                              await _controller!.dispose();
                              _controller = null;

                              // Manually dispose of the widget when done capturing
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ));
          },
        );
        // } else {
        //   // Show a loading indicator while waiting for camera initialization
        //   return const Center(child: CircularProgressIndicator());
        // }
      },
    );
  }
}


// Stack(
//                 children: [
//                   Positioned(
//                     child: Container(
//                       width: 300,
//                       height: 300,
//                       child: AspectRatio(
//                         aspectRatio: 1 / 1,
//                         child: ClipRect(
//                           child: Transform.scale(
//                             scale: _controller!.value.aspectRatio / 1,
//                             child: Center(
//                               child: CameraPreview(_controller!),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 50,
//                     left: 0,
//                     right: 0,
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: CupertinoButton.filled(
//                         child: Text(
//                           "Capture",
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         onPressed: () async {
//                           try {
//                             await _controller!.setFocusMode(FocusMode.locked);
//                             await _controller!
//                                 .setExposureMode(ExposureMode.locked);

//                             XFile image = await _controller!.takePicture();

//                             await _controller!.setFocusMode(FocusMode.auto);
//                             await _controller!
//                                 .setExposureMode(ExposureMode.auto);

//                             if (!mounted) return;

//                             imagePath = image.path;

//                             ref.read(isImageCapturedProvider.notifier).state =
//                                 true;
//                             print("ImagePath:" + imagePath);
//                             await _controller!.dispose();
//                             _controller = null;

//                             // Manually dispose of the widget when done capturing
//                           } catch (e) {
//                             print(e);
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),