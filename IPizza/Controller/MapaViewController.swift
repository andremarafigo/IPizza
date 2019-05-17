//
//  MapaViewController.swift
//  IPizza
//
//  Created by André Marafigo on 28/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaViewController: UIViewController, CLLocationManagerDelegate {

    let lm = CLLocationManager()
    static let geocoder = CLGeocoder()
    var editUsuario: Usuarios!
    var validaLocais: Bool = false
    
    var qtdEnderecos1: Int!
    var qtdEnderecos2: Int!
    
    @IBOutlet weak var mapaView: MKMapView!
    
    //    let localInicial = CLLocation(latitude: -29.3666, longitude: -52.2612)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Mapa", image: UIImage(named: "icons8-mapa-48"), tag: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapaViewModel.shared.loadDataFireBase(owner: self)
        
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyHundredMeters
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
        
        mapaView.mapType = .standard
        
        mapaView.showsUserLocation = true
        
        buscaLocalizacaoAtual()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MapaViewModel.shared.loadDataFireBase(owner: self)
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
    
    func buscaLocalizacaoAtual() {
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
                
                self.validaLocais = true
                
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
