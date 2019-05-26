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
    var refPedidos: DatabaseReference!
    
    init() {
        refUsuarios = Database.database().reference().child("Usuarios")
        refPedidos = Database.database().reference().child("Pedidos")
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
    
    func criaPedido(owner: FinalizarPedidoViewController, pedido: Pedido) {
        database = Database.database().reference()
        let key = self.refPedidos.childByAutoId().key
        var validaAddPedido : Bool = false
        var validaAddPizza : Bool = false
        
        self.database.child("Pedidos").observe(.value, with: { (snapshot: DataSnapshot) in
            let qtd = snapshot.childrenCount
            
            var nPedido : Int = 0
            
            if Int(qtd) > 0 {
                nPedido = Int(qtd)+1
            }else {
                nPedido = 1
            }
            
            owner.lblNumPedido.text = "Pedido nº \(String(qtd))"
            
            if validaAddPedido == false {
                let json = self.montaJson(pedido: pedido, nPedido: nPedido)

                self.refPedidos.child(key!).setValue(json)
                
                validaAddPedido = true
            }

            if validaAddPizza == false {
                for pizza in pedido.pizza {
                    let jsonPizzas = self.montaJsonPizzas(pizza: pizza)
                    self.refPedidos.child(key!).child("Pizzas").child(pizza.key).setValue(jsonPizzas)
                }
                
                validaAddPizza = true
            }
            
            let alert = UIAlertController(title: "Pedido enviado com sucesso.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                owner.owner.pedido = Pedido()
                owner.navigationController?.popViewController(animated: true)
            }))

            // show the alert
            owner.present(alert, animated: true, completion: nil)
        })
    }
    
    func adicionaPizzasDoPedido(owner: FinalizarPedidoViewController, key: String, pedido: Pedido) {

        for pizza in pedido.pizza {
            let jsonPizzas = self.montaJsonPizzas(pizza: pizza)
            self.refPedidos.child(key).child("Pizzas").child(pizza.key).setValue(jsonPizzas)
        }
    }
    
    func montaJson(pedido: Pedido, nPedido: Int) -> [String:Any] {
        let json : [String:Any] = [
            "N_Pedido": nPedido,
            "Key_Usuario": pedido.key_usuario,
            "Key_Pizzaria": pedido.key_pizzaria,
            "ValorTotal": pedido.valorTotal,
            "FormaDePagamento": pedido.formaDePagamento,
            "FormaDeRetirada": pedido.formaDeRetirada,
            "Status": pedido.status,
        ]
        return json
    }
    
    func montaJsonPizzas(pizza: Sabor) -> [String:Any] {
        let json : [String:Any] = [
            "Key": pizza.key,
            "NomeSabor": pizza.nomeSabor,
            "Tamanho": pizza.detalhes.tamanho,
            "Tipo": pizza.detalhes.tipo,
            "Salgada": pizza.detalhes.salgada,
            "Valor": pizza.detalhes.valor
            ]
        return json
    }
}
