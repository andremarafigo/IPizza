//
//  FinalizarPedidoViewController.swift
//  IPizza
//
//  Created by André Marafigo on 25/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Firebase

class FinalizarPedidoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scFormaDePagamento: UISegmentedControl!
    @IBOutlet weak var scFormaDeRetirada: UISegmentedControl!
    
    @IBOutlet weak var lblNumPedido: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblValorTotal: UILabel!
    
    var pedido = Pedido()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblValorTotal.text = String("\(pedido.valorTotal)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        
        lblStatus.text = pedido.status
        
        pedido.valorTotal = 0
        for valor in pedido.pizza {
            pedido.valorTotal += valor.detalhes.valor
        }
    }
    
    @IBAction func btnAdicionarPizzaOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFinalizarPedidoOnClick(_ sender: Any) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pedido.pizza.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPizza", for: indexPath)
        
        cell.textLabel?.text = pedido.pizza[indexPath.row].nomeSabor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pedido.pizza.remove(at: indexPath.row)
            pedido.valorTotal = 0.0
            for valor in pedido.pizza {
                pedido.valorTotal += valor.detalhes.valor
            }
            lblValorTotal.text = String("\(pedido.valorTotal)")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
