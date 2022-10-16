//
//  ViewController.swift
//  DelegationDemo
//
//  Created by Elvis Marcelo on 10/4/22.

import UIKit
// cheif, customer has menu, cheif dont have
class ViewController: UIViewController, ChangeViewDelegate {
    func changeAbout(str: String) {
        message.text = str
    }
    
    func changeUsername(str: String) {
        username.text = str
    }
    

    let avatar = UIImageView()
    let pushButton = UIButton()
    let presentButton = UIButton()
    let message = UITextView()
    let about = UILabel()
    let username = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "My Profile"
        
        presentButton.addTarget(self, action: #selector(presentViewController), for: .touchUpInside)
        presentButton.backgroundColor = .systemGray
        presentButton.layer.cornerRadius = 0.5 * 153
        presentButton.clipsToBounds = true
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(presentButton)

        avatar.image = UIImage(named: "Avatar")
        avatar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatar)
        
        username.text = "Yingshi Zhu"
        username.font = .systemFont(ofSize: 25)
        username.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(username)

        pushButton.setTitle("EDIT MY PROFILE >", for: .normal)
        pushButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
        pushButton.setTitleColor(.systemPurple, for: .normal)
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pushButton)


        about.text = "About"
        about.font = .systemFont(ofSize: 18, weight: .bold)
        about.textColor = .systemGray
        about.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(about)
        
        message.font = .systemFont(ofSize: 14)
        message.textColor = .systemGray
        message.text = "Hi there, I am a student majoring in Information Science at Cornell University."
        message.translatesAutoresizingMaskIntoConstraints = false
        message.layer.cornerRadius = 15
        view.addSubview(message)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatar.heightAnchor.constraint(equalToConstant: 150),
            avatar.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 20),
            username.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        NSLayoutConstraint.activate([
            pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushButton.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 10),
            pushButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])

        NSLayoutConstraint.activate([
            presentButton.centerYAnchor.constraint(equalTo: avatar.centerYAnchor),
            presentButton.centerXAnchor.constraint(equalTo: avatar.centerXAnchor),
            presentButton.heightAnchor.constraint(equalToConstant: 155),
            presentButton.widthAnchor.constraint(equalToConstant: 155)
        ])
        
        NSLayoutConstraint.activate([
            about.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            about.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            message.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1, constant: -80),
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            message.topAnchor.constraint(equalTo: about.bottomAnchor, constant: 15),
            message.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    @objc func pushViewController() {
        print("Implement push!")
        navigationController?.pushViewController(PushViewController(delegate: self), animated: true)
    }

    @objc func presentViewController() {
        print("Implement present!")
        present(PresentViewController(), animated: true, completion: nil)
    }

}
