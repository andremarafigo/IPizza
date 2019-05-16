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
                    return
            }
            print("Deu certo")
            
            key = (result?.user.uid)!
            
            self.refUsuarios.child(key).setValue(usuario)
            
            let alert = UIAlertController(title: "Cadastro realizado com sucesso.", message: "Clique em OK para continuar!", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                owner.navigationController?.popViewController(animated: true)
            }))
            
            // show the alert
            owner.present(alert, animated: true, completion: nil)
            //return
        }
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
    func buscaEnderecoPorCEP(owner : CadastroViewController, cep : String) {
        
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
                    
//                    self.cep.text = json["cep"].stringValue
//                    self.cidade.text = json["localidade"].stringValue
//                    self.endereco.text = json["logradouro"].stringValue
//                    self.estado.text = json["uf"].stringValue
                    print(json)
                    
                }else if (response.result.error != nil){
                    print("Error buscar CEP -> \(response.result)")
                }else if response.result.isFailure{
                    print("Falha ao buscar CEP")
                }
            }
        }
    }
    
}
