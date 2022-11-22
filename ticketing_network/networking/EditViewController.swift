

import UIKit

class EditViewController: UIViewController {

    let headerLabel = UILabel()
    let descriptionTextView = UITextView()
    let doneText = UILabel()
    let doneSwitch = UISwitch()
    let saveButton = UIButton()
    let stackView = UIStackView()

    var ticket: Ticket!
    weak var delegate: ChangeTicketInfoDelegate?

    init(ticket: Ticket, delegate: ChangeTicketInfoDelegate?) {
        self.ticket = ticket
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        

        headerLabel.text = "Edit Ticket"
        headerLabel.font = .boldSystemFont(ofSize: 20)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = .systemFont(ofSize: 20)
        view.addSubview(headerLabel)

        descriptionTextView.text = ticket.description
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.clipsToBounds = true
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.font = .systemFont(ofSize: 20)
        descriptionTextView.backgroundColor = .systemGray6
        view.addSubview(descriptionTextView)
        
        doneText.font = UIFont.systemFont(ofSize: 18)
        doneText.translatesAutoresizingMaskIntoConstraints = false
        doneText.text = "DONE: "
        doneText.textAlignment = .center

        doneSwitch.translatesAutoresizingMaskIntoConstraints = false
        doneSwitch.isOn = ticket.done
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.addArrangedSubview(doneText)
        stackView.addArrangedSubview(doneSwitch)
        view.addSubview(stackView)

        saveButton.setTitle("Save", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 15
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        view.addSubview(saveButton)

        setupConstraints()
    }

    @objc func saveAction() {
        delegate?.changeCellInfo(id:ticket.id, description: descriptionTextView.text!, done: doneSwitch.isOn)
        ticket.description = descriptionTextView.text!
        ticket.done = doneSwitch.isOn
        dismiss(animated: true)
    }

    func setupConstraints() {
        let widthMultiplier: CGFloat = 0.75

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            descriptionTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
        

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            doneSwitch.centerYAnchor.constraint(equalTo: doneText.centerYAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: doneSwitch.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol ChangeTicketInfoDelegate: AnyObject {
    func changeCellInfo(id: Int, description: String, done: Bool)
}
