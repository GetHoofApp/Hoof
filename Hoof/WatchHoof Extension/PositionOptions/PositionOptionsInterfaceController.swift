//
//  PositionOptionsInterfaceController.swift
//  WatchHoof Extension
//
//  Created by Sameh Mabrouk on 08/02/2022.
//

import WatchKit
import Foundation


class PositionOptionsInterfaceController: WKInterfaceController {

    @IBOutlet weak var positionOptionsTable: WKInterfaceTable!

    let positions = ["GoalKeeper",
                     "Left center-back",
                     "Center back",
                     "Right center-back",
                     "Left back",
                     "Defense midfield",
                     "Right back",
                     "Left midfielder",
                     "Center midfielder",
                     "Right midfielder",
                     "Left forward",
                     "Center forward",
                     "Right forward"
    ]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        print("RowsCount: \(positions.count)")
        positionOptionsTable.setNumberOfRows(positions.count, withRowType: "PositionRow")
        
        for index in 0..<positionOptionsTable.numberOfRows {
          guard let controller = positionOptionsTable.rowController(at: index) as? PositionOptionsRowController else { continue }

          controller.option = positions[index]
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
        NotificationCenter.default.post(name: .PositionSelectedForFirstHalf, object: nil)
        dismiss()
    }
}
