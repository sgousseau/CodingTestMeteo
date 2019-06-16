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
    
    let viewModel = WeatherViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        viewModel.isLoading
            .skip(1) //Skip 1 car le premier appel sera false, pas besoin de refresh l'UI
            .drive(onNext: { [unowned self] (loading) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = loading
                if !loading {
                    self.refreshUI()
                }
            })
            .disposed(by: viewModel.bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.refreshData()
    }
    
    // MARK: - UI
    
    func initUI() {
        tempValueLabel.text = viewModel.tempText
        windValueLabel.text = viewModel.windText
        cloudsValueLabel.text = viewModel.cloudsText
        humidityValueLabel.text = viewModel.humidityText
        pressureValueLabel.text = viewModel.pressureText
    }
    
    func refreshUI() {
        collectionView.fade().reloadSections([0])
        tempValueLabel.fade().text = viewModel.tempText
        windValueLabel.fade().text = viewModel.windText
        cloudsValueLabel.fade().text = viewModel.cloudsText
        humidityValueLabel.fade().text = viewModel.humidityText
        pressureValueLabel.fade().text = viewModel.pressureText
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    
    }
    
    // MARK: - Collection Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
    }
}
