//
//  ViewController.swift
//  DrawWithFriends
//
//  Created by Sean Viswanathan on 1/4/15.
//  Copyright (c) 2015 Sean Viswanathan. All rights reserved.
//

import UIKit
import MultipeerConnectivity


class ViewController: UIViewController, MCBrowserViewControllerDelegate {
    @IBOutlet weak var drawView: DrawView!

    var appDelegate: AppDelegate!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        appDelegate.mpchandler.setUpPeerWithDisplayName(UIDevice.currentDevice().name)
        appDelegate.mpchandler.setUpSession()
        appDelegate.mpchandler.advertiseSelf(true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "peerChangedStateWithNotification", name: "MPC_DidChangeStateNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleReceivedDataWithNotification", name: "MPC_DidReceiveDataNotification", object: nil)
    }

    @IBAction func connectWithPlayer(sender: AnyObject) {
        
        if appDelegate.mpchandler.session != nil{
            appDelegate.mpchandler.setUpBrowser()
            appDelegate.mpchandler.browser.delegate = self
            
            self.presentViewController(appDelegate.mpchandler.browser, animated: true, completion: nil)
        }
    }
    
    
    func peerChangedStateWithNotification(notification: NSNotification) {
        let userInfo = NSDictionary(dictionary: notification.userInfo!)
        
        let state = userInfo.objectForKey("state") as Int
        
        if state != MCSessionState.Connecting.rawValue {
            self.navigationItem.title = "Connected"
        }
    }
    
    
    func handleReceivedDataWithNotification(notification: NSNotification) {
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!) {
        appDelegate.mpchandler.browser.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
        appDelegate.mpchandler.browser.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func clearScreen(sender: UIButton) {
        
        var theDrawView: DrawView = drawView as DrawView
        theDrawView.lines = []
        theDrawView.setNeedsDisplay()
    }

}

