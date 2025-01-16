

import UIKit
class BottomSheetView: UIView {
    
    // MARK: - UI Components
    let profitAndLossButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Profit & Loss: ₹0.00", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private let currentValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Current Value:"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let totalInvestmentLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Investment:"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let todayPNLLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's P&L:"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGreen
        return label
    }()
    
    private let currentValueValueLabel: UILabel = {
        let label = UILabel()
        label.text = "₹0.00"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    private let totalInvestmentValueLabel: UILabel = {
        let label = UILabel()
        label.text = "₹0.00"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    private let todayPNLValueLabel: UILabel = {
        let label = UILabel()
        label.text = "₹0.00"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        label.textColor = .systemGreen
        return label
    }()
    
    // MARK: - Properties
    var bottomAnchorConstraint: NSLayoutConstraint?
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupActions() // Add actions to the button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 8
        
        addSubview(profitAndLossButton)
        addSubview(currentValueLabel)
        addSubview(currentValueValueLabel)
        addSubview(totalInvestmentLabel)
        addSubview(totalInvestmentValueLabel)
        addSubview(todayPNLLabel)
        addSubview(todayPNLValueLabel)
    }
    
    private func setupConstraints() {
        profitAndLossButton.translatesAutoresizingMaskIntoConstraints = false
        currentValueLabel.translatesAutoresizingMaskIntoConstraints = false
        currentValueValueLabel.translatesAutoresizingMaskIntoConstraints = false
        totalInvestmentLabel.translatesAutoresizingMaskIntoConstraints = false
        totalInvestmentValueLabel.translatesAutoresizingMaskIntoConstraints = false
        todayPNLLabel.translatesAutoresizingMaskIntoConstraints = false
        todayPNLValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profitAndLossButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            profitAndLossButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profitAndLossButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profitAndLossButton.heightAnchor.constraint(equalToConstant: 50),
            
            currentValueLabel.topAnchor.constraint(equalTo: profitAndLossButton.bottomAnchor, constant: 16),
            currentValueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            currentValueValueLabel.centerYAnchor.constraint(equalTo: currentValueLabel.centerYAnchor),
            currentValueValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            totalInvestmentLabel.topAnchor.constraint(equalTo: currentValueLabel.bottomAnchor, constant: 8),
            totalInvestmentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalInvestmentValueLabel.centerYAnchor.constraint(equalTo: totalInvestmentLabel.centerYAnchor),
            totalInvestmentValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            todayPNLLabel.topAnchor.constraint(equalTo: totalInvestmentLabel.bottomAnchor, constant: 8),
            todayPNLLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            todayPNLValueLabel.centerYAnchor.constraint(equalTo: todayPNLLabel.centerYAnchor),
            todayPNLValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func setupActions() {
        // Add action to the button
        profitAndLossButton.addTarget(self, action: #selector(profitAndLossButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Button Action
    @objc private func profitAndLossButtonTapped() {
        
    }
    
    // MARK: - Update Methods
    
    func updateProfitAndLoss(profitAndLoss: Double, currentValue: Double, totalInvestment: Double, todayPNL: Double) {
        let formattedProfitAndLoss = String(format: "₹%.2f", profitAndLoss)
        profitAndLossButton.setTitle("Profit & Loss: \(formattedProfitAndLoss)", for: .normal)
        
        currentValueValueLabel.text = "₹\(String(format: "%.2f", currentValue))"
        totalInvestmentValueLabel.text = "₹\(String(format: "%.2f", totalInvestment))"
        todayPNLValueLabel.text = "₹\(String(format: "%.2f", todayPNL))"
    }
}
