//
//  MapaViewController.swift
//  IPizza
//
//  Created by André Marafigo on 16/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaViewController: UIViewController, CLLocationManagerDelegate {
    
    let lm = CLLocationManager()
    static let geocoder = CLGeocoder()
    
    var qtdEnderecos1: Int!
    var qtdEnderecos2: Int!
    
    @IBOutlet weak var mapaView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapaViewModel.shared.loadDataFireBase(owner: self)
        
        mapaView.mapType = .standard
        
        mapaView.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                lm.requestWhenInUseAuthorization()
            }
            
            lm.delegate = self
            lm.desiredAccuracy = kCLLocationAccuracyHundredMeters
            lm.startUpdatingLocation()
            
            //let lat = -25.4456301
            //let long = -49.2126449
            
            //Usa localização atual
            let lat = Double((lm.location?.coordinate.latitude)!)
            let long = Double((lm.location?.coordinate.longitude)!)
            
            let center = CLLocationCoordinate2DMake(lat, long)
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let regiao = MKCoordinateRegion(center: center, span: span)
            self.mapaView.setRegion(regiao, animated: true)
            
        }else {
            print("Por favor ligue o GPS")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let local = locations[locations.count-1]
        
        if local.horizontalAccuracy > 0.0 {
            lm.stopUpdatingLocation()
            print("\(local.coordinate.latitude), \(local.coordinate.longitude)")
            MapaViewController.geocoder.reverseGeocodeLocation(local) { (placemarks, _) in
                if let marca = placemarks?.first {
                    print(marca)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
    
    
    func addAnnotations(pizzarias: [Pizzaria]) {
        if qtdEnderecos2 < qtdEnderecos1 {
            let endereco = ("\(String(pizzarias[self.qtdEnderecos2].rua)), \(String(pizzarias[self.qtdEnderecos2].numero)) - \(String(pizzarias[self.qtdEnderecos2].cep)) - \(String(pizzarias[self.qtdEnderecos2].bairro)), \(String(pizzarias[self.qtdEnderecos2].cidade)) - \(String(pizzarias[self.qtdEnderecos2].estado))")
            
            MapaViewController.geocoder.geocodeAddressString(endereco) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                    else {
                        print("Erro location!!")
                        return
                }
                
                let anotacao = MKPointAnnotation()
                anotacao.coordinate = location.coordinate
                anotacao.title = ("\(String(pizzarias[self.qtdEnderecos2].nomeFantasia))")
                
                self.mapaView.addAnnotation(anotacao)
                self.qtdEnderecos2 += 1
                self.addAnnotations(pizzarias: pizzarias)
            }
        }
    }

}
