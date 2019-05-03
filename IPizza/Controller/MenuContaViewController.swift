//
//  MenuContaViewController.swift
//  IPizza
//
//  Created by André Marafigo on 23/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class MenuContaViewController: UIViewController {
    
    var menuContaVM : MenuContaViewModel!
    
    @IBOutlet weak var btnAlterarConta: UIButton!
    @IBOutlet weak var btnPedidosEmAndamento: UIButton!
    @IBOutlet weak var btnPedidosFinalizados: UIButton!
    
    @IBOutlet weak var btnPaginaDaPizzaria: UIButton!
    
    @IBOutlet weak var btnEfetuarLogin: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Conta", image: UIImage(named: "icons8-usuário-de-gênero-neutro-48"), tag: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if menuContaVM.users[0].email != nil {
//            btnAlterarConta.isHidden = false
//            btnPedidosEmAndamento.isHidden = false
//            btnPedidosFinalizados.isHidden = false
//            btnPaginaDaPizzaria.isHidden = false
//            btnEfetuarLogin.isHidden = true
//        }else {
//            btnAlterarConta.isHidden = true
//            btnPedidosEmAndamento.isHidden = true
//            btnPedidosFinalizados.isHidden = true
//            btnPaginaDaPizzaria.isHidden = true
//            btnEfetuarLogin.isHidden = false
//        }
    }
    
}
