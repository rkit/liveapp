//
//  Insomnia
//  Live!
//
//  Created by Igor Romanov on 10/04/2017.
//  Copyright © 2017 rkit. All rights reserved.
//

import Cocoa
import IOKit.pwr_mgt

class Insomnia: NSObject {
    private var isEnabled: Bool = false
    private var assertionID: IOPMAssertionID = IOPMAssertionID()
    private let assertion​Name = "Live!" as CFString
    
    func on() -> Bool {
        let success = IOPMAssertionCreateWithName(
            kIOPMAssertionTypeNoDisplaySleep as NSString,
            IOPMAssertionLevel(kIOPMAssertionLevelOn),
            assertion​Name,
            &assertionID
        )
        
        if (success == kIOReturnSuccess) {
            isEnabled = true
            return true;
        }

        return false
    }
    
    func off() -> Bool {
        let success = IOPMAssertionRelease(assertionID)
        if (success == kIOReturnSuccess) {
            isEnabled = false
            return true;
        }

        return false
    }
}
