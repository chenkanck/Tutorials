//
//  DRCBigIConButton.swift
//  CustomButton
//
//  Created by Kan Chen on 4/1/16.
//  Copyright © 2016 Kan Chen. All rights reserved.
//

import UIKit

@IBDesignable class DRCImagePositionButton: UIButton {
    @IBInspectable var topPadding: CGFloat = 5.0
    @IBInspectable var bottomPadding: CGFloat = 5.0
    @IBInspectable var imageHeight: CGFloat
    @IBInspectable var top: Bool = true
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        self.imageHeight = 32.0
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        self.imageHeight = 32.0
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let lableFrame = titleLabel?.frame else { return }
        guard let imageFrame = imageView?.frame else { return }
        let labelWidth = lableFrame.size.width
        let imageWidth = imageFrame.size.width
        let imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2

        let labelOffsetX = imageFrame.size.width / 2

        if !top {
            let imageOffsetY = (bounds.height - imageFrame.height)/2 - bottomPadding
            let labelOffsetY = (bounds.height - lableFrame.height)/2 - topPadding
            titleEdgeInsets = UIEdgeInsetsMake(
                -labelOffsetY,
                -labelOffsetX,
                labelOffsetY,
                labelOffsetX
            )
            imageEdgeInsets = UIEdgeInsetsMake(
                imageOffsetY,
                imageOffsetX,
                -imageOffsetY,
                -imageOffsetX
            )
        } else {
            // Image postion: Top
            let imageOffsetY = (bounds.height - imageFrame.height)/2 - topPadding
            let labelOffsetY = (bounds.height - lableFrame.height)/2 - bottomPadding
            titleEdgeInsets = UIEdgeInsetsMake(
                labelOffsetY,
                -labelOffsetX,
                -labelOffsetY,
                labelOffsetX
            )
            imageEdgeInsets = UIEdgeInsetsMake(
                -imageOffsetY,
                imageOffsetX ,
                imageOffsetY,
                -imageOffsetX
            )
        }


    }
}
