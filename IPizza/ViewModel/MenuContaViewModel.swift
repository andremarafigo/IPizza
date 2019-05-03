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
        user = User (context: contexto)
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