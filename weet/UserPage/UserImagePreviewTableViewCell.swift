//
//  UserImagePreviewTableViewCell.swift
//  weet
//
//  Created by owner on 2019/01/10.
//  Copyright © 2019 GS. All rights reserved.
//

import UIKit

class UserImagePreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePreview: UIImageView!
    
    func cellViewData(num: IndexPath, imageName: String) {
        self.imagePreview.image = UIImage(named: imageName)
    }
}
