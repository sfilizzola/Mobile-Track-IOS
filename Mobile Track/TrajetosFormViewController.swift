//
//  TrajetosFormViewController.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 01/12/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import UIKit

class TrajetosFormViewController: UIViewController {

    var TopViewControler:MainViewController?
    
    
    @IBOutlet weak var dtInicial: UIDatePicker!
    @IBOutlet weak var dtFinal: UIDatePicker!
    
    @IBAction func btnContinuar(sender: UIBarButtonItem) {
        if TopViewControler != nil
        {
            self.dismissViewControllerAnimated(true, completion: {
                self.TopViewControler!.plotaTrajetos(self.dtInicial.date, dtFim: self.dtFinal.date)
            })
        }
    }
    
    @IBAction func btnCanacelar(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
