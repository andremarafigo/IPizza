//
//  CadastroViewController.swift
//  IPizza
//
//  Created by ALUNO on 05/04/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import UIKit
import JMMaskTextField_Swift

class CadastroViewController: UIViewController {
    
    var email: String = ""
    var senha: String = ""
    var usuario: [String: Any]? = nil
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtCPF: UITextField!
    @IBOutlet weak var txtDataNascimento: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    
    @IBOutlet weak var swtEmpresa: UISwitch!
    
    @IBOutlet weak var lblRazaoSocial: UILabel!
    @IBOutlet weak var txtRazaoSocial: UITextField!
    
    @IBOutlet weak var lblNomeFantasia: UILabel!
    @IBOutlet weak var txtNomeFantasia: UITextField!
    
    @IBOutlet weak var lblCNPJ: UILabel!
    @IBOutlet weak var txtCNPJ: UITextField!
    
    @IBOutlet weak var lblCEP: UILabel!
    @IBOutlet weak var txtCEP: UITextField!
    
    @IBOutlet weak var lblRua: UILabel!
    @IBOutlet weak var txtRua: UITextField!
    
    @IBOutlet weak var lblNumero: UILabel!
    @IBOutlet weak var txtNumero: UITextField!
    
    @IBOutlet weak var lblBairro: UILabel!
    @IBOutlet weak var txtBairro: UITextField!
    
    @IBOutlet weak var lblCidade: UILabel!
    @IBOutlet weak var txtCidade: UITextField!
    
    @IBOutlet weak var lblEstado: UILabel!
    @IBOutlet weak var txtEstado: UITextField!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swtEmpresaOnOff()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.locale = NSLocale(localeIdentifier: "pt_BR") as Locale
        
        datePicker?.addTarget(self, action: #selector(CadastroViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CadastroViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        txtDataNascimento.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        txtDataNascimento.text = dateFormatter.string(from: datePicker.date)
        //view.endEditing(true)
        
    }
    
    @IBAction func swtEmpresaClick(_ sender: Any) {
        swtEmpresaOnOff()
    }
    
//    @IBAction func btnContinuarOnClick(_ sender: Any) {
//        email = txtEmail.text!
//        senha = txtSenha.text!
//
//        usuario = buscaDadosUsuario()
//
//        key = cadastroVM.createUsuario(usuario: usuario!, email: email, senha: senha)
//    }
    
    @IBAction func btnCancelarOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func swtEmpresaOnOff() {
        if swtEmpresa.isOn {
            lblRazaoSocial.isHidden = false
            lblNomeFantasia.isHidden = false
            lblCNPJ.isHidden = false
            lblCEP.isHidden = false
            lblRua.isHidden = false
            lblNumero.isHidden = false
            lblBairro.isHidden = false
            lblCidade.isHidden = false
            lblEstado.isHidden = false
            
            txtRazaoSocial.isHidden = false
            txtNomeFantasia.isHidden = false
            txtCNPJ.isHidden = false
            txtCEP.isHidden = false
            txtRua.isHidden = false
            txtNumero.isHidden = false
            txtBairro.isHidden = false
            txtCidade.isHidden = false
            txtEstado.isHidden = false
            
        }else{
            lblRazaoSocial.isHidden = true
            lblNomeFantasia.isHidden = true
            lblCNPJ.isHidden = true
            lblCEP.isHidden = true
            lblRua.isHidden = true
            lblNumero.isHidden = true
            lblBairro.isHidden = true
            lblCidade.isHidden = true
            lblEstado.isHidden = true
            
            txtRazaoSocial.isHidden = true
            txtNomeFantasia.isHidden = true
            txtCNPJ.isHidden = true
            txtCEP.isHidden = true
            txtRua.isHidden = true
            txtNumero.isHidden = true
            txtBairro.isHidden = true
            txtCidade.isHidden = true
            txtEstado.isHidden = true
            
        }
    }
    
    func buscaDadosUsuario() -> [String : Any]? {
        
        var usuario: [String : Any] = [:]
        
        var camposObrigatorios : Bool = false
        
        if swtEmpresa.isOn {
            if txtNome.text == "" || txtCPF.text == "" || txtDataNascimento == nil || txtEmail == nil || txtSenha == nil || txtRazaoSocial == nil || txtNomeFantasia == nil || txtCNPJ == nil || txtCEP == nil || txtRua == nil || txtNumero == nil || txtBairro == nil || txtCidade == nil || txtEstado == nil {
                
                camposObrigatorios = true
                
                let alert = UIAlertController(title: "Todos os campos são Obrigatórios!", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
                // add the actions (buttons)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                return nil
                
            } else if camposObrigatorios == false {
                usuario = ["nome": txtNome.text! as String,
                           "cpf": txtCPF.text! as String,
                           "dataNascimento": txtDataNascimento.text! as String,
                           "email": txtEmail.text! as String,
                           "senha": txtSenha.text! as String,
                           "enderecos": [""] as [String],
                           "telefones": [""] as [String],
                           "pizzaria": swtEmpresa.isOn,
                           "razaoSocial": txtRazaoSocial.text! as String,
                           "nomeFantasia": txtNomeFantasia.text! as String,
                           "cnpj": txtCNPJ.text! as String,
                           "cep": txtCEP.text! as String,
                           "rua": txtRua.text! as String,
                           "numero": txtNumero.text! as String,
                           "bairro": txtBairro.text! as String,
                           "cidade": txtCidade.text! as String,
                           "estado": txtEstado.text! as String,
                           "telefonesEmpresa": [""] as [String]
                    ] as [String : Any]
                return usuario
            }
            
        }else{
            if txtNome.text == "" || txtCPF.text == "" || txtDataNascimento == nil || txtEmail == nil || txtSenha == nil {
                
                camposObrigatorios = true
                
                let alert = UIAlertController(title: "Todos os campos são Obrigatórios!", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
                // add the actions (buttons)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                return nil
                
            }else if camposObrigatorios == false {
                usuario = ["nome": txtNome.text! as String,
                           "cpf": txtCPF.text! as String,
                           "dataNascimento": txtDataNascimento.text! as String,
                           "email": txtEmail.text! as String,
                           "senha": txtSenha.text! as String,
                           "enderecos": [""] as [String],
                           "telefones": [""] as [String],
                           "pizzaria": swtEmpresa.isOn,
                    ] as [String : Any]
                return usuario
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! EnderecosTelefonesViewController
        next.owner = self
        
        email = txtEmail.text!
        senha = txtSenha.text!
        
        usuario = buscaDadosUsuario()
        
        if segue.identifier == "enderecosTelefones" {
            next.usuario = usuario
            next.email = email
            next.senha = senha
            next.swtEmpresa = swtEmpresa.isOn
        } else {
            next.usuario = nil
        }
    }
}
