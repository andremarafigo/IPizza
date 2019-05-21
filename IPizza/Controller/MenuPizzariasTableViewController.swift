//
//  MenuPizzariasTableViewController.swift
//  IPizza
//
//  Created by André Marafigo on 27/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class MenuPizzariasTableViewController: UITableViewController {

    var x : Bool = false
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Pizzarias", image: UIImage(named: "icons8-pizza-32"), tag: 2)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController!.selectedIndex = 1;
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if tableView.headerView(forSection: section)?.textLabel?.text == "Lista de Pizzarias" {
        if section == 2 {
            return MapaViewModel.shared.pizzarias.count
        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        

        //if tableView.headerView(forSection: indexPath.section)?.textLabel?.text == "Logo" {
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "cellBuscar", for: indexPath)
        }
        
        //if tableView.headerView(forSection: indexPath.section)?.textLabel?.text == "Buscar" {
        if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "cellLogo", for: indexPath)
        }
        
       // if tableView.headerView(forSection: indexPath.section)?.textLabel?.text == "Lista de Pizzarias" {
        if indexPath.section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "cellPizzaria", for: indexPath)
            cell.textLabel?.text = MapaViewModel.shared.pizzarias[indexPath.row].nomeFantasia
        }
        
        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
