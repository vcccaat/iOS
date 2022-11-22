

import UIKit

class TicketTableViewCell: UITableViewCell {

    let idLabel = UILabel()
    let descriptionLabel = UILabel()
    let doneLabel = UILabel()
    let title1Label = UILabel()
    let title2Label = UILabel()
    
    let stackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        
        idLabel.textAlignment = .left
        idLabel.font = UIFont.systemFont(ofSize: 20)
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(idLabel)
        
        title1Label.font = UIFont.systemFont(ofSize: 12)
        title1Label.text = "TICKET"
        title1Label.textColor = .lightGray
        title1Label.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        title2Label.font = UIFont.systemFont(ofSize: 12)
        title2Label.textColor = .lightGray
        title2Label.text = "STATUS"
        title2Label.translatesAutoresizingMaskIntoConstraints = false

        doneLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        doneLabel.textColor = .gray
        doneLabel.translatesAutoresizingMaskIntoConstraints = false
        

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical

        stackView.addArrangedSubview(title1Label)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(title2Label)
        stackView.addArrangedSubview(doneLabel)
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        let verticalPadding: CGFloat = 20.0
        let sidePadding: CGFloat = 20.0

        NSLayoutConstraint.activate([
            idLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding),
            stackView.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(ticketObject: Ticket) {
        idLabel.text = String(ticketObject.id)
        descriptionLabel.text = ticketObject.description
        doneLabel.text = ticketObject.done ? "True" : "False"

//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
//        let timeStamp = dateFormatter.date(from: ticketObject.timeStamp)!
//
//        let coolDateFormatter = DateFormatter()
//        coolDateFormatter.dateFormat = "MMM d, h:mm a"
//        let coolDateString = coolDateFormatter.string(from: timeStamp)
//        timestampLabel.text = "\(coolDateString)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TicketTableViewCell: ChangeTicketInfoDelegate {

    func changeCellInfo(id: Int, description: String, done: Bool) {

        NetworkManager.updateTicket(id: id, description: description, done: done) {ticket in
            self.doneLabel.text = done ? "True" : "False"
            self.descriptionLabel.text = description
        }

        NetworkManager.getTicketById(id: id) { ticket in

            print("success!",ticket.id, ticket.description, ticket.done)
        }
    }

}
