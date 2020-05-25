//
//  HistoryViewController.swift
//  ScAnimals
//
//  Created by I on 2/28/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {

    private var history: [HistoryModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchHistory()
    }
}

extension HistoryViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return history.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryItem.cellIdentifier(), for: indexPath) as? HistoryItem
        cell?.selectionStyle = .none
        cell?.configure(with: history[indexPath.row])
        return cell!
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            StoreManager.shared().removeAnimalFromHistory(with: indexPath.row)
            history.remove(at: indexPath.row)
            if history.isEmpty == true {
                tableView.backgroundView = MessageBackgroundView(with: "У вас нету истории")
            }
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
}

private extension HistoryViewController {

    func fetchHistory() -> Void {
        if let history = StoreManager.shared().fetchHistory(),
            history.isEmpty == false
        {
            self.history = history
            tableView.backgroundView = nil
        }
        else {
            self.history = []
            tableView.backgroundView = MessageBackgroundView(with: "У вас нету истории")
        }

        self.history.forEach { (his) in
            print(his.date)
        }
        tableView.reloadData()
    }
}

private extension HistoryViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        //table view
        tableView.backgroundColor = #colorLiteral(red: 0.231372549, green: 0.2470588235, blue: 0.2823529412, alpha: 1)
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()

        //navigation item
        navigationItem.title = "История"
    }

    func buildLayouts() -> Void {

    }

    func buildServices() -> Void {

        tableView.register(HistoryItem.self, forCellReuseIdentifier: HistoryItem.cellIdentifier())
    }
}

