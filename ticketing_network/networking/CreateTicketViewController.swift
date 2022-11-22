

import UIKit

class CreateTicketViewController: UIViewController {

    let headerLabel = UILabel()
    let bodyTextView = UITextView()
    let ticketerTextField = UITextField()
    let saveButton = UIButton()

    weak var delegate: CreateTicketDelegate?

    init(delegate: CreateTicketDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        headerLabel.text = "Create Ticket"
        headerLabel.font = .boldSystemFont(ofSize: 20)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = .systemFont(ofSize: 20)
        view.addSubview(headerLabel)


        bodyTextView.text = "Insert Ticket Description"
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.clipsToBounds = true
        bodyTextView.layer.cornerRadius = 5
        bodyTextView.backgroundColor = .systemGray4
        bodyTextView.font = .systemFont(ofSize: 15)
        view.addSubview(bodyTextView)

        saveButton.setTitle("Save", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 15
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        view.addSubview(saveButton)

        setupConstraints()
    }
    
    @objc func saveAction() {
        let description = bodyTextView.text!
        delegate?.createTicket(description: description)

        navigationController?.popViewController(animated: true)
    }

    func setupConstraints() {
        let widthMultiplier: CGFloat = 0.75

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            bodyTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bodyTextView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            bodyTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier),
            bodyTextView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: bodyTextView.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol CreateTicketDelegate: UIViewController {
    func createTicket(description: String)
}
