//
//  LoginViewModel.swift
//  IPizza
//
//  Created by André Marafigo on 01/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CoreData

class LoginViewModel {

    var contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users : [User]
    var user : User
    let requestUser: NSFetchRequest<User> = User.fetchRequest()
    
    init() {
        user = User (context: contexto)
        users = []
        loadData()
    }
    
    func login (email: String, senha: String) {
        Auth.auth().signIn(withEmail: email, password: senha) { (result, error) in
            
            guard let user = result?.user
                else {
                    print(error!)
                    return
            }
            
            print("Deu certo")
            
            Analytics.setUserProperty("sim", forName: "Entrou")
            
            Analytics.logEvent("login", parameters: ["nome: ": email])
        }        
    }
    
    func saveData() {
        do {
            try contexto.save()
        } catch  {
            print("Erro ao salvar o contexto: \(error) ")
        }
        loadData()
    }
    
    func loadData() {
        do
        {
            users = try contexto.fetch(requestUser)
        }
        catch
        {
            print("Erro: \(error)")
        }
    }
}
