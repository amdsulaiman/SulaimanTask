//
//  HoldingTableViewCell.swift
//  SulaimanTask
//
//  Created by Mohammed Sulaiman on 13/01/25.
//


import UIKit

class HoldingTableViewCell: UITableViewCell {
    static let identifier = "HoldingTableViewCell"

    // Left side labels
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private let netQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    // Right side labels
    private let ltpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()

    private let pnlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(netQuantityLabel)
        contentView.addSubview(ltpLabel)
        contentView.addSubview(pnlLabel)

        // Auto Layout Constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        netQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        ltpLabel.translatesAutoresizingMaskIntoConstraints = false
        pnlLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Left side
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            netQuantityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            netQuantityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            netQuantityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            // Right side
            ltpLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ltpLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),

            pnlLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pnlLabel.topAnchor.constraint(equalTo: ltpLabel.bottomAnchor, constant: 4),
            pnlLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    // MARK: - Configuration
    func configure(with holding: Holding) {
        nameLabel.text = holding.symbol
        netQuantityLabel.text = "NET QTY: \(holding.quantity)"
        ltpLabel.text = "LTP: ₹\(holding.ltp)"
        let profitLoss = (holding.ltp - holding.avgPrice) * Double(holding.quantity)
        let formattedProfitLoss = String(format: "%.2f", profitLoss)
        pnlLabel.text = "P&L: ₹\(formattedProfitLoss)"
        pnlLabel.textColor = profitLoss >= 0 ? .green : .red
    }

}
