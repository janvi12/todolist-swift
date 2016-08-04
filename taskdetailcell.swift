//
//  taskdetailcell.swift
//  todolist
//

import UIKit

class taskdetailcell: UITableViewCell
{
    @IBOutlet var btnCheckBox: UIButton!
    @IBOutlet var btnDeleteTask: UIButton!
    @IBOutlet var txtViewTask: UITextView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
