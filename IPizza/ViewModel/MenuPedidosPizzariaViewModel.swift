//
//  MenuPedidosPizzariaViewModel.swift
//  IPizza
//
//  Created by André Marafigo on 26/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CoreData

class MenuPedidosPizzariaViewModel {
    static let shared = MenuPedidosPizzariaViewModel()
    
    //Pedidos Usuário
    var pizzasPedido : [Sabor] = []
    var pizzaPedido : Sabor = Sabor()
    var detalhesPedido : DetalhesSabor = DetalhesSabor()
    
    var pedidos : [Pedido]!
    var pedido : Pedido!
    
    var refUsuarios: DatabaseReference!
    var refPedidos: DatabaseReference!
    
    var pizzaria: Pizzaria!
    
    init() {
        buscaDadosPizzaria()
        refUsuarios = Database.database().reference().child("Usuarios")
        refPedidos = Database.database().reference().child("Pedidos")
    }
    
    func buscaDadosPizzaria() {
    }
    
    func loadDataFireBase(owner: MenuPedidosPizzariaTableViewController){
        //Pedidos
        self.refPedidos.observe(.value, with: { (snapshot: DataSnapshot) in
            self.pedidos = []
            
            for child in snapshot.children {
                self.pizzasPedido = []
                self.pedido = Pedido()
                
                let json = child as! DataSnapshot
                let resultado = json.value as! [String : Any]
                
                self.pedido.key = resultado["Key"] as? String
                self.pedido.n_pedido = (resultado["N_Pedido"] as? Int)!
                self.pedido.key_usuario = resultado["Key_Usuario"] as? String
                self.pedido.key_pizzaria = resultado["Key_Pizzaria"] as? String
                self.pedido.valorTotal = (resultado["ValorTotal"] as? Double)!
                self.pedido.formaDePagamento = resultado["FormaDePagamento"] as? String
                self.pedido.formaDeRetirada = resultado["FormaDeRetirada"] as? String
                self.pedido.status = resultado["Status"] as? String
                self.pedido.dataHora = resultado["DataHora"] as? String
                
                if (resultado["Pizzas"] != nil) {
                    for childPizzas in resultado["Pizzas"] as! [String : Any] {
                        self.pizzaPedido = Sabor()
                        self.detalhesPedido = DetalhesSabor()
                        print(childPizzas)
                        
                        let value = childPizzas.value as? NSDictionary
                        self.pizzaPedido.key = value!["Key"] as? String
                        self.pizzaPedido.nomeSabor = value!["NomeSabor"] as? String
                        self.detalhesPedido.tamanho = value!["Tamanho"] as? String
                        self.detalhesPedido.valor = value!["Valor"] as? Double
                        self.detalhesPedido.salgada = value!["Salgada"] as? Bool
                        self.detalhesPedido.tipo = value!["Tipo"] as? String
                        self.pizzaPedido.detalhes = self.detalhesPedido
                        self.pizzasPedido.append(self.pizzaPedido)
                    }
                }
                self.pedido.pizza = self.pizzasPedido
                self.pedidos.append(self.pedido)
            }
            owner.pedidos = []
            for pedido in self.pedidos {
                if pedido.key_pizzaria == Auth.auth().currentUser?.uid {
                    owner.pedidos.append(pedido)
                }
            }
            owner.tableView.reloadData()
        })
    }
}
