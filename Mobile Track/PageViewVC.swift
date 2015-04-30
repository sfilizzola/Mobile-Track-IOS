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
    var pageTitles: [String]?
    var pageImages: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the data model
        pageTitles = ["Over 200 Tips and Tricks", "Discover Hidden Features", "Bookmark Favorite Tip", "Free Regular Update"];
        pageImages = ["page1.png", "page2.png", "page3.png", "page4.png"];
        
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
    
    private func getItemController(itemIndex: Int) -> PageContentVC? {
        
        if (itemIndex < 0 || self.pageTitles!.count == 0 || itemIndex >= self.pageTitles?.count) {
            return nil;
        }
        
        let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("PageContentVC") as! PageContentVC
            
        pageItemController.pageIndex = itemIndex
        pageItemController.titulo = self.pageTitles![itemIndex]
        pageItemController.imagem = self.pageImages![itemIndex]
        return pageItemController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedStartAgain(sender: UIButton) {
        
        let startingVC: PageContentVC = self.getItemController(0)!
        let startingViewControllers: NSArray = [startingVC]
        
        self.pageVC!.setViewControllers(startingViewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Reverse, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageContentVC
        
        if (itemController.pageIndex == NSNotFound) {
            return nil;
        }
        
        itemController.pageIndex--
        
        if (itemController.pageIndex == self.pageTitles?.count) {
            return nil;
        }
        
        return getItemController(itemController.pageIndex)

    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageContentVC
        
        if (itemController.pageIndex == NSNotFound) {
            return nil;
        }
        
        itemController.pageIndex++
        
        if (itemController.pageIndex == self.pageTitles?.count) {
            return nil;
        }
        
        return getItemController(itemController.pageIndex)
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
