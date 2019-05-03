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
    
    var refUsuarios: DatabaseReference!
    
    init() {
        refUsuarios = Database.database().reference().child("usuarios")
    }
    
    func createUsuario (usuario: [String : Any], email: String, senha: String) -> String {
        let key = refUsuarios.childByAutoId().key
        
        Auth.auth().createUser(withEmail: email, password: senha) { (result, error) in
            
            guard (result?.user) != nil
                else {
                    print(error!)
                    return
            }
            print("Deu certo")
        }
        
        refUsuarios.child(key!).setValue(usuario)
        
        return key!
    }
    
}
