//
//  SimpleCell.swift
//  ReelsPageUIkit
//
//  Created by Noman belim on 09/02/26.
//

import UIKit
import UIKit

class SimpleCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
