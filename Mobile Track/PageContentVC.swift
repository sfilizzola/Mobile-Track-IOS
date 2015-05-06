//
//  PageContentVC.swift
//  Mobile Track
//
//  Created by Vinicius Gontijo on 29/04/15.
//  Copyright (c) 2015 ECX Card. All rights reserved.
//

import UIKit

class PageContentVC: UIViewController {

    @IBOutlet weak var imgGuia: UIImageView!
    //@IBOutlet weak var lblTitulo: UILabel!
    
    var pageIndex: NSInteger = 0
    var imagem: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgGuia.image = UIImage(named: self.imagem)

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
