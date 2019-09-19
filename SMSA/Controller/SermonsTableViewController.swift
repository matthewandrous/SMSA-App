//
//  SecondViewController.swift
//  SMSA
//
//  Created by Matthew Androus on 7/19/19.
//  Copyright © 2019 SMSA Devs. All rights reserved.
//

import UIKit
import SafariServices
import WebKit

class SermonsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SermonsModel.sermonsModel.test()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SermonsModel.sermonsModel.sermonList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .detailButton
        cell.textLabel?.text = SermonsModel.sermonsModel.sermonList[indexPath.row]["title"] as! String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTutorial(indexPath.row)
    }
    
    
    func showTutorial(_ which: Int) {
        SermonsModel.sermonsModel.selectSermon(index: which)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NowPlayingVC")
        newViewController.modalPresentationStyle = .popover
        self.present(newViewController, animated: true, completion: nil)
//        if let url = URL(string: (SermonsModel.sermonsModel.sermonList[which]["url"] as? String)!) {
//            let config = SFSafariViewController.Configuration()
//
//            let vc = SFSafariViewController(url: url, configuration: config)
//            present(vc, animated: true) /*{
//             var frame = vc.view.frame
//             let OffsetY: CGFloat  = 535
//             frame.origin = CGPoint(x: frame.origin.x, y: frame.origin.y - OffsetY)
//             frame.size = CGSize(width: frame.width, height: frame.height + OffsetY)
//             vc.view.frame = frame
//             } */
//        }
    }

}

