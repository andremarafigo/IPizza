//
//  Usuarios.swift
//  IPizza
//
//  Created by André Marafigo on 01/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation

class Usuarios {
    var nome : String
    var cpf : String
    var dataNascimento : Date
    var email : String
    var senha : String
    var enderecos : [String]
    var telefones : [String]
    var pizzaria : Bool
    var razaoSocial : String
    var nomeFantasia : String
    var cnpj : String
    var cep : String
    var rua : String
    var numero : Int
    var bairro : String
    var cidade : String
    var estado : String
    var telefonesEmpresa : [String]
    
    init() {
        nome = ""
        cpf = ""
        dataNascimento = Date()
        email = ""
        senha = ""
        enderecos = []
        telefones = []
        pizzaria = false
        razaoSocial = ""
        nomeFantasia = ""
        cnpj = ""
        cep = ""
        rua = ""
        numero = 0
        bairro = ""
        cidade = ""
        estado = ""
        telefonesEmpresa = []
    }
}
