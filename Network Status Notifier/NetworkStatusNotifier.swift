//
//  NetworkStatusNotifier.swift
//  Network Status Notifier
//
//  Created by dinesh sharma on 04/03/17.
//  Copyright © 2017 dinesh sharma. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import MobileCoreServices

enum NetworkStatusType {
    case offline
    case online
}


struct DefaultNetworkStyle {
    
    static let onlineBackColor = UIColor(red: 11/255.0, green: 148/255.0, blue: 68/255.0, alpha: 1.0)
    static let offlineBackColor = UIColor(red: 232/255.0, green: 98/255.0, blue: 109/255.0, alpha: 1.0)
    static let textColor = UIColor.white
    static let offlineMessage = "You are offline"
    static let onlineMessage = "You are online"
}

protocol StatusBarNotificationProtocol {
    func hideStatusBarView()
    func showNetworkStatusBar(message:String,dismissAfter:TimeInterval?,style: NetworkStatusType)
}


class NetworkStatusNotifier : UIResponder,StatusBarNotificationProtocol
{
    var reachability:Reachability?
    
    var statusBarLabel : UILabel!
    
    var messageTextColor : UIColor!
    var onlineModeBackgroundColor : UIColor!
    var offlineModeBackgroundColor : UIColor!
    var offlineMessage : String!
    var onlineMessage : String!
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name:ReachabilityChangedNotification, object: nil)
       
    }
    
    //MARK: - ADD NETWORK STATUS NOTIFIER
    func addNetWorkNotifier(offlineMessageText:String = DefaultNetworkStyle.offlineMessage,offlineBackColor:UIColor = DefaultNetworkStyle.offlineBackColor, onlineMessageText:String = DefaultNetworkStyle.onlineMessage,onlineBackColor : UIColor = DefaultNetworkStyle.onlineBackColor, textColor:UIColor = DefaultNetworkStyle.textColor ) {
        
        
        messageTextColor = textColor
        onlineModeBackgroundColor = onlineBackColor
        offlineModeBackgroundColor = offlineBackColor
        offlineMessage = offlineMessageText
        onlineMessage = onlineMessageText
        
        if reachability == nil {
         reachability = Reachability.init()
         try? reachability?.startNotifier()
        }
    }
    
    //MARK: - FUNCTION CALLED ON NETWORK STATUS CHANGED
    func reachabilityChanged() {
        if !(reachability?.isReachable)!{
            print("disconnected")
            showNetworkStatusBar(message: offlineMessage, dismissAfter: nil, style: .offline)
        }else {
            print("connected")
            showNetworkStatusBar(message: onlineMessage, dismissAfter: 3.0, style: .online)
        }
    }
    
    
    //MARK: - HDIE STATUS BAR VIEW
    func hideStatusBarView() {
        UIView.animate(withDuration: 0.5) {
            self.statusBarLabel.transform = CGAffineTransform.identity
        }
    }
    
    //MARK: - SHOW NETWORK STATUS BAR VIEW
    func showNetworkStatusBar(message:String,dismissAfter:TimeInterval?,style: NetworkStatusType) {
        
        if statusBarLabel == nil {
            statusBarLabel = UILabel()
            statusBarLabel.frame = CGRect(x: 0, y: -20, width: UIScreen.main.bounds.width, height: 20)
            statusBarLabel.font = UIFont(name: "Avenir-Medium", size: 13.3)
            statusBarLabel.textAlignment = .center
            if let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow {
                statusBarWindow.addSubview(statusBarLabel)
            }
        }
        statusBarLabel.text = message
        statusBarLabel.textColor = messageTextColor

        UIView.animate(withDuration: 0.5) {
            self.statusBarLabel.transform = CGAffineTransform(translationX: 0, y: 20)
        }
        
        if let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow {
            statusBarWindow.addSubview(statusBarLabel)
            statusBarWindow.bringSubview(toFront: statusBarLabel)
        }
        
        switch style {
        case NetworkStatusType.offline:
            statusBarLabel.backgroundColor = offlineModeBackgroundColor
        default:
            statusBarLabel.backgroundColor = onlineModeBackgroundColor
        }
        
        if dismissAfter != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter!, execute: {
                if !(self.reachability?.isReachable)!{
                    self.showNetworkStatusBar(message: self.offlineMessage, dismissAfter: nil, style: .offline)
                }else{
                    self.hideStatusBarView()
                }
            })
        }
    }

}
