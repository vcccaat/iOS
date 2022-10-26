
import UIKit

class ViewController: UIViewController {

    var songs: [Songs] = []
    let SongsTableView = UITableView()
    let reuseIdentifier = "SongsResuerIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Playlist"
        view.backgroundColor = .white

        let Easy = Songs(songPicName: "2", songName: "Easy", artist: "Troye Sivan")
        let TheRoad = Songs(songPicName: "3", songName: "The Road", artist: "Faouzia")
        let BeKind = Songs(songPicName: "4", songName: "Be Kind (with Halsey)", artist: "Marshmello, Halsey")
        let FalseConfidence = Songs(songPicName: "5", songName: "False Confidence", artist: "Noah Kahan")
        let MissAmericana = Songs(songPicName: "6", songName: "Miss Americana & The Hearbreak Prince", artist: "Taylor Swift")
        let EndofTime = Songs(songPicName: "7", songName: "End of Time", artist:"Alan Walker")
        let BreakMyHeart = Songs(songPicName: "8", songName: "Break My Heart", artist:"Dua Lipa")
        let IllWait = Songs(songPicName: "9", songName: "I'll Wait", artist: "Kygo")
        let Falling = Songs(songPicName: "10", songName: "Falling", artist: "Trevor Daniel")
        songs = [Easy, TheRoad, BeKind, FalseConfidence, MissAmericana, EndofTime, BreakMyHeart, IllWait, Falling]

        SongsTableView.translatesAutoresizingMaskIntoConstraints = false
        SongsTableView.dataSource = self
        SongsTableView.delegate = self  // who is change SongsTableView: myself
        SongsTableView.register(SongsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(SongsTableView)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            SongsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            SongsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            SongsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            SongsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = SongsTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SongsTableViewCell {
            cell.configure(song: songs[indexPath.row])
            cell.backgroundColor = .black
            return cell
            }
        else {
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // delegate: we try to change the tableviewCell, not the controller
        let cell = SongsTableView.cellForRow(at: indexPath) as! SongsTableViewCell
        present(DetailViewController(song: songs[indexPath.row], delegate: cell), animated: true)
    }
}
