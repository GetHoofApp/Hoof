//
//  GameOptionsRowController.swift
//  WatchHoof Extension
//
//  Created by Sameh Mabrouk on 08/02/2022.
//

import WatchKit

import WatchKit

class PositionOptionsRowController: NSObject {
    
    @IBOutlet var separator: WKInterfaceSeparator!
    @IBOutlet var label: WKInterfaceLabel!
    
    var option: String? {
        didSet {
            guard let option = option else { return }
            
            label.setText(option)
        }
    }
}
