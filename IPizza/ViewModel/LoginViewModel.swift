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

    static let shared = LoginViewModel()
    
    var contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //var owner : LoginViewController!
    
    var users : [User] = []
    var user : User!
    
    init() {
//        user = User (context: contexto)
//        if users.count > 0 {
//            var y: Int = 0
//            for x in users {
//                if x.email == nil {
//                    contexto.delete(x)
//                }else if y > 0 {
//                    contexto.delete(x)
//                }else {
//                    y = 1
//                }
//            }
//            //loadData()
//        }else {
            loadData()
//            if users.count > 0 {
//                var y: Int = 0
//                for x in users {
//                    if x.email == nil {
//                        contexto.delete(x)
//                    }else if y > 0 {
//                        contexto.delete(x)
//                    }else {
//                        y = 1
//                    }
//                }
//            }
//       }
    }
    
    func login (owner: LoginViewController, email: String, senha: String){
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
            
            self.salvaUserCoreData(valida: x, usuario: email, password: senha)
            
            owner.navigationController?.popViewController(animated: true)
        }
    }
    
    func salvaUserCoreData(valida: Bool, usuario: String, password: String) {
        if valida == true {
            user = User (context: contexto)
            user.email = usuario
            user.senha = password
            if users.count > 0 {
                users[0] = user
            }else{
                users.append(user)
            }
            saveData()
        }
    }
    
    func saveData() {
        do {
            try contexto.save()
        } catch  {
            print("Erro ao salvar o contexto: \(error) ")
        }
        //loadData()
    }
    
    func deleteData() {
        contexto.delete(users[0])
        saveData()
        //loadData()
    }
    
    func loadData() {
        let requestUser: NSFetchRequest<User> = User.fetchRequest()
        do
        {
            print(users)
            let usurs = try contexto.fetch(requestUser)
            print(usurs)
            users = usurs
            print(users)
        }
        catch
        {
            print("Erro: \(error)")
        }
    }
}
