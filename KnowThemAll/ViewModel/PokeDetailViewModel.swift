//
//  PokeDetailViewModel.swift
//  KnowThemAll
//
//  Created by Данік on 19/07/2023.
//

import Foundation
import UIKit
import SnapKit

final class PokeDetailViewModel: UIViewController {
    
    let pokeDetailView = PokeDetailView()
    var chosenPokemon: PokeModel?
    let stats = ["Height", "Weight", "Power", "Attack", "Damage"]
    var values: [String] = []
    
    override func loadView() {
        view = pokeDetailView
        pokeDetailView.backArrow.addTarget(self, action: #selector(backArrowTapped(_:)), for: .touchUpInside)
        guard let chosenPokemon = chosenPokemon else { return }
        guard let name = chosenPokemon.name,
              let imageUrl = chosenPokemon.imageUrl else { return }
        pokeDetailView.configure(withName: name, withUrl: imageUrl)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StatsTableViewCell.self, forCellReuseIdentifier: StatsTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    @objc private func backArrowTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(pokeDetailView.segmentedControl.snp.bottom).offset(20)
        }
    }
}

extension PokeDetailViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatsTableViewCell.reuseIdentifier, for: indexPath) as? StatsTableViewCell else {return UITableViewCell()}
        cell.configure(withStat: stats[indexPath.row], withValue: values[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired height for each cell (including the additional spacing)
        return 40  // Adjust the value to add more space
    }
}
