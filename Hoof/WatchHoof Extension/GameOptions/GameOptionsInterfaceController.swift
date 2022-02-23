//
//  GameOptionsInterfaceController.swift
//  WatchHoof Extension
//
//  Created by Sameh Mabrouk on 31/01/2022.
//

import WatchKit
import Foundation

class GameOptionsInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var gameOptionsTable: WKInterfaceTable!
    
    let gameOptions = [
        GameOption(name: "Game", image: UIImage(named: "game")!),
        GameOption(name: "Training", image: UIImage(named: "training")!)
    ]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        becomeCurrentPage()
        
        gameOptionsTable.setNumberOfRows(gameOptions.count, withRowType: "GameOptionRow")
        
        for index in 0..<gameOptionsTable.numberOfRows {
          guard let controller = gameOptionsTable.rowController(at: index) as? GameOptionsRowController else { continue }

          controller.option = gameOptions[index]
        }        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        WKInterfaceController.reloadRootPageControllers(
            withNames: ["trackingControl", "tracking"],
            contexts: nil,
            orientation: .horizontal,
            pageIndex: 1)
    }
}
