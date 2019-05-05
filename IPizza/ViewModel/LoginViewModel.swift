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
    
    var owner : LoginViewController!
    
    var users : [User]
    var user : User
    let requestUser: NSFetchRequest<User> = User.fetchRequest()
    
    init() {
        user = User (context: contexto)
        users = []
        loadData()
        if users.count > 0 {
            for x in users {
                if x.email == nil {
                    contexto.delete(x)
                }
            }
            loadData()
        }
    }
    
    func login (email: String, senha: String) {
        var x: Bool = false
        
        Auth.auth().signIn(withEmail: email, password: senha) { (result, error) in
            
            guard let user = result?.user
                else {
                    print(error!)
                    return
            }
            
            print("Deu certo")
            
            Analytics.setUserProperty("sim", forName: "Entrou")
            
            Analytics.logEvent("login", parameters: ["nome: ": email])
            
            x = true
        }
        
        if x == true {
            self.owner.loginVM.user.email = email
            self.owner.loginVM.user.senha = senha
            self.owner.loginVM.users[0] = self.owner.loginVM.user
            self.owner.loginVM.saveData()
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
