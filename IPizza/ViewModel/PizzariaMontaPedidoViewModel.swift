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
    //Pizzaria
    var database : DatabaseReference!
    var pizzas : [Sabor] = []
    var pizza : Sabor = Sabor()
    var detalhes : DetalhesSabor = DetalhesSabor()
    var key : String = ""
    
    //Pedidos
    var pizzasPedido : [Sabor] = []
    var pizzaPedido : Sabor = Sabor()
    var detalhesPedido : DetalhesSabor = DetalhesSabor()
    
    var pizzaria : Pizzaria!
    
    var pedidos : [Pedido]!
    var pedido : Pedido!
    
    var refUsuarios: DatabaseReference!
    
    init() {
        refUsuarios = Database.database().reference().child("Usuarios")
    }
    
    func loadDataFireBase(owner: PizzariaMontaPedidoViewController){
        database = Database.database().reference()
        //Pizzaria
        self.database.child("Usuarios").child(pizzaria.key).child("Pizzas").observe(.value, with: { (snapshot: DataSnapshot) in
            self.pizzas = []
            let x = snapshot.childrenCount
            for child in snapshot.children {
                self.pizza = Sabor()
                self.detalhes = DetalhesSabor()
                let json = child as! DataSnapshot
                let resultado = json.value as! [String : Any]
                self.pizza.key = resultado["Key"] as? String
                self.pizza.nomeSabor = resultado["NomeSabor"] as? String
                self.detalhes.tamanho = resultado["Tamanho"] as? String
                self.detalhes.valor = Double(resultado["Valor"] as! String)
                self.detalhes.salgada = resultado["Salgada"] as? Bool
                self.detalhes.tipo = resultado["Tipo"] as? String
                self.pizza.detalhes = self.detalhes
                self.pizzas.append(self.pizza)
            }
            owner.separaSabores()
            owner.tableView.reloadData()
            print("Teste de Erro")
        })
        
        //Pedidos
        self.database.child("Pedidos").observe(.value, with: { (snapshot: DataSnapshot) in
            self.pedidos = []
            self.pizzasPedido = []
            
            let x = snapshot.childrenCount
            for child in snapshot.children {
                self.pedido = Pedido()
                self.pizzaPedido = Sabor()
                self.detalhesPedido = DetalhesSabor()
                let json = child as! DataSnapshot
                let resultado2 = json.value as! [String : Any]
                
                self.pedido.n_pedido = (resultado2["N_Pedido"] as? Int)!
                self.pedido.key_usuario = resultado2["Key_Usuario"] as? String
                self.pedido.key_pizzaria = resultado2["Key_Pizzaria"] as? String
                self.pedido.valorTotal = (resultado2["ValorTotal"] as? Double)!
                self.pedido.formaDePagamento = resultado2["FormaDePagamento"] as? String
                self.pedido.formaDeRetirada = resultado2["FormaDeRetirada"] as? String
                self.pedido.status = resultado2["Status"] as? String
                
                if (resultado2["Pizzas"] != nil) {
                    for childPizzas in resultado2["Pizzas"] as! [String : Any] {
                        print(childPizzas)
                        
                        let value = childPizzas.value as? NSDictionary
                        self.pizzaPedido.key = value!["Key"] as? String
                        self.pizzaPedido.nomeSabor = value!["NomeSabor"] as? String
                        self.detalhesPedido.tamanho = value!["Tamanho"] as? String
                        self.detalhesPedido.valor = value!["Valor"] as? Double
                        self.detalhesPedido.salgada = value!["Salgada"] as? Bool
                        self.detalhesPedido.tipo = value!["Tipo"] as? String
                        self.pizzaPedido.detalhes = self.detalhesPedido
                        self.pizzas.append(self.pizzaPedido)
                    }
                }
                self.pedido.pizza = self.pizzasPedido
            }
        })
    }
    
    func criaSabor() {
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
}
