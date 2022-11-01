//
//  PushViewController.swift
//  DelegationDemo
//
//  Created by Yingshi on 2022/10/5.
//

import UIKit

class PushViewController: UIViewController {
    let nameText = UILabel()
    let nameField = UITextField()
    let aboutText = UILabel()
    let aboutField = UITextField()
    let submitButton = UIButton()
    
    weak var delegate: ChangeViewDelegate?
    
    init(delegate: ChangeViewDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Edit My Profile"
        
        nameText.text = "USERNAME"
        nameText.font = .systemFont(ofSize: 15, weight: .semibold)
        nameText.textColor = .systemGray2
        nameText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameText)
        
        nameField.backgroundColor = .systemGray6
        nameField.clipsToBounds = true
        nameField.layer.cornerRadius = 15
        nameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameField)
        
        aboutText.text = "ABOUT"
        aboutText.font = .systemFont(ofSize: 15, weight: .semibold)
        aboutText.textColor = .systemGray2
        aboutText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutText)
        
        aboutField.backgroundColor = .systemGray6
        aboutField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        aboutField.clipsToBounds = true
        aboutField.layer.cornerRadius = 15
        aboutField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aboutField)
        
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
        if nameField.text != "" {
            delegate?.changeUsername(str: nameField.text ?? "didn't input text")
        }
        if aboutField.text != "" {
            delegate?.changeAbout(str: aboutField.text ?? "didn't input text")
        }
        navigationController?.popViewController(animated: true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        ])
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 10),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            nameField.heightAnchor.constraint(equalToConstant: 45),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)

        ])
        
        NSLayoutConstraint.activate([
            aboutText.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 50),
            aboutText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        ])
        
        NSLayoutConstraint.activate([
            aboutField.topAnchor.constraint(equalTo: aboutText.bottomAnchor, constant: 10),
            aboutField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            aboutField.heightAnchor.constraint(equalToConstant: 300),
            aboutField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)

        ])
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: aboutField.bottomAnchor, constant:60),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
   

}

protocol ChangeViewDelegate: UIViewController {
    func changeUsername(str: String)
    func changeAbout(str: String)
}
