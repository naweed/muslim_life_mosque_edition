import 'package:adhan/adhan.dart';
import 'package:event_bus/event_bus.dart';
import 'package:muslimlife/Events/page_index_evet.dart';
import 'package:muslimlife/Framework/Helpers/location_helpers.dart';
import 'package:muslimlife/Shared/app_session.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:vibration/vibration.dart';

class QiblaDirectionPageViewModel extends StreamViewModel<CompassEvent> {
  final EventBus eventBus;
  bool isListening = false;

  double qiblaDirection = 0.0;

  int qiblaPageIndex = 2;

  int prevQiblaDirection = 0;
  bool showVibration = false;

  String Title = "";
  bool IsBusy = false;
  String LoadingText = "";
  bool DataLoaded = false;
  bool IsErrorState = false;
  String ErrorMessage = "";
  String ErrorImage = "";

  QiblaDirectionPageViewModel(this.eventBus) : super() {
    Title = "Qibla Direction";

    //Listen to PageIndexEvent
    eventBus.on<PageIndexEvent>().listen((event) {
      if (event.pageIndex == qiblaPageIndex && !isListening) {
        startListening();
      } else if (event.pageIndex != qiblaPageIndex && isListening) {
        stopListening();
      }
    });
  }

  void setDataLodingIndicators(bool isStaring) {
    if (isStaring) {
      IsBusy = true;
      DataLoaded = false;
      IsErrorState = false;
      ErrorMessage = "";
      ErrorImage = "";
    } else {
      LoadingText = "";
      IsBusy = false;
    }

    rebuildUi();
  }

  Future<void> loadData() async {
    //Try to get Precise Location
    double userLat = 0.0;
    double userLon = 0.0;

    await LocationHelpers.requestLocationermissions();

    //Check Location Permissions and Extract Location
    if (await LocationHelpers.locationermissionsGranted()) {
      (userLat, userLon) = await LocationHelpers.getLocationCoordinates();
    }

    //If Location not obtained
    if (userLon == 0.0 && userLat == 0.0) {
      userLat = AppSession.MyLatitude!;
      userLon = AppSession.MyLongitude!;
    }

    qiblaDirection = Qibla(Coordinates(userLat, userLon)).direction;

    DataLoaded = true;
    rebuildUi();
  }

  @override
  Stream<CompassEvent> get stream => getFlutterCompassEvents();

  Stream<CompassEvent> getFlutterCompassEvents() {
    return isListening ? FlutterCompass.events! : Stream.empty();
  }

  Future<void> startListening() async {
    isListening = true;
    rebuildUi();
  }

  Future<void> stopListening() async {
    isListening = false;
    rebuildUi();
  }

  String showHeading(double direction, double qiblaDirection) {
    var deltaDegrees = (qiblaDirection.toInt() - direction.toInt());

    if (deltaDegrees.abs() != prevQiblaDirection) {
      if (!((prevQiblaDirection == 0 && deltaDegrees.abs() == 1) ||
          (prevQiblaDirection == 1 && deltaDegrees.abs() == 0))) {
        showVibration = true;
      } else {
        showVibration = false;
      }

      prevQiblaDirection = deltaDegrees.abs();
    } else {
      showVibration = false;
    }

    if (deltaDegrees.abs() <= 1) {
      try {
        if (showVibration) {
          Vibration.vibrate(pattern: [100, 900, 100, 900], intensities: [1, 255, 1, 255], duration: 2000);
        }
      } catch (ex) {}

      return "You are facing the Qibla!";
    }

    return "Turn ${deltaDegrees > 0 ? "right" : "left"} ${deltaDegrees.abs().toStringAsFixed(0)}°";
  }
}
