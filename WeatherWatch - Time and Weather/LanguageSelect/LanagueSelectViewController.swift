//
//  LanagueSelectViewController.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 11/6/2023.
//

import UIKit

class LanguageSelectionViewController: UITableViewController {
    private let viewModel: LanguageSelectViewModel
    
    private let coordinator: SettingsCoordinator

    init(viewModel: LanguageSelectViewModel, coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(LanguageSelectCell.self, forCellReuseIdentifier: LanguageSelectCell.reuseIdentifier)
    }
}

extension LanguageSelectionViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLanguages
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageSelectCell.reuseIdentifier, for: indexPath) as! LanguageSelectCell
        
        let language = viewModel.language(at: indexPath.row)
        let isSelected = language == viewModel.selectedLanguage
        
        cell.configure(with: language, isSelected: isSelected)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Update the selected language
        viewModel.selectLanguage(at: indexPath.row)
        
        // update user config
        self.viewModel.updateConfig()
        
        // Reload the table view to update checkmark
        tableView.reloadData()
    }
}
