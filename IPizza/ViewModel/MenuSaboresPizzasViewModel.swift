//
//  MenuSaboresPizzasViewModel.swift
//  IPizza
//
//  Created by André Marafigo on 18/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CoreData

class MenuSaboresPizzasViewModel {
    
    static let shared = MenuSaboresPizzasViewModel()
    
    var database : DatabaseReference!
    var sabores : [Sabor] = []
    var sabor : Sabor = Sabor()
    var detalhes : DetalhesSabor = DetalhesSabor()
    var key : String = ""
    
    var refUsuarios: DatabaseReference!
    
    init() {
        refUsuarios = Database.database().reference().child("Usuarios")
    }
    
    func loadDataFireBase(owner: MenuSaboresPizzasViewController, key: String){
        database = Database.database().reference()
        self.database.child("Usuarios").child(key).child("Pizzas").observe(.value, with: { (snapshot: DataSnapshot) in
            self.sabores = []
            for child in snapshot.children {
                self.sabor = Sabor()
                self.detalhes = DetalhesSabor()
                let json = child as! DataSnapshot
                let resultado = json.value as! [String : Any]
                self.sabor.key = resultado["Key"] as? String
                self.sabor.nomeSabor = resultado["NomeSabor"] as? String
                self.detalhes.tamanho = resultado["Tamanho"] as? String
                self.detalhes.valor = Double(resultado["Valor"] as! String)
                self.detalhes.salgada = resultado["Salgada"] as? Bool
                self.detalhes.tipo = resultado["Tipo"] as? String
                self.sabor.detalhes = self.detalhes
                self.sabores.append(self.sabor)
            }
            owner.separaSabores()
            owner.tableView.reloadData()
        })
    }
    
    func criaSabor(owner: MenuSaboresPizzasViewController, json: [String : Any]?, key: String) {
    refUsuarios.child(LoginViewModel.shared.users[0].key!).child("Pizzas").child(key).setValue(json)
        
        let alert = UIAlertController(title: "Cadastro realizado com sucesso.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            owner.navigationController?.popViewController(animated: true)
        }))
        
        // show the alert
        owner.present(alert, animated: true, completion: nil)
        owner.limpaCampos()
        return
    }
    
    func alteraSabor(owner: MenuSaboresPizzasViewController, json: [String : Any]?, key: String) {
        refUsuarios.child(LoginViewModel.shared.users[0].key!).child("Pizzas").child(key).setValue(json)
        
        let alert = UIAlertController(title: "Cadastro alterado com sucesso.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            owner.navigationController?.popViewController(animated: true)
        }))
        
        // show the alert
        owner.present(alert, animated: true, completion: nil)
        owner.limpaCampos()
        return
    }
    
    func deletaSabor(owner: MenuSaboresPizzasViewController, key: String) {
        refUsuarios.child(LoginViewModel.shared.users[0].key!).child("Pizzas").child(key).removeValue()
        
        let alert = UIAlertController(title: "Sabor deletado com sucesso.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            owner.navigationController?.popViewController(animated: true)
        }))
        
        // show the alert
        owner.present(alert, animated: true, completion: nil)
        owner.limpaCampos()
        return
    }
}
