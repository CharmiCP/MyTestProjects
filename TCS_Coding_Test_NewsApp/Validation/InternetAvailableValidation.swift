//
//  InternetValidation.swift
//  TCS_Coding_Test_NewsApp
//
//  Created by Charmy on 6/3/22.
//

import Foundation
import Network

class InternetAvailableValidation{
    
    func isInternetAvailable() -> Bool{
        let monitor = NWPathMonitor()
        var isInternetAvailable = true
        
        monitor.pathUpdateHandler = { path in
           if path.status == .satisfied {
//              print("Connected")
              isInternetAvailable = true
           } else {
//              print("Disconnected")
              isInternetAvailable = false
           }
//           print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
        
        return isInternetAvailable
    }
    
}
