
import Foundation
import UIKit

class Songs {
    var songPicName: String
    var songName: String
    var artist: String
    var rating: String

    init(songPicName: String, songName: String, artist: String, rating: String = "100%") {
        self.songPicName = songPicName
        self.songName = songName
        self.artist = artist
        self.rating = rating
    }
}
