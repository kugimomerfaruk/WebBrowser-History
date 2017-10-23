//
//  ViewController.swift
//  webApp2
//
//  Created by ST13 on 16.10.2017.
//  Copyright © 2017 Kugim. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var urlTextFieldOutlet: UITextField!
    @IBOutlet weak var webViewOutlet: UIView!
    @IBOutlet weak var goBtnOutlet: UIButton!
    
    var webView: WKWebView!
    

    @IBAction func goBtnAction(_ sender: UIButton) {
        let urlCheck = goOrSearchURL(
                checkURL: urlTextFieldOutlet.text!,
                searchURLField: searchEngines[searchURL][1],
                isSearchable: searchIsOn
        )
        print(urlCheck.url)
        print(urlCheck.isGoing)
        
        if urlCheck.isGoing == false {
            // let alert = UIAlertController(title: "Title", message: "Uyari Mesaji", preferredStyle: .alert)
            let alert = UIAlertController(title: "Title", message: "Uyari Mesaji", preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "Ayarlar'a Git", style: .default){ (_: UIAlertAction) in
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let settingsViewController = storyBoard.instantiateViewController(withIdentifier: "WebStettingsViewController")
                self.present(settingsViewController, animated: true, completion: nil)
            }
            let action2 = UIAlertAction(title: "Iptal", style: .cancel){ (_: UIAlertAction) in
                print("cancel")
            }
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
        } else {
            print("Gidilecek URL : \(urlCheck.url)")
            if urlCheck.url != " " {
                searchHistory.insert(urlCheck.url, at: 0)
                print(searchHistory)
                urlTextFieldOutlet.text! = ""
                let myURL = URL(string: urlCheck.url)
                let myRequest = URLRequest(url: myURL!)
                webView.load(myRequest)
            }
    
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // User Default  -> defaultSearcUrl
        if let UserDefaultURL = UserDefaults.standard.object(forKey: "UserDefaultURL") as? String {
            defaultSearcUrl = UserDefaultURL
            print("Kullanıcının Belirlediği URL = \(defaultSearcUrl)")
        }
        
        if let UsersearchIsOn = UserDefaults.standard.object(forKey: "searchIsOn") as? Bool {
        searchIsOn = UsersearchIsOn
            print("Kullanıcı Arama Yapılsın Ayarı = \(searchIsOn)")
        }
        
        if let UserselectedSegment = UserDefaults.standard.object(forKey: "selectedSegment") as? Int {
        selectedSegment = UserselectedSegment
            print("Kullanıcı Ayarlar ve Geçmiş Sekme Ayarı = \(selectedSegment)")
        }
        
        if let UserSearchUrl = UserDefaults.standard.object(forKey: "searchURL") as? Int {
        searchURL = UserSearchUrl
            print("Kullanıcı Arama Motoru Ayarı = \(UserSearchUrl)")
        }
        
        if searchHistory.count > 0 {
            print("Şuan Gidilecek Adres = \(searchHistory[SelectedHistoryURL])")
        }
        
        
        
        //GotoHistoryURL = searchHistory[GotoHistoryURL]
        ///print(GotoHistoryURL)
        
        webView = WKWebView(frame: webViewOutlet.bounds, configuration: WKWebViewConfiguration() )
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.webViewOutlet.addSubview(webView)
        self.webView.allowsBackForwardNavigationGestures = true
        //let localURL = Bundle.main.url(forResource: "index", withExtension: "html")
        
        if  searchHistory.count > 0 {
  
            let myURL = URL(string: searchHistory[SelectedHistoryURL])
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            
        }else {
        
        
        let myURL = URL(string: defaultSearcUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    
    }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

