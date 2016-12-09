//
//  ViewController.swift
//  Geofence
//
//  Created by Fede on 12/3/16.
//  Copyright © 2016 Lateral View. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
    }
    
    func setUpGeofenceForPlayaGrandeBeach() {
        let geofenceRegionCenter = CLLocationCoordinate2DMake(-38.028308, -57.531508);
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 400, identifier: "CurrentLocation");
        geofenceRegion.notifyOnExit = true;
        geofenceRegion.notifyOnEntry = true;
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let mapRegion = MKCoordinateRegion(center: geofenceRegionCenter, span: span)
        self.mapView.setRegion(mapRegion, animated: true)
        
        let regionCircle = MKCircle(center: geofenceRegionCenter, radius: 400)
        self.mapView.add(regionCircle)
        self.mapView.showsUserLocation = true;
        
        self.locationManager.startMonitoring(for: geofenceRegion)
    }
    
    //MARK - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.authorizedAlways) {
            //App Authorized, stablish geofence
            self.setUpGeofenceForPlayaGrandeBeach()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Started Monitoring Region: \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Welcome to Playa Grande! If the waves are good, you can try surfing!")
        self.message.text = "Welcome to Playa Grande! If the waves are good, you can try surfing!"
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Bye! Hope you had a great day at the beach!")
        self.message.text = "Bye! Hope you had a great day at the beach!"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.message.text = ""
    }
    
    //MARK - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let overlayRenderer : MKCircleRenderer = MKCircleRenderer(overlay: overlay);
        overlayRenderer.lineWidth = 4.0
        overlayRenderer.strokeColor = UIColor(red: 7.0/255.0, green: 106.0/255.0, blue: 255.0/255.0, alpha: 1)
        overlayRenderer.fillColor = UIColor(red: 0.0/255.0, green: 203.0/255.0, blue: 208.0/255.0, alpha: 0.7)
        return overlayRenderer
    }
}

