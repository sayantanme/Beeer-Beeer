//
//  BeerCells.swift
//  Beeer-Beeer
//
//  Created by Sayantan Chakraborty on 29/06/18.
//  Copyright © 2018 Personal. All rights reserved.
//

import UIKit

class BeerCells: UITableViewCell {

    @IBOutlet weak var contentBeerView: UIView!
    @IBOutlet weak var imgbeer: UIImageView! = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 16
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerType: UILabel!
    @IBOutlet weak var beerAlContent: UILabel!
    @IBOutlet weak var beerEmotion: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBInspectable var cornerRadius: CGFloat = 10
    
    @IBInspectable var shadowOffsetWidth: Int = 1
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5
    
    override func layoutSubviews() {
        contentBeerView.layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        contentBeerView.layer.masksToBounds = false
        contentBeerView.layer.shadowColor = shadowColor?.cgColor
        contentBeerView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        contentBeerView.layer.shadowOpacity = shadowOpacity
        contentBeerView.layer.shadowPath = shadowPath.cgPath
        contentBeerView.layer.borderWidth = 0.5
        contentBeerView.layer.borderColor =  UIColor.red.cgColor
        //UIColor(red:0.00, green:0.87, blue:0.39, alpha:1.0).cgColor
    }

}
