//
//  ConfigurationViewController.swift
//  Example
//
//  Created by Cornelius Horstmann on 26.02.17.
//  Copyright © 2017 Mattias Levin. All rights reserved.
//

import UIKit
import PiwikTracker

class ConfigurationViewController: UIViewController {
    
    @IBOutlet weak var baseURLTextField: UITextField!
    @IBOutlet weak var siteIDTextField: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Tracker.sharedInstance?.track(view: ["configuration"])
        
        baseURLTextField.text = UserDefaults.standard.url(forKey: "piwik-example-baseurl")?.absoluteString
        siteIDTextField.text = UserDefaults.standard.string(forKey: "piwik-example-siteid")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let baseURLText = baseURLTextField.text,
            let baseURL = URL(string: baseURLText),
            let siteID = siteIDTextField.text else { return }
        UserDefaults.standard.set(baseURL, forKey: "piwik-example-baseurl")
        UserDefaults.standard.set(siteID, forKey: "piwik-example-siteid")
        UserDefaults.standard.synchronize()
        
        Tracker.configureSharedInstance(withSiteID: siteID, baseURL: baseURL)
    }
    
    @IBAction func newSessionButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func dispatchButtonTapped(_ sender: UIButton) {
        Tracker.sharedInstance?.dispatch()
    }

}
