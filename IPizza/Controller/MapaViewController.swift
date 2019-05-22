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

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

class MapaViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    let lm = CLLocationManager()
    static let geocoder = CLGeocoder()
    
    var qtdEnderecos1: Int!
    var qtdEnderecos2: Int!
    
    var chamarLoadDataFireBase: Bool!
    
    @IBOutlet weak var mapaView: MKMapView!
    
    @IBOutlet weak var searchPizzaria: UISearchBar!
    
    @IBOutlet weak var viewLogo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        esconderMostrarSearchBar()
        chamarLoadDataFireBase = true
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
            
        }else {
            print("Por favor ligue o GPS")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        esconderMostrarSearchBar()
        if chamarLoadDataFireBase == true {
            MapaViewModel.shared.loadDataFireBase(owner: self)
        }
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //let lat = -25.4456301
        //let long = -49.2126449
        
        //Usa localização atual
        let lat = Double((lm.location?.coordinate.latitude)!)
        let long = Double((lm.location?.coordinate.longitude)!)
        
        let center = CLLocationCoordinate2DMake(lat, long)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let regiao = MKCoordinateRegion(center: center, span: span)
        self.mapaView.setRegion(regiao, animated: true)
        
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
    
    func esconderMostrarSearchBar() {
        if self.parent is TelaInicialViewController {
            searchPizzaria.isHidden = true
            viewLogo.isHidden = true
        } else if self.parent is MenuMapaViewController{
            searchPizzaria.isHidden = false
        } else if self.parent is MenuPizzariasViewController {
            searchPizzaria.isHidden = false
            viewLogo.isHidden = false
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
                
                let anotacao = MKPointAnnotation()
                anotacao.coordinate = location.coordinate
                anotacao.title = ("\(String(pizzarias[self.qtdEnderecos2].nomeFantasia))")
                
                self.mapaView.addAnnotation(anotacao)
                self.qtdEnderecos2 += 1
                self.addAnnotations(pizzarias: pizzarias)
                self.chamarLoadDataFireBase = true
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let buscarPizza = searchBar.text
        for pizzaria in MapaViewModel.shared.pizzarias {
            if buscarPizza == pizzaria.nomeFantasia {
                let endereco: String = ("\(String(pizzaria.rua)), \(String(pizzaria.numero)) - \(String(pizzaria.cep)) - \(String(pizzaria.bairro)) - \(String(pizzaria.cidade)) - \(String(pizzaria.estado))")
                buscaPorEndereco(endereco: endereco)
            }
        }
    }
    
    func buscaPorEndereco(endereco: String){
        MapaViewController.geocoder.geocodeAddressString(endereco) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    print("Erro location!!")
                    return
            }
            
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            let regiao = MKCoordinateRegion(center: center, span: span)
            self.mapaView.setRegion(regiao, animated: true)
        }
    }
    
    
    func criaRota(pizzaria: Pizzaria){
        //origem
        //Usa localização atual
        let lat = Double((lm.location?.coordinate.latitude)!)
        let long = Double((lm.location?.coordinate.longitude)!)
        let sourceLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let sourcePin = customPin(pinTitle: "Você está aqui!", pinSubTitle: "", location: sourceLocation)
        
        let destino = ("\(String(pizzaria.rua)), \(String(pizzaria.numero)) - \(String(pizzaria.cep)) - \(String(pizzaria.bairro)), \(String(pizzaria.cidade)) - \(String(pizzaria.estado))")
        //let destino = String("\(self.usuario.logradouro!),\(self.usuario.numero!),\(self.usuario.cep!)")
        
        MapaViewController.geocoder.geocodeAddressString(destino) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    print("Erro location!!!")
                    return
            }
            let destinationLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let destinationPin = customPin(pinTitle: pizzaria.nomeFantasia , pinSubTitle: "", location: destinationLocation)
            
            self.mapaView.addAnnotation(sourcePin)
            self.mapaView.addAnnotation(destinationPin)
            
            let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
            
            let directionRequest = MKDirections.Request()
            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
            directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
            directionRequest.transportType = .automobile
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate { (response, error) in
                guard let directionResonse = response else {
                    if let error = error {
                        print("we have error getting directions==\(error.localizedDescription)")
                    }
                    return
                }
                
                let route = directionResonse.routes[0]
                self.mapaView.addOverlay(route.polyline, level: .aboveRoads)
                
                let rect = route.polyline.boundingMapRect
                self.mapaView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
            
            //self.mapaView.delegate = self
        }
        
        
    }
    
    //MARK:- MapKit delegates
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
