//
//  ButtonsCollectionViewCell.swift
//  L5Starter
//
//  Created by Yingshi on 2022/10/31.
//

import UIKit

class ButtonsCollectionViewCell: UICollectionViewCell {
    var buttonTextView = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true

        buttonTextView.textAlignment = .center
        
        buttonTextView.layer.cornerRadius = 15
        buttonTextView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        buttonTextView.font = .systemFont(ofSize: 15)
        buttonTextView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(buttonTextView)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonTextView.topAnchor.constraint(equalTo: contentView.topAnchor),
            buttonTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            buttonTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            buttonTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(button: Button) {
        buttonTextView.text = button.name
    }
    
    func changeColor(ifSelected: Bool) {
        if (ifSelected == true) {
            buttonTextView.backgroundColor = UIColor(red: 0.39, green: 0.80, blue: 0.85, alpha: 1.00)
            buttonTextView.textColor = .white
        } else {
            buttonTextView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
            buttonTextView.textColor = .black
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
