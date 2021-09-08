//
//  MainTableViewCell.swift
//  Mega-F-Service_TestTask
//
//  Created by Сергей Горбачёв on 07.09.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    private let backgroundViewCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let onOffCircularView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        return view
    }()
    
    private let onLineLabel: UILabel = {
        let label = UILabel()
        label.text = "ON LINE"
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.textColor = .white
        return label
    }()
    
    private var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var onLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.text = "ДАТЧИК ГАЗА"
        label.font = UIFont(name: "Roboto-Regular", size: 24)
        label.textColor = #colorLiteral(red: 0.09803921569, green: 0.1294117647, blue: 0.1725490196, alpha: 1)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.137254902, green: 0.1294117647, blue: 0.5960784314, alpha: 1)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rocket")
        return imageView
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "РАБОТАЕТ"
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.textColor = .white
        return label
    }()
    
    private var statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "time")
        imageView.isHidden = true
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "03:12:16"
        label.font = UIFont(name: "Roboto-Regular", size: 12)
        label.textColor = .white
        label.isHidden = true
        return label
    }()
    
    private var timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setConstraints()
        backgroundGradient()
        
        onOffCircularView.layer.cornerRadius = onOffCircularView.frame.width / 2
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()

        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(device: Datum) {
        onOffCircularView.backgroundColor = device.isOnline ? #colorLiteral(red: 0, green: 1, blue: 0.03921568627, alpha: 1) : #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        onLineLabel.text = device.isOnline ? "ON LINE" : "OFF LINE"
        productName.text = device.name.rawValue == "Датчик газа" ? "ДАТЧИК ГАЗА" : "РОБОТ ПЫЛЕСОС"
        
        switch device.status {
        case "Работает":
            statusLabel.text = "РАБОТАЕТ"
            showTimeView()
        case "Выключен":
            statusLabel.text = "ВЫКЛЮЧЕН"
            hideTimeView()
        case "1":
            statusLabel.text = "РАБОТАЕТ"
            showTimeView()
        case "2":
            statusLabel.text = "ГАЗ НЕ ОБНАРУЖЕН"
            hideTimeView()
        default:
            statusLabel.text = "НЕОПРЕДЕЛЕНО"
            hideTimeView()
        }
        statusImageView.image = device.type == 1 ? UIImage(named: "rocket") : UIImage(named: "stop")
    }

    private func hideTimeView() {
        timeLabel.isHidden = true
        timeImageView.isHidden = true
    }
    
    private func showTimeView() {
        timeLabel.isHidden = false
        timeImageView.isHidden = false
    }
    
    private func backgroundGradient() {
        let topColor = #colorLiteral(red: 0.6705882353, green: 0.4117647059, blue: 1, alpha: 1).cgColor
        let bottomColor = #colorLiteral(red: 0.2862745098, green: 0.2941176471, blue: 0.9215686275, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backgroundViewCell.bounds
        gradientLayer.colors = [topColor, bottomColor]
        backgroundViewCell.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupViews() {
        self.addSubview(backgroundViewCell)
        backgroundViewCell.addSubview(onOffCircularView)
        self.addSubview(productImageView)
  
        onLineStackView = UIStackView(arrangedSubviews: [onOffCircularView, onLineLabel],
                                      axis: .horizontal,
                                      spacing: 5,
                                      distribution: .fillProportionally)
        self.addSubview(onLineStackView)
        
        self.addSubview(productName)
        self.addSubview(statusView)
        
        statusStackView = UIStackView(arrangedSubviews: [statusImageView, statusLabel],
                                      axis: .horizontal,
                                      spacing: 18,
                                      distribution: .fillProportionally)
        self.addSubview(statusStackView)
        
        timeStackView = UIStackView(arrangedSubviews: [timeImageView, timeLabel],
                                    axis: .horizontal,
                                    spacing: 7,
                                    distribution: .fillProportionally)
        self.addSubview(timeStackView)
    }
    
    private func setConstraints() {

        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: backgroundViewCell.topAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(equalToConstant: 98),
            productImageView.widthAnchor.constraint(equalToConstant: 98)
        ])
        
        NSLayoutConstraint.activate([
            onOffCircularView.heightAnchor.constraint(equalToConstant: 12),
            onOffCircularView.widthAnchor.constraint(equalToConstant: 12)
        ])

        NSLayoutConstraint.activate([
            onLineStackView.topAnchor.constraint(equalTo: backgroundViewCell.topAnchor, constant: 16),
            onLineStackView.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 17),
            onLineStackView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: onLineStackView.topAnchor, constant: 14),
            productName.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 17),
            productName.widthAnchor.constraint(equalToConstant: 120),
            productName.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            statusView.bottomAnchor.constraint(equalTo: backgroundViewCell.bottomAnchor, constant: -11),
            statusView.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15),
            statusView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            statusStackView.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
            statusStackView.leadingAnchor.constraint(equalTo: statusView.leadingAnchor, constant: 10),
            statusStackView.trailingAnchor.constraint(equalTo: statusView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            timeImageView.heightAnchor.constraint(equalToConstant: 20),
            timeImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            timeStackView.bottomAnchor.constraint(equalTo: backgroundViewCell.bottomAnchor, constant: -16),
            timeStackView.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -17),
            timeStackView.widthAnchor.constraint(equalToConstant: 80),
            timeStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


