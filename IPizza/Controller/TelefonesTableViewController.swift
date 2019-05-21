//
//  TelefonesTableViewController.swift
//  IPizza
//
//  Created by André Marafigo on 07/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

// Não está sendo utilizada
class TelefonesTableViewController: UITableViewController {

    var telefones : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        telefones = ["+55 41 9 9990-8417", "+55 41 9 9990-8417", "+55 41 9 9990-8417", "+55 41 9 9990-8417", "+55 41 9 9990-8417"]
    }

    override func viewWillAppear(_ animated: Bool) {
        //pizzas.loadData()
        //tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return telefones.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTelefone", for: indexPath)

        cell.textLabel?.text = telefones[indexPath.row]

        return cell
    }
}
