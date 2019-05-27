//
//  PizzariaPedidosViewModel.swift
//  IPizza
//
//  Created by André Marafigo on 26/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CoreData

class PizzariaPedidosViewModel {
    
    static let shared = PizzariaPedidosViewModel()
    
    //Pedidos Usuário
    var pizzasPedidoUsuario : [Sabor] = []
    var pizzaPedidoUsuario : Sabor = Sabor()
    var detalhesPedidoUsuario : DetalhesSabor = DetalhesSabor()
    
    var pedidosUsuario : [Pedido]!
    var pedidoUsuario : Pedido!
    
    var refUsuarios: DatabaseReference!
    var refPedidos: DatabaseReference!
    
    var pizzaria: Pizzaria!
    
    init() {
        pizzaria = Pizzaria()
        pizzaria = PizzariaMontaPedidoViewModel.shared.pizzaria
        refUsuarios = Database.database().reference().child("Usuarios")
        refPedidos = Database.database().reference().child("Pedidos")
    }
    
    func loadPedidosUsuarioFireBase(owner: PizzariaPedidosTableViewController) {
        self.refPedidos.observe(.value, with: { (snapshot: DataSnapshot) in
            self.pizzaria = Pizzaria()
            self.pizzaria = PizzariaMontaPedidoViewModel.shared.pizzaria
            self.pedidosUsuario = []
            
            for child in snapshot.children {
                self.pizzasPedidoUsuario = []
                self.pedidoUsuario = Pedido()
                
                let json = child as! DataSnapshot
                let resultado = json.value as! [String : Any]
                
                if (resultado["Key_Usuario"] as? String) == Auth.auth().currentUser?.uid {
                    self.pedidoUsuario.key = resultado["Key"] as? String
                    self.pedidoUsuario.n_pedido = (resultado["N_Pedido"] as? Int)!
                    self.pedidoUsuario.key_usuario = resultado["Key_Usuario"] as? String
                    self.pedidoUsuario.key_pizzaria = resultado["Key_Pizzaria"] as? String
                    self.pedidoUsuario.valorTotal = (resultado["ValorTotal"] as? Double)!
                    self.pedidoUsuario.formaDePagamento = resultado["FormaDePagamento"] as? String
                    self.pedidoUsuario.formaDeRetirada = resultado["FormaDeRetirada"] as? String
                    self.pedidoUsuario.status = resultado["Status"] as? String
                    self.pedidoUsuario.dataHora = resultado["DataHora"] as? String
                    
                    if (resultado["Pizzas"] != nil) {
                        for childPizzas in resultado["Pizzas"] as! [String : Any] {
                            self.pizzaPedidoUsuario = Sabor()
                            self.detalhesPedidoUsuario = DetalhesSabor()
                            
                            let value = childPizzas.value as? NSDictionary
                            self.pizzaPedidoUsuario.key = value!["Key"] as? String
                            self.pizzaPedidoUsuario.nomeSabor = value!["NomeSabor"] as? String
                            self.detalhesPedidoUsuario.tamanho = value!["Tamanho"] as? String
                            self.detalhesPedidoUsuario.valor = value!["Valor"] as? Double
                            self.detalhesPedidoUsuario.salgada = value!["Salgada"] as? Bool
                            self.detalhesPedidoUsuario.tipo = value!["Tipo"] as? String
                            self.pizzaPedidoUsuario.detalhes = self.detalhesPedidoUsuario
                            self.pizzasPedidoUsuario.append(self.pizzaPedidoUsuario)
                        }
                    }
                    self.pedidoUsuario.pizza = self.pizzasPedidoUsuario
                    self.pedidosUsuario.append(self.pedidoUsuario)
                }
            }
            owner.pedidos = []
            for pedido in self.pedidosUsuario {
                if pedido.key_pizzaria == self.pizzaria.key {
                    owner.pedidos.append(pedido)
                }
            }
            owner.tableView.reloadData()
        })
    }
}
