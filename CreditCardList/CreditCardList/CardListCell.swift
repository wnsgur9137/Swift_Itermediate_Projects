//
//  CardListCell.swift
//  CreditCardList
//
//  Created by 이준혁 on 2022/08/08.
//

import UIKit

class CardListCell: UITableViewCell {

    @IBOutlet var cardImageView: UIImageView!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var promotionLabel: UILabel!
    @IBOutlet var cardNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
