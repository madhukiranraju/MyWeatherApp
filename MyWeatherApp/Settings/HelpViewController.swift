//
//  HelpViewController.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 07/01/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let url = Bundle.main.url(forResource: "WeatherAPIHelp", withExtension: "html")
        webView.loadFileURL(url!, allowingReadAccessTo: url!)
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
