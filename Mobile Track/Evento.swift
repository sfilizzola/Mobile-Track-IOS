//
//  Evento.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 16/11/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import Foundation

class Evento {
    var CodCliente : Int
    var CodEquipamento : Int
    var CodEvento : Int64
    var CodVeiculo : Int
    var Hodometro : Int
    var Latitude : Double
    var Longitude: Double
    var dataEvento: NSDate?
    var StatusIgnicao: Bool?
    
    init(){
        CodCliente = 0;
        CodEquipamento = 0;
        CodEvento = 0;
        CodVeiculo = 0;
        Hodometro = 0;
        Latitude = 0.0;
        Longitude = 0.0;
    }
    
}