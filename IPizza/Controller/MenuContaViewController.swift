//
//  MenuContaViewController.swift
//  IPizza
//
//  Created by André Marafigo on 23/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class MenuContaViewController: UIViewController {
    
    @IBOutlet weak var btnAlterarConta: UIButton!
    @IBOutlet weak var btnPedidosEmAndamento: UIButton!
    @IBOutlet weak var btnPedidosFinalizados: UIButton!
    
    @IBOutlet weak var btnPaginaDaPizzaria: UIButton!
    
    @IBOutlet weak var btnEfetuarLogin: UIButton!
    
    @IBOutlet weak var btnSair: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Conta", image: UIImage(named: "icons8-usuario-de-genero-neutro-48"), tag: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if LoginViewModel.shared.users.count == 1 {
            if LoginViewModel.shared.users[0].email != nil {
                btnAlterarConta.isHidden = false
                btnPedidosEmAndamento.isHidden = false
                btnPedidosFinalizados.isHidden = false
                btnPaginaDaPizzaria.isHidden = false
                btnSair.isHidden = false
                btnEfetuarLogin.isHidden = true
            }else {
                btnAlterarConta.isHidden = true
                btnPedidosEmAndamento.isHidden = true
                btnPedidosFinalizados.isHidden = true
                btnPaginaDaPizzaria.isHidden = true
                btnEfetuarLogin.isHidden = false
            }
        }else {
            btnAlterarConta.isHidden = true
            btnPedidosEmAndamento.isHidden = true
            btnPedidosFinalizados.isHidden = true
            btnPaginaDaPizzaria.isHidden = true
            btnSair.isHidden = true
            btnEfetuarLogin.isHidden = false
        }
        LoginViewModel.shared.loadData()
    }
    
    @IBAction func btnSairOnClick(_ sender: Any) {
        LoginViewModel.shared.deletData()
        viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let next = segue.destination as! LoginViewController
        //next.loginVM = loginVM
    }
    
}
