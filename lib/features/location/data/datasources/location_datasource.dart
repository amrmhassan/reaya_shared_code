import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:reaya_shared_code/features/pharmacy/models/location_model.dart';
import 'package:reaya_shared_code/init/runt_time_variables.dart';
import 'package:reaya_shared_code/utils/errors/custom_exception.dart';

class LocationDatasource {
  Future<LocationModel?> getUserLocation({
    LocationAccuracy? accuracy,
    bool lastKnownLocation = false,

    /// this is to show a modal to request for the location permission if need permission
    FutureOr<bool> Function()? onNeedPermission,
  }) async {
    // Check if location services are enabled, and request to enable if not.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool openSettings = await Geolocator.openLocationSettings();
      if (!openSettings) {
        // User denied enabling location services
        return null;
      }
    }

    // Check the permission status
    LocationPermission permission = await Geolocator.checkPermission();
    bool allowed = permission == LocationPermission.always ||
        LocationPermission.whileInUse == permission;
    if (!allowed) {
      bool doContinue = await _handleDenied(permission, onNeedPermission);
      if (!doContinue) return null;
    }

    // Get the current position with the desired accuracy
    return _getActualLocation(lastKnownLocation, accuracy);
  }

  Future<LocationModel?> _getActualLocation(
    bool lastKnownLocation,
    LocationAccuracy? accuracy,
  ) async {
    try {
      Position position;
      var accuracyPosition = Geolocator.getCurrentPosition(
        desiredAccuracy: accuracy ?? LocationAccuracy.lowest,
      );
      var lastPosition = Geolocator.getLastKnownPosition();

      // getting the last known position or the accuracy position
      if (lastKnownLocation) {
        position = (await lastPosition) ?? (await accuracyPosition);
      } else {
        position = await accuracyPosition;
      }
      LocationModel locationModel =
          LocationModel(position.latitude, position.longitude);
      return locationModel;
    } catch (e) {
      // Handle location retrieval errors
      logger.e('Error getting location: $e');
      return null;
    }
  }

  Future<bool> _handleDenied(
    LocationPermission permission,
    FutureOr<bool> Function()? onNeedPermission,
  ) async {
    if (permission == LocationPermission.denied) {
      if (onNeedPermission != null) {
        var doContinue = await onNeedPermission();
        if (!doContinue) return false;
      }
      // Request permission if it's denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission denied by user
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permission permanently denied
      throw CustomException('Location is not allowed for this app to use');
    }
    return true;
  }
}
