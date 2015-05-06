//
//  PageViewVC.swift
//  Mobile Track
//
//  Created by Vinicius Gontijo on 29/04/15.
//  Copyright (c) 2015 ECX Card. All rights reserved.
//

import UIKit

class PageViewVC: UIViewController, UIPageViewControllerDataSource {

    var pageVC: UIPageViewController?
    var pageImages: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageImages = ["01.png", "02.png"];
        
        // Create page view controller
        self.pageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PageVC") as? UIPageViewController
        
        //self.pageVC! = self.storyboard!.instantiateViewControllerWithIdentifier("PageVC") as! UIPageViewController
        
        
        self.pageVC!.dataSource = self
        
        let startingVC: PageContentVC = self.getItemController(0)!
        let startingViewControllers: NSArray = [startingVC]
        
        self.pageVC!.setViewControllers(startingViewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        // Change the size of page view controller
        //self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
        
        //self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 50);
        
        //pageVC = pageController
        addChildViewController(pageVC!)
        self.view.addSubview(pageVC!.view)
        pageVC!.didMoveToParentViewController(self)
        
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getItemController(itemIndex: Int) -> PageContentVC? {
        
        if (itemIndex < 0 || self.pageImages!.count == 0 || itemIndex >= self.pageImages?.count) {
            return nil;
        }
        
        let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("PageContentVC") as! PageContentVC
        
        pageItemController.pageIndex = itemIndex
        pageItemController.imagem = self.pageImages![itemIndex]
        return pageItemController
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageContentVC
        
        if (itemController.pageIndex == NSNotFound) {
            return nil;
        }
        
        //itemController.pageIndex--
        //return getItemController(itemController.pageIndex)
        
        if itemController.pageIndex > 0 {
            return getItemController(itemController.pageIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageContentVC
        
        if (itemController.pageIndex == NSNotFound) {
            return nil;
        }
        
        //itemController.pageIndex++
        
        if itemController.pageIndex+1 < pageImages?.count {
            return getItemController(itemController.pageIndex+1)
        }
        
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageImages!.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
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
