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

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var pizzaria : Pizzaria!
    
    var saboresSalgados : [Sabor]!
    var saboresDoces : [Sabor]!
    var sabor : Sabor!
    var editarSabor: Sabor!
    var key : String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Sabores", image: UIImage(named: "icons8-pizza-32"), tag: 2)
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
        if segmentedControl.selectedSegmentIndex == 0 {
            print("Salgada")
            tableView.reloadData()
        }else if segmentedControl.selectedSegmentIndex == 1 {
            print("Doce")
            tableView.reloadData()
        }
    }

    func separaSabores() {
        saboresSalgados = []
        saboresDoces = []
        for sab in PizzariaMontaPedidoViewModel.shared.sabores {
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
        if segmentedControl.selectedSegmentIndex == 0 {
            if saboresSalgados != nil {
                cells = saboresSalgados.count
            }
        }else if segmentedControl.selectedSegmentIndex == 1 {
            if saboresDoces != nil {
                cells = saboresDoces.count
            }
        }
        return cells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSabor", for: indexPath)
        
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = saboresSalgados[indexPath.row].nomeSabor
            //cell.detailTextLabel?.text = pizzas.listaPizzas[indexPath.row].tamanho!
        }else if segmentedControl.selectedSegmentIndex == 1 {
            cell.textLabel?.text = saboresDoces[indexPath.row].nomeSabor
            //cell.detailTextLabel?.text = pizzas.listaPizzas[indexPath.row].tamanho!
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
            
        }else if segmentedControl.selectedSegmentIndex == 1 {
            
        }
    }
}
