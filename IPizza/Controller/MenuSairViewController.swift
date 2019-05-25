//
//  MenuSairPizzariaViewController.swift
//  IPizza
//
//  Created by André Marafigo on 19/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class MenuSairViewController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Sair", image: UIImage(named: "icons8-sair-32"), tag: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
