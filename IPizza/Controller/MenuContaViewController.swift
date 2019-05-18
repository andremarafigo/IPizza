//
//  MenuContaViewController.swift
//  IPizza
//
//  Created by André Marafigo on 23/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Firebase

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
        
        criaBotoes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        criaBotoes()
    }
    
    @IBAction func btnSairOnClick(_ sender: Any) {
        LoginViewModel.shared.deleteData()
        criaBotoes()
    }
    
    func criaBotoes() {
        
        if Auth.auth().currentUser != nil {
            print("Deu Certo")
        }
        
        if LoginViewModel.shared.users.count == 1 {
            if LoginViewModel.shared.users[0].email != nil {
                btnAlterarConta.isHidden = false
                btnPedidosEmAndamento.isHidden = false
                btnPedidosFinalizados.isHidden = false
                if LoginViewModel.shared.users[0].pizzaria == true {
                    btnPaginaDaPizzaria.isHidden = false
                }else{
                    btnPaginaDaPizzaria.isHidden = true
                }
                btnSair.isHidden = false
                btnEfetuarLogin.isHidden = true
            }else {
                btnAlterarConta.isHidden = true
                btnPedidosEmAndamento.isHidden = true
                btnPedidosFinalizados.isHidden = true
                btnPaginaDaPizzaria.isHidden = true
                btnSair.isHidden = true
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "efetuarLogin" {
            let next = segue.destination as! LoginViewController
            next.owner = self
        }else if segue.identifier == "alterarUsuario" {
            let next = segue.destination as! CadastroViewController
            next.editarUsuario = LoginViewModel.shared.usuario
        }
    }
    
}
