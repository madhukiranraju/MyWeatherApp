//
//  TempCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by madhu kiran on 06/01/21.
//

import UIKit

class TempCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var templbl: UILabel!
    @IBOutlet weak var forecastlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
