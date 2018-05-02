//
//  MapViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 4/20/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlacePicker

class MapViewController: GMSPlacePickerViewController, CLLocationManagerDelegate, GMSPlacePickerViewControllerDelegate {

    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        print(place.name)
    }
    
    var currentLocation: CLLocationCoordinate2D?
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarHidden(true, animated: true)
        locationManager.delegate = self
        delegate = self
        authLocationManager()
        
        guard let currentLocation = locationManager.location?.coordinate else {
            return
        }
    }

    private func authLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
