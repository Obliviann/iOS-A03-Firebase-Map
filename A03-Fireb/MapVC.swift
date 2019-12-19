//
//  MapVC.swift
//  A03-Fireb
//
//  Created by Olivia Sartorius Freschet on 2/12/19.
//  Copyright © 2019 Olivia. All rights reserved.
//

import UIKit
import MapKit //1
import CoreLocation //2
                            //1.                //2.
class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //1.1
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var txtField: UITextField!
    //2.1 poner dentro del viewdidLoad?
    let locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //1.2
        MapView.delegate = self
        checkLocationServices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //2.2 We SET our DELEGATE (to be able to use the methods inside it)
    func setupLocationManager(){
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //make sure location Services are available on user device
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocAuthorisation()
        } else {
            //show alerts ("You must enable location services!")
        }
    }
    
    //if user changes authorisation
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        checkLocAuthorisation()
    }
    
    //if loc updates
    //locations : arr con las últimas localizaciones del dispositivo
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        //cojemos le último elemento de ese aray: if 'nil', return, and nothing will happen
        guard let locat = locations.last else { return } //else:
        let regionSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: locat.coordinate, span: regionSpan )
        //para mostrarlo
        MapView.setRegion(region, animated: true)
        print("Hello blue dot!")
    }
    
    //2.4 To display user's location on the map, centered
    func centerViewOnLocation(){
        //we unwrap the optional with 'if let'  // if value != nil ({)
        print(locManager.location?.coordinate)
        if let loc = locManager.location?.coordinate {
            /*2. que necesita un zoom determinado (latitudeDelta,longitudeDelta)
            Usamos de unidad los grados de superficie terrestre*/
            let regionSpan = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
            //1. creamos una region
            let region = MKCoordinateRegion(center: loc, span: regionSpan)
            //LO MOSTRAMOS
            MapView.setRegion(region, animated: true)
            print("view centered!")
        }
    }
    
    //2.3
    func checkLocAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            //not asking for so much permisssions, just:
            print("ALWAYS")
            break
        case .authorizedWhenInUse:
            print("WHENINUSE") //true= YES??
            //1. true = causes the map view to use the CL framework to track the user’s location and update it periodically.
            MapView.showsUserLocation = true //Same as tickin the check box 'user location' on storyboard
            //DOES NOT GUARANTEE THAT THE LOC IS VISIBLE ON THE MAP, user might have scrolled to a diff point.
            if (MapView.isUserLocationVisible) {
                print("LOCVISIBLE")
            } else {
                print("user’s current location is not currently displayed on map")
                //If that location rectangle does not intersect the map’s visible rectangle
            }
            centerViewOnLocation()
            //2. calls 'didUpdateLocations locations:' every few seconds or whenever there's location change
            locManager.startUpdatingLocation()
            break
        case .notDetermined:
            locManager.requestWhenInUseAuthorization() //async method, meaning next line of code will will execute before user taps on alert. This is why we need the switch case
            //must activate description in Info.plist !
            print("NOTDETERMINED")
            break
        case .restricted:
            //the user CANNOT change this app status, possibly due to parental control
            //show alert
            print("RESTRICTED")
            break
        case .denied:
            //Show alert asking them to authorize
            print("DENIED")
            //locManager.requestWhenInUseAuthorization() - does not work bc you must change this from the phone's settings, you can't directly from the app.
            //DEINSTALL THE APP FROM THE PHONE U BITCH
            break
        }
    }
    
    //3.
    //IBAction func search(_ sender:Any)
    func action() {
        let query = txtField.text //TODO pasar el outlet del UITextField
        let request = MKLocalSearchRequest()
        //le pedimos que no lo interprete literalmente, da cabida al error humano de comerse una letra etc.
        request.naturalLanguageQuery = query
        let search = MKLocalSearch(request: request)
        //we double click the LocationHandler, le ponemos un nombre a los params, ambos opcionales
        search.start { (resp, err) in
            guard let response = resp else {
                return
            }
            print(response)
            //self - GESTION DE MEMORIA - ARC (Automatic Reference Counting) saber qué objs no están en uso para borrarlos
            //self es una forma de capturarlo para que no lo borre. Cada self es una adición al contador que tiene de sus referencias
            //self es una forma de subirle artifialmente el contador de referencias del MapView, para que aunque ej.CERREMOS la ventana
            //nos aseguramos que aunque este VC se haya ido, sigue existiendo esta referencia para usarla
            //necesario por los CLOSURES, pero es una forma explícita de decir que sabemos que lo mantendremos siempre en memoria
            self.MapView.setRegion(response.boundingRegion, animated: true)
        }
    }
}


/*to create your delegate separetelly:
extension MapVC: CLLocationManagerDelegate {}*/
/*OPT1
let locPrueba = CLLocation(latitude: 37.2582017, longitude: -6.9293230)
//MapView.setCenter(<#T##coordinate: CLLocationCoordinate2D##CLLocationCoordinate2D#>, animated: <#T##Bool#>)*/
