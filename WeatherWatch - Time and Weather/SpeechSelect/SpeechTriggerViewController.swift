//
//  SelectedSpeechTrigger.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 5/6/2023.
//

import UIKit

class SpeechSelectViewController: UITableViewController {

    let viewModel: SpeechSelectViewModel

    init(viewModel: SpeechSelectViewModel) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - UITableView DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TriggerCell", for: indexPath)
        let trigger = viewModel.trigger(forIndexPath: indexPath)
        cell.textLabel?.text = trigger.rawValue
        cell.accessoryType = viewModel.isSelectedTrigger(atIndexPath: indexPath) ? .checkmark : .none
        return cell
    }

    // MARK: - UITableView Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectTrigger(atIndexPath: indexPath)
        tableView.reloadData()

        // Handle the selected trigger
        viewModel.handleSelectedTrigger()
    }
}
