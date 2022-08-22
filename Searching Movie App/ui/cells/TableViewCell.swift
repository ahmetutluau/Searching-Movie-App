//
//  TableViewCell.swift
//  Searching Movie App
//
//  Created by MAC on 19.08.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
