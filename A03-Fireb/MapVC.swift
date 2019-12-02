//
//  MapVC.swift
//  A03-Fireb
//
//  Created by Olivia Sartorius Freschet on 2/12/19.
//  Copyright © 2019 Olivia. All rights reserved.
//

import UIKit
//1
import MapKit
import CoreLocation

class MapVC: UIViewController {

    //1
    @IBOutlet weak var MapView: MKMapView!
    //2.1
    let locManager = CLLocationManager()
    //3
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkLocationServices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //2.2 We SET our DELEGATE (to be able to use the methods inside our delegate (2))
    func setupLocationManager(){
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //2.4 make sure location Services are available on user device
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocAuthorisation()
        } else {
            //show alerts ("You must enable location services!")
        }
    }
    
    //3
    func centerViewOnLocation(){
        //we unwrap the condition with 'if let'  // if value != nil ({)
        if let loc = locManager.location?.coordinate {
            //let region = MKCoordinateRegion.init(center: loc, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            //MapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            //not asking for so much permisssions, just:
            break
        case .authorizedWhenInUse:
            //
            MapView.showsUserLocation = true
            centerViewOnLocation()
            break
        case .notDetermined:
            locManager.requestWhenInUseAuthorization()
            //must activate description in Info.plist !
            break
        case .restricted:
            //the user CANNOT change this app status, poss due to parental control
            //show alert
            locManager.requestWhenInUseAuthorization()
            break
        case .denied:
            //Show alert asking them to authorize
            locManager.requestWhenInUseAuthorization()
            //I think this does not work because you must change this in settings, you can't directly from the app
            break
        }
    }
    
}

//2 We create our CLLocationManager DELEGATE
extension MapVC: CLLocationManagerDelegate {
    // do smth everytime the location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    // do smth when user changes authorisation
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
}
