//
//  MapaViewController.swift
//  IPizza
//
//  Created by André Marafigo on 28/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class MapaMenuViewController: UIViewController {

    var editUsuario: Usuarios!
    var validaLocais: Bool = false
    
    //    let localInicial = CLLocation(latitude: -29.3666, longitude: -52.2612)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Mapa", image: UIImage(named: "icons8-mapa-48"), tag: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
}
