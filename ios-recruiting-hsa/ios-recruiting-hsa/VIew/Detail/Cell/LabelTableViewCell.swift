//
//  LabelTableViewCell.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
    @IBOutlet
    private weak var movieLabel: UILabel!
    private var separator: UIView!
    @IBOutlet
    private weak var favoriteButton: UIButton!
    @IBOutlet
    private weak var favoriteButtonWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareViews()
    }
    
    private func prepareViews() {
        movieLabel.numberOfLines = Constants.Text.numberOfLines
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (separator != nil) {
            separator.frame = DetailConstants.Cells.separatorFrame(width: bounds.size.width)
        }
    }
    
    func configure(title: String,
                   showSeparator: Bool,
                   showFavorite: Bool = false) {
        movieLabel.text = title
        
        if (showSeparator) {
            separator = UIView()
            separator.backgroundColor = .lightGray
            contentView.addSubview(separator)
        }
        
        favoriteButtonWidth.constant = showFavorite ? DetailConstants.Cells.Label.width : 0
    }
    
    override func prepareForReuse() {
        movieLabel.text = nil
    }
}