//
//  MapaViewController.swift
//  IPizza
//
//  Created by André Marafigo on 28/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {

    let lm = CLLocationManager()
    
    var endereco : String = "Raymundo Nina Rodrigues, 910 - 82920-010 - Cajuru - Curitiba - Paraná"
    var nomeFantasia : String = "André Marafigo"
    
    var endereco2 : String = "Raymundo Nina Rodrigues, 900 - 82920-010 - Cajuru - Curitiba - Paraná"
    var nomeFantasia2 : String = "Pizzaria"
    
    @IBOutlet weak var mapa: MKMapView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Mapa", image: UIImage(named: "icons8-mapa-48"), tag: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Precisão da localização
        lm.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //Solicita Permissão
        lm.requestWhenInUseAuthorization()
        //Starta o GPS
        //lm.startUpdatingLocation()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = endereco
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                print("ERRO")
            }else {
                //Busca dados
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Cria anotação
                let anotacao = MKPointAnnotation()
                anotacao.title = self.nomeFantasia // self.endereco?.cliente?.nome
                anotacao.subtitle = self.endereco
                anotacao.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapa.addAnnotation(anotacao)
                
                //Zoom
                let coordenada: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let regiao = MKCoordinateRegion(center: coordenada, span: span)
                self.mapa.setRegion(regiao, animated: true)
            }
        }
        
        
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activityIndicator2 = UIActivityIndicatorView(style: .gray)
        activityIndicator2.center = self.view.center
        activityIndicator2.hidesWhenStopped = true
        activityIndicator2.startAnimating()
        
        self.view.addSubview(activityIndicator2)
        
        let searchRequest2 = MKLocalSearch.Request()
        searchRequest2.naturalLanguageQuery = endereco2
        
        let activeSearch2 = MKLocalSearch(request: searchRequest2)
        
        activeSearch2.start { (response, error) in
            
            activityIndicator2.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                print("ERRO")
            }else {
                //Busca dados
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Cria anotação
                let anotacao = MKPointAnnotation()
                anotacao.title = self.nomeFantasia2 // self.endereco?.cliente?.nome
                anotacao.subtitle = self.endereco2
                anotacao.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapa.addAnnotation(anotacao)
                
                //Zoom
                let coordenada: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                let regiao = MKCoordinateRegion(center: coordenada, span: span)
                self.mapa.setRegion(regiao, animated: true)
            }
        }
        
    }

}
