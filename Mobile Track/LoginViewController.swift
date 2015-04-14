//
//  ViewController.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 01/10/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate,  UITextViewDelegate {

    @IBOutlet weak var txtUsuario: UITextField!
    
    @IBOutlet weak var txtSenha: UITextField!
    
    @IBOutlet weak var indicador: UIActivityIndicatorView!
    
    @IBOutlet weak var lembrarSlider: UISwitch!
    
    @IBAction func lembrarChangeEvent(sender: UISwitch) {
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(sender.on, forKey: "lembrarChecked")
        
    }
    var usuarioLogado:Usuario?
    
    var StringErro:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtSenha.delegate = self
        self.txtUsuario.delegate = self
        self.indicador.hidesWhenStopped = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var UserName: String? = userDefaults.valueForKey("UserName") as! String?
        var UserPassword: String? = userDefaults.valueForKey("UserPassword") as! String?
        var lembrar:Bool? = userDefaults.valueForKey("lembrarChecked") as! Bool?
        
        if lembrar != nil
        {
            if lembrar! && UserName != nil
            {
                self.txtUsuario.text = UserName
                self.txtSenha.text = UserPassword
                self.lembrarSlider.setOn(true, animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLogin(sender: UIButton)
    {
        self.indicador.startAnimating()
        NSThread.detachNewThreadSelector("fazLogin", toTarget: self, withObject: nil)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == txtUsuario{
            txtSenha.becomeFirstResponder()
        } else if textField == txtSenha {
            textField.resignFirstResponder()
            self.indicador.startAnimating()
            NSThread.detachNewThreadSelector("fazLogin", toTarget: self, withObject: nil)
        }
        
        textField.resignFirstResponder()
        return true
    }

    func verificaLogin (NomeUsuario:String, SenhaUsuario:String) -> (Logado:Bool, SituacaoErro:String, CodUsuario:Int) {
        
        var erroLogin:String = ""
        var IsLogado:Bool = false
        var CodUsuario:Int = 0
        
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
                
                let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setInteger(usuarioSistema!.CodUsuario, forKey: "CodUsuarioLogado")
                
                if lembrarSlider.on
                {
                    userDefaults.setObject(NomeUsuario, forKey: "UserName")
                    userDefaults.setObject(SenhaUsuario, forKey: "UserPassword")
                }
                self.usuarioLogado = usuarioSistema
                IsLogado = true
                CodUsuario = usuarioSistema!.CodUsuario;
            }
        }
        return (IsLogado, erroLogin, CodUsuario)
        
    }
    
    
    func fazLogin (){
        
        let logData = verificaLogin(txtUsuario.text, SenhaUsuario: txtSenha.text)
        
        
        if logData.Logado
        {
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.carregaview()
            })
        }
        else
        {
            self.StringErro = logData.SituacaoErro
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.carregaAlerta()
            })
        }
        self.indicador.stopAnimating()
    }
    
    func carregaview(){
        //chama na mao
        var mvc = self.storyboard?.instantiateViewControllerWithIdentifier("SplitViewController") as! SplitViewController
        mvc.usuarioLogado = self.usuarioLogado
    
        self.presentViewController(mvc, animated: true, completion: nil)
    }
    
    func carregaAlerta(){
        
        var alert:UIAlertController = UIAlertController(title: "Login invalido", message: self.StringErro!, preferredStyle: UIAlertControllerStyle.Alert)
        
        var alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(alertAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }


}

