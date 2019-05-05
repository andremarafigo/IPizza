//
//  MenuContaViewModel.swift
//  IPizza
//
//  Created by André Marafigo on 02/05/19.
//  Copyright © 2019 André Marafigo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CoreData

class MenuContaViewModel {
    
    var contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users : [User] = []
    var user : User!
    let requestUser: NSFetchRequest<User> = User.fetchRequest()
    
    init() {
        loadData()
//        if users.count == 0 {
//            user = User (context: contexto)
//            user.email = "andremarafigo11@gmail.com"
//            user.senha = "123456"
//            users.append(user)
//            saveData()
//        }
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
