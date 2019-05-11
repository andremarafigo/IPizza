//
//  TelefonesEmpresaViewController.swift
//  IPizza
//
//  Created by PUCPR on 08/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit

class TelefonesEmpresaViewController: UIViewController {

    var owner : EnderecosTelefonesViewController?
    var usuario : [String : Any]?
    var key : String = ""
    var email: String = ""
    var senha: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction func btnCancelarOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func montaJson() -> [String : Any]? {
        var usuario: [String : Any] = [:]
    
        var camposObrigatorios : Bool = false
        if owner!.owner!.txtNome.text == "" || owner!.owner!.txtCPF.text == "" || owner!.owner!.txtDataNascimento == nil || owner!.owner!.txtEmail.text == "" || owner!.owner!.txtSenha.text == "" || (owner!.owner!.txtSenha.text?.count)! < 6 || owner!.owner!.txtRazaoSocial.text == "" || owner!.owner!.txtNomeFantasia.text == "" || owner!.owner!.txtCNPJ.text == "" || owner!.owner!.txtCEP.text == "" || owner!.owner!.txtRua.text == "" || owner!.owner!.txtNumero.text == "" || owner!.owner!.txtBairro.text == "" || owner!.owner!.txtCidade.text == "" || owner!.owner!.txtEstado.text == ""{
    
        camposObrigatorios = true
    
        let alert = UIAlertController(title: "Todos os campos são Obrigatórios!", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
    
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
        }))
    
        // show the alert
        self.present(alert, animated: true, completion: nil)
        return nil
    
        } else if camposObrigatorios == false {
    
        usuario = [
        "nome": owner!.owner!.txtNome.text! as String,
        "cpf": owner!.owner!.txtCPF.text! as String,
        "dataNascimento": owner!.owner!.txtDataNascimento.text! as String,
        "email": owner!.owner!.txtEmail.text! as String,
        "enderecos": [
        "Rua": owner!.txtRua.text! as String,
        "Numero": owner!.txtNumero.text! as String,
        "CEP": owner!.txtCEP.text! as String,
        "Bairro": owner!.txtBairro.text! as String,
        "Cidade": owner!.txtCidade.text! as String,
        "Estado": owner!.txtEstado.text! as String
        ] as [String : Any],
        "telefones": [
        "DDI": owner!.txtDDI.text! as String,
        "DDD": owner!.txtDDD.text! as String,
        "NumeroFone": owner!.txtNumeroFone.text! as String
        ] as [String : Any],
        "pizzaria": owner!.owner!.swtEmpresa.isOn,
        "razaoSocial": owner!.owner!.txtRazaoSocial.text! as String,
        "nomeFantasia": owner!.owner!.txtNomeFantasia.text! as String,
        "cnpj": owner!.owner!.txtCNPJ.text! as String,
        "cep": owner!.owner!.txtCEP.text! as String,
        "rua": owner!.owner!.txtRua.text! as String,
        "numero": owner!.owner!.txtNumero.text! as String,
        "bairro": owner!.owner!.txtBairro.text! as String,
        "cidade": owner!.owner!.txtCidade.text! as String,
        "estado": owner!.owner!.txtEstado.text! as String,
        "telefonesEmpresa": [""] as [String]
        ]
        return usuario
        }
    }
}
