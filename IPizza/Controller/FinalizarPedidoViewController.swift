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
    
    @IBOutlet weak var btnFinalizarPedido: UIButton!
    @IBOutlet weak var btnAddPizza: UIButton!
    @IBOutlet weak var btnCancelarPedido: UIButton!
    @IBOutlet weak var btnSobre: UIButton!
    @IBOutlet weak var btnAceitarPedido: UIButton!
    
    var owner : PizzariaMontaPedidoViewController!
    var pedido = Pedido()
    
    var verPedido : Pedido?
    var ownerPedidos : PizzariaPedidosTableViewController!
    
    var aceitarPedido : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblValorTotal.text = String("R$\(pedido.valorTotal)")
        btnCancelarPedido.isHidden = true
        btnAceitarPedido.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        if verPedido != nil {
            lblNumPedido.text = "Pedido nº \(String(verPedido!.n_pedido))"
            lblStatus.text = verPedido?.status
            lblValorTotal.text = "\(String(verPedido!.valorTotal))"
            if verPedido?.formaDePagamento == "Dinheiro" {
                scFormaDePagamento.isSelected = true
                scFormaDePagamento.selectedSegmentIndex = 0
            }else {
                scFormaDePagamento.isSelected = true
                scFormaDePagamento.selectedSegmentIndex = 1
            }
            
            if verPedido?.formaDeRetirada == "Entrega" {
                scFormaDeRetirada.isSelected = true
                scFormaDeRetirada.selectedSegmentIndex = 0
            }else {
                scFormaDeRetirada.isSelected = true
                scFormaDeRetirada.selectedSegmentIndex = 1
            }
            
            btnFinalizarPedido.isHidden = true
            btnAddPizza.setTitle("Voltar", for: .normal)
            
            if verPedido?.status == "Enviado" {
                if aceitarPedido == true {
                    scFormaDePagamento.isEnabled = false
                    scFormaDeRetirada.isEnabled = false
                    btnSobre.isHidden = true
                    btnCancelarPedido.isHidden = true
                    btnAceitarPedido.isHidden = false
                }else {
                    scFormaDePagamento.isEnabled = false
                    scFormaDeRetirada.isEnabled = false
                    btnSobre.isHidden = true
                    btnCancelarPedido.isHidden = false
                    btnAceitarPedido.isHidden = true
                }
            }else if verPedido?.status == "Cancelado" {
                if aceitarPedido == true {
                    scFormaDePagamento.isEnabled = false
                    scFormaDeRetirada.isEnabled = false
                    btnSobre.isHidden = true
                    btnCancelarPedido.isHidden = true
                    btnAceitarPedido.isHidden = true
                }else {
                    scFormaDePagamento.isEnabled = false
                    scFormaDeRetirada.isEnabled = false
                    btnSobre.isHidden = true
                    btnCancelarPedido.isHidden = true
                    btnAceitarPedido.isHidden = true
                }
            }else if verPedido?.status == "Aceito" {
                if aceitarPedido == true {
                    scFormaDePagamento.isEnabled = false
                    scFormaDeRetirada.isEnabled = false
                    btnSobre.isHidden = true
                    btnCancelarPedido.isHidden = true
                    btnAceitarPedido.setTitle("Finalizar", for: .normal)
                    btnAceitarPedido.isHidden = false
                }else {
                    scFormaDePagamento.isEnabled = false
                    scFormaDeRetirada.isEnabled = false
                    btnSobre.isHidden = true
                    btnCancelarPedido.isHidden = true
                    btnAceitarPedido.isHidden = true
                }
            }else if verPedido?.status == "Finalizado" {
                if aceitarPedido == true {
                    scFormaDePagamento.isEnabled = false
                    scFormaDeRetirada.isEnabled = false
                    btnSobre.isHidden = true
                    btnCancelarPedido.isHidden = true
                    btnAceitarPedido.isHidden = true
                }else {
                    scFormaDePagamento.isEnabled = false
                    scFormaDeRetirada.isEnabled = false
                    btnSobre.isHidden = true
                    btnCancelarPedido.isHidden = true
                    btnAceitarPedido.isHidden = true
                }
            }
            
            tableView.reloadData()
        }else {
            tableView.reloadData()
            
            lblStatus.text = pedido.status
            
            pedido.valorTotal = 0
            for valor in pedido.pizza {
                pedido.valorTotal += valor.detalhes.valor
            }
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
    
    @IBAction func btnCancelarPedidoOnClick(_ sender: Any) {
        let alert = UIAlertController(title: "Cancelar Pedido", message: "Deseja realmente cancelar esse pedido?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "NÃO", style: .default, handler: { (action) in
        }))
        alert.addAction(UIAlertAction(title: "SIM", style: .default, handler: { (action) in
            self.verPedido?.status = "Cancelado"
            PizzariaMontaPedidoViewModel.shared.cancelarPedido(owner: self, pedido: self.verPedido!)
        }))
        
        // show the alert
        present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func btnAceitarPedidoOnClick(_ sender: Any) {
        if self.verPedido?.status == "Enviado" {
            let alert = UIAlertController(title: "Aceitar Pedido", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "NÃO", style: .default, handler: { (action) in
            }))
            alert.addAction(UIAlertAction(title: "SIM", style: .default, handler: { (action) in
                self.verPedido?.status = "Aceito"
                PizzariaMontaPedidoViewModel.shared.aceitarPedido(owner: self, pedido: self.verPedido!)
            }))
            
            // show the alert
            present(alert, animated: true, completion: nil)
        }else if self.verPedido?.status == "Aceito" {
            let alert = UIAlertController(title: "Finalizar Pedido", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "NÃO", style: .default, handler: { (action) in
            }))
            alert.addAction(UIAlertAction(title: "SIM", style: .default, handler: { (action) in
                self.verPedido?.status = "Finalizado"
                PizzariaMontaPedidoViewModel.shared.finalizarPedido(owner: self, pedido: self.verPedido!)
            }))
            
            // show the alert
            present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if verPedido != nil {
            return verPedido!.pizza.count
        }else {
            return pedido.pizza.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPizza", for: indexPath)
        
        if verPedido != nil {
            cell.textLabel?.text = verPedido!.pizza[indexPath.row].nomeSabor
            cell.detailTextLabel?.text = "R$\(String(verPedido!.pizza[indexPath.row].detalhes.valor))"
        }else {
            cell.textLabel?.text = pedido.pizza[indexPath.row].nomeSabor
            cell.detailTextLabel?.text = "R$\(String(pedido.pizza[indexPath.row].detalhes.valor))"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if verPedido != nil {
            let alert = UIAlertController(title: "Pedido já enviado não pode ser alterado, apenas cancelado.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            }))
            
            // show the alert
            present(alert, animated: true, completion: nil)
            return
        }else if editingStyle == .delete {
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
