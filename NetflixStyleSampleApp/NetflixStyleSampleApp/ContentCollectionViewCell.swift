//
//  ContentCollectionViewCell.swift
//  NetflixStyleSampleApp
//
//  Created by 이준혁 on 2022/09/06.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        
        // image View AutoLayout
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
