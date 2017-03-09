//
//  ViewController.swift
//  Network Status Notifier
//
//  Created by dinesh sharma on 04/03/17.
//  Copyright © 2017 dinesh sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    var offlineText = "You are offline."
    var onlineText = "You are online."
    var appDelegate : AppDelegate!
    var offlineBackColor = DefaultNetworkStyle.offlineBackColor
    var onlineBackColor = DefaultNetworkStyle.onlineBackColor
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = NSString(string:textField.text!)
        let resultingString = text.replacingCharacters(in: range, with: string) as NSString
        if textField.tag == 0 {
            if textField.text != ""
            {
                onlineText = resultingString as String!
                appDelegate.onlineMessage = resultingString as String!
            }
        }else{
            if textField.text != ""
            {
                offlineText = resultingString as String!
                appDelegate.offlineMessage = resultingString as String!
            }
        }
        appDelegate.addNetWorkNotifier(offlineMessageText: offlineText, offlineBackColor: offlineBackColor, onlineMessageText: onlineText, onlineBackColor: onlineBackColor)
        
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate  as! AppDelegate
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeOnlineBackColorButtonAction(_ sender: UIButton) {
        sender.isSelected = true
        onlineBackColor = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        
        appDelegate.addNetWorkNotifier(offlineMessageText: offlineText, offlineBackColor: offlineBackColor, onlineMessageText: onlineText, onlineBackColor: onlineBackColor)

    }
    
    @IBAction func changeOfflinebackColorButtonAction(_ sender: UIButton) {
        offlineBackColor = .black
        sender.isSelected = true
        
        appDelegate.addNetWorkNotifier(offlineMessageText: offlineText, offlineBackColor: offlineBackColor, onlineMessageText: onlineText, onlineBackColor: onlineBackColor)

    }
}

