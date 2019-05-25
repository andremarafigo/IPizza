//
//  Pedido.swift
//  IPizza
//
//  Created by André Marafigo on 25/05/19.
//  Copyright © 2019 PUCPR. All rights reserved.
//

import Foundation

class Pedido {
    var n_pedido : Int = 0
    var key_usuario : String!
    var key_pizzaria : String!
    var valorTotal : Double = 0.0
    var formaDePagamento : String!
    var formaDeRetirada : String!
    var status : String!
    var pizza : [Sabor] = []
}
