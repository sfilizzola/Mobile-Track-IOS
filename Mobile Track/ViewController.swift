//
//  ViewController.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 01/10/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,  UITextViewDelegate {

    @IBOutlet weak var txtUsuario: UITextField!
    
    @IBOutlet weak var txtSenha: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtSenha.delegate = self
        self.txtUsuario.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLogin(sender: UIButton)
    {
        fazLogin()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == txtUsuario{
            txtSenha.becomeFirstResponder()
        } else if textField == txtSenha {
            textField.resignFirstResponder()
            fazLogin()
        }
        
        textField.resignFirstResponder()
        return true
    }

    func verificaLogin (NomeUsuario:String, SenhaUsuario:String) -> (Logado:Bool, SituacaoErro:String) {
        
        var erroLogin:String = ""
        var IsLogado:Bool = false
        
        if NomeUsuario.isEmpty
        {
            erroLogin = "Nome do usuario em branco"
        }
        else if SenhaUsuario.isEmpty
        {
            erroLogin = "Senha em Branco"
        }
        
        if erroLogin.isEmpty
        {
            var objLogin:Login = Login()
            var usuarioSistema:Usuario? = objLogin.validaLogin(NomeUsuario, SenhaUsuario: SenhaUsuario)
        
            if usuarioSistema == nil
            {
                erroLogin = "usuario ou senha invalidos, favor tentar novamente."
            } else {
                //TODO setar usuario logado nas preferencias
                IsLogado = true
            }
        }
        return (IsLogado, erroLogin)
        
    }
    
    
    func fazLogin (){
        
        let logData = verificaLogin(txtUsuario.text, SenhaUsuario: txtSenha.text)
        
        
        if logData.Logado
        {
            //chama na mao
           var mvc = self.storyboard?.instantiateViewControllerWithIdentifier("TelaMapa") as MainViewController
           self.presentViewController(mvc, animated: true, completion: nil)
            
        }
        else
        {
            var alert:UIAlertController = UIAlertController(title: "Login invalido", message: logData.SituacaoErro, preferredStyle: UIAlertControllerStyle.Alert)
            
            var alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            
            alert.addAction(alertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }


}

