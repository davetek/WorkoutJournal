//
//  ExerciseCell.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 3/16/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import UIKit

protocol ExerciseCellDelegate {
    func didTapViewInBrowser(cellRow: Int)
}

class ExerciseCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    
    //this is set when cell is created from view controller, in tableView(tableView:cellForRowAtIndexPath)
    var cellRow: Int?
    
    var cellDelegate: ExerciseCellDelegate?
    
    
    @IBAction func viewInBrowserTapped(_ sender: UIButton) {
        if let cellRowNumber = cellRow {
            if let delegate = cellDelegate {
                delegate.didTapViewInBrowser(cellRow: cellRowNumber)
            }
        }
        
    }
    
    
}
