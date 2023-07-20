//
//  MainView.swift
//  KnowThemAll
//
//  Created by Данік on 10/07/2023.
//

import Foundation
import UIKit
import SnapKit

@IBDesignable
final class MainScreen: UIViewController, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView!
    
    private var collectionViewOffset: CGFloat = 20
    private var spacingUpDown: CGFloat = 10
    private var spacingLeftRight: CGFloat = 10
    private var numberOfRows: CGFloat = 2
    private var widthOffset: CGFloat {
        return  collectionViewOffset + spacingLeftRight / numberOfRows
    }
    
    private var pokemons: [PokeModel] = []
    let pokeManager = PokeManager()
    
    private func addElements() {
        addLightningBolts()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        // Setup collectionView constraints
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(collectionViewOffset)
            make.right.equalToSuperview().offset(-collectionViewOffset)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        addElements()
        pokeManager.delegate = self
        pokeManager.fetchPokemons()
    }

    func addLightningBolts() {
        let boltFull = UIImageView().apply {
            $0.image = UIImage(named: "boltFull")
            $0.alpha = 0.5
        }
        
        let boltEmpty = UIImageView().apply {
            $0.image = UIImage(named: "boltEmpty")
            $0.tintColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1)
        }
        
        view.addSubview(boltFull)
        view.addSubview(boltEmpty)
        
        boltFull.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(20)
            make.top.equalToSuperview()
        }
        
        boltEmpty.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(boltFull)
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacingUpDown
        layout.minimumInteritemSpacing = spacingLeftRight
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // register the cell and the header
        collectionView.register(PokeCell.self, forCellWithReuseIdentifier: PokeCell.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokeDatailViewModel = PokeDetailViewModel()
        let clickedPokemon = pokemons[indexPath.row]
        pokeDatailViewModel.chosenPokemon = clickedPokemon
        pokeDatailViewModel.modalPresentationStyle = .fullScreen
        
        if let height = clickedPokemon.height,
           let weight = clickedPokemon.weight,
           let power = clickedPokemon.power,
           let attack = clickedPokemon.attack,
           let damage = clickedPokemon.damage {
            pokeDatailViewModel.values.append("\(height)0 cm")
            pokeDatailViewModel.values.append("\(weight) kg")
            pokeDatailViewModel.values.append("\(power)")
            pokeDatailViewModel.values.append("\(attack.capitalized)")
            pokeDatailViewModel.values.append("\(damage)")
        }
        self.present(pokeDatailViewModel, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension MainScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCell.identifier, for: indexPath) as? PokeCell else {
            return UICollectionViewCell()
        }
        guard let name = pokemons[indexPath.row].name,
                let description = pokemons[indexPath.row].ability,
              let imageUrl = pokemons[indexPath.row].imageUrl else { return UICollectionViewCell() }
        
        cell.configure(withName: name, withDescription: description, withUrl: imageUrl )
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / numberOfRows - widthOffset , height: view.frame.size.height / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView else {
                return UICollectionReusableView()
            }
            // configure headerView here
            return headerView
        default:
            assert(false, "Invalid element type")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: UIScreen.main.bounds.height / 6.5)
    }
}

// MARK: - PokeManagerDelegate
extension MainScreen: PokeManagerDelegate {
    func didUpdatePokemons(_ manager: PokeManager, pokemon: PokeModel) {
        self.pokemons.append(pokemon)
        DispatchQueue.main.async {
            self.collectionView.reloadData() }
    }
    
    func didFailWithError(error: Error) {
    }
}


