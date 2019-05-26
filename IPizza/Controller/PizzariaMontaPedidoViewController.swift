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
    @IBOutlet weak var lblPartes: UILabel!
    
    @IBOutlet weak var btnPedido: UIButton!
    
    var pizzaria : Pizzaria!
    
    var saboresSalgados : [Sabor]!
    var saboresDoces : [Sabor]!
    var saborTableView : [Sabor]!
    var pizza : Sabor!
    var editarSabor: Sabor!
    var key : String!
    
    var pedido = Pedido()
    
    var qtdPizza : Int = 0
    var novaPizza : Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Pedir", image: UIImage(named: "icons8-pizza-32"), tag: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPartes.isHidden = true
        scPartes.isHidden = true
        
        btnPedido.isHidden = true
        
        pizzaria = PizzariaMontaPedidoViewModel.shared.pizzaria
        PizzariaMontaPedidoViewModel.shared.loadDataFireBase(owner: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        lblPartes.isHidden = true
        scPartes.isHidden = true
        tableView.reloadData()
        
        if pedido.pizza.count > 0 {
            btnPedido.isHidden = false
        }
        
        pedido.valorTotal = 0
        for valor in pedido.pizza {
            pedido.valorTotal += valor.detalhes.valor
        }
        lblPizzas.text = "Pizzas: \(String(pedido.pizza.count))"
        lblValorTotal.text = "Valor Total: R$\(String(pedido.valorTotal))"
    }
    
    @IBAction func scSalgadoDoceOnClick(_ sender: Any) {
        tableView.reloadData()
    }
    
    @IBAction func scTamanhoOnClick(_ sender: Any) {
        tableView.reloadData()
    }
    
    @IBAction func btnAdicionarOnClick(_ sender: Any) {
        if pedido.pizza.count > 0 {
            pedido.key_usuario = Auth.auth().currentUser?.uid
            pedido.key_usuario = LoginViewModel.shared.users[0].key!
            pedido.key_pizzaria = pizzaria.key
            pedido.valorTotal = 0
            for valor in pedido.pizza {
                pedido.valorTotal += valor.detalhes.valor
            }
            pedido.status = "Em Construção"
            lblPizzas.text = "Pizzas: \(String(pedido.pizza.count))"
            lblValorTotal.text = "Valor Total: R$\(String(pedido.valorTotal))"
            //pedido.formaDePagamento =
            //pedido.formaDeRetirada =
            novaPizza = true
            btnPedido.isHidden = false
            
            let alert = UIAlertController(title: "Pizza adicionada com sucesso.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            }))
            
            // show the alert
            present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Selecione um sabor para adicionar ao pedido", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            }))
            
            // show the alert
            present(alert, animated: true, completion: nil)
        }
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
        var tamanho = ""
        saborTableView = []
        if scSalgadaDoce.selectedSegmentIndex == 0 {
            if saboresSalgados != nil {
                switch scTamanho.selectedSegmentIndex {
                    case 0:
                        tamanho = "P"
                        break
                    case 1:
                        tamanho = "M"
                        break
                    case 2:
                        tamanho = "G"
                        break
                    case 3:
                        tamanho = "GG"
                        break
                    default:
                        break
                }
                
                for x in saboresSalgados {
                    if x.detalhes.tamanho == tamanho {
                        saborTableView.append(x)
                        cells += 1
                    }
                }
            }
        }else if scSalgadaDoce.selectedSegmentIndex == 1 {
            if saboresDoces != nil {
                switch scTamanho.selectedSegmentIndex {
                case 0:
                    tamanho = "P"
                    break
                case 1:
                    tamanho = "M"
                    break
                case 2:
                    tamanho = "G"
                    break
                case 3:
                    tamanho = "GG"
                    break
                default:
                    break
                }
                
                for x in saboresDoces {
                    if x.detalhes.tamanho == tamanho {
                        saborTableView.append(x)
                        cells += 1
                    }
                }
            }
        }
        return cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSabor", for: indexPath)
        
        cell.textLabel?.text = saborTableView[indexPath.row].nomeSabor
        cell.detailTextLabel?.text = "R$\(String(saborTableView[indexPath.row].detalhes.valor))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if novaPizza == true {
            pedido.pizza.append(saborTableView[indexPath.row])
            novaPizza = false
        }else {
            let qtd = pedido.pizza.count
            pedido.pizza[qtd - 1] = saborTableView[indexPath.row]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! FinalizarPedidoViewController
        
        if segue.identifier == "finalizarPedido" {
            next.owner = self
            next.pedido = pedido
        }
    }
}
