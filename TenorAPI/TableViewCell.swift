//
//  TableViewCell.swift
//  TenorAPI
//
//  Created by Matheus Lima Ferreira on 28/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var gif: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
