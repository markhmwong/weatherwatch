//
//  TimeFormatViewController.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 11/6/2023.
//

import UIKit

class TimeFormatSelectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let viewModel: TimeFormatViewModel
    private let coordinator: SettingsCoordinator
    
    init(viewModel: TimeFormatViewModel, coordinator: SettingsCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TimeFormatCell.self, forCellWithReuseIdentifier: "TimeFormatCell")
        collectionView.backgroundColor = .white
    }
    
    // MARK: - Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfOptions
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeFormatCell", for: indexPath) as! TimeFormatCell
        let option = viewModel.option(at: indexPath.row)
        cell.optionLabel.text = option.rawValue
        cell.optionLabel.text = option.formatName
        
        switch option {
        case .hourMinuteSecond:
            cell.sampleLabel.text = "10:26:00"
        case .hourMinuteSecondMillisecond:
            cell.sampleLabel.text = "10:26:00:234"
        }
        
        
        if option == viewModel.selectedTimeFormat {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        } else {
            cell.isSelected = false
        }
        
        return cell
    }
    
    // MARK: - Collection View Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Update the selected time format
        viewModel.selectTimeFormat(at: indexPath.row)
        viewModel.updateConfig()
        // Reload the collection view to update selection
        collectionView.reloadData()
        
        // Do something with the selected time format
        let selectedTimeFormat = viewModel.selectedTimeFormat
        print("Selected time format: \(selectedTimeFormat?.rawValue ?? "")")
    }
    
    // MARK: - Collection View Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        return CGSize(width: width, height: 80)
    }
}


