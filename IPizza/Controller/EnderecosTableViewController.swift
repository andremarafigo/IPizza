//
//  EnderecosTableViewController.swift
//  IPizza
//
//  Created by André Marafigo on 07/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class EnderecosTableViewController: UITableViewController {

    var enderecos : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enderecos = ["Rua 1", "Rua 2", "Rua 3", "Rua 4", "Rua 5",]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //pizzas.loadData()
        //tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enderecos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellEndereco", for: indexPath)
        
        cell.textLabel?.text = enderecos[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //pizzas.deletData(enderecos[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
