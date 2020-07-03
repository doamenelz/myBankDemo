//
//  LabelHelpers.swift
//  PlanBok_SwiftUI
//
//  Created by Ed Em on 2020-06-30.
//  Copyright © 2020 QuetzalConsults. All rights reserved.
//

import Foundation
import UIKit

struct DateFormatterHelper {
    
    func formatDate(serverDate: String) -> String  {
        let dateFormat = DateFormatter()

        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let parsedServerDate = dateFormat.date(from: serverDate)
        
        let presentedDateFormatter = DateFormatter()
        
        presentedDateFormatter.dateFormat = "MMM d, yyyy"
        
        let formattedDate = presentedDateFormatter.string(from: parsedServerDate!)
        
        return formattedDate
                
        
    }
    
    func formatDateString(serverDate: String) -> String  {
        let dateFormat = DateFormatter()

        dateFormat.dateFormat = "yyyy/mm/dd"
        
        let parsedServerDate = dateFormat.date(from: serverDate)
        
        let presentedDateFormatter = DateFormatter()
        
        presentedDateFormatter.dateFormat = "MMM d, yyyy"
        
        let formattedDate = presentedDateFormatter.string(from: parsedServerDate!)
        
        return formattedDate
                
        
    }

    
    func changeStringToDate (receivedStringDate: String) -> Date {
           
        let dateFormatter = DateFormatter()
           
        dateFormatter.dateFormat = "yyyy/mm/dd"
        
        let dateFromString = dateFormatter.date(from: receivedStringDate)
        
        return dateFromString ?? Date()

       }
    
    static func formatFirebaseDate(serverDate: Date) -> String  {
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let parsedPickerDate = dateFormat.string(from: serverDate)
        
        let tempD = dateFormat.date(from: parsedPickerDate)
        
        let presentedDateFormatter = DateFormatter()
        
        presentedDateFormatter.dateFormat = "d MMM, h:mm a"
        
        let formattedDate = presentedDateFormatter.string(from: tempD!)
        
        return formattedDate
    }

    
    
    
}

