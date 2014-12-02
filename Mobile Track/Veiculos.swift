//
//  Veiculos.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 16/11/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import Foundation

class Veiculos {
    
    let ws : Webservice

    init(){
        ws = Webservice()
    }
    
    func VeiculosPorUsuario (CodUsuario:Int) -> [Veiculo]
    {
        return ws.VeiculosPorCliente(CodUsuario)
    }
    
    func UltimoEventoVeiculo(veic:Veiculo) -> Evento? {
        return ws.UltimaLocalizacaoVeiculo(veic.CodVeiculo!)
    }
    
    func Trajetos(DataInicial:NSDate, DataFinal:NSDate, CodVeiculo:Int) -> [Evento]
    {
        return ws.Trajetos(DataInicial, DataFinal: DataFinal, CodVeiculo: CodVeiculo)
    }
}