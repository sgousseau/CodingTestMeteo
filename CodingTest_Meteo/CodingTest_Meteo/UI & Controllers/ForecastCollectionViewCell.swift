//
//  ForecastCollectionViewCell.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherText: UILabel!
    private static var _attributedStringPattern: NSAttributedString!
    
    var forecast: Forecast?
    var viewModel: WeatherViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if ForecastCollectionViewCell._attributedStringPattern == nil {
           ForecastCollectionViewCell._attributedStringPattern = weatherText.attributedText
        }
    }
    
    func configure() {
        if let f = self.forecast {
            let weatherText = viewModel.detailCollectionViewCellText(pattern: ForecastCollectionViewCell._attributedStringPattern, forecast: f)
            let weatherIcon = viewModel.forecastIcon(forecast: f)
            
            self.weatherText.attributedText = weatherText
            self.weatherIcon.image = weatherIcon
        }
    }
}
