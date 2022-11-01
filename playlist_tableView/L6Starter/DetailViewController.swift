
import UIKit

class DetailViewController: UIViewController {

    let picImageView = UIImageView()
    let nameTextField = UITextField()
    let artistTextField = UITextField()
    let ratingTextField = UITextField()
    let submitButton = UIButton()
    let title1 = UILabel()
    let title2 = UILabel()
    let title3 = UILabel()

    let song: Songs
    weak var delegate: ChangeSongsDelegate?

    init(song: Songs, delegate: ChangeSongsDelegate) {
        self.song = song
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        picImageView.image = UIImage(named:song.songPicName)
        picImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picImageView)

        
        title1.text = "Song:"
        title1.font = .systemFont(ofSize: 20)
        title1.textColor = .white
        title1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title1)
        
        title2.text = "Artist:"
        title2.font = .systemFont(ofSize: 20)
        title2.textColor = .white
        title2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title2)
        
        title3.text = "Rating:"
        title3.font = .systemFont(ofSize: 20)
        title3.textColor = .white
        title3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title3)
        
        
        nameTextField.text = song.songName
        nameTextField.font = .systemFont(ofSize: 20)
        nameTextField.backgroundColor = .black
        nameTextField.textColor = .white
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.borderColor = UIColor.white.cgColor
        nameTextField.layer.cornerRadius = 5
        nameTextField.clipsToBounds = true
        nameTextField.textAlignment = .center
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        artistTextField.text = song.artist
        artistTextField.font = .systemFont(ofSize: 20)
        artistTextField.backgroundColor = .black
        artistTextField.textColor = .white
        artistTextField.layer.borderWidth = 1.0
        artistTextField.layer.borderColor = UIColor.white.cgColor
        artistTextField.layer.cornerRadius = 5
        artistTextField.clipsToBounds = true
        artistTextField.textAlignment = .center
        artistTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(artistTextField)
        
        ratingTextField.text = song.rating
        ratingTextField.font = .systemFont(ofSize: 20)
        ratingTextField.backgroundColor = .black
        ratingTextField.textColor = .white
        ratingTextField.layer.borderWidth = 1.0
        ratingTextField.layer.borderColor = UIColor.white.cgColor
        ratingTextField.layer.cornerRadius = 5
        ratingTextField.clipsToBounds = true
        ratingTextField.textAlignment = .center
        ratingTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ratingTextField)

        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.systemBlue, for: .normal)
        submitButton.addTarget(self, action: #selector(changeSongsCell), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)

        setupConstraints()
    }

    @objc func changeSongsCell() {
        delegate?.changeSongsName(name: nameTextField.text!, artist: artistTextField.text!, rating: ratingTextField.text!)
        song.songName = nameTextField.text!
        song.artist = artistTextField.text!
        song.rating = ratingTextField.text!
        dismiss(animated: true)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            picImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            picImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            picImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])

        NSLayoutConstraint.activate([
            title1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title1.topAnchor.constraint(equalTo: picImageView.bottomAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: title1.bottomAnchor, constant: 10),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            nameTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            title2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title2.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            artistTextField.topAnchor.constraint(equalTo: title2.bottomAnchor, constant: 10),
            artistTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artistTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            artistTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            title3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title3.topAnchor.constraint(equalTo: artistTextField.bottomAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            ratingTextField.topAnchor.constraint(equalTo: title3.bottomAnchor, constant: 10),
            ratingTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ratingTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            ratingTextField.heightAnchor.constraint(equalToConstant: 35)
        ])


        NSLayoutConstraint.activate([
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol ChangeSongsDelegate: UITableViewCell {
    func changeSongsName(name: String, artist: String, rating: String)
}
