//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import RxSwift
import RxCocoa

enum LeftMenu: Int {
    case home = 0
    case onlineShop
    case askaDoctor
    case uploadPrescription
    case socialWall
    case helpCentre
    case privacyPolicy
    case userAgreement
    case aboutUs
}

enum LeftMenuLogined: Int {
    case home = 0
    case onlineShop
    case uploadPrescription
    case socialWall
    case askaDoctor
    case notifications
    case inviteaFriend
    case helpCentre
    case aboutUs
    case privacyPolicy
    case userAgreement
    case logout
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol, ImageHeaderViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Home", "Online Shop", "Ask a Doctor", "Upload Prescription", "Social Wall"
        , "Help Centre", "Privacy Policy", "User Agreement", "About Us"]
    var menusLogined = ["Home", "Online Shop", "Upload Prescription", "Social Wall", "Ask a Doctor", "Notifications", "Invite a Friend", "Help Centre", "Privacy Policy", "User Agreement", "About Us", "Logout"]
    var homeViewController: UIViewController!
    var onlineShopViewController: UIViewController!
    var askaDoctorViewController: UIViewController!
    var uploadPrescriptionViewController: UIViewController!
    var socialWallViewController: UIViewController!
    var helpCentreViewController: UIViewController!
    var privacyPolicyViewController: UIViewController!
    var userAgreementViewController: UIViewController!
    var aboutUsViewController: UIViewController!
    var inviteaFriendViewController: UIViewController!
    var notificationsViewController: UIViewController!
    var signInViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    fileprivate let disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red: 224, green: 224, blue: 224)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let askaDoctorStoryboard = UIStoryboard(name: "AskaDoctor", bundle: nil)
        
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.homeViewController = UINavigationController(rootViewController: homeViewController)
        
        let onlineShopViewController = mainStoryboard.instantiateViewController(withIdentifier: "OnlineShopViewController") as! OnlineShopViewController
        self.onlineShopViewController = UINavigationController(rootViewController: onlineShopViewController)
        
        let askaDoctorViewController = askaDoctorStoryboard.instantiateViewController(withIdentifier: "AskaDoctorViewController") as! AskaDoctorViewController
        self.askaDoctorViewController = UINavigationController(rootViewController: askaDoctorViewController)
        
        let uploadPrescriptionViewController = mainStoryboard.instantiateViewController(withIdentifier: "UploadPrescriptionViewController") as! UploadPrescriptionViewController
        self.uploadPrescriptionViewController = UINavigationController(rootViewController: uploadPrescriptionViewController)
        
        let socialWallViewController = mainStoryboard.instantiateViewController(withIdentifier: "SocialWallViewController") as! SocialWallViewController
        self.socialWallViewController = UINavigationController(rootViewController: socialWallViewController)
        
        let helpCentreViewController = mainStoryboard.instantiateViewController(withIdentifier: "HelpCentreViewController") as! HelpCentreViewController
        self.helpCentreViewController = UINavigationController(rootViewController: helpCentreViewController)
        
        let privacyPolicyViewController = mainStoryboard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        self.privacyPolicyViewController = UINavigationController(rootViewController: privacyPolicyViewController)
        
        let userAgreementViewController = mainStoryboard.instantiateViewController(withIdentifier: "UserAgreementViewController") as! UserAgreementViewController
        self.userAgreementViewController = UINavigationController(rootViewController: userAgreementViewController)
        
        let aboutUsViewController = mainStoryboard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        self.aboutUsViewController = UINavigationController(rootViewController: aboutUsViewController)
        
        let notificationsViewController = mainStoryboard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
        self.notificationsViewController = UINavigationController(rootViewController: notificationsViewController)
        
        let inviteaFriendViewController = mainStoryboard.instantiateViewController(withIdentifier: "InviteaFriendViewController") as! InviteaFriendViewController
        self.inviteaFriendViewController = UINavigationController(rootViewController: inviteaFriendViewController)
        
        let signInViewController = loginStoryboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.signInViewController = UINavigationController(rootViewController: signInViewController)
        
        self.tableView.registerCellClass(MenuTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
        imageHeaderView.delegate = self
        
        NotificationCenter.default.rx.notification(Notification.Name("UserLoginedNotification"))
            .subscribe(onNext: { _ in
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func goToSignIn() {
        slideMenuController()?.changeMainViewController(signInViewController, close: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 160)
        view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .home:
            slideMenuController()?.changeMainViewController(homeViewController, close: true)
        case .onlineShop:
            slideMenuController()?.changeMainViewController(onlineShopViewController, close: true)
        case .askaDoctor:
            slideMenuController()?.changeMainViewController(askaDoctorViewController, close: true)
        case .uploadPrescription:
            slideMenuController()?.changeMainViewController(uploadPrescriptionViewController, close: true)
        case .socialWall:
            slideMenuController()?.changeMainViewController(socialWallViewController, close: true)
        case .helpCentre:
            slideMenuController()?.changeMainViewController(helpCentreViewController, close: true)
        case .privacyPolicy:
            slideMenuController()?.changeMainViewController(privacyPolicyViewController, close: true)
        case .userAgreement:
            slideMenuController()?.changeMainViewController(userAgreementViewController, close: true)
        case .aboutUs:
            slideMenuController()?.changeMainViewController(aboutUsViewController, close: true)
        }
    }
    func changeViewController(_ menu: LeftMenuLogined) {
        switch menu {
        case .home:
            slideMenuController()?.changeMainViewController(homeViewController, close: true)
        case .onlineShop:
            slideMenuController()?.changeMainViewController(onlineShopViewController, close: true)
        case .askaDoctor:
            slideMenuController()?.changeMainViewController(askaDoctorViewController, close: true)
        case .uploadPrescription:
            slideMenuController()?.changeMainViewController(uploadPrescriptionViewController, close: true)
        case .socialWall:
            slideMenuController()?.changeMainViewController(socialWallViewController, close: true)
        case .helpCentre:
            slideMenuController()?.changeMainViewController(helpCentreViewController, close: true)
        case .privacyPolicy:
            slideMenuController()?.changeMainViewController(privacyPolicyViewController, close: true)
        case .userAgreement:
            slideMenuController()?.changeMainViewController(userAgreementViewController, close: true)
        case .aboutUs:
            slideMenuController()?.changeMainViewController(aboutUsViewController, close: true)
        case .notifications:
            slideMenuController()?.changeMainViewController(notificationsViewController, close: true)
        case .inviteaFriend:
            slideMenuController()?.changeMainViewController(inviteaFriendViewController, close: true)
        case .logout:
            print("Logout")
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(Global.logined) {
            if let menu = LeftMenuLogined(rawValue: indexPath.row) {
                switch menu {
                case .home, .onlineShop, .askaDoctor, .uploadPrescription, .socialWall, .helpCentre, .privacyPolicy, .userAgreement, .aboutUs, .notifications, .inviteaFriend, .logout :
                    return MenuTableViewCell.height()
                }
            }
        } else {
            if let menu = LeftMenu(rawValue: indexPath.row) {
                switch menu {
                case .home, .onlineShop, .askaDoctor, .uploadPrescription, .socialWall, .helpCentre, .privacyPolicy, .userAgreement, .aboutUs :
                    return MenuTableViewCell.height()
                }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(Global.logined) {
            if let menu = LeftMenuLogined(rawValue: indexPath.row) {
                self.changeViewController(menu)
            }
        } else if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(Global.logined) {
            return menusLogined.count
        } else {
            return menus.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(Global.logined) {
            if let menu = LeftMenuLogined(rawValue: indexPath.row) {
                switch menu {
                case .home, .onlineShop, .askaDoctor, .uploadPrescription, .socialWall, .helpCentre, .privacyPolicy, .userAgreement, .aboutUs, .notifications, .inviteaFriend, .logout :
                    let cell = Bundle.main.loadNibNamed("MenuTableViewCell", owner: self, options: nil)?.first as! MenuTableViewCell
                    cell.setData(menusLogined[indexPath.row])
                    return cell
                }
            }
        } else if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .home, .onlineShop, .askaDoctor, .uploadPrescription, .socialWall, .helpCentre, .privacyPolicy, .userAgreement, .aboutUs :
                let cell = Bundle.main.loadNibNamed("MenuTableViewCell", owner: self, options: nil)?.first as! MenuTableViewCell
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
}
