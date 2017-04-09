//
//  StatusBarController.swift
//  Live!
//
//  Created by Igor Romanov on 09/04/2017.
//  Copyright © 2017 rkit. All rights reserved.
//

import Cocoa

class StatusBarController: NSObject {
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    var isEnabled = false
    
    func turnOn() {
        let insomnia = Insomnia()
        let success = insomnia.on()
        print("on", success)
    }
    
    func turnOff() {
        let insomnia = Insomnia()
        let success = insomnia.off()
        print("off", success)
    }
    
    func modeOff() {
        statusItem.menu?.item(at:0)?.title = "Enable"
        isEnabled = false
        
        let icon = NSImage(named: "StatusBarIcon-Off")
        icon?.isTemplate = true
        statusItem.image = icon
    }

    func modeOn() {
        statusItem.menu?.item(at:0)?.title = "Disable"
        isEnabled = true
        
        let icon = NSImage(named: "StatusBarIcon-On")
        icon?.isTemplate = true
        statusItem.image = icon
    }
    
    func switchMode() {
        if (isEnabled) {
            modeOff()
            turnOff()
        } else {
            modeOn();
            turnOn();
        }
    }
    
    func quit() {
        turnOff()
        NSApplication.shared().terminate(self)
    }
    
    func makeItem(title: String, action: Selector) -> NSMenuItem {
        let item = NSMenuItem()
        item.title = title
        item.target = self
        item.action = action
        
        return item
    }
    
    func makeStatusBar() {
        let menu = NSMenu()
        menu.autoenablesItems = true
        menu.addItem(makeItem(title: "Enable", action: #selector(switchMode)))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(makeItem(title: "Quit", action: #selector(quit)))
        
        statusItem.menu = menu
        
        modeOff();
    }
    
    override func awakeFromNib() {
        makeStatusBar()
    }
}
