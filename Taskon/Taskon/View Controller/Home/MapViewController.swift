//
//  MapViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 22/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private weak var mapview: MKMapView!
    public var location: Location!
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
}


// MARK: - Private Methods

extension MapViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Navigation"
    }
    
    private func setupViewController() {
        setupMapView()
    }
    
    private func setupMapView() {
        mapview.delegate = self
        mapview.showsScale = true
        mapview.isPitchEnabled = true
        mapview.isZoomEnabled = true
        mapview.showsCompass = true
        
        drawRoute()
    }
    
    private func drawRoute() {
        guard let sourceLocation = LocationManager.default.location else {
            updateUi()
            return
        }
        let destinationLocation = destination()
        
        // Annotations
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Current Location"
        sourceAnnotation.coordinate = sourceLocation.coordinate
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = location.title
        destinationAnnotation.coordinate = destinationLocation.coordinate
        
        mapview.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation.coordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation.coordinate)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .any
        
        let direction = MKDirections(request: directionRequest)
        direction.calculate { [weak self] response, error in
            guard let self = self, let response = response else {
                if let error = error {
                    debugPrint(error)
                }
                return
            }
            guard let route = response.routes.first else { return }
            self.mapview.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            let region = MKCoordinateRegion(rect)
            self.mapview.setRegion(region, animated: true)
        }
    }
    
    private func destination() -> CLLocation {
        let latitude = CLLocationDegrees(location.latitude) ?? 0.0
        let longitude = CLLocationDegrees(location.longitude) ?? 0.0
        let mapLocation = CLLocation(latitude: latitude, longitude: longitude)
        return mapLocation
    }
    
    private func updateUi() {
        let mapLocation = destination()
        let region = MKCoordinateRegion(center: mapLocation.coordinate, latitudinalMeters: Constants.Map.radius, longitudinalMeters: Constants.Map.radius)
        mapview.setRegion(region, animated: true)
    }
    
    private func openAppleMaps() {
        guard let sourceLocation = LocationManager.default.location else {
            updateUi()
            return
        }
        let destinationLocation = destination()
        let directionsURL = "http://maps.apple.com/?saddr=\(sourceLocation.coordinate.latitude),\(sourceLocation.coordinate.longitude)&daddr=\(destinationLocation.coordinate.latitude),\(destinationLocation.coordinate.longitude)"
        guard let url = URL(string: directionsURL) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            showAlert(message: "Apple Maps not available.")
        }
    }
}


// MARK: - MapView Methods

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolygonRenderer(overlay: overlay)
        renderer.strokeColor = .mainBlue
        renderer.lineCap = .round
        renderer.lineWidth = 4.0
        return renderer
    }
}


// MARK: - Action Methods
    
extension MapViewController {
    
    @IBAction private func navigateButtonTapped(_ sender: UIButton) {
        openAppleMaps()
    }
    
}
