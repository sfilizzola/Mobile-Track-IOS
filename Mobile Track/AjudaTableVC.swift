//
//  AjudaTableVC.swift
//  Mobile Track
//
//  Created by Vinicius Gontijo on 09/04/15.
//  Copyright (c) 2015 ECX Card. All rights reserved.
//

import UIKit
import MessageUI

class AjudaTableVC: UITableViewController, MFMailComposeViewControllerDelegate {

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
    @IBAction func ajudaUsoPressed(sender: UIButton) {
        
        let view2 = self.storyboard!.instantiateViewControllerWithIdentifier("PageViewVC") as! UIViewController
        
        self.navigationController!.pushViewController(view2, animated: true)
        
    }

    // MARK: - Table view data source

    @IBAction func telPressed(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://03130296444")!)
        
    }
    
    
    @IBAction func mailPressed(sender: UIButton) {
        
        if (MFMailComposeViewController.canSendMail()){
            var mailCompose: MFMailComposeViewController = MFMailComposeViewController()
            
            mailCompose.mailComposeDelegate = self
            
            mailCompose.setSubject("Sua dúvida...")
            mailCompose.setMessageBody("", isHTML: false)
            mailCompose.setToRecipients(["ecxtrack@ecx.com.br"])
            
            self.presentViewController(mailCompose, animated: true, completion: nil)
        }
        else{
            
            let alertSucesso = UIAlertView()
            alertSucesso.message = "Conta de email não configurada no dispositivo."
            alertSucesso.addButtonWithTitle("Ok")
            alertSucesso.delegate = self
            alertSucesso.show()
        }
        
    }
    
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError) {
        switch result.value {
        case MFMailComposeResultCancelled.value:
            println("Mail cancelled")
        case MFMailComposeResultSaved.value:
            println("Mail saved")
        case MFMailComposeResultSent.value:
            println("Mail sent")
        case MFMailComposeResultFailed.value:
            println("Mail sent failure: %@", [error.localizedDescription])
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    @IBAction func chatPressed(sender: UIButton) {
        
        Helpshift.installForApiKey("a21a303c81649ab4857be952523837ff", domainName: "ecxtrack.helpshift.com", appID: "ecxtrack_platform_20150406213738198-1af3f4bfd4f7581")
        
        Helpshift.sharedInstance().showConversation(self, withOptions: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
