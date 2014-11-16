//
//  Webservice.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 09/11/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import Foundation


class Webservice {
    let ServerURL:String = "http://www.trackecx.com:8090/EcxTrackAppServices.svc"
    let NAMESPACE:String = "http://tempuri.org/"
    var SOAP_ACTION:String?
    var METHOD_NAME:String?
    
    init(){}
    
    func Login (NomeUsuario:String, Senha:String ) -> Usuario? {
        
        SOAP_ACTION = "http://tempuri.org/IEcxTrackAppServices/Login";
        METHOD_NAME = "Login";
        
        var usuario: Usuario?
        //TODO - Implementar conexao Webservice de login
        
        return usuario
    }
    
    func UltimaLocalizacaoVeiculo (CodVeiculo:Int) -> Evento? {
        
        SOAP_ACTION = "http://tempuri.org/IEcxTrackAppServices/UltimaLocalizacaoVeiculo";
        METHOD_NAME = "UltimaLocalizacaoVeiculo";
        
        var evento:Evento?
        
        //TODO - implementar conexao Webservice busca Evento
        
        return evento
    }
    
    func VeiculosPorCliente (CodUsuario:Int) -> Array<Veiculo>
    {
        return VeiculosPorCliente(CodUsuario, IsClienteAdicional: false)
    }
    
    func VeiculosPorCliente (CodUsuario:Int, IsClienteAdicional:Bool) -> Array<Veiculo>
    {
        //CodVeiculo
        SOAP_ACTION = "http://tempuri.org/IEcxTrackAppServices/VeiculosPorCliente";
        METHOD_NAME = "VeiculosPorCliente";
        
        var listaVeiculos:Array<Veiculo> = Array<Veiculo>()
        
        //TODO - implementar conexao webservice lista de veiculos
        
        return listaVeiculos

    }
    
    func Trajetos (DataInicial:NSDate, DataFinal:NSDate, CodVeiculo:Int) -> Array<Evento> {
        SOAP_ACTION = "http://tempuri.org/IEcxTrackAppServices/ListaPontosPeriodo";
        METHOD_NAME = "ListaPontosPeriodo";
        
        var listaEventos : Array<Evento> = Array<Evento>()
        
        //TODO - implementar conexao com webservice para retorno de trajetos
        
        return listaEventos
    }
    
    
    
    
    
    
    
    
}