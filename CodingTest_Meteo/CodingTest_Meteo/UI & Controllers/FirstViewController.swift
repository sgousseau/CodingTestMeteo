//
//  FirstViewController.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var refreshButton:       UIButton!
    @IBOutlet weak var globalWeatherImage:  UIImageView!
    @IBOutlet weak var tempValueLabel:      UILabel!
    @IBOutlet weak var windValueLabel:      UILabel!
    @IBOutlet weak var cloudsValueLabel:    UILabel!
    @IBOutlet weak var humidityValueLabel:  UILabel!
    @IBOutlet weak var pressureValueLabel:  UILabel!
    @IBOutlet weak var globalInfosView:     UIView!
    @IBOutlet weak var collectionView:      UICollectionView!
    
    var viewModel: WeatherViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshUI()
        
        viewModel.isLoading
            .drive(onNext: { [unowned self] (loading) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = loading
                if !loading {
                    self.refreshUI()
                }
            })
            .disposed(by: viewModel.bag)
        
        refreshButton.rx.tap
            .bind(to: viewModel.shouldRefresh)
            .disposed(by: viewModel.bag)
    }
    
    // MARK: - UI
    
    func refreshUI() {
        collectionView.fade().reloadData()
        globalWeatherImage.fade().image = viewModel.currentWeatherIcon()
        tempValueLabel.fade().text = viewModel.tempText
        windValueLabel.fade().text = viewModel.windText
        cloudsValueLabel.fade().text = viewModel.cloudsText
        humidityValueLabel.fade().text = viewModel.humidityText
        pressureValueLabel.fade().text = viewModel.pressureText
    }
    
    // MARK: - Collection Delegate
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.forecastCollectionViewCell, for: indexPath)!
        cell.viewModel = viewModel
        cell.forecast = viewModel.fiveDaysForecast[indexPath.section][indexPath.row]
        cell.configure()
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.fiveDaysForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.fiveDaysForecast[section].count
    }
}
