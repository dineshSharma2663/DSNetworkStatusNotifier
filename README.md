

![Online Preview](https://github.com/dineshSharma2663/DSNetworkStatusNotifier/blob/master/Network%20Status%20Notifier/online.png)


#Supported Platoform
#iOS 9.0+
#Swift3.0+

# DSNetworkStatusNotifier
Most of times in mobile application, we want to be notified whenever our network connection changes &amp; we want to show a network status bar in our app like "No internet connection!" / "You are online" like Facebook. Now I have created a class for the same. It looks better &amp; provides better user experience through out the app.


You can use this feature after just doing couple of things mentioned below:


1. First add "Reachability.swift" & "NetworkStatusNotifier.swift" to your project. There may be a possiblity that most of you will be aleady having "Reachability.swift". In that case you have to add only "NetworkStatusNotifier.swift".

2. After that we have to do couple of changes in your project "AppDelegate.swift". 

   a.) You will be seeing that AppDelegate is inheriting from class 'UIResponder'. Now you have to make 'AppDelegate' from 'NetworkStatusNotifier' instead of 'UIResponder' as I have done it internally in 'NetworkStatusNotifier'. Don't change anything in inheriting protocols like 'UIApplicationDelegate'.

b.) Till now you have confirmed to 'NetworkStatusNotifier' class. Only thing left is, you have to just add a notifier which will be called when you internet statuses changes. For this, just call function 'addNetWorkNotifier()' in your 'applicationDidBecomeActive' function. You can customise your status bar view providing different arguments in 'addNetWorkNotifier' as shown below:

#func addNetWorkNotifier(offlineMessageText:String = DefaultNetworkStyle.offlineMessage,offlineBackColor:UIColor = DefaultNetworkStyle.offlineBackColor, onlineMessageText:String = DefaultNetworkStyle.onlineMessage,onlineBackColor : UIColor = DefaultNetworkStyle.onlineBackColor, textColor:UIColor = DefaultNetworkStyle.textColor )


here you can see how it looks like.

![Offline Preview](https://github.com/dineshSharma2663/DSNetworkStatusNotifier/blob/master/Network%20Status%20Notifier/offline.png)


