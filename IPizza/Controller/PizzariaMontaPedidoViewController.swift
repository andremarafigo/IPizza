//
//  PizzariaMontaPedidoViewController.swift
//  IPizza
//
//  Created by André Marafigo on 25/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Firebase

class PizzariaMontaPedidoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var scSalgadaDoce: UISegmentedControl!
    @IBOutlet weak var scTamanho: UISegmentedControl!
    @IBOutlet weak var scPartes: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblPizzas: UILabel!
    @IBOutlet weak var lblValorTotal: UILabel!
    
    var pizzaria : Pizzaria!
    
    var saboresSalgados : [Sabor]!
    var saboresDoces : [Sabor]!
    var pizza : Sabor!
    var editarSabor: Sabor!
    var key : String!
    var pedido = Pedido()
    var qtdPizza : Int = 0
    var novaPizza : Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Pedido", image: UIImage(named: "icons8-pizza-32"), tag: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzaria = PizzariaMontaPedidoViewModel.shared.pizzaria
        PizzariaMontaPedidoViewModel.shared.loadDataFireBase(owner: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @IBAction func segmentedControlOnClick(_ sender: Any) {
        if scSalgadaDoce.selectedSegmentIndex == 0 {
            print("Salgada")
            tableView.reloadData()
        }else if scSalgadaDoce.selectedSegmentIndex == 1 {
            print("Doce")
            tableView.reloadData()
        }
    }
    
    @IBAction func btnAdicionarOnClick(_ sender: Any) {
        pedido.key_usuario = Auth.auth().currentUser?.uid
        pedido.key_usuario = LoginViewModel.shared.users[0].key!
        pedido.key_pizzaria = pizzaria.key
        pedido.valorTotal = 0
        for valor in pedido.pizza {
            pedido.valorTotal += valor.detalhes.valor
        }
        lblPizzas.text = "Pizzas: \(String(pedido.pizza.count))"
        lblValorTotal.text = "Valor Total: \(String(pedido.valorTotal))"
        //pedido.formaDePagamento =
        //pedido.formaDeRetirada =
        novaPizza = true
    }
    
    func separaSabores() {
        saboresSalgados = []
        saboresDoces = []
        for sab in PizzariaMontaPedidoViewModel.shared.pizzas {
            if sab.detalhes.salgada == true {
                saboresSalgados.append(sab)
            }else {
                saboresDoces.append(sab)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cells : Int = 0
        if scSalgadaDoce.selectedSegmentIndex == 0 {
            if saboresSalgados != nil {
                cells = saboresSalgados.count
            }
        }else if scSalgadaDoce.selectedSegmentIndex == 1 {
            if saboresDoces != nil {
                cells = saboresDoces.count
            }
        }
        return cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSabor", for: indexPath)
        
        if scSalgadaDoce.selectedSegmentIndex == 0 {
            cell.textLabel?.text = saboresSalgados[indexPath.row].nomeSabor
            //cell.detailTextLabel?.text = pizzas.listaPizzas[indexPath.row].tamanho!
        }else if scSalgadaDoce.selectedSegmentIndex == 1 {
            cell.textLabel?.text = saboresDoces[indexPath.row].nomeSabor
            //cell.detailTextLabel?.text = pizzas.listaPizzas[indexPath.row].tamanho!
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if scSalgadaDoce.selectedSegmentIndex == 0 {
            if novaPizza == true {
                pedido.pizza.append(saboresSalgados[indexPath.row])
                novaPizza = false
            }else {
                let qtd = pedido.pizza.count
                pedido.pizza[qtd - 1] = saboresSalgados[indexPath.row]
            }
        }else if scSalgadaDoce.selectedSegmentIndex == 1 {
            
        }
    }
}
