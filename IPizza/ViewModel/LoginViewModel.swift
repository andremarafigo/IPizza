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
    
    init() {
        loadData()
    }
    
    func login (owner: LoginViewController, email: String, senha: String){
        var x: Bool = false
        
        Auth.auth().signIn(withEmail: email, password: senha) { (result, error) in
            
            guard let user = result?.user
                else {
                    print(error!)
                    return
            }
            
            print("Deu certo")
            
            Analytics.setUserProperty("sim", forName: "Entrou")
            
            Analytics.logEvent("login", parameters: ["nome: ": email])
            
            self.loadDataFireBase(key: user.uid)
            
            x = true
            
            self.salvaUserCoreData(valida: x, key: user.uid, usuario: email, password: senha)
            
            owner.navigationController?.popViewController(animated: true)
        }
    }
    
    func loadDataFireBase(key: String){
        self.database.child("Usuarios").child(key).observe(.value, with: { (snapshot: DataSnapshot) in
            if let value = snapshot.value as? [String : Any] {
                var usuarios = [Usuarios]()
                let usuario = Usuarios()
                
                usuario.nome = value["Nome"] as? String
                usuario.cpf = value["CPF"] as? String
                usuario.dataNascimento = value["DataNascimento"] as? String
                usuario.email = value["Email"] as? String
                usuario.ddi = value["DDI"] as? String
                usuario.ddd = value["DDD"] as? String
                usuario.telefone = value["Telefone"] as? String
                usuario.cep = value["CEP"] as? String
                usuario.rua = value["Rua"] as? String
                usuario.numero = value["Numero"] as? String
                usuario.bairro = value["Bairro"] as? String
                usuario.cidade = value["Cidade"] as? String
                usuario.estado = value["Estado"] as? String
                usuario.pizzaria = value["Pizzaria"] as? Bool
                if usuario.pizzaria == true {
                    usuario.razaoSocial = value["RazaoSocial"] as? String
                    usuario.nomeFantasia = value["NomeFantasia"] as? String
                    usuario.cnpj = value["CNPJ"] as? String
                    usuario.cepPizzaria = value["CEPPizzaria"] as? String
                    usuario.ruaPizzaria = value["RuaPizzaria"] as? String
                    usuario.numeroPizzaria = value["NumeroPizzaria"] as? String
                    usuario.bairroPizzaria = value["BairroPizzaria"] as? String
                    usuario.cidadePizzaria = value["CidadePizzaria"] as? String
                    usuario.estadoPizzaria = value["EstadoPizzaria"] as? String
                    usuario.ddiPizzaria = value["DDIPizzaria"] as? String
                    usuario.dddPizzaria = value["DDDPizzaria"] as? String
                    usuario.telefonePizzaria = value["TelefonePizzaria"] as? String
                }
                
                usuarios.append(usuario)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: USERINFO), object: nil, userInfo: ["usuarios": usuarios])
            }
        })
    }
    
    func salvaUserCoreData(valida: Bool, key: String, usuario: String, password: String) {
        if valida == true {
            user = User (context: contexto)
            user.key = key
            user.email = usuario
            user.senha = password
            if users.count > 0 {
                users[0] = user
            }else{
                users.append(user)
            }
            saveData()
        }
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
