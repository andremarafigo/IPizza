//
//  PizzariaMontaPedidoViewModel.swift
//  IPizza
//
//  Created by André Marafigo on 25/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CoreData

class PizzariaMontaPedidoViewModel {
    
    static let shared = PizzariaMontaPedidoViewModel()
    
    var database : DatabaseReference!
    var sabores : [Sabor] = []
    var sabor : Sabor = Sabor()
    var detalhes : DetalhesSabor = DetalhesSabor()
    var key : String = ""
    
    var pizzaria : Pizzaria!
    
    var refUsuarios: DatabaseReference!
    
    init() {
        refUsuarios = Database.database().reference().child("Usuarios")
    }
    
    func loadDataFireBase(owner: PizzariaMontaPedidoViewController){
        database = Database.database().reference()
        self.database.child("Usuarios").child(pizzaria.key).child("Pizzas").observe(.value, with: { (snapshot: DataSnapshot) in
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
            print("Teste de Erro")
        })
    }
}
