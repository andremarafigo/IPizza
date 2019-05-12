//
//  LoginViewModel.swift
//  IPizza
//
//  Created by André Marafigo on 01/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import CoreData

let USERINFO = "users_info"

class LoginViewModel {

    static let shared = LoginViewModel()
    
    var contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var database : DatabaseReference!
    
    var users : [User] = []
    var user : User!
    
    let usuario = Usuarios()
    
    init() {
        loadData()
        if users.count > 0 {
            if users[0].email != nil {
                loadDataFireBase(valida: false, owner: nil, key: users[0].key!, email: users[0].email!, senha: users[0].senha!)
            }
        }
    }
    
    func login (owner: LoginViewController, email: String, senha: String){
        var x: Bool = false
        
        Auth.auth().signIn(withEmail: email, password: senha) { (result, error) in
            
            guard let user = result?.user
                else {
                    print(error!)
                    let alert = UIAlertController(title: "Usuário ou Senha inválidos.", message: "Tente novamente!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    }))
                    
                    // show the alert
                    owner.present(alert, animated: true, completion: nil)
                    return
            }
        
            print("Deu certo")
            
            Analytics.setUserProperty("sim", forName: "Entrou")
            
            Analytics.logEvent("login", parameters: ["nome: ": email])
            
            x = true
            self.loadDataFireBase(valida: x, owner: owner, key: user.uid, email: email, senha: senha)
            
            //self.salvaUserCoreData(valida: x, key: user.uid, usuario: email, password: senha)
        }
    }
    
    func loadDataFireBase(valida: Bool, owner: LoginViewController!, key: String, email: String, senha: String){
        
        database = Database.database().reference()
        self.database.child("Usuarios").child(key).observe(.value, with: { (snapshot: DataSnapshot) in
            if let value = snapshot.value as? [String : Any] {
                
                self.usuario.nome = value["Nome"] as? String
                self.usuario.cpf = value["CPF"] as? String
                self.usuario.dataNascimento = value["DataNascimento"] as? String
                self.usuario.email = value["Email"] as? String
                self.usuario.ddi = value["DDI"] as? String
                self.usuario.ddd = value["DDD"] as? String
                self.usuario.telefone = value["Telefone"] as? String
                self.usuario.cep = value["CEP"] as? String
                self.usuario.rua = value["Rua"] as? String
                self.usuario.numero = value["Numero"] as? String
                self.usuario.bairro = value["Bairro"] as? String
                self.usuario.cidade = value["Cidade"] as? String
                self.usuario.estado = value["Estado"] as? String
                self.usuario.pizzaria = value["Pizzaria"] as? Bool
                if self.usuario.pizzaria == true {
                    self.usuario.razaoSocial = value["RazaoSocial"] as? String
                    self.usuario.nomeFantasia = value["NomeFantasia"] as? String
                    self.usuario.cnpj = value["CNPJ"] as? String
                    self.usuario.cepPizzaria = value["CEPPizzaria"] as? String
                    self.usuario.ruaPizzaria = value["RuaPizzaria"] as? String
                    self.usuario.numeroPizzaria = value["NumeroPizzaria"] as? String
                    self.usuario.bairroPizzaria = value["BairroPizzaria"] as? String
                    self.usuario.cidadePizzaria = value["CidadePizzaria"] as? String
                    self.usuario.estadoPizzaria = value["EstadoPizzaria"] as? String
                    self.usuario.ddiPizzaria = value["DDIPizzaria"] as? String
                    self.usuario.dddPizzaria = value["DDDPizzaria"] as? String
                    self.usuario.telefonePizzaria = value["TelefonePizzaria"] as? String
                }
                if self.users.count > 0 {
                    if self.users[0].email != email {
                        self.salvaUserCoreData(key: key, usuario: email, password: senha, pizzaria: self.usuario.pizzaria!)
                    }
                }else {
                    self.salvaUserCoreData(key: key, usuario: email, password: senha, pizzaria: self.usuario.pizzaria!)
                }
                
                if valida == true {
                    owner.navigationController?.popViewController(animated: true)
                }
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: USERINFO), object: nil, userInfo: ["usuario": self.usuario])
            }
        })
    }
    
    func salvaUserCoreData(key: String, usuario: String, password: String, pizzaria: Bool) {
        user = User (context: contexto)
        user.key = key
        user.email = usuario
        user.senha = password
        user.pizzaria = pizzaria
        if users.count > 0 {
            users[0] = user
        }else{
            users.append(user)
        }
        saveData()
    }
    
    func saveData() {
        do {
            try contexto.save()
        } catch  {
            print("Erro ao salvar o contexto: \(error) ")
        }
        //loadData()
    }
    
    func deleteData() {
        contexto.delete(users[0])
        saveData()
        //loadData()
    }
    
    func loadData() {
        let requestUser: NSFetchRequest<User> = User.fetchRequest()
        do
        {
            print(users)
            let usurs = try contexto.fetch(requestUser)
            print(usurs)
            users = usurs
            print(users)
        }
        catch
        {
            print("Erro: \(error)")
        }
    }
}
