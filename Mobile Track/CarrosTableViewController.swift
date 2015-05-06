//
//  CarrosTableViewController.swift
//  Mobile Track
//
//  Created by Samuel Filizzola on 27/11/14.
//  Copyright (c) 2014 ECX Card. All rights reserved.
//

import UIKit

class CarrosTableViewController: UITableViewController, UISearchBarDelegate {
    
    var listaSelecionado:[Veiculo]?
    var usuarioLogado:Usuario?
    var detailVC:MainViewController?
    
    @IBOutlet weak var busca: UISearchBar!
    
    override func viewWillAppear(animated: Bool) {
        
        
        //se for iPad
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            if detailVC != nil
            {
                var funcBarButton:UIBarButtonItem = UIBarButtonItem(title: "Opções", style: UIBarButtonItemStyle.Plain, target: detailVC!, action: "DisparaFuncoes")
                self.navigationItem.rightBarButtonItem = funcBarButton;
            }
        }
        
        if (listaSelecionado == nil)
        {
            NSThread.detachNewThreadSelector("ListaVeiculos", toTarget: self, withObject: nil)
        }
    }
    
    func ListaVeiculos ()
    {
        var userPrefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var CodUsuarioLogado:Int = userPrefs.integerForKey("CodUsuarioLogado")

        var DALVeiculos:Veiculos = Veiculos()
        listaSelecionado = DALVeiculos.VeiculosPorUsuario(CodUsuarioLogado)
        
        //Agora precisa disso
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if listaSelecionado != nil
        {
            return listaSelecionado!.count
        }
        else
        {
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CelulaCarro", forIndexPath: indexPath) as! UITableViewCell

        let carroAtual:Veiculo = listaSelecionado![indexPath.row]
        
        cell.textLabel?.text = carroAtual.Placa
        
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        //TODO - filtra lista
        /*listaSelecionado = listaSelecionado!.filter({
            v in v.Placa!.        })*/
        
        NSLog(searchText)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) // called when keyboard search button pressed
    {
        searchBar.resignFirstResponder()
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow()
            {
                busca.resignFirstResponder()
                let carroSelecionado:Veiculo = listaSelecionado![indexPath.row] as Veiculo
                let controler:MainViewController = segue.destinationViewController as! MainViewController
                
                controler.veiculoSelecionado = carroSelecionado
                /*let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! MainViewController).topViewController as! MainViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true*/
            }
        }
    }
    

}
