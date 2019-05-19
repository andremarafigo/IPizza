//
//  MenuCadastrarSaborViewController.swift
//  IPizza
//
//  Created by PUCPR on 17/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class MenuSaboresPizzasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var txtSabor: UITextField!
    @IBOutlet weak var txtTamanho: UITextField!
    @IBOutlet weak var txtValor: UITextField!
    
    @IBOutlet weak var lblListaSabores: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var sabores : [Sabor]!
    var sabor : Sabor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sabores = []
        for x in 0...10 {
            sabor = Sabor()
            sabor.nomeSabor = String("Sabor \(x)")
            sabor.tamanho = "G"
            sabor.valor = String(x+10)
            if x > 5 {
                sabor.tipo = "Doce"
            }else {
                sabor.tipo = "Salgada"
            }
            sabores.append(sabor)
        }
    }
    
    @IBAction func segmentedControlOnClick(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            print("Salgada")
            lblListaSabores.text = "Lista de Sabores Salgados"
        }else if segmentedControl.selectedSegmentIndex == 1 {
            print("Doce")
            lblListaSabores.text = "Lista de Sabores Doces"
        }
    }
    
    @IBAction func btnAdicionarOnClick(_ sender: Any) {
    }
    
    @IBAction func btnLimparOnCLick(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sabores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSabor", for: indexPath)
        
        cell.textLabel?.text = sabores[indexPath.row].nomeSabor
        //cell.detailTextLabel?.text = pizzas.listaPizzas[indexPath.row].tamanho!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath) as! UITableViewCell
        txtSabor.text = sabores[indexPath.row].nomeSabor
        txtTamanho.text = sabores[indexPath.row].tamanho
        txtValor.text = sabores[indexPath.row].valor
    }

}
