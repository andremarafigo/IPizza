//
//  CadastroViewModel.swift
//  IPizza
//
//  Created by André Marafigo on 01/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//a

import Foundation
import Firebase
import FirebaseDatabase

class CadastroViewModel {
    
    static let shared = CadastroViewModel()
    
    var refUsuarios: DatabaseReference!
    
    init() {
        refUsuarios = Database.database().reference().child("Usuarios")
    }
    
    func createUsuario (owner: CadastroViewController, usuario: [String : Any]?, email: String, senha: String){
        //let key = refUsuarios.childByAutoId().key
        var key: String = ""
        Auth.auth().createUser(withEmail: email, password: senha) { (result, error) in
            
            guard (result?.user) != nil
                else {
                    print(error!)
                    return
            }
            print("Deu certo")
            
            key = (result?.user.uid)!
            
            self.refUsuarios.child(key).setValue(usuario)
            
            let alert = UIAlertController(title: "Cadastro realizado com sucesso.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                owner.navigationController?.popViewController(animated: true)
            }))
            
            // show the alert
            owner.present(alert, animated: true, completion: nil)
            //return
        } 
    }
    
}
