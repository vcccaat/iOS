
import UIKit

class ViewController: UIViewController {

    // MARK: UI Elements
    let ticketTableView = UITableView()
    let addticketButton = UIBarButtonItem()
    let ticketReuseIdentifier = "ticketReuseIdentifier"
    
    // Learn how to setup a refreshControl here https://cocoacasts.com/how-to-add-pull-to-refresh-to-a-table-view-or-collection-view
    let refreshControl = UIRefreshControl()

    // MARK: Data
    var ticketData: [Ticket] = []
    var shownticketData: [Ticket] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ticket Board"
        view.backgroundColor = .white

        ticketTableView.translatesAutoresizingMaskIntoConstraints = false
        ticketTableView.delegate = self
        ticketTableView.dataSource = self
        ticketTableView.register(TicketTableViewCell.self, forCellReuseIdentifier: ticketReuseIdentifier)
        view.addSubview(ticketTableView)

        //TODO: #1.5 Setup refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        
        if #available(iOS 10.0, *) {
            ticketTableView.refreshControl = refreshControl
        } else {
            ticketTableView.addSubview(refreshControl)
        }

        addticketButton.image = UIImage(systemName: "plus.message")
        addticketButton.target = self
        addticketButton.action = #selector(pushCreateView)
        navigationItem.rightBarButtonItem = addticketButton

        createDummyData()

        setupConstraints()
    }

    /// Order `ticketData` in order of newest to oldest.
    /// PRECONDITION: ticket ids are ordered where the lowest is the oldest and the highest is the newest. */
//    func sortticketData() {
//        ticketData.sort { ticket1, ticket2 in
//            return ticket1.timeStamp > ticket2.timeStamp
//        }
//    }
    
    func createDummyData() {
        // MARK: Use getAllTickets
        /**
         We want to retrieve data from the server here upon refresh. Make sure to
         1) Sort the tickets with `sortticketData`
         2) Update `ticketData` & `shownticketData` and reload `ticketTableView`
         */

        NetworkManager.getAllTickets { tickets in
            self.ticketData = tickets
//            self.sortticketData()
            self.shownticketData = self.ticketData
            self.ticketTableView.reloadData()
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            ticketTableView.topAnchor.constraint(equalTo: view.topAnchor),
            ticketTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ticketTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ticketTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func refreshData() {

        //TODO: #1.5 Implement Refresh
        NetworkManager.getAllTickets { tickets in
            self.ticketData = tickets
//            self.sortticketData()
            self.shownticketData = self.ticketData
            self.ticketTableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }
    }

    @objc func pushCreateView() {
        navigationController?.pushViewController(CreateTicketViewController(delegate: self), animated: true)
    }
    
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = ticketTableView.cellForRow(at: indexPath) as! TicketTableViewCell
        let editVC = EditViewController(ticket: shownticketData[indexPath.row], delegate: cell)
        editVC.title = "My Title"
        
        present(editVC, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete) {
            let rowId = shownticketData[indexPath.row].id
            NetworkManager.deleteTicket(id: rowId){ ticket in
                self.shownticketData.remove(at: indexPath.row)
                self.ticketTableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownticketData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ticketReuseIdentifier, for: indexPath) as! TicketTableViewCell
        let ticketObject = shownticketData[indexPath.row]
        cell.configure(ticketObject: ticketObject)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: CreateTicketDelegate  {
    func createTicket(description: String) {
        NetworkManager.createTicket(description: description) {ticket in
            self.shownticketData =  self.shownticketData + [ticket]
            self.ticketTableView.reloadData()
        }
        
    }
}


