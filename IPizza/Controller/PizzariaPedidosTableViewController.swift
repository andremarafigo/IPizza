//
//  PizzariaPedidosTableViewController.swift
//  IPizza
//
//  Created by André Marafigo on 26/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class PizzariaPedidosTableViewController: UITableViewController {

    var pedidos : [Pedido] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Pedidos", image: UIImage(named: "icons8-lista-de-tarefas-30"), tag: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PizzariaPedidosViewModel.shared.loadPedidosUsuarioFireBase(owner: self)
        navigationItem.title = PizzariaMontaPedidoViewModel.shared.pizzaria.nomeFantasia
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        PizzariaPedidosViewModel.shared.loadPedidosUsuarioFireBase(owner: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedidos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPedido", for: indexPath)
        
        cell.textLabel?.text = "Pedido nº \(String(pedidos[indexPath.row].n_pedido)) - \(String(pedidos[indexPath.row].status))"
        cell.detailTextLabel?.text = pedidos[indexPath.row].dataHora

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! FinalizarPedidoViewController
        
        if segue.identifier == "verPedido" {
            next.ownerPedidos = self
            next.verPedido = PizzariaPedidosViewModel.shared.pedidosUsuario[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
