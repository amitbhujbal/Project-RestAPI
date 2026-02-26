//
//  ProductTableViewCell.swift
//  Protect-RestAPI
//
//  Created by Amit Bhujbal on 25/02/2026.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        categoryLabel.backgroundColor = .systemRed
        categoryLabel.textColor = .white
        categoryLabel.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
    }

}
