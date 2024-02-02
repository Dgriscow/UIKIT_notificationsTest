//
//  NotificationDelegate.swift
//  notificationsTest
//
//  Created by Devin Grischow on 1/30/24.
//
import UIKit
import UserNotifications
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge])
    }
    
    
}
