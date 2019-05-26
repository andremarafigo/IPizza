//
//  LoginViewController.swift
//  IPizza
//
//  Created by André Marafigo on 28/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var owner: MenuContaViewController! 
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnVoltar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnFacebook.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        btnFacebook.isHidden = true
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func btnVoltarOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signin(_ sender: Any) {
        print(MapaViewModel.shared.pizzarias.count)
        let email: String = txtEmail.text!
        let senha: String = txtSenha.text!

        LoginViewModel.shared.login(owner: self, email: email, senha: senha)

        //self.performSegue(withIdentifier: "bemVindo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let next = segue.destination as! LoginViewModel
        //next.owner = self
    }
}
