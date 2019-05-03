//
//  TelaInicialViewController.swift
//  IPizza
//
//  Created by André Marafigo on 19/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class TelaInicialViewController: UIViewController {
    
    @IBOutlet weak var viewBordaTittle: UIView!
    @IBOutlet weak var viewTitle: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBordaTittle.layer.cornerRadius = viewBordaTittle.frame.size.width/2
        viewBordaTittle.clipsToBounds = true
        
        viewTitle.layer.cornerRadius = viewTitle.frame.size.width/2
        viewTitle.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }

}
