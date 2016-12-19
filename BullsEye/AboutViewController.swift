//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Pavel Prokofyev on 30.11.16.
//  Copyright © 2016 pavelprokofyev. All rights reserved.
//

import UIKit
import Foundation

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func okButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html")
        if let htmlData = try? Data(contentsOf: url!) {
            let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
            webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
        }
    }
}
