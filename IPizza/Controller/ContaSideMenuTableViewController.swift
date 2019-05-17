//
//  ContaSideMenuTableViewController.swift
//  IPizza
//
//  Created by PUCPR on 12/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import SideMenu


class ContaSideMenuTableViewController: UITableViewController {

    @IBOutlet weak var cellSair: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }

    @IBAction func btnSairOnClick(_ sender: Any) {
        //super.navigationController?.popToViewController(ViewController, animated: true)
        
        let alert = UIAlertController(title: "Logoff", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (action) in
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            MenuBemVindoViewController.logout = true
            self.dismiss(animated: false, completion: nil)
        }))

        // show the alert
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
