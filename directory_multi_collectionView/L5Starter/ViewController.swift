//
//  ButtonsCollectionViewCell.swift
//  L5Starter
//
//  Created by Yingshi on 2022/10/31.
//

import UIKit

class ViewController: UIViewController {
    let p1 = Card(name: "aa", year: "Senior", team: "iOS")
    let p2 = Card(name: "bb", year: "Senior", team: "iOS")
    let p3 = Card(name: "cc", year: "Junior", team: "Backend")
    let p4 = Card(name: "dd", year: "Junior", team: "Android")
    let p5 = Card(name: "ee", year: "Junior", team: "Backend")
    let p6 = Card(name: "ff", year: "Sophomore", team: "Marketing")
    let p7 = Card(name: "gg", year: "Sophomore", team: "Marketing")
    let p8 = Card(name: "hh", year: "Freshman", team: "Design")
    
    
    var buttons: [Button] = [Button(name:"iOS"),Button(name:"Backend"),Button(name:"Android"),Button(name:"Marketing"),Button(name:"Design")]
    var teams: [String] = ["iOS", "Backend", "Android", "Marketing", "Design"]
    var buttonSelect: [Bool] = [false, false, false, false, false]
    
    var cards: [Card] = []
    var allcards: [Card] = []

    var cardCollectionView: UICollectionView!
    var filterBarCollectionView: UICollectionView!
    let spacing: CGFloat = 10
    let buttonSpacing: CGFloat = 20
    let cardReuseIdentifier: String = "cardReuseIdentifier"
    let buttonReuseIdentifier: String = "buttonReuseIdentifier"
    
    var filterTextView = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Directory"
        view.backgroundColor = .white
        
        filterTextView.text = "FILTER BY"
        filterTextView.textColor = .lightGray
        filterTextView.font = .systemFont(ofSize: 17, weight: .bold)
        filterTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterTextView)
        
        cards = [p1,p2,p3,p4,p5,p6,p7,p8]
        
        // always constant
        allcards = cards
        
        // Setup cards flow layout
        let cardlayout = UICollectionViewFlowLayout()
        cardlayout.minimumLineSpacing = spacing
        cardlayout.minimumInteritemSpacing = spacing
        cardlayout.scrollDirection = .vertical
        
        // Instantiate cardCollectionView
        cardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: cardlayout)
        cardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cardCollectionView.register(CardsCollectionViewCell.self, forCellWithReuseIdentifier: cardReuseIdentifier)
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        view.addSubview(cardCollectionView)
        
        // Setup filter bar flow layout
        let buttonLayout = UICollectionViewFlowLayout()
        buttonLayout.minimumLineSpacing = spacing
        buttonLayout.minimumInteritemSpacing = buttonSpacing
        buttonLayout.scrollDirection = .horizontal

        // Instantiate filterBarCollectionView
        filterBarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: buttonLayout)
        filterBarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterBarCollectionView.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: buttonReuseIdentifier)
        filterBarCollectionView.dataSource = self
        filterBarCollectionView.delegate = self
        view.addSubview(filterBarCollectionView)
        
        setupConstraints()
    }
    
    
    
    func filtercards(index: Int) {
        cards = []
        buttonSelect[index].toggle()

        for (i, ifSelected) in buttonSelect.enumerated(){
            if (ifSelected) {
                cards = cards + allcards.filter({ card in
                                card.team == teams[i]
                            })
            }
        }
        let repeated = repeatElement(false, count: 5)
        if (buttonSelect.elementsEqual(repeated)) {
            cards = allcards
        }
        
        cardCollectionView.reloadData()
    }
    
    func setupConstraints() {
        let collectionViewPadding: CGFloat = 20
        NSLayoutConstraint.activate([
        filterTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        filterTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
        ])
        
        NSLayoutConstraint.activate([
            filterBarCollectionView.topAnchor.constraint(equalTo: filterTextView.bottomAnchor, constant: 10),
            filterBarCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            filterBarCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding),
            filterBarCollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            cardCollectionView.topAnchor.constraint(equalTo: filterBarCollectionView.bottomAnchor, constant: collectionViewPadding),
            cardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            cardCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewPadding),
            cardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
        
    }
}



// datasource config
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == filterBarCollectionView){
            return buttons.count
        } else {
            return cards.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == filterBarCollectionView){
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonReuseIdentifier, for: indexPath) as? ButtonsCollectionViewCell {
                cell.configure(button: buttons[indexPath.row])
                return cell
            }
            else {
                return UICollectionViewCell()
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardReuseIdentifier, for: indexPath) as? CardsCollectionViewCell {
                cell.configure(card: cards[indexPath.row])
                return cell
            }
            else {
                return UICollectionViewCell()
            }
        }
    }
}


// delegate config
extension ViewController: UITableViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == filterBarCollectionView){
            let cell = collectionView.cellForItem(at: indexPath) as? ButtonsCollectionViewCell
            filtercards(index: indexPath.row)
            cell?.changeColor(ifSelected: buttonSelect[indexPath.row])
        }
    }
}


// layout config
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == filterBarCollectionView){
            return CGSize(width: 80, height: 40)
        } else {
            // not using the view.frame.width because collectionView is smaller
            let size  = (collectionView.frame.width - 10) / 2.0
            return CGSize(width: size, height: size)
        }
    }
}

