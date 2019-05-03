//
//  TelefonesEmpresasViewController.swift
//  IPizza
//
//  Created by André Marafigo on 29/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class TelefonesEmpresasViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }

    @IBAction func btnVoltarOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
