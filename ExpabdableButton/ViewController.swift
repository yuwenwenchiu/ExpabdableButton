//
//  ViewController.swift
//  ExpabdableButton
//
//  Created by Yuwen Chiu on 2020/7/4.
//  Copyright © 2020 YuwenChiu. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    let screenSize = UIScreen.main.bounds
    let expandableButtonView = ExpandableButtonView()
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.apple.com/tw/")
        let reqrust = URLRequest(url: url!)
        webView.load(reqrust)
        
        setUpExpandableButtonView()
    }

    func setUpExpandableButtonView() {
        
        expandableButtonView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        expandableButtonView.setupShadowView()
        expandableButtonView.setupButtons(buttonTitles: ["FB", "IG", "Photo"])
        expandableButtonView.delegate = self
        
        navigationController?.view.addSubview(expandableButtonView)
    }
}

extension ViewController: ExpandableButtonViewDelegate {
    
    func doSomethingBy(title: String) {
        
        switch title {
        case "FB":
            // Share to Facebook or whatever you want
            ()
            
        case "IG":
            // Share to Instagram or whatever you want
            ()
            
        case "Photo":
            // Open the camera app or whatever you want
            ()
            
        default:
            ()
        }
    }
}
