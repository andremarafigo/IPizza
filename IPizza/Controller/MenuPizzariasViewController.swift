//
//  MenuPizzariasViewController.swift
//  IPizza
//
//  Created by PUCPR on 20/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class MenuPizzariasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var pizzariaEncontrada : Bool = false
    var pizzarias : [Pizzaria]!
    
    var searchedCountry = [Pizzaria]()
    var searching = false
    
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Pizzarias", image: UIImage(named: "icons8-pizza-32"), tag: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedCountry.count
        } else {
            return MapaViewModel.shared.pizzarias.count
        }
        
//        var num : Int = 0
//        if pizzariaEncontrada == true {
//            num = pizzarias.count
//        }else {
//            num = MapaViewModel.shared.pizzarias.count
//        }
//        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPizzaria", for: indexPath)
        
        if searching {
            cell.textLabel?.text = searchedCountry[indexPath.row].nomeFantasia
        } else {
            cell.textLabel?.text = MapaViewModel.shared.pizzarias[indexPath.row].nomeFantasia
        }
        
//        if pizzariaEncontrada == true {
//            cell.textLabel?.text = pizzarias[indexPath.row].nomeFantasia
//        }else {
//            cell.textLabel?.text = MapaViewModel.shared.pizzarias[indexPath.row].nomeFantasia
//        }
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedCountry = MapaViewModel.shared.pizzarias.filter({$0.nomeFantasia.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let buscarPizza = searchBar.text
//        pizzarias = []
//        for pizzaria in MapaViewModel.shared.pizzarias {
//            if buscarPizza == pizzaria.nomeFantasia {
//                pizzarias.append(pizzaria)
//                pizzariaEncontrada = true
//                tableView.reloadData()
//            }
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapaView" {
            let botao = sender as! UIButton
            let content = botao.superview
            let cell = content!.superview as! UITableViewCell
            
            let nextEditar = segue.destination as! MapaViewController
            
            let indexPath = tableView.indexPath(for: cell)
            
            nextEditar.escondeSearch = true
            nextEditar.criaRota(pizzaria: MapaViewModel.shared.pizzarias[(indexPath?.row)!])
        }
    }
}
