//
//  Login.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 16/11/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import Foundation

class Login {
    let ws : Webservice
    
    init(){
        ws = Webservice()
    }
    
    func validaLogin (NomeUsuario:String, SenhaUsuario:String) -> Usuario? {
        var usu:Usuario?
        
        usu = ws.Login(NomeUsuario, Senha: SenhaUsuario)
        
        if usu == nil || usu?.Status == nil{
            NSLog("usuario ou senha invalidos")
        }
        
        return usu
    }
}
