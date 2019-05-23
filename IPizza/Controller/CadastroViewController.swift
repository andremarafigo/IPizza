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
    var usuario: [String: Any]?
    var editarUsuario: Usuarios!
    
    //Campos para Usuário
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblSenha: UILabel!
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtCPF: UITextField!
    @IBOutlet weak var txtDataNascimento: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var lblErrorSenha: UILabel!
    @IBOutlet weak var txtDDI: UITextField!
    @IBOutlet weak var txtDDD: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtCEP: UITextField!
    @IBOutlet weak var txtRua: UITextField!
    @IBOutlet weak var txtNumero: UITextField!
    @IBOutlet weak var txtBairro: UITextField!
    @IBOutlet weak var txtCidade: UITextField!
    @IBOutlet weak var txtEstado: UITextField!
    
    //Campos para Empresa
    @IBOutlet weak var swtEmpresa: UISwitch!
    
    @IBOutlet weak var lblRazaoSocial: UILabel!
    @IBOutlet weak var txtRazaoSocial: UITextField!
    
    @IBOutlet weak var lblNomeFantasia: UILabel!
    @IBOutlet weak var txtNomeFantasia: UITextField!
    
    @IBOutlet weak var lblCNPJ: UILabel!
    @IBOutlet weak var txtCNPJ: UITextField!
    
    @IBOutlet weak var lblCEPPizzaria: UILabel!
    @IBOutlet weak var txtCEPPizzaria: UITextField!
    
    @IBOutlet weak var lblRuaPizzaria: UILabel!
    @IBOutlet weak var txtRuaPizzaria: UITextField!
    
    @IBOutlet weak var lblNumeroPizzaria: UILabel!
    @IBOutlet weak var txtNumeroPizzaria: UITextField!
    
    @IBOutlet weak var lblBairroPizzaria: UILabel!
    @IBOutlet weak var txtBairroPizzaria: UITextField!
    
    @IBOutlet weak var lblCidadePizzaria: UILabel!
    @IBOutlet weak var txtCidadePizzaria: UITextField!
    
    @IBOutlet weak var lblEstadoPizzaria: UILabel!
    @IBOutlet weak var txtEstadoPizzaria: UITextField!
    
    @IBOutlet weak var lblTelefonePizzaria: UILabel!
    @IBOutlet weak var txtDDIPizzaria: UITextField!
    @IBOutlet weak var txtDDDPizzaria: UITextField!
    @IBOutlet weak var txtTelefonePizzaria: UITextField!
    
    @IBOutlet weak var btnCadastrar: UIButton!
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblErrorSenha.isHidden = true
        
        validaTextFilds()
        
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
    
    @IBAction func txtCEPEditingDidEnd(_ sender: Any) {
        CadastroViewModel.shared.buscaEnderecoPorCEP(owner: self, cep: txtCEP.text!, pizzaria: false)
    }
    
    @IBAction func txtCEPPizzariaEditingDidEnd(_ sender: Any) {
        CadastroViewModel.shared.buscaEnderecoPorCEP(owner: self, cep: txtCEPPizzaria.text!, pizzaria: true)
    }
    
    @IBAction func swtEmpresaClick(_ sender: Any) {
        swtEmpresaOnOff()
    }
    
    @IBAction func btnCancelarOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnCadastrarOnClick(_ sender: Any) {
        let json: [String : Any]? = montaJson()
        if json != nil {
            if editarUsuario != nil {
                CadastroViewModel.shared.alteraUsuario(owner: self, usuario: json)
            }else{
                CadastroViewModel.shared.createUsuario(owner: self, usuario: json, email: txtEmail.text!, senha: txtSenha.text!)
            }
        }
        print(MapaViewModel.shared.pizzarias.count)
    }
    
    @IBAction func txtSenhaEditEnd(_ sender: Any) {
        if (txtSenha.text?.count)! < 6 {
            lblErrorSenha.isHidden = false
        }else {
            lblErrorSenha.isHidden = true
        }
    }
    
    func swtEmpresaOnOff() {
        if swtEmpresa.isOn {
            lblRazaoSocial.isHidden = false
            lblNomeFantasia.isHidden = false
            lblCNPJ.isHidden = false
            lblCEPPizzaria.isHidden = false
            lblRuaPizzaria.isHidden = false
            lblNumeroPizzaria.isHidden = false
            lblBairroPizzaria.isHidden = false
            lblCidadePizzaria.isHidden = false
            lblEstadoPizzaria.isHidden = false
            
            txtRazaoSocial.isHidden = false
            txtNomeFantasia.isHidden = false
            txtCNPJ.isHidden = false
            txtCEPPizzaria.isHidden = false
            txtRuaPizzaria.isHidden = false
            txtNumeroPizzaria.isHidden = false
            txtBairroPizzaria.isHidden = false
            txtCidadePizzaria.isHidden = false
            txtEstadoPizzaria.isHidden = false
            lblTelefonePizzaria.isHidden = false
            txtDDIPizzaria.isHidden = false
            txtDDDPizzaria.isHidden = false
            txtTelefonePizzaria.isHidden = false
            
        }else{
            lblRazaoSocial.isHidden = true
            lblNomeFantasia.isHidden = true
            lblCNPJ.isHidden = true
            lblCEPPizzaria.isHidden = true
            lblRuaPizzaria.isHidden = true
            lblNumeroPizzaria.isHidden = true
            lblBairroPizzaria.isHidden = true
            lblCidadePizzaria.isHidden = true
            lblEstadoPizzaria.isHidden = true
            
            txtRazaoSocial.isHidden = true
            txtNomeFantasia.isHidden = true
            txtCNPJ.isHidden = true
            txtCEPPizzaria.isHidden = true
            txtRuaPizzaria.isHidden = true
            txtNumeroPizzaria.isHidden = true
            txtBairroPizzaria.isHidden = true
            txtCidadePizzaria.isHidden = true
            txtEstadoPizzaria.isHidden = true
            lblTelefonePizzaria.isHidden = true
            txtDDIPizzaria.isHidden = true
            txtDDDPizzaria.isHidden = true
            txtTelefonePizzaria.isHidden = true
        }
    }
    
    func validaTextFilds(){
        if editarUsuario != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            txtNome.text = editarUsuario.nome
            txtCPF.text = editarUsuario.cpf
            txtDataNascimento.text = editarUsuario.dataNascimento
            txtEmail.text = editarUsuario.email
            txtSenha.text = LoginViewModel.shared.users[0].senha
            txtDDI.text = editarUsuario.ddi
            txtDDD.text = editarUsuario.ddd
            txtTelefone.text = editarUsuario.telefone
            txtCEP.text = editarUsuario.cep
            txtRua.text = editarUsuario.rua
            txtNumero.text = editarUsuario.numero
            txtRua.text = editarUsuario.rua
            txtBairro.text = editarUsuario.bairro
            txtCidade.text = editarUsuario.cidade
            txtEstado.text = editarUsuario.estado
            swtEmpresa.setOn(editarUsuario.pizzaria!, animated: true)
            if editarUsuario.pizzaria == true {
                txtRazaoSocial.text = editarUsuario.razaoSocial
                txtNomeFantasia.text = editarUsuario.nomeFantasia
                txtCNPJ.text = editarUsuario.cnpj
                txtCEPPizzaria.text = editarUsuario.cepPizzaria
                txtRuaPizzaria.text = editarUsuario.ruaPizzaria
                txtNumeroPizzaria.text = editarUsuario.numeroPizzaria
                txtBairroPizzaria.text = editarUsuario.bairroPizzaria
                txtCidadePizzaria.text = editarUsuario.cidadePizzaria
                txtEstadoPizzaria.text = editarUsuario.estadoPizzaria
                txtDDIPizzaria.text = editarUsuario.ddiPizzaria
                txtDDDPizzaria.text = editarUsuario.dddPizzaria
                txtTelefonePizzaria.text = editarUsuario.telefonePizzaria
            }else{
                txtRazaoSocial.text = ""
                txtNomeFantasia.text = ""
                txtCNPJ.text = ""
                txtCEPPizzaria.text = ""
                txtRuaPizzaria.text = ""
                txtNumeroPizzaria.text = ""
                txtBairroPizzaria.text = ""
                txtCidadePizzaria.text = ""
                txtEstadoPizzaria.text = ""
                txtDDIPizzaria.text = ""
                txtDDDPizzaria.text = ""
                txtTelefonePizzaria.text = ""
            }
            lblEmail.isHidden = true
            txtEmail.isHidden = true
            lblSenha.isHidden = true
            txtSenha.isHidden = true
            btnCadastrar.setTitle("Alterar", for: .normal)
        }else { //Descomentar quando acabar os testes.
            txtNome.text = ""
            txtCPF.text = ""
            txtDataNascimento.text = ""
            txtEmail.text = ""
            txtSenha.text = ""
            txtDDI.text = ""
            txtDDD.text = ""
            txtTelefone.text = ""
            txtCEP.text = ""
            txtRua.text = ""
            txtNumero.text = ""
            txtRua.text = ""
            txtBairro.text = ""
            txtCidade.text = ""
            txtEstado.text = ""
            swtEmpresa.setOn(false, animated: true)
            txtRazaoSocial.text = ""
            txtNomeFantasia.text = ""
            txtCNPJ.text = ""
            txtCEPPizzaria.text = ""
            txtRuaPizzaria.text = ""
            txtNumeroPizzaria.text = ""
            txtBairroPizzaria.text = ""
            txtCidadePizzaria.text = ""
            txtEstadoPizzaria.text = ""
            txtDDIPizzaria.text = ""
            txtDDDPizzaria.text = ""
            txtTelefonePizzaria.text = ""
            btnCadastrar.setTitle("Cadastrar", for: .normal)
        }
        
        swtEmpresaOnOff()
    }
    
    func montaJson() -> [String : Any]? {
        
        var usuario: [String : Any] = [:]
        
        var camposObrigatorios : Bool = false
        
        if swtEmpresa.isOn {
            
            if txtNome.text == "" || txtCPF.text == "" || txtDataNascimento == nil || txtEmail.text == "" || txtSenha.text == "" || (txtSenha.text?.count)! < 6 || txtDDI.text == "" || txtDDD.text == "" || txtTelefone.text == "" || txtCEP.text == "" || txtRua.text == "" || txtNumero.text == "" || txtBairro.text == "" || txtCidade.text == "" || txtEstado.text == "" || txtRazaoSocial.text == "" || txtNomeFantasia.text == "" || txtCNPJ.text == "" || txtCEPPizzaria.text == "" || txtRuaPizzaria.text == "" || txtNumeroPizzaria.text == "" || txtBairroPizzaria.text == "" || txtCidadePizzaria.text == "" || txtEstadoPizzaria.text == "" || txtDDIPizzaria.text == "" || txtDDDPizzaria.text == "" || txtTelefonePizzaria.text == ""{
                
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
                    "Nome": txtNome.text! as String,
                    "CPF": txtCPF.text! as String,
                    "DataNascimento": txtDataNascimento.text! as String,
                    "Email": txtEmail.text! as String,
                    "Rua": txtRua.text! as String,
                    "Numero": txtNumero.text! as String,
                    "CEP": txtCEP.text! as String,
                    "Bairro": txtBairro.text! as String,
                    "Cidade": txtCidade.text! as String,
                    "Estado": txtEstado.text! as String,
                    "DDI": txtDDI.text! as String,
                    "DDD": txtDDD.text! as String,
                    "Telefone": txtTelefone.text! as String,
                    "Pizzaria": swtEmpresa.isOn,
                    "RazaoSocial": txtRazaoSocial.text! as String,
                    "NomeFantasia": txtNomeFantasia.text! as String,
                    "CNPJ": txtCNPJ.text! as String,
                    "CEPPizzaria": txtCEPPizzaria.text! as String,
                    "RuaPizzaria": txtRuaPizzaria.text! as String,
                    "NumeroPizzaria": txtNumeroPizzaria.text! as String,
                    "BairroPizzaria": txtBairroPizzaria.text! as String,
                    "CidadePizzaria": txtCidadePizzaria.text! as String,
                    "EstadoPizzaria": txtEstadoPizzaria.text! as String,
                    "DDIPizzaria": txtDDI.text! as String,
                    "DDDPizzaria": txtDDD.text! as String,
                    "TelefonePizzaria": txtTelefonePizzaria.text! as String
                ]
                return usuario
            }
            
        }else{
            if txtNome.text == "" || txtCPF.text == "" || txtDataNascimento == nil || txtEmail.text == "" || txtSenha.text == "" || (txtSenha.text?.count)! < 6 || txtDDI.text == "" || txtDDD.text == "" || txtTelefone.text == "" || txtCEP.text == "" || txtRua.text == "" || txtNumero.text == "" || txtBairro.text == "" || txtCidade.text == "" || txtEstado.text == ""{
                
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
                    "Nome": txtNome.text! as String,
                    "CPF": txtCPF.text! as String,
                    "DataNascimento": txtDataNascimento.text! as String,
                    "Email": txtEmail.text! as String,
                    "Rua": txtRua.text! as String,
                    "Numero": txtNumero.text! as String,
                    "CEP": txtCEP.text! as String,
                    "Bairro": txtBairro.text! as String,
                    "Cidade": txtCidade.text! as String,
                    "Estado": txtEstado.text! as String,
                    "DDI": txtDDI.text! as String,
                    "DDD": txtDDD.text! as String,
                    "Telefone": txtTelefone.text! as String,
                    "Pizzaria": swtEmpresa.isOn
                ]
                return usuario
            }
        }
    }
    
    /*
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
     */
}
