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
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
    }

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func signin(_ sender: Any) {
        var x: Bool = false
        let email: String = txtEmail.text!
        let senha: String = txtSenha.text!

        x = LoginViewModel.shared.login(email: email, senha: senha)

        navigationController?.popViewController(animated: true)
        //self.performSegue(withIdentifier: "bemVindo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let next = segue.destination as! LoginViewModel
        //next.owner = self
    }
}
