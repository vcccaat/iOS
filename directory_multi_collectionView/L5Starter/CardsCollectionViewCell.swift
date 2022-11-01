//
//  ButtonsCollectionViewCell.swift
//  L5Starter
//
//  Created by Yingshi on 2022/10/31.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {

    var cardsImageView = UIImageView()
    var cardsTitleView = UILabel()
    var cardsYearTextView = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 6
        contentView.layer.borderColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00).cgColor
        contentView.layer.borderWidth = 2.5
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: -2, height: -2)
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowRadius = 2.0
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true

        cardsImageView.contentMode = .scaleAspectFit
        cardsImageView.translatesAutoresizingMaskIntoConstraints = false
        cardsImageView.image = UIImage(named: "profile-img")
        contentView.addSubview(cardsImageView)
        

        cardsTitleView.font = .systemFont(ofSize: 25)
        cardsTitleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardsTitleView)
        

        cardsYearTextView.font = .systemFont(ofSize: 15)
        cardsYearTextView.textColor = .gray
        cardsYearTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardsYearTextView)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cardsImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.55),
            cardsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cardsTitleView.topAnchor.constraint(equalTo: cardsImageView.bottomAnchor),
            cardsTitleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cardsYearTextView.topAnchor.constraint(equalTo: cardsTitleView.bottomAnchor),
            cardsYearTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            cardsYearTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    func configure(card: Card) {
        cardsTitleView.text = card.name
        cardsYearTextView.text = card.year
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

