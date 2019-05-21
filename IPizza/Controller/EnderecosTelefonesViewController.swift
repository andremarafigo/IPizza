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

// Não está sendo utilizada
class EnderecosTelefonesViewController: UIViewController {
    
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
    
    
    @IBOutlet weak var btnLimparEndereco: UIButton!
    @IBOutlet weak var btnAdicionarEndereco: UIButton!
    @IBOutlet weak var lblListaEnderecos: UILabel!
    
    @IBOutlet weak var btnLimparTelefone: UIButton!
    @IBOutlet weak var btnAdicionarTelefone: UIButton!
    @IBOutlet weak var lblListaTelefones: UILabel!
    
    @IBOutlet weak var txtRua: UITextField!
    @IBOutlet weak var txtNumero: UITextField!
    @IBOutlet weak var txtCEP: UITextField!
    @IBOutlet weak var txtBairro: UITextField!
    @IBOutlet weak var txtCidade: UITextField!
    @IBOutlet weak var txtEstado: UITextField!
    
    @IBOutlet weak var txtDDI: UITextField!
    @IBOutlet weak var txtDDD: UITextField!
    @IBOutlet weak var txtNumeroFone: UITextField!
    
    
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
    
    @IBAction func btnAdicionarOnClick(_ sender: Any) {
        adicionaDados()
    }
    
    @IBAction func btnCancelarOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFinalizarOnClick(_ sender: Any) {
        let json: [String : Any]? = montaJson()
        if json != nil {
            //CadastroViewModel.shared.createUsuario(usuario: json, email: email, senha: senha)
        }
    }
    
    func enderecoOuTelefone() {
        segControlEnderecoTelefone.isHidden = true
        
        svEnderecos.isHidden = false
        ctvEnderecos.isHidden = false
        svTelefones.isHidden = true
        ctvTelefones.isHidden = true
        btnAdicionarEndereco.isHidden = true
        btnLimparEndereco.isHidden = true
        lblListaEnderecos.isHidden = true
        btnAdicionarTelefone.isHidden = true
        btnLimparTelefone.isHidden = true
        lblListaTelefones.isHidden = true
//        if segControlEnderecoTelefone.selectedSegmentIndex == 0 {
//            svEnderecos.isHidden = false
//            ctvEnderecos.isHidden = true
//            svTelefones.isHidden = true
//            ctvTelefones.isHidden = true
//            lblListaEnderecos.isHidden = true
//            lblListaTelefones.isHidden = true
//        }else if segControlEnderecoTelefone.selectedSegmentIndex == 1 {
//            svEnderecos.isHidden = true
//            ctvEnderecos.isHidden = true
//            svTelefones.isHidden = false
//            ctvTelefones.isHidden = true
//            lblListaEnderecos.isHidden = true
//            lblListaTelefones.isHidden = true
//        }
    }
    
