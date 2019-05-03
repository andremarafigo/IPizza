//
//  EnderecosTelefonesViewController.swift
//  IPizza
//
//  Created by André Marafigo on 06/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Firebase
import JMMaskTextField_Swift

class EnderecosTelefonesViewController: UIViewController {
    
    
    
    var owner : CadastroViewController?
    var usuario : [String : Any]?
    var key : String = ""
    var email: String = ""
    var senha: String = ""
    
    @IBOutlet weak var svEnderecos: UIStackView!
    @IBOutlet weak var svTelefones: UIStackView!
    @IBOutlet weak var segControlEnderecoTelefone: UISegmentedControl!
    @IBOutlet weak var ctvEnderecos: UIView!
    @IBOutlet weak var ctvTelefones: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enderecoOrTelefone()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func segControlEnderecoTelefoneClick(_ sender: Any) {
        enderecoOrTelefone()
    }
    
    @IBAction func btnVoltarOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func enderecoOrTelefone() {
        if segControlEnderecoTelefone.selectedSegmentIndex == 0 {
            svEnderecos.isHidden = false
            ctvEnderecos.isHidden = false
            svTelefones.isHidden = true
            ctvTelefones.isHidden = true
        }else if segControlEnderecoTelefone.selectedSegmentIndex == 1 {
            svEnderecos.isHidden = true
            ctvEnderecos.isHidden = true
            svTelefones.isHidden = false
            ctvTelefones.isHidden = false
        }
    }
}
