//
//  WebStettingsViewController.swift
//  webApp2
//
//  Created by ST13 on 16.10.2017.
//  Copyright © 2017 Kugim. All rights reserved.
//

import UIKit

let searchEngines = [
    ["Google", "https://www.google.com.tr/search?q=", "google"],
    ["Yandex", "https://yandex.com/search?q=", "yahoo"],
    ["Bing", "https://bing.com/search?q=", "bing"],
]

var searchHistory = [String]()
var defaultSearcUrl : String = "https://www.google.com/"
var SelectedHistoryURL : Int = 0
var GotoHistoryURL : String = ""
var searchs : String = ""
var searchIsOn = true
var selectedSegment = 0
//-----------

var searchURL = 2

//------------

class WebStettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var historyViewOutlet: UIView!
    @IBOutlet weak var webSearchHistoryOutlet: UILabel!
    @IBOutlet weak var tableHistoryView: UITableView!
    @IBOutlet weak var defaultUrlTextField: UITextField!
    @IBOutlet weak var settingsSegmentOutlet: UISegmentedControl!
    @IBOutlet weak var settingsViewOutlet: UIView!
    @IBOutlet weak var searchImageOutlet: UIImageView!
    @IBOutlet weak var searchEnginePickerOutlet: UIPickerView!
    
    @IBAction func defaultUrlAddButton(_ sender: UIButton) {
        
        defaultSearcUrl = defaultUrlTextField.text!
        
        UserDefaults.standard.set(defaultSearcUrl, forKey: "UserDefaultURL")
        print(defaultUrlTextField.text!)
        
    }
    
    
    @IBAction func settingsSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "selectedSegment")
        settingsViewOutlet.isHidden = false
            historyViewOutlet.isHidden = true
        } else if sender.selectedSegmentIndex == 1 {
            UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "selectedSegment")
            settingsViewOutlet.isHidden = true
            historyViewOutlet.isHidden = false
        }
       selectedSegment = sender.selectedSegmentIndex
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return searchEngines.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return searchEngines[row][0]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        searchURL = row
        UserDefaults.standard.set(searchURL, forKey: "searchURL")
        print(print(searchURL))
        searchImageOutlet.image = UIImage(named: searchEngines[row][2])
    }
    
    
    
    
    
    @IBOutlet weak var searchSettingsView: UIView!
    
    @IBOutlet weak var searchSwitchOutlet: UISwitch!

    @IBAction func searchSwitchAction(_ sender: UISwitch) {
        
        if sender.isOn == true {
            searchSettingsView.isHidden = false
            
            searchIsOn = true
            UserDefaults.standard.set(searchIsOn, forKey: "searchIsOn")
        } else {
            searchSettingsView.isHidden = true
            searchIsOn = false
            UserDefaults.standard.set(searchIsOn, forKey: "searchIsOn")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    // --------------------Table View Begin--------------------
    
    let cellReuseIdentifier = "cell"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistory.count
    }
    
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = searchHistory[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        SelectedHistoryURL = indexPath.row
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let settingsViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController")
        self.present(settingsViewController, animated: true, completion: nil)
        
        
    }
    
    
    // --------------------Table View End--------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        defaultUrlTextField.text = defaultSearcUrl
        self.tableHistoryView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableHistoryView.delegate = self
        tableHistoryView.dataSource = self
        
        
        
        searchs = ""
        
        for value in searchHistory {
            searchs += "\n\(value)"
        }
        
        webSearchHistoryOutlet.text = searchs
        
        // change default search engine
        searchEnginePickerOutlet.selectRow(searchURL, inComponent: 0, animated: true)
        searchImageOutlet.image = UIImage(named: searchEngines[searchURL][2])

        
        // globaldeki bilgi searchSwitchOutlet'e gelsin
        searchSwitchOutlet.isOn = searchIsOn
        searchSwitchAction(searchSwitchOutlet)
        
        // 
        settingsSegmentOutlet.selectedSegmentIndex = selectedSegment
        settingsSegmentAction(settingsSegmentOutlet)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
