
import UIKit

class SongsTableViewCell: UITableViewCell {

    let songImageView = UIImageView()
    let songNameLabel =  UILabel()
    let artistLabel = UILabel()
    let ratingLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        songImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(songImageView)
        
        songNameLabel.textColor = .white
        songNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(songNameLabel)
        
        artistLabel.textColor = .gray
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(artistLabel)
        
        ratingLabel.textColor = .gray
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ratingLabel)
        
        setupConstraints()
    }
    
    func configure(song: Songs) {
        songImageView.image = UIImage(named: song.songPicName)
        songNameLabel.text = song.songName
        artistLabel.text = "Artist: " + song.artist
        ratingLabel.text = "Rating: " + song.rating
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            songImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            songImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            songImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            songImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            songImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            songNameLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 10),
            songNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 10),
            artistLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 10),
            ratingLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 10)
        ])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension SongsTableViewCell: ChangeSongsDelegate {
    func changeSongsName(name: String, artist: String, rating: String) {
        songNameLabel.text = name
        artistLabel.text = artist
        ratingLabel.text = rating
    }

}

