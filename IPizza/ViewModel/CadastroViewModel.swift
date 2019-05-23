//
//  CadastroViewModel.swift
//  IPizza
//
//  Created by André Marafigo on 01/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//a

import Foundation
import Firebase
import FirebaseDatabase
import Alamofire
import SwiftyJSON

class CadastroViewModel {
    
    static let shared = CadastroViewModel()
    
    var refUsuarios: DatabaseReference!
    
    init() {
        refUsuarios = Database.database().reference().child("Usuarios")
    }
    
    func createUsuario (owner: CadastroViewController, usuario: [String : Any]?, email: String, senha: String){
        //let key = refUsuarios.childByAutoId().key
        var key: String = ""
        Auth.auth().createUser(withEmail: email, password: senha) { (result, error) in
            
            guard (result?.user) != nil
                else {
                    print(error!)
                    let alert = UIAlertController(title: "E-mail já utilizado", message: "Favor informar um e-mail válido!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        owner.txtEmail.selectAll(owner)
                    }))
                    
                    // show the alert
                    owner.present(alert, animated: true, completion: nil)
                    return
            }
            print(MapaViewModel.shared.pizzarias.count)
            
            key = (result?.user.uid)!
            
            self.refUsuarios.child(key).setValue(usuario)
            
            let alert = UIAlertController(title: "Cadastro realizado com sucesso.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                owner.navigationController?.popViewController(animated: true)
                print(MapaViewModel.shared.pizzarias.count)
            }))
            
            // show the alert
            owner.present(alert, animated: true, completion: nil)
            //return
        }
        print(MapaViewModel.shared.pizzarias.count)
    }
    
    func alteraUsuario(owner: CadastroViewController, usuario: [String : Any]?) {
        refUsuarios.child(LoginViewModel.shared.users[0].key!).setValue(usuario)
            
        let alert = UIAlertController(title: "Cadastro alterado com sucesso.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            owner.navigationController?.popViewController(animated: true)
        }))
        
        // show the alert
        owner.present(alert, animated: true, completion: nil)
        return
    }
    
    //@IBAction func txtCepChanged(_ sender: Any) {
    func buscaEnderecoPorCEP(owner : CadastroViewController, cep : String, pizzaria: Bool) {
        
        //let urlBase = "http://cep.republicavirtual.com.br/web_cep.php?cep="
        let urlBase = "https://viacep.com.br/ws/"
        let cep = cep.replacingOccurrences(of: "-", with: "")
        //let final = "&formato=json"
        let final = "json"
        
        if cep.count == 8 {
            let url = "\(urlBase)/\(cep)/\(final)"
            
            Alamofire.request(url).responseJSON { (response) in
                
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    
                    if pizzaria == false {
                        owner.txtRua.text = json["logradouro"].stringValue
                        owner.txtBairro.text = json["bairro"].stringValue
                        owner.txtCidade.text = json["localidade"].stringValue
                        owner.txtEstado.text = self.trocaUFporNomeEstado(uf: json["uf"].stringValue)
                        print(json)
                        
                        owner.txtNumero.text = ""
                        owner.txtNumero.selectAll(owner)
                    }else {
                        owner.txtRuaPizzaria.text = json["logradouro"].stringValue
                        owner.txtBairroPizzaria.text = json["bairro"].stringValue
                        owner.txtCidadePizzaria.text = json["localidade"].stringValue
                        owner.txtEstadoPizzaria.text = self.trocaUFporNomeEstado(uf: json["uf"].stringValue)
                        print(json)
                        
                        owner.txtNumeroPizzaria.text = ""
                        owner.txtNumeroPizzaria.selectAll(owner)
                    }
                    
                }else if (response.result.error != nil){
                    print("Error buscar CEP -> \(response.result)")
                }else if response.result.isFailure{
                    print("Falha ao buscar CEP")
                }
            }
        }
    }
    
    func trocaUFporNomeEstado(uf: String) -> String{
        var nome : String = ""
        let nomes : [String: String] = [
            "AC": "Acre",
            "AL": "Alagoas",
            "AP": "Amapá",
            "AM": "Amazonas",
            "BA": "Bahia",
            "CE": "Ceará",
            "DF": "Distrito Federal",
            "ES": "Espírito Santo",
            "GO": "Goiás",
            "MA": "Maranhão",
            "MT": "Mato Grosso",
            "MS": "Mato Grosso do Sul",
            "MG": "Minas Gerais",
            "PA": "Pará",
            "PB": "Paraíba",
            "PR": "Paraná",
            "PE": "Pernambuco",
            "PI": "Piauí",
            "RJ": "Rio de Janeiro",
            "RN": "Rio Grande do Norte",
            "RS": "Rio Grande do Sul",
            "RO": "Rondônia",
            "RR": "Roraima",
            "SC": "Santa Catarina",
            "SP": "São Paulo",
            "SE": "Sergipe",
            "TO": "Tocantins"
        ]
        
        for (sigla, nomeCompleto) in nomes {
            if uf == sigla {
                nome = nomeCompleto
            }
        }
        
        return nome
    }
    
}
