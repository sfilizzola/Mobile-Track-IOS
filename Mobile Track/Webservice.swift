//
//  Webservice.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 09/11/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import Foundation


class Webservice {
    let ServerURL:String = "http://www.trackecx.com:7090/RestService.svc"
    
    
    var usuarioLogin:Usuario?
    
    init(){}
    
    func Login (NomeUsuario:String, Senha:String ) -> Usuario? {
        
        
        var method:String = "/LoginJSON/\(NomeUsuario.lowercaseString)/\(Senha)";
        
        var UrlCompleta:String = ServerURL + method
        
        var url:NSURL! = NSURL(string: UrlCompleta)
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        var response:NSURLResponse?
        var responseError:NSError?
        var usu: Usuario?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &responseError)
        
        if (urlData != nil){
            var error:NSError?
        
            let jsonResponse:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
            let jsonData: NSDictionary = jsonResponse.valueForKey("LoginJSONResult") as NSDictionary

            var Status:NSString = jsonData.valueForKey("Status") as NSString
        
        
        
            if Status == "OK"
            {
                usu = Usuario()
                usu?.Nome = (jsonData.valueForKey("Nome") as NSString)
                usu?.Email = (jsonData.valueForKey("Email") as NSString)
                usu?.CodUsuario = jsonData.valueForKey("CodUsuario") as NSInteger
                usu?.Status = Status
            }
        }
        return usu
    }
    
    func UltimaLocalizacaoVeiculo (CodVeiculo:Int) -> Evento? {
       
        //METHOD_NAME = "";
        
        var method:String = "/UltimaLocalizacaoVeiculoJSON/\(CodVeiculo)";
        
        var UrlCompleta:String = ServerURL + method
        
        var url:NSURL! = NSURL(string: UrlCompleta)
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        var response:NSURLResponse?
        var responseError:NSError?
        
        var evento:Evento?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &responseError)
        
        if (urlData != nil){
            var error:NSError?
            
            let jsonResponse:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
            let jsonData: NSDictionary = jsonResponse.valueForKey("UltimaLocalizacaoVeiculoJSONResult") as NSDictionary
            
            if jsonData.count != 0
            {
                evento = Evento()
                evento?.CodCliente = jsonData.valueForKey("CodCliente") as Int
                evento?.CodEquipamento = jsonData.valueForKey("CodEquipamento") as Int
                evento?.CodEvento = jsonData.valueForKey("CodEvento") as Int
                evento?.CodVeiculo = jsonData.valueForKey("CodVeiculo") as Int
               // evento?.dataEvento = (jsonData.valueForKey("DataEvento") as NSDate)
                evento?.Hodometro = jsonData.valueForKey("Hodometro") as Int
                evento?.Latitude = jsonData.valueForKey("Latitude") as Double
                evento?.Longitude = jsonData.valueForKey("Longitude") as Double
                evento?.StatusIgnicao = (jsonData.valueForKey("StatusIgnicao") as Bool)
 
            }
            
        }
        return evento
    }
    
    func VeiculosPorCliente (CodUsuario:Int) -> [Veiculo]
    {
        return VeiculosPorCliente(CodUsuario, IsClienteAdicional: false)
    }
    
    func VeiculosPorCliente (CodUsuario:Int, IsClienteAdicional:Bool) -> [Veiculo]
    {
        var BooleanResult:String
        if IsClienteAdicional
        {
            BooleanResult = "true"
        } else {
            BooleanResult = "false"
        }
        
        
        //CodVeiculo
        var method:String = "/VeiculosPorClienteJSON/\(CodUsuario)/\(BooleanResult)";
        
        var UrlCompleta:String = ServerURL + method
        
        var url:NSURL! = NSURL(string: UrlCompleta)
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        var response:NSURLResponse?
        var responseError:NSError?
        
        var listaVeiculos:[Veiculo] = [Veiculo]()
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &responseError)
        
        if (urlData != nil){
            var error:NSError?
            
            let jsonResponse:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
            let jsonData: NSArray = jsonResponse.valueForKey("VeiculosPorClienteJSONResult") as NSArray
            
            for item in jsonData
            {
                var carro:Veiculo = Veiculo()
                carro.Placa =  (item.valueForKey("Placa") as String)
                carro.CodVeiculo = (item.valueForKey("CodVeiculo") as Int)
                listaVeiculos.append(carro);
            }
            
        }
        
        return listaVeiculos

    }
    
    func Trajetos (DataInicial:NSDate, DataFinal:NSDate, CodVeiculo:Int) -> [Evento] {
        
        let timeZone = NSTimeZone(name: "UTC-3")
        
        var dateFormatterAno:NSDateFormatter = NSDateFormatter()
        
        dateFormatterAno.dateFormat = "dd-MM-YYYY$HH-mm-ss"
        
        var dtIni: String = dateFormatterAno.stringFromDate(DataInicial)
        var dtFim: String = dateFormatterAno.stringFromDate(DataFinal)
    
        var method:String = "/ListaPontosPeriodoJSON/\(dtIni)/\(dtFim)/\(CodVeiculo)";
        
        //var method:String = "/ListaPontosPeriodoJSON/01-12-2014$08-00-00/01-12-2014$17-00-00/12";
        
        var UrlCompleta:String = ServerURL + method
        
        var url:NSURL! = NSURL(string: UrlCompleta)
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
              
        var response:NSURLResponse?
        var responseError:NSError?
       
        var teste:String
        
        var listaEventos : [Evento] = [Evento]()
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &responseError)
        
        if (urlData != nil){
            var error:NSError?
            
            let jsonResponse:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
            let jsonData: NSArray = jsonResponse.valueForKey("ListaPontosPeriodoJSONResult") as NSArray
            
            for item in jsonData
            {
                var evt:Evento = Evento()
                evt.Hodometro = item.valueForKey("Hodometro") as Int
                evt.Latitude = item.valueForKey("Latitude") as Double
                evt.Longitude = item.valueForKey("Longitude") as Double
                
                listaEventos.append(evt);
            }
            
        }
        
        return listaEventos
    }

    
    /*func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!) {
        NSLog("Element's name is \(elementName)")
        NSLog("Element's attributes are \(attributeDict)")
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        NSLog("foundCharacters \(string)")
    }*/
    
    
    
    
    
    
    
    
}