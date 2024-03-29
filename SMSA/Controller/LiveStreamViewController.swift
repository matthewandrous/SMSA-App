//
//  VideoViewController.swift
//  YoutubeEmbedApp
//
//  Created by MAC on 6/1/19.
//  Copyright © 2019 cagdaseksi. All rights reserved.
//

import UIKit
import WebKit

class LiveStreamViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var videoWebView: WKWebView!
    @IBOutlet weak var Activity: UIActivityIndicatorView!
    @IBOutlet weak var ContainerView: UIView!
    
    // Set corner radius
    let cornerRadius : CGFloat = 25.0
    
    fileprivate func setupWebViewContainer() {
        
        // Shadow and round corner Web View
        ContainerView.layer.cornerRadius = cornerRadius
        ContainerView.layer.shadowColor = UIColor.darkGray.cgColor
        ContainerView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        ContainerView.layer.shadowRadius = 25.0
        ContainerView.layer.shadowOpacity = 0.5
        ContainerView.layer.shadowPath = UIBezierPath(roundedRect: videoWebView.bounds, cornerRadius: cornerRadius).cgPath
        videoWebView.layer.cornerRadius = cornerRadius
        videoWebView.clipsToBounds = true
        videoWebView.scrollView.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hides the lines under the Navigation bar for a cleaner look (like Things)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        setupWebViewContainer()
        
        // Live stream URL
        let url = URL(string: "https://www.youtube.com/embed/live_stream?channel=UC_eGnmI2MqiwOLncMVLKbOg")
        
        // Used to check if the live stream is loading
        videoWebView.navigationDelegate = self
        
        // Start loading URL
        videoWebView.load(URLRequest(url: url!))
        
        // Start the activity indicator
        self.Activity.startAnimating()
        
        // Will hide the element when the loading is done
        self.Activity.hidesWhenStopped = true

    }
    
    // Delegate method for the loading animation
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Activity.stopAnimating()
    }
    
    // Delegate method for the loading animation
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Activity.stopAnimating()
    }
    
    
    // 'Open in YouTube' button
    @IBAction func onOpenYouTube(_ sender: UIButton) {
        // LINK NOT WORKING
        let youtubeID = "UC_eGnmI2MqiwOLncMVLKbOg"
        //out youtube channel ID: UC_eGnmI2MqiwOLncMVLKbOg
        
        // If YouTube is installed
        if let youtubeURL = URL(string: "youtube://\(youtubeID)"),
            UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        }
            // Otherwise, go to Safari
        else if let youtubeURL = URL(string: "https://www.youtube.com/channel/\(youtubeID)") {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        }
    }
}
