import UIKit
import Kingfisher 

class ViewController: UIViewController {

    var api = Service()
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userFollowersLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray .withAlphaComponent(1.5)
        nameLabel.text = "User"
        followersLabel.text = "Followers"
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 0.7
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.contentMode = .scaleAspectFit

        api.getUser { Result in
            switch Result {
                
            case .success(let githubUser):
                self.userNameLabel.text = githubUser.login
                self.userFollowersLabel.text = String(githubUser.followers)
                let urlThumbnail = githubUser.avatar_url
                let url = URL(string: urlThumbnail)
                self.userImage.kf.setImage(with: url)
                self.userBioLabel.text = githubUser.bio
                print(githubUser.avatar_url)
                
            case .failure(_):
                print("Error")
            }
        }
    }
}
