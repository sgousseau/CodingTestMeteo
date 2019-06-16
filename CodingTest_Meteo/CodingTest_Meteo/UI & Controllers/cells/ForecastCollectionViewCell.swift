//
//  ForecastCollectionViewCell.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell, ForecastCellProtocol {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherText: UILabel!
    
}
