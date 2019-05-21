//
//  TelefonesEmpresaTableViewController.swift
//  IPizza
//
//  Created by André Marafigo on 07/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

// Não está sendo utilizada
class TelefonesEmpresaTableViewController: UITableViewController {

    var telefonesEmpresa : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        telefonesEmpresa = ["+55 41 9 9990-8417", "+55 41 9 9990-8417", "+55 41 9 9990-8417", "+55 41 9 9990-8417", "+55 41 9 9990-8417"]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return telefonesEmpresa.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTelefoneEmpresa", for: indexPath)

        cell.textLabel?.text = telefonesEmpresa[indexPath.row]
        
        return cell
    }

}
