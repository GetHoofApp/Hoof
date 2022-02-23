//
//  SettingsInterfaceController.swift
//  WatchHoof Extension
//
//  Created by Sameh Mabrouk on 01/02/2022.
//

import WatchKit
import Foundation

class SettingsInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var settingsTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
                
        settingsTable.setNumberOfRows(1, withRowType: "SettingsRow")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
