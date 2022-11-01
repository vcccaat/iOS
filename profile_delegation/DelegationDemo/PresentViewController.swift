//
//  PresentViewController.swift
//  DelegationDemo
//
//  Created by Yingshi on 2022/10/5.
//

import UIKit

class PresentViewController: UIViewController {
    let inputTextField = UITextField()
    let submitButton = UIButton()
    let avatar = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Change My Picture"

        
        avatar.image = UIImage(named: "Avatar")
        avatar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatar)
        
        submitButton.setTitle("Save", for: .normal)
        submitButton.backgroundColor = .systemPurple
        submitButton.layer.cornerRadius = 15
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.addTarget(self, action: #selector(dismissAndChange), for: .touchUpInside)
        view.addSubview(submitButton)
        
        setupConstraints()
    }
    
    @objc func dismissAndChange() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatar.heightAnchor.constraint(equalToConstant: 150),
            avatar.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant:20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
    


}

