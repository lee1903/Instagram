//
//  PostCell.swift
//  Instagram
//
//  Created by Brian Lee on 2/23/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
