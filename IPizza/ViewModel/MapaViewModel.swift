//
//  MapaViewModel.swift
//  IPizza
//
//  Created by PUCPR on 13/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CoreData

class MapaViewModel {
    
    static let shared = MapaViewModel()
    
    var database : DatabaseReference!
    
    var pizzarias : [Pizzaria]!
    var pizzaria : Pizzaria!
    
    init() {
        
    }
    
    func loadDataFireBase(owner: MapaViewController){
        owner.chamarLoadDataFireBase = false
        self.pizzarias = []
        database = Database.database().reference()
        self.database.child("Usuarios").observe(.value, with: { (snapshot: DataSnapshot) in
            for child in snapshot.children {
                let usuarios = child as! DataSnapshot
                let resultado = usuarios.value as! [String : Any]
                if resultado["Pizzaria"] as? Bool == true {
                    self.pizzaria = Pizzaria()
                    self.pizzaria.nomeFantasia = resultado["NomeFantasia"] as? String
                    self.pizzaria.cep = resultado["CEPPizzaria"] as? String
                    self.pizzaria.rua = resultado["RuaPizzaria"] as? String
                    self.pizzaria.numero = resultado["NumeroPizzaria"] as? String
                    self.pizzaria.bairro = resultado["BairroPizzaria"] as? String
                    self.pizzaria.cidade = resultado["CidadePizzaria"] as? String
                    self.pizzaria.estado = resultado["EstadoPizzaria"] as? String
                    self.pizzarias.append(self.pizzaria)
                }
            }
            owner.qtdEnderecos1 = self.pizzarias.count
            owner.qtdEnderecos2 = 0
            owner.addAnnotations(pizzarias: self.pizzarias)
        })
    }
}
