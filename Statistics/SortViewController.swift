//
//  SortViewController.swift
//  Timer
//
//  Created by Ingrid on 28/09/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import UIKit

protocol SortViewControllerDelegate : NSObjectProtocol{
    func sortByType(data: [String])
    func sortByDate(date: String)
}

class SortViewController: UIViewController {
    
    var sortTableViewData = [Category]()
    let cellReuseIdentifier = "sortCell"
    var selectedTypes: [String] = []
    weak var delegate : SortViewControllerDelegate?
    var sortViewModel = SortViewModel()
    
    let sortTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: Constants.accentDark)
        tableView.allowsMultipleSelection = true
        return tableView
    }()
     
    let selectSortingButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.backgroundColor = UIColor(named: Constants.accentLight)
         button.setTitle("Select", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .selected)
         button.addTarget(self, action: #selector(selectSort), for: .touchUpInside)
         button.isUserInteractionEnabled = true
         button.tag = 1
         return button
    }()
    
    let closeSortingButton: UIButton = {
         let button = UIButton()
         button.translatesAutoresizingMaskIntoConstraints = false
         button.backgroundColor = UIColor(named: Constants.accentLight)
         button.setTitle("Close", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .selected)
         button.addTarget(self, action: #selector(close), for: .touchUpInside)
         button.tag = 1
         return button
     }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        view.addSubview(visualEffectView)
        view.addSubview(selectSortingButton)
        view.addSubview(closeSortingButton)
        view.addSubview(sortTableView)
        setConstraints()
        
        sortTableViewData = sortViewModel.favorites
        
        sortTableView.dataSource = self
        sortTableView.delegate = self
        sortTableView.register(StatisticsTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        sortTableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    private func setConstraints() {
        
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        sortTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sortTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.sideMargin).isActive = true
        sortTableView.bottomAnchor.constraint(equalTo: selectSortingButton.topAnchor, constant: -Constants.sideMargin).isActive = true
        sortTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin).isActive = true
        sortTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        
        selectSortingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        selectSortingButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.sideMargin).isActive = true
        selectSortingButton.heightAnchor.constraint(equalToConstant: Constants.smallButtons).isActive = true
        selectSortingButton.widthAnchor.constraint(equalToConstant: Constants.smallButtons).isActive = true
        
        closeSortingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        closeSortingButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -Constants.sideMargin).isActive = true
        closeSortingButton.heightAnchor.constraint(equalToConstant: Constants.smallButtons).isActive = true
        closeSortingButton.widthAnchor.constraint(equalToConstant: Constants.smallButtons).isActive = true
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func selectSort() {
        if let delegate = delegate {
            print(selectedTypes)
            delegate.sortByType(data: selectedTypes)
        }
        else {
            print("failed")
        }
        dismiss(animated: true, completion: nil)
    }
}

extension SortViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SortViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.sortTableViewData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortTableViewData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height * 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedType = sortTableViewData[indexPath.row].type ?? ""
        selectedTypes.append(selectedType)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedType = sortTableViewData[indexPath.row].name
        selectedTypes.removeAll{$0 == selectedType}
    }
}
