//
//  MapaViewController.swift
//  IPizza
//
//  Created by André Marafigo on 28/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapaView: MKMapView!
    let lm = CLLocationManager()
    static let geocoder = CLGeocoder()
    var editUsuario: Usuarios!
    
    var x: Int!
    var qtdEnderecos: Int!
    
    //    let localInicial = CLLocation(latitude: -29.3666, longitude: -52.2612)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Mapa", image: UIImage(named: "icons8-mapa-48"), tag: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyHundredMeters
        lm.requestWhenInUseAuthorization()
        lm.startUpdatingLocation()
        
        mapaView.mapType = .standard

        let lat = -25.4456301
        let long = -49.2126449
        
        //Usa localização atual
//        let lat = Double((lm.location?.coordinate.latitude)!)
//        let long = Double((lm.location?.coordinate.longitude)!)
        
        let center = CLLocationCoordinate2DMake(lat, long)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let regiao = MKCoordinateRegion(center: center, span: span)
        self.mapaView.setRegion(regiao, animated: true)

        let anotacao = MKPointAnnotation()
        anotacao.coordinate = center
        anotacao.title = "Você está Aqui!"

        self.mapaView.addAnnotation(anotacao)
        
        let enderecos: [String] = [
            "Raymundo Nina Rodrigues, 910 - 82920-010",
            "Luiz França, 3083 - 82920-010",
            "Raymundo Nina Rodrigues, 841 - 82920-010",
            "Raymundo Nina Rodrigues, 750 - 82920-010"
        ]
        qtdEnderecos = enderecos.count
        x = 0

        addAnnotations(enderecos: enderecos)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    
    func addAnnotations(enderecos: [String]) {
        if x < qtdEnderecos {
            MapaViewController.geocoder.geocodeAddressString(enderecos[self.x]) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                    else {
                        print("Erro location!!")
                        return
                }
                
                let anotacao = MKPointAnnotation()
                anotacao.coordinate = location.coordinate
                anotacao.title = "Aqui!"
                
                self.mapaView.addAnnotation(anotacao)
                self.x += 1
                self.addAnnotations(enderecos: enderecos)
            }
        }
    }
}
