//
//  RaceStatistcsViewController.swift
//  Timer
//
//  Created by Ingrid on 16/11/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import UIKit

class RaceDetailsViewController: UIViewController {
    
    var unit = "m"
    var detail = "3:50"
    var icon = "Favourite"
    var name = "Time"
    var date = "3, July"
    var lapTimesData = ["Hei","på","deeeg","fgh","ghj","gh"]
    let cellReuseIdentifier = "cell"
    
    let summaryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.accentLight)
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        return view
    }()
    
    let summarytitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textColor = UIColor(named: Constants.lightText)
        label.textAlignment = .left
        label.font = Constants.mainFont
        label.text = "Run Stats"
        return label
    }()
    
    let summaryDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textColor = UIColor(named: Constants.lightText)
        label.textAlignment = .center
        label.font = Constants.mainFont
        return label
    }()
    
    let detailRowType: DetailRow = {
        let view = DetailRow(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailRowTime: DetailRow = {
        let view = DetailRow(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailRowDistance: DetailRow = {
        let view = DetailRow(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let detailRowSpeed: DetailRow = {
        let view = DetailRow(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lapsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.accentDark)
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        return view
    }()
    
    let tabLapslabel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: Constants.accentDark)
        button.setTitle("Lap times", for: .normal)
        button.setTitleColor(UIColor(named: Constants.lightText), for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.clipsToBounds = true
        button.layer.maskedCorners = [.layerMinXMinYCorner]
        button.addTarget(self, action: #selector(showLaps), for: .touchUpInside)
        return button
    }()
    
    let tabGraphLabel: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: Constants.accentLight)
        button.setTitle("Graph", for: .normal)
        button.setTitleColor(UIColor(named: Constants.lightText), for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.clipsToBounds = true
        button.layer.maskedCorners = [.layerMaxXMinYCorner]
        button.addTarget(self, action: #selector(showGraph), for: .touchUpInside)
        return button
    }()
    
    let lapTimeTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = Constants.cornerRadius
        tableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tableView.allowsSelection = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: Constants.main)
        view.addSubview(summaryView)
        
        summaryView.addSubview(summarytitleLabel)
        summaryView.addSubview(summaryDateLabel)
        
        summaryView.addSubview(detailRowType)
        summaryView.addSubview(detailRowTime)
        summaryView.addSubview(detailRowDistance)
        summaryView.addSubview(detailRowSpeed)
        
        detailRowType.setProperties(title: name, unit: "", icon: icon, detail: "")
        detailRowTime.setProperties(title: "Time", unit: "s", icon: icon, detail: detail)
        detailRowDistance.setProperties(title: "Total Distance", unit: "m", icon: icon, detail: detail)
        detailRowSpeed.setProperties(title: "Average Speed", unit: "km/h", icon: icon, detail: detail)
        summaryDateLabel.text = date

        view.addSubview(lapsView)
        lapsView.addSubview(tabLapslabel)
        lapsView.addSubview(tabGraphLabel)
        lapsView.addSubview(lapTimeTableView)
        
        lapTimeTableView.dataSource = self
        lapTimeTableView.delegate = self
        lapTimeTableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        summaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.sideMargin).isActive = true
        summaryView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin).isActive = true
        summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        
        summarytitleLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: Constants.sideMargin).isActive = true
        summarytitleLabel.heightAnchor.constraint(equalTo: summaryView.heightAnchor, multiplier: 1/6).isActive = true
        summarytitleLabel.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: Constants.sideMargin).isActive = true
        summarytitleLabel.trailingAnchor.constraint(equalTo: summaryView.centerXAnchor).isActive = true
        
        summaryDateLabel.topAnchor.constraint(equalTo: summaryView.topAnchor, constant: Constants.sideMargin).isActive = true
        summaryDateLabel.heightAnchor.constraint(equalTo: summaryView.heightAnchor, multiplier: 1/6).isActive = true
        summaryDateLabel.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        summaryDateLabel.leadingAnchor.constraint(equalTo: summaryView.centerXAnchor).isActive = true
        
        detailRowType.topAnchor.constraint(equalTo: summarytitleLabel.bottomAnchor).isActive = true
        detailRowType.heightAnchor.constraint(equalTo: summaryView.heightAnchor, multiplier: 1/6).isActive = true
        detailRowType.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: Constants.sideMargin).isActive = true
        detailRowType.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        
        detailRowTime.topAnchor.constraint(equalTo: detailRowType.bottomAnchor).isActive = true
        detailRowTime.heightAnchor.constraint(equalTo: summaryView.heightAnchor, multiplier: 1/6).isActive = true
        detailRowTime.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: Constants.sideMargin).isActive = true
        detailRowTime.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        
        detailRowDistance.topAnchor.constraint(equalTo: detailRowTime.bottomAnchor).isActive = true
        detailRowDistance.heightAnchor.constraint(equalTo: summaryView.heightAnchor, multiplier: 1/6).isActive = true
        detailRowDistance.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: Constants.sideMargin).isActive = true
        detailRowDistance.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        
        detailRowSpeed.topAnchor.constraint(equalTo: detailRowDistance.bottomAnchor).isActive = true
        detailRowSpeed.heightAnchor.constraint(equalTo: summaryView.heightAnchor, multiplier: 1/6).isActive = true
        detailRowSpeed.leadingAnchor.constraint(equalTo: summaryView.leadingAnchor, constant: Constants.sideMargin).isActive = true
        detailRowSpeed.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        
        lapsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        lapsView.topAnchor.constraint(equalTo: summaryView.bottomAnchor, constant: Constants.sideMargin).isActive = true
        lapsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin).isActive = true
        lapsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        
        tabLapslabel.topAnchor.constraint(equalTo: lapsView.topAnchor).isActive = true
        tabLapslabel.heightAnchor.constraint(equalTo: lapsView.heightAnchor, multiplier: 1/6).isActive = true
        tabLapslabel.leadingAnchor.constraint(equalTo: lapsView.leadingAnchor).isActive = true
        tabLapslabel.trailingAnchor.constraint(equalTo: lapsView.centerXAnchor).isActive = true
        
        tabGraphLabel.topAnchor.constraint(equalTo: lapsView.topAnchor).isActive = true
        tabGraphLabel.heightAnchor.constraint(equalTo: lapsView.heightAnchor, multiplier: 1/6).isActive = true
        tabGraphLabel.trailingAnchor.constraint(equalTo: lapsView.trailingAnchor).isActive = true
        tabGraphLabel.leadingAnchor.constraint(equalTo: lapsView.centerXAnchor).isActive = true
        
        lapTimeTableView.topAnchor.constraint(equalTo: tabLapslabel.bottomAnchor, constant: Constants.sideMargin / 2).isActive = true
        lapTimeTableView.bottomAnchor.constraint(equalTo: lapsView.bottomAnchor, constant: -Constants.sideMargin / 2).isActive = true
        lapTimeTableView.leadingAnchor.constraint(equalTo: lapsView.leadingAnchor).isActive = true
        lapTimeTableView.trailingAnchor.constraint(equalTo: lapsView.trailingAnchor).isActive = true
    }
    
    @objc private func showLaps() {
        lapTimeTableView.isHidden = false
        tabGraphLabel.backgroundColor = UIColor(named: Constants.accentLight)
        tabLapslabel.backgroundColor = UIColor(named: Constants.accentDark)
    }
    
    @objc private func showGraph() {
        lapTimeTableView.isHidden = true
        tabGraphLabel.backgroundColor = UIColor(named: Constants.accentDark)
        tabLapslabel.backgroundColor = UIColor(named: Constants.accentLight)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RaceDetailsViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

extension RaceDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.lapTimesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ResultsTableViewCell
        cell.timeLabel.text = self.lapTimesData[indexPath.row]
        cell.numberLabel.text = String(indexPath.row + 1)
        cell.backgroundColor = UIColor(named: Constants.accentDark)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height * 0.1
    }

}
