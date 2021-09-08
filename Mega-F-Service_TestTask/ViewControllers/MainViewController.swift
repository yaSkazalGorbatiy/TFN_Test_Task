//
//  ViewController.swift
//  Mega-F-Service_TestTask
//
//  Created by Сергей Горбачёв on 07.09.2021.
//

import UIKit
import SVGKit

class MainViewController: UIViewController {
    
    private let refreshButton: UIButton = {
        let button = UIButton()
        button.setTitle("Обновить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let smartThingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Умные вещи"
        label.textColor = #colorLiteral(red: 0.6075592637, green: 0.4817877412, blue: 0.9792199731, alpha: 1)
        label.font = UIFont(name: "Roboto-Regular", size: 24)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let errorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1254901961, blue: 0.1764705882, alpha: 1)
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 24)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.isHidden = true
        return label
    }()
    
    private let errorButton: UIButton = {
        let button = UIButton()
        button.setTitle("ОБНОВИТЬ", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.backgroundColor = #colorLiteral(red: 0.137254902, green: 0.1294117647, blue: 0.5960784314, alpha: 1)
        button.isHidden = true
        return button
    }()
    
    private var errorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let deleteAlert = DeleteAlert()
    
    let idIdentifierCell = "idIdentifierCell"
    
    var devices: DevicesModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        loadingModel()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: idIdentifierCell)
        
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        errorButton.addTarget(self, action: #selector(errorButtonTapped), for: .touchUpInside)
    }
    
    private func setupViews() {
        
        view.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1294117647, blue: 0.1725490196, alpha: 1)
        
        view.addSubview(smartThingsLabel)
        view.addSubview(tableView)
        view.addSubview(refreshButton)
        
        view.addSubview(errorView)
        errorStackView = UIStackView(arrangedSubviews: [errorLabel,errorButton],
                                     axis: .vertical,
                                     spacing: 50,
                                     distribution: .fillProportionally)
        errorView.addSubview(errorStackView)
    }
    
    private func loadingModel() {
        NetworkDataFetch.shared.fetchDevices { [self] devicesModel, error  in
            if error == nil {
                guard let devicesModel = devicesModel else { return }
                self.devices = devicesModel
                self.tableView.reloadData()
            } else {
                errorLoading(error: error)
            }
        }
    }
    
    private func errorLoading(error: Error?) {
        errorView.isHidden = false
        errorLabel.isHidden = false
        errorButton.isHidden = false
        
        guard let error = error else { return }
        errorLabel.text = "Что-то пошло не так, ошибка \(error.localizedDescription)"
    }
    
    @objc private func refreshButtonTapped() {
        devices = nil
        loadingModel()
        tableView.reloadData()
    }
    
    @objc private func errorButtonTapped() {
        errorView.isHidden = true
        errorLabel.isHidden = true
        errorButton.isHidden = true
        loadingModel()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        devices?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idIdentifierCell, for: indexPath) as! MainTableViewCell
        guard let device = devices?.data[indexPath.row] else { return cell }
        cell.cellConfigure(device: device)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let deviceName = devices?.data[indexPath.row].name.rawValue else { return }
        deleteAlert.showDeleteAlert(with: deviceName, on: self) {
            self.devices?.data.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}

extension MainViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            refreshButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            refreshButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -26),
            refreshButton.widthAnchor.constraint(equalToConstant: 150),
            refreshButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            smartThingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            smartThingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            smartThingsLabel.widthAnchor.constraint(equalToConstant: 90),
            smartThingsLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: smartThingsLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            errorButton.heightAnchor.constraint(equalToConstant: 50),
            errorButton.widthAnchor.constraint(equalToConstant: 140),
            
            errorStackView.centerYAnchor.constraint(equalTo: errorView.centerYAnchor),
            errorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}


