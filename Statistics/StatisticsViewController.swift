//
//  StatisticsViewController.swift
//  Timer
//
//  Created by Ingrid on 25/09/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    let viewModel = StatisticsViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let cellReuseIdentifier = "statsCell"
    var tableViewData: [Race] = []
    let dateFormatter = DateFormatter()
    var raceType: String = ""
    var raceLength: Int = 0
    var raceTimeTotal: Int = 0
    var raceLaps: Int = 0
    var raceDate: Date = Date()
    
    let sortByTypeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: Constants.white)
        button.setTitle("Run type", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .selected)
        button.titleLabel?.font = Constants.mainFontLarge
        button.addTarget(self, action: #selector(presentSort), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.tag = 1
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        return button
    }()
    
    let sortByDateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: Constants.white)
        button.setTitle("Date", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .selected)
        button.titleLabel?.font = Constants.mainFontLarge
        button.addTarget(self, action: #selector(presentDate), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.tag = 2
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        return button
    }()
    
    let sortByTimeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: Constants.white)
        button.setTitle("Time", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .selected)
        button.titleLabel?.font = Constants.mainFont
        button.addTarget(self, action: #selector(sortBySelected), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.tag = 3
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        return button
    }()
    
    let sortByLapsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: Constants.white)
        button.setTitle("No. of Laps", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .selected)
        button.titleLabel?.font = Constants.mainFont
        button.addTarget(self, action: #selector(sortBySelected), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.tag = 4
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        return button
    }()
    
    let sortByLapLengthButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: Constants.white)
        button.setTitle("Lap length", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), for: .selected)
        button.titleLabel?.font = Constants.mainFont
        button.addTarget(self, action: #selector(sortBySelected), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.tag = 5
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        return button
    }()
    
    let sortView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.main)
        return view
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: Constants.contrast)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.addTarget(self, action: #selector(editTable), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.tag = 1
        button.layer.cornerRadius = Constants.heightOfDisplay * 0.025
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        return button
    }()
    
    let editButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let headerLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Laps"
        label.textColor = UIColor(named: Constants.lightText)
        label.font = Constants.mainFontSB
        return label
    }()
    
    let headerLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = "Lap length"
        label.textAlignment = .center
        label.textColor = UIColor(named: Constants.lightText)
        label.font = Constants.mainFontSB
        return label
    }()
    
    let headerLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Speed"
        label.textColor = UIColor(named: Constants.lightText)
        label.font = Constants.mainFontSB
        return label
    }()
    
    let headerLabel4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Time"
        label.textColor = UIColor(named: Constants.lightText)
        label.font = Constants.mainFontSB
        return label
    }()

    
    let statsHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: Constants.accentDark)
        return view
    }()
    
    let statsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: Constants.accentDark)
        return tableView
    }()
    
    let testTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: Constants.accentDark)
        return tableView
    }()
    
    lazy var popUpView: PopUpView = {
        let view = PopUpView(frame: .zero, title: "")
        view.backgroundColor = UIColor(named: Constants.accentDark)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        viewModel.loadRace()
        statsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadRace()
        setResults()
        
        view.addSubview(sortView)
        sortView.addSubview(sortByTypeButton)
        sortView.addSubview(sortByDateButton)
        sortView.addSubview(sortByTimeButton)
        sortView.addSubview(sortByLapsButton)
        sortView.addSubview(sortByLapLengthButton)
        view.addSubview(statsHeader)
        statsHeader.addSubview(editButtonView)
        editButtonView.addSubview(editButton)
        statsHeader.addSubview(headerLabel1)
        statsHeader.addSubview(headerLabel2)
        statsHeader.addSubview(headerLabel3)
        statsHeader.addSubview(headerLabel4)
        view.addSubview(statsTableView)
        
        statsTableView.dataSource = self
        statsTableView.delegate = self
        statsTableView.register(StatisticsTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        statsTableView.tableFooterView = UIView()
        
        setConstraints()
    }
    
    private func setConstraints() {
        
        sortView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        sortView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.225).isActive = true
        sortView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sortView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        sortByTypeButton.topAnchor.constraint(equalTo: sortView.topAnchor, constant: Constants.sideMargin).isActive = true
        sortByTypeButton.bottomAnchor.constraint(equalTo: sortView.centerYAnchor, constant: -Constants.sideMargin / 2).isActive = true
        sortByTypeButton.leadingAnchor.constraint(equalTo: sortView.leadingAnchor, constant: Constants.sideMargin).isActive = true
        sortByTypeButton.trailingAnchor.constraint(equalTo: sortView.centerXAnchor, constant: -Constants.sideMargin / 2).isActive = true
        
        sortByDateButton.topAnchor.constraint(equalTo: sortView.topAnchor, constant: Constants.sideMargin).isActive = true
        sortByDateButton.bottomAnchor.constraint(equalTo: sortView.centerYAnchor, constant: -Constants.sideMargin / 2).isActive = true
        sortByDateButton.trailingAnchor.constraint(equalTo: sortView.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        sortByDateButton.leadingAnchor.constraint(equalTo: sortView.centerXAnchor, constant: Constants.sideMargin / 2).isActive = true
        
        let sortButtonWidth = (Constants.widthOfDisplay - Constants.sideMargin * 4) / 3
        sortByLapsButton.topAnchor.constraint(equalTo: sortView.centerYAnchor, constant: Constants.sideMargin / 2).isActive = true
        sortByLapsButton.bottomAnchor.constraint(equalTo: sortView.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        sortByLapsButton.leadingAnchor.constraint(equalTo: sortView.leadingAnchor, constant: Constants.sideMargin).isActive = true
        sortByLapsButton.widthAnchor.constraint(equalToConstant: sortButtonWidth).isActive = true
        
        sortByLapLengthButton.topAnchor.constraint(equalTo: sortView.centerYAnchor, constant: Constants.sideMargin / 2).isActive = true
        sortByLapLengthButton.bottomAnchor.constraint(equalTo: sortView.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        sortByLapLengthButton.leadingAnchor.constraint(equalTo: sortByLapsButton.trailingAnchor, constant: Constants.sideMargin).isActive = true
        sortByLapLengthButton.widthAnchor.constraint(equalToConstant: sortButtonWidth).isActive = true
        
        sortByTimeButton.topAnchor.constraint(equalTo: sortView.centerYAnchor, constant: Constants.sideMargin / 2).isActive = true
        sortByTimeButton.bottomAnchor.constraint(equalTo: sortView.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        sortByTimeButton.trailingAnchor.constraint(equalTo: sortView.trailingAnchor, constant: -Constants.sideMargin).isActive = true
        sortByTimeButton.leadingAnchor.constraint(equalTo: sortByLapLengthButton.trailingAnchor, constant: Constants.sideMargin).isActive = true
        
        statsHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statsHeader.topAnchor.constraint(equalTo: sortView.bottomAnchor).isActive = true
        statsHeader.heightAnchor.constraint(equalTo: sortView.heightAnchor, multiplier: 0.5).isActive = true
        statsHeader.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
       
        editButtonView.topAnchor.constraint(equalTo: statsHeader.topAnchor).isActive = true
        editButtonView.bottomAnchor.constraint(equalTo: statsHeader.bottomAnchor).isActive = true
        editButtonView.trailingAnchor.constraint(equalTo: headerLabel1.leadingAnchor).isActive = true
        editButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        editButton.centerXAnchor.constraint(equalTo: editButtonView.centerXAnchor).isActive = true
        editButton.centerYAnchor.constraint(equalTo: editButtonView.centerYAnchor).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.05).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.05).isActive = true

        
        headerLabel1.topAnchor.constraint(equalTo: statsHeader.topAnchor, constant: Constants.sideMargin).isActive = true
        headerLabel1.bottomAnchor.constraint(equalTo: statsHeader.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        headerLabel1.trailingAnchor.constraint(equalTo: headerLabel2.leadingAnchor).isActive = true
        headerLabel1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        headerLabel2.topAnchor.constraint(equalTo: statsHeader.topAnchor, constant: Constants.sideMargin).isActive = true
        headerLabel2.bottomAnchor.constraint(equalTo: statsHeader.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        headerLabel2.trailingAnchor.constraint(equalTo: headerLabel3.leadingAnchor).isActive = true
        headerLabel2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        
        headerLabel3.topAnchor.constraint(equalTo: statsHeader.topAnchor, constant: Constants.sideMargin).isActive = true
        headerLabel3.bottomAnchor.constraint(equalTo: statsHeader.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        headerLabel3.trailingAnchor.constraint(equalTo: headerLabel4.leadingAnchor).isActive = true
        headerLabel3.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        
        headerLabel4.topAnchor.constraint(equalTo: statsHeader.topAnchor, constant: Constants.sideMargin).isActive = true
        headerLabel4.bottomAnchor.constraint(equalTo: statsHeader.bottomAnchor, constant: -Constants.sideMargin).isActive = true
        headerLabel4.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerLabel4.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        
        statsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statsTableView.topAnchor.constraint(equalTo: statsHeader.bottomAnchor).isActive = true
        statsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        statsTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    @objc func presentSort(_ sender: UIButton) {
        let vc = SortViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    @objc func presentDate(_ sender: UIButton) {
        let vc = DateViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    @objc func sortBySelected(_ sender: UIButton) {
        
        if (sender.tag == 3) {
            let selected = "totalTime"
            if (sender.isSelected == true) {
                viewModel.sortBySelected(selected: selected, bool: true)
                sender.isSelected = false
            }
            else {
               viewModel.sortBySelected(selected: selected, bool: false)
               sender.isSelected = true
            }
        }
        
        if (sender.tag == 4) {
            let selected = "laps"
            if (sender.isSelected == true) {
                viewModel.sortBySelected(selected: selected, bool: true)
                sender.isSelected = false
            }
            else {
               viewModel.sortBySelected(selected: selected, bool: false)
               sender.isSelected = true
            }
        }
        
        if (sender.tag == 5) {
            let selected = "lapLength"
            if (sender.isSelected == true) {
                viewModel.sortBySelected(selected: selected, bool: true)
                sender.isSelected = false
            }
            else {
               viewModel.sortBySelected(selected: selected, bool: false)
               sender.isSelected = true
            }
        }

        tableViewData = viewModel.races
        
        DispatchQueue.main.async {
            self.statsTableView.reloadData()
        }
    }
    
    @objc func editTable(_ sender: UIButton) {
        self.statsTableView.isEditing = !self.statsTableView.isEditing
        //let title = (self.statsTableView.isEditing) ? "Done" : "Edit"
        //sender.setTitle(title, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToSorter"){
            let displayVC = segue.destination as! SortViewController
            displayVC.delegate = self
        }
    }
    
    //--** OBS MUST NOT BREAK VERY FIRST TIME APP IS OPENED; IE BEFORE THE FIRST RACE IS STORED ***___//

    
    private func setResults() {
        tableViewData = viewModel.races
    }
    
    func getType(race: Race) -> String? {
        return race.type
    }
    
    func saveRace() {
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
    }

    @objc func infoPopUp() {
        
        self.view.addSubview(visualEffectView)
        self.view.addSubview(popUpView)
        popUpView.addSubview(testTableView)
        
        popUpView.titleLabel.text = ""

        popUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        popUpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        popUpView.heightAnchor.constraint(equalToConstant: Constants.heightOfDisplay * 0.4).isActive = true
        popUpView.widthAnchor.constraint(equalToConstant: Constants.widthOfDisplay * 0.8).isActive = true
        
        testTableView.centerXAnchor.constraint(equalTo: popUpView.centerXAnchor).isActive = true
        testTableView.centerYAnchor.constraint(equalTo: popUpView.centerYAnchor).isActive = true
        testTableView.heightAnchor.constraint(equalTo: popUpView.heightAnchor).isActive = true
        testTableView.widthAnchor.constraint(equalTo: popUpView.widthAnchor).isActive = true
        
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
}

extension StatisticsViewController: PopUpDelegate {
    
    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpView.alpha = 0
            self.popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpView.removeFromSuperview()
        }
    }
}

extension StatisticsViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

extension StatisticsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! StatisticsTableViewCell

        dateFormatter.dateStyle = .short
        let date = (dateFormatter.string(from: self.tableViewData[indexPath.row].date ?? Date()))
        let laps = self.tableViewData[indexPath.row].laps
        let lapLength = self.tableViewData[indexPath.row].lapLength
        let totalTime = self.tableViewData[indexPath.row].totalTime
        let averageSpeed = self.tableViewData[indexPath.row].averageSpeed
        
        cell.label4.text = String(format: "%.2f", totalTime)
        cell.label2.text = String(lapLength)
        cell.label1.text = String(laps)
        cell.label3.text = String(format: "%.2f", averageSpeed)
        cell.label5.text = date
        cell.backgroundColor = UIColor(named: Constants.white)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height * 0.1125
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let race = self.tableViewData[indexPath.row]
            context.delete(race)
            tableViewData.remove(at: indexPath.row)
            statsTableView.deleteRows(at: [indexPath], with: .fade)
            saveRace()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationController = RaceDetailsViewController()
        destinationController.lapTimes = viewModel.setLapTimes(thisRace: tableViewData[indexPath.row])
        destinationController.averageSpeed = String(format: "%.2f",tableViewData[indexPath.row].averageSpeed)
        destinationController.time = String(format: "%.2f", tableViewData[indexPath.row].totalTime)
        destinationController.type = tableViewData[indexPath.row].type ?? ""
        
        dateFormatter.dateStyle = .short
        let date = (dateFormatter.string(from: self.tableViewData[indexPath.row].date ?? Date()))
        destinationController.date = date
        destinationController.laps = Int(tableViewData[indexPath.row].laps)
        
        let laps = Int(tableViewData[indexPath.row].laps)
        let lapLength = Int(tableViewData[indexPath.row].lapLength)
        let totalDist = laps * lapLength
        
        destinationController.lapLength = totalDist / laps

        
        navigationController?.pushViewController(destinationController, animated: false)
    }
}

extension StatisticsViewController: SortViewControllerDelegate {
    
    func sortByType(data: [String]) {
        viewModel.reloadData(userFilter: data)
        print(data)
        tableViewData = viewModel.races
        DispatchQueue.main.async{
            self.statsTableView.reloadData()
        }
    }
    
    func sortByDate(date: String) {
        
    }
}

extension StatisticsViewController: DateViewControllerDelegate {
    func setDate(data: [String]) {
        viewModel.reloadData(userFilter: data)
        tableViewData = viewModel.races
        
        DispatchQueue.main.async{
            self.statsTableView.reloadData()
        }
    }
}

