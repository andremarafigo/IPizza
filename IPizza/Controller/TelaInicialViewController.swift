//
//  TelaInicialViewController.swift
//  IPizza
//
//  Created by André Marafigo on 19/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import MapKit

class TelaInicialViewController: UIViewController, CLLocationManagerDelegate {
    
    let lm = CLLocationManager()
    static let geocoder = CLGeocoder()
    
    var x: Int!
    var qtdEnderecos: Int!
    
    @IBOutlet weak var viewBordaTittle: UIView!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var mapaView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginViewModel.shared
        
        viewBordaTittle.layer.cornerRadius = viewBordaTittle.frame.size.width/2
        viewBordaTittle.clipsToBounds = true
        
        viewTitle.layer.cornerRadius = viewTitle.frame.size.width/2
        viewTitle.clipsToBounds = true
        
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
