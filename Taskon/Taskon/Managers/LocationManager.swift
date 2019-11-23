//
//  LocationManager.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 20/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    
    // MARK: - Class Properties
    
    static let `default`: LocationManager = LocationManager()
    private var manager: CLLocationManager!
    var location: CLLocation? = nil
    
    
    // MARK: - Initialization Methods
    
    override init() {
        super.init()
        manager = CLLocationManager()
        manager.delegate = self
        let settings = TOUserDefaults.settings.get() ?? Settings()
        manager.desiredAccuracy = Double(settings.locationAccuracy)
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    
    // MARK: - Public Methods
    
    public func distance(from location: Location) -> Int? {
        let latitude = CLLocationDegrees(location.latitude) ?? 0.0
        let longitude = CLLocationDegrees(location.longitude) ?? 0.0
        let fromLocation = CLLocation(latitude: latitude, longitude: longitude)
        guard let toLocation = LocationManager.default.location else { return nil }
        
        let latitudeArc = (fromLocation.coordinate.latitude - toLocation.coordinate.latitude) * Constants.DEG_TO_RAD
        let longitudeArc = (fromLocation.coordinate.longitude - toLocation.coordinate.longitude) * Constants.DEG_TO_RAD
        
        var latitudeH = sin(latitudeArc * 0.5)
        latitudeH *= latitudeH
        
        var lontitudeH = sin(longitudeArc * 0.5)
        lontitudeH *= lontitudeH
        
        let tmp = cos(fromLocation.coordinate.latitude * Constants.DEG_TO_RAD) * cos(toLocation.coordinate.latitude * Constants.DEG_TO_RAD)
        let distanceInM = Constants.EARTH_RADIUS_IN_METERS * 2.0 * asin(sqrt(latitudeH + (tmp * lontitudeH)))
        let distanceInKM = distanceInM / 1000
        return Int(distanceInKM)
    }
    
    public func address(for location: CLLocation, completion: @escaping AddressCompletion) {
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let _ = self else {
                completion(nil)
                return
            }
            if error == nil {
                let firstLocation = placemarks?[0]
                completion(firstLocation)
            }
            else {
                // An error occurred during geocoding.
                completion(nil)
            }
        }
    }
    
}


// MARK: - CLLocationManagerDelegate Methods

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = manager.location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
}
