//
//  TrailerViewController.swift
//  flixProject
//
//  Created by Suma Valli on 2/26/21.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
        
        var webView: WKWebView!
        var movieId: String!
        
        override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            view = webView
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            let api = URL(string: "https://developers.themoviedb.org/3/movie/\(String(describing: movieId))/videos/api_key")
            let key = URLRequest(url: api!)
            let myURL = URL(string: "https://www.youtube.com/watch?v=\(key)")
            print(movieId)
            //print(myURL as Any)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }


        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
