//
//  FirstViewController.swift
//  SMSA
//
//  Created by Matthew Androus on 7/19/19.
//  Copyright © 2019 SMSA Devs. All rights reserved.
//

import UIKit
import SafariServices
import WebKit

class AnnouncementsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var announcementsTableView: UITableView!
    
    /*
    var webView: WKWebView?
    
    private var request : NSURLRequest {
        let baseUrl = "https://st-athanasius.org"
        let URL = NSURL(string: baseUrl)!
        return NSURLRequest(url: URL as URL)
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnnouncementsModel.announcementsModel.test()
        announcementsTableView.delegate = self
        announcementsTableView.dataSource = self
        
        /* Create our preferences on how the web page should be loaded */
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = false
        
        /* Create a configuration for our preferences */
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        
        //starting Calendar parsing in a seperate thread
        DispatchQueue.global().async {
            //iCalParser.icp.doNothing()
            DispatchQueue.main.async {
                //nothing
            }
        }
        
        //starting Sermons parsing in a seperate thread
        DispatchQueue.global().async {
            SermonsModel.sermonsModel.test()
            DispatchQueue.main.async {
                //nothing
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let index = self.announcementsTableView.indexPathForSelectedRow{
            self.announcementsTableView.deselectRow(at: index, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        print("IN numberOfSection()")
        //return one section because we only have one section
        //this was a dumb comment in retrospect
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AnnouncementsModel.announcementsModel.announcementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Announcement", for: indexPath) as! AnnouncementCell
        
        cell.announcementTitle?.text = AnnouncementsModel.announcementsModel.announcementList[indexPath.row]["title"] as? String
        
        if AnnouncementsModel.announcementsModel.announcementList[indexPath.row]["tag"] as! String == "HS" {
//            print("CHANGING IMAGE")
            cell.announcementImage?.image = #imageLiteral(resourceName: "CrossGreen")
        }
        else if AnnouncementsModel.announcementsModel.announcementList[indexPath.row]["tag"] as! String == "JHB" {
//            print("CHANGING IMAGE")
            cell.announcementImage?.image = #imageLiteral(resourceName: "CrossBlue")
        }
        else if AnnouncementsModel.announcementsModel.announcementList[indexPath.row]["tag"] as! String == "JHG" {
//            print("CHANGING IMAGE")
            cell.announcementImage?.image = #imageLiteral(resourceName: "CrossPurple")
        }
        else if AnnouncementsModel.announcementsModel.announcementList[indexPath.row]["tag"] as! String == "ELEM" {
//            print("CHANGING IMAGE")
            cell.announcementImage?.image = #imageLiteral(resourceName: "CrossYellow")
        }
        else {
//            print("DEFAULT IMAGE")
            cell.announcementImage?.image = #imageLiteral(resourceName: "CrossRed")
        }
        cell.accessoryType = .disclosureIndicator
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTutorial(indexPath.row)
    }
    
    /* Some non-working WKWebView Stuff */
    /*
     *
     *
    /* Start the network activity indicator when the web view is loading */
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    /* Stop the network activity indicator when the loading finishes */
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    private func webView(webView: WKWebView,
                 decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse,
                 decisionHandler: ((WKNavigationResponsePolicy) -> Void)){
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
//        if challenge.protectionSpace.host == "https://unimol.esse3.cineca.it/auth/Logon.do" {
//            let user = "*******"
//            let password = "******"
//            let credential = URLCredential(user: user, password: password, persistence: URLCredential.Persistence.forSession)
//            challenge.sender?.use(credential, for: challenge)
//        }
    }
    */
    
    
    
    func showTutorial(_ which: Int) {
        if let url = URL(string: (AnnouncementsModel.announcementsModel.announcementList[which]["link"] as? String)!) {
            let config = SFSafariViewController.Configuration()

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true) /*{
                var frame = vc.view.frame
                let OffsetY: CGFloat  = 535
                frame.origin = CGPoint(x: frame.origin.x, y: frame.origin.y - OffsetY)
                frame.size = CGSize(width: frame.width, height: frame.height + OffsetY)
                vc.view.frame = frame
            } */
        }
    }
}