    func adicionaDados() {
//        var endereco: [String : Any] = [:]
//
//        endereco = [
//            "Rua": txtRua.text! as String,
//            "Numero": txtNumero.text! as String,
//            "CEP": txtCEP.text! as String,
//            "Bairro": txtBairro.text! as String,
//            "Cidade": txtCidade.text! as String,
//            "Estado": txtEstado.text! as String
//        ]
//
//        var telefone: [String : Any] = [:]
//
//        telefone = [
//            "DDI": txtDDI.text! as String,
//            "DDD": txtDDD.text! as String,
//            "NumeroFone": txtNumeroFone.text! as String
//        ]
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
    
    func montaJson() -> [String : Any]? {
        var usuario: [String : Any] = [:]
        
        var camposObrigatorios : Bool = false
        
        if owner!.txtNome.text == "" || owner!.txtCPF.text == "" || owner!.txtDataNascimento.text == "" || owner!.txtEmail.text == "" || owner!.txtSenha.text == "" || (owner!.txtSenha.text?.count)! < 6{
            
            camposObrigatorios = true
            
            let alert = UIAlertController(title: "Todos os campos são Obrigatórios!", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return nil
            
        }else if camposObrigatorios == false {
            usuario = [
                "nome": owner!.txtNome.text! as String,
                "cpf": owner!.txtCPF.text! as String,
                "dataNascimento": owner!.txtDataNascimento.text! as String,
                "email": owner!.txtEmail.text! as String,
                "senha": owner!.txtSenha.text! as String,
                "enderecos": [
                    "Rua": txtRua.text! as String,
                    "Numero": txtNumero.text! as String,
                    "CEP": txtCEP.text! as String,
                    "Bairro": txtBairro.text! as String,
                    "Cidade": txtCidade.text! as String,
                    "Estado": txtEstado.text! as String
                    ] as [String : Any],
                "telefones": [
                    "DDI": txtDDI.text! as String,
                    "DDD": txtDDD.text! as String,
                    "NumeroFone": txtNumeroFone.text! as String
                    ] as [String : Any],
                "pizzaria": owner!.swtEmpresa.isOn,
                ] as [String : Any]
            return usuario
        }
        
        /**if owner!.swtEmpresa.isOn {
            if owner!.txtNome.text == "" || owner!.txtCPF.text == "" || owner!.txtDataNascimento == nil || owner!.txtEmail.text == "" || owner!.txtSenha.text == "" || (owner!.txtSenha.text?.count)! < 6 || owner!.txtRazaoSocial.text == "" || owner!.txtNomeFantasia.text == "" || owner!.txtCNPJ.text == "" || owner!.txtCEP.text == "" || owner!.txtRua.text == "" || owner!.txtNumero.text == "" || owner!.txtBairro.text == "" || owner!.txtCidade.text == "" || owner!.txtEstado.text == ""{
                
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
                    "nome": owner!.txtNome.text! as String,
                    "cpf": owner!.txtCPF.text! as String,
                    "dataNascimento": owner!.txtDataNascimento.text! as String,
                    "email": owner!.txtEmail.text! as String,
                    "enderecos": [
                        "Rua": txtRua.text! as String,
                        "Numero": txtNumero.text! as String,
                        "CEP": txtCEP.text! as String,
                        "Bairro": txtBairro.text! as String,
                        "Cidade": txtCidade.text! as String,
                        "Estado": txtEstado.text! as String
                        ] as [String : Any],
                    "telefones": [
                        "DDI": txtDDI.text! as String,
                        "DDD": txtDDD.text! as String,
                        "NumeroFone": txtNumeroFone.text! as String
                        ] as [String : Any],
                    "pizzaria": owner!.swtEmpresa.isOn,
                    "razaoSocial": owner!.txtRazaoSocial.text! as String,
                    "nomeFantasia": owner!.txtNomeFantasia.text! as String,
                    "cnpj": owner!.txtCNPJ.text! as String,
                    "cep": owner!.txtCEP.text! as String,
                    "rua": owner!.txtRua.text! as String,
                    "numero": owner!.txtNumero.text! as String,
                    "bairro": owner!.txtBairro.text! as String,
                    "cidade": owner!.txtCidade.text! as String,
                    "estado": owner!.txtEstado.text! as String,
                    "telefonesEmpresa": [""] as [String]
                ]
                return usuario
            }
            
        }else{
            if owner!.txtNome.text == "" || owner!.txtCPF.text == "" || owner!.txtDataNascimento.text == "" || owner!.txtEmail.text == "" || owner!.txtSenha.text == "" || (owner!.txtSenha.text?.count)! < 6{
                
                camposObrigatorios = true
                
                let alert = UIAlertController(title: "Todos os campos são Obrigatórios!", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
                // add the actions (buttons)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                return nil
                
            }else if camposObrigatorios == false {
                usuario = [
                    "nome": owner!.txtNome.text! as String,
                    "cpf": owner!.txtCPF.text! as String,
                    "dataNascimento": owner!.txtDataNascimento.text! as String,
                    "email": owner!.txtEmail.text! as String,
                    "senha": owner!.txtSenha.text! as String,
                    "enderecos": [
                        "Rua": txtRua.text! as String,
                        "Numero": txtNumero.text! as String,
                        "CEP": txtCEP.text! as String,
                        "Bairro": txtBairro.text! as String,
                        "Cidade": txtCidade.text! as String,
                        "Estado": txtEstado.text! as String
                        ] as [String : Any],
                    "telefones": [
                        "DDI": txtDDI.text! as String,
                        "DDD": txtDDD.text! as String,
                        "NumeroFone": txtNumeroFone.text! as String
                        ] as [String : Any],
                    "pizzaria": owner!.swtEmpresa.isOn,
                    ] as [String : Any]
                return usuario
            }
        }**/
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
