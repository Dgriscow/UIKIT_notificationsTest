//
//  ViewController.swift
//  notificationsTest
//
//  Created by Devin Grischow on 1/29/24.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {
    
    var counter = 0.0
    
    
    @IBOutlet weak var labell: UILabel!
    
    
    @IBAction func makeaschedule(_ sender: Any) {
        
        self.introNotification()
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.checkPermissions()
        
        self.timedNotification()
    }

    func checkPermissions(){
        print("Checking permisions")
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus{
            case .authorized:
                self.introNotification()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]){ didAllow, error in
                    
                    if didAllow{
                        self.introNotification()
                    }
                    
                }
                
                
                
            default:
                return
            }
            
            
        }
    }
    
    func timedNotification(){
        let hourSet = 13
        let minuteSet = 21
        
        self.counter += 1
        
        let notificationCenter = UNMutableNotificationContent()
        
        notificationCenter.title = "Its Time!"
        
        notificationCenter.body = "Time to get up and work"
        
        notificationCenter.badge = counter as NSNumber
        
        let calenderTime = Calendar.current
        
        var dateComponents = DateComponents(calendar: calenderTime, timeZone: TimeZone.current)
        
        dateComponents.hour = hourSet
        dateComponents.minute = minuteSet
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "Caldender", content: notificationCenter, trigger: trigger)
        
        

    }
    
    func introNotification(){
        
        
        
        print("annoucing thing")
        
        let timeUp = 5.0
        
        self.counter += 1
        
        let notificationCenter = UNMutableNotificationContent()
        
        notificationCenter.title = "Recorded time for later"
        
        notificationCenter.body = "will present when ready"
        
        notificationCenter.badge = counter as NSNumber
        
        //Trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeUp, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Timely Reminder4234", content: notificationCenter, trigger: trigger)
        
        //schedule
        UNUserNotificationCenter.current().add(request)
        
        
    }
    
    func accessDeniedAlert(){
        print("denied")
        // presents an alert when access is denied for notifications on startup. give the user two choices to dismiss the alert and to go to settings to change thier permissions.
        let alert = UIAlertController(title: "denied", message: "This App needs notifications to work properly, but they are currently turned off. Turn them on in settings.", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(okayAction)
        alert.addAction(settingsAction)
        present(alert, animated: true) {
        }
    }

}

