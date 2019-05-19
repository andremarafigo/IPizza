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
    var sabor : Sabor = Sabor()
    var detalhes : DetalhesSabor = DetalhesSabor()
    
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
                    self.pizzaria.razaoSocial = resultado["RazaoSocial"] as? String
                    self.pizzaria.nomeFantasia = resultado["NomeFantasia"] as? String
                    self.pizzaria.cep = resultado["CEPPizzaria"] as? String
                    self.pizzaria.rua = resultado["RuaPizzaria"] as? String
                    self.pizzaria.numero = resultado["NumeroPizzaria"] as? String
                    self.pizzaria.bairro = resultado["BairroPizzaria"] as? String
                    self.pizzaria.cidade = resultado["CidadePizzaria"] as? String
                    self.pizzaria.estado = resultado["EstadoPizzaria"] as? String
                    self.pizzaria.telefone = resultado["TelefonePizzaria"] as? String
                    let pizzas = resultado["Pizzas"] as! DataSnapshot
                    for pizza in pizzas.children {
                        self.sabor = Sabor()
                        self.detalhes = DetalhesSabor()
                        let json = pizza as! DataSnapshot
                        let resultado = json.value as! [String : Any]
                        self.sabor.key = resultado["Key"] as? String
                        self.sabor.nomeSabor = resultado["NomeSabor"] as? String
                        self.detalhes.tamanho = resultado["Tamanho"] as? String
                        self.detalhes.valor = Double(resultado["Valor"] as! String)
                        self.detalhes.salgada = resultado["Salgada"] as? Bool
                        self.detalhes.tipo = resultado["Tipo"] as? String
                        self.sabor.detalhes = self.detalhes
                        self.pizzaria.pizzas.append(self.sabor)
                    }
                    self.pizzarias.append(self.pizzaria)
                }
            }
            owner.qtdEnderecos1 = self.pizzarias.count
            owner.qtdEnderecos2 = 0
            owner.addAnnotations(pizzarias: self.pizzarias)
        })
    }
}
