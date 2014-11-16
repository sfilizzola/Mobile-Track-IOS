//
//  Usuario.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 16/11/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import Foundation

class Usuario {
    var CodUsuario: Int
    var Nome: String?
    var CPF: String?
    var Email: String?
    var Senha: String?
    var dtValidade: NSDate
    var Status: String? 
    
    init() {
        CodUsuario = 0
        dtValidade = NSDate()
    }
    
    
}
