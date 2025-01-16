//
//  PortfolioViewController.swift
//  SulaimanTask
//
//  Created by Mohammed Sulaiman on 15/01/25.
//


import UIKit

class PortfolioViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = HoldingsViewModel()
    private let bottomSheetView = BottomSheetView()
    private var isBottomSheetExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupBottomSheetView()
        viewModel.onDataUpdated = {
            self.tableView.reloadData()
            self.updateProfitAndLoss()
        }
        viewModel.loadHoldings()
    }
    
    private func setupTableView() {
        tableView.register(HoldingTableViewCell.self, forCellReuseIdentifier: HoldingTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor , constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupBottomSheetView() {
        view.addSubview(bottomSheetView)
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        
        // Initially closed, showing only the button
        bottomSheetView.bottomAnchorConstraint = bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 150)
        bottomSheetView.bottomAnchorConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Add action for the button
        bottomSheetView.profitAndLossButton.addTarget(self, action: #selector(toggleBottomSheet), for: .touchUpInside)
    }
    
    private func updateProfitAndLoss() {
        viewModel.updateProfitAndLossForView(bottomSheetView: bottomSheetView)
    }
    
    @objc private func toggleBottomSheet() {
        isBottomSheetExpanded.toggle()
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetView.bottomAnchorConstraint?.constant = self.isBottomSheetExpanded ? 0 : 150
            self.view.layoutIfNeeded()
        }
    }
}

extension PortfolioViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfHoldings()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HoldingTableViewCell.identifier, for: indexPath) as? HoldingTableViewCell else {
            return UITableViewCell()
        }
        let holding = viewModel.holding(at: indexPath.row)
        cell.configure(with: holding)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  90
    }
}

