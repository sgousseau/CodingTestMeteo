//
//  ViewController.swift
//  CodingTest_Meteo
//
//  Created by Sébastien Gousseau on 16/06/2019.
//  Copyright © 2019 Sébastien Gousseau. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    var viewModel = WeatherViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.isLoading
            .skip(1)
            .drive(onNext: { [unowned self] (loading) in
                if !loading {
                    self.performSegue(withIdentifier: R.segue.splashScreenViewController.splashToFirst, sender: self)
                }
            })
            .disposed(by: viewModel.bag)
        
        viewModel.refreshData()
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = R.segue.splashScreenViewController.splashToFirst(segue: segue)?.destination {
            controller.viewModel = viewModel
        }
    }
}

