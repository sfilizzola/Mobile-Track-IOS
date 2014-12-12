//
//  SplitViewController.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 27/11/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {
    
    var usuarioLogado:Usuario?
    var veiculosCliente:[Veiculo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var DetailVC:MainViewController?
        
        if segue.destinationViewController.isKindOfClass(MainViewController) {
            var destViewController:MainViewController = segue.destinationViewController as MainViewController
            destViewController.usuarioLogado = self.usuarioLogado
            DetailVC = destViewController
        }
        
        if segue.destinationViewController.isKindOfClass(CarrosTableViewController)
        {
            var destViewController:CarrosTableViewController = segue.destinationViewController as CarrosTableViewController
            destViewController.usuarioLogado = self.usuarioLogado
            if DetailVC != nil
            {
                destViewController.detailVC = DetailVC
            }
        }
    }
   

}
