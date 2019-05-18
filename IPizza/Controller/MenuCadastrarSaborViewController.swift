//
//  MenuCadastrarSaborViewController.swift
//  IPizza
//
//  Created by PUCPR on 17/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class MenuCadastrarSaborViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnLimparOnCLick(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
