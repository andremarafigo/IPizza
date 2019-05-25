//
//  FinalizarPedidoViewController.swift
//  IPizza
//
//  Created by André Marafigo on 25/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class FinalizarPedidoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnAdicionarPizzaOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
