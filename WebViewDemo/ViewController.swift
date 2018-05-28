//
//  ViewController.swift
//  WebViewDemo
//
//  Created by Mohamed Sobhi  Fouda on 5/26/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate,  WKNavigationDelegate {
    
    // MARK: - Class Variable
    var webView: WKWebView?
    @IBOutlet weak var BackButton: UIBarButtonItem!
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var ForwardButton: UIBarButtonItem!
    
    @IBAction func ForwardButtonTapped(_ sender: Any) {
       
        if (webView?.canGoForward)!{
            webView?.goForward()
        }
    }
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        
        if (webView?.canGoBack)!{
            webView?.goBack()
        } else {
            //Pop view controller to preview view controller
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    // MARK: - Add webView to app main view
    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1
        let urlString = "https://apple.com"
        let url = URL(string: urlString)!
        webView?.load(URLRequest(url: url))
        
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView?.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
        
        urlText.text = urlString
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        urlText.delegate = self
        webView?.navigationDelegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // 1
        let url = URL(string: urlText.text!)!
        webView?.load(URLRequest(url: url))
        
        // 2
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView?.reload))
        toolbarItems = [refresh]
        
        navigationController?.isToolbarHidden = true
        
        textField.resignFirstResponder()
        
        urlText.delegate = self
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        BackButton.isEnabled = webView.canGoBack
        ForwardButton.isEnabled = webView.canGoForward
        
        urlText.text = webView.url?.absoluteString
    }
    
    
}

