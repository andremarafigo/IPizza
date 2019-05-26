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
    
    var owner : PizzariaMontaPedidoViewController!
    var pedido = Pedido()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblValorTotal.text = String("R$\(pedido.valorTotal)")
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
    
    @IBAction func btnSobreOnClick(_ sender: Any) {
        let alert = UIAlertController(title: "Para retirar pizza do Pedido, basta arrastar para esquerda.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
        }))
        
        // show the alert
        present(alert, animated: true, completion: nil)
        return
    }
    
    @IBAction func btnAdicionarPizzaOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFinalizarPedidoOnClick(_ sender: Any) {
        switch scFormaDePagamento.selectedSegmentIndex {
            case 0:
                pedido.formaDePagamento = scFormaDePagamento.titleForSegment(at: 0)
                break
            case 1:
                pedido.formaDePagamento = scFormaDePagamento.titleForSegment(at: 1)
                break
            default:
                let alert = UIAlertController(title: "Favor selecionar uma Forma de Pagamento.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                }))
                
                // show the alert
                present(alert, animated: true, completion: nil)
                return
        }
        switch scFormaDeRetirada.selectedSegmentIndex {
            case 0:
                pedido.formaDeRetirada = scFormaDeRetirada.titleForSegment(at: 0)
                break
            case 1:
                pedido.formaDeRetirada = scFormaDeRetirada.titleForSegment(at: 1)
                break
            default:
                let alert = UIAlertController(title: "Favor selecionar uma Forma de Retirada.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                }))
                
                // show the alert
                present(alert, animated: true, completion: nil)
                return
        }
        pedido.status = "Enviado"
        lblStatus.text = pedido.status
        PizzariaMontaPedidoViewModel.shared.criaPedido(owner: self, pedido: pedido)
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
        cell.detailTextLabel?.text = "R$\(String(pedido.pizza[indexPath.row].detalhes.valor))"
        
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
            lblValorTotal.text = String("R$\(pedido.valorTotal)")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
