//
//  EnderecosTelefonesViewController.swift
//  IPizza
//
//  Created by André Marafigo on 06/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import Firebase
import JMMaskTextField_Swift

class EnderecosTelefonesViewController: UIViewController {
    
    var cadastroVM : CadastroViewModel!
    
    var owner : CadastroViewController?
    var usuario : [String : Any]?
    var key : String = ""
    var email: String = ""
    var senha: String = ""
    var swtEmpresa: Bool?
    var per: Bool = false
    
    @IBOutlet weak var svEnderecos: UIStackView!
    @IBOutlet weak var svTelefones: UIStackView!
    @IBOutlet weak var segControlEnderecoTelefone: UISegmentedControl!
    @IBOutlet weak var ctvEnderecos: UIView!
    @IBOutlet weak var ctvTelefones: UIView!
    @IBOutlet weak var btnFinalizar: UIButton!
    @IBOutlet weak var btnContinuar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        per = true
        
        enderecoOuTelefone()
        usuarioOuEmpresa()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func segControlEnderecoTelefoneClick(_ sender: Any) {
        enderecoOuTelefone()
    }
    
    @IBAction func btnCancelarOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnFinalizarOnClick(_ sender: Any) {
        key = cadastroVM.createUsuario(usuario: usuario!, email: email, senha: senha)
    }
    
    func enderecoOuTelefone() {
        if segControlEnderecoTelefone.selectedSegmentIndex == 0 {
            svEnderecos.isHidden = false
            ctvEnderecos.isHidden = false
            svTelefones.isHidden = true
            ctvTelefones.isHidden = true
        }else if segControlEnderecoTelefone.selectedSegmentIndex == 1 {
            svEnderecos.isHidden = true
            ctvEnderecos.isHidden = true
            svTelefones.isHidden = false
            ctvTelefones.isHidden = false
        }
    }
    
    func usuarioOuEmpresa() {
        if swtEmpresa == true {
            btnContinuar.isHidden = false
            btnFinalizar.isHidden = true
        }else {
            btnContinuar.isHidden = true
            btnFinalizar.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if per == true {
            if segue.identifier == "telefonesEmpresa" {
                let next = segue.destination as! TelefonesEmpresaViewController
                next.owner = self
                next.usuario = usuario
                next.key = key
                next.email = email
                next.senha = senha
            } else {
                let next = segue.destination as! TelefonesEmpresaViewController
                next.usuario = nil
            }
        }
    }
}
