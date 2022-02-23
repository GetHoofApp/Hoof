//
//  GameOptionsRowController.swift
//  WatchHoof Extension
//
//  Created by Sameh Mabrouk on 31/01/2022.
//

import WatchKit

struct GameOption {
    let name: String
    let image: UIImage
}

class GameOptionsRowController: NSObject {
    
    @IBOutlet var separator: WKInterfaceSeparator!
    @IBOutlet var label: WKInterfaceLabel!
    @IBOutlet var image: WKInterfaceImage!
    
    var option: GameOption? {
      didSet {
        guard let option = option else { return }
        
          label.setText(option.name)
          image.setImage(option.image)
      }
    }
}
