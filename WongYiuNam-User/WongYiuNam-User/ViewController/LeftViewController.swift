//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import RxSwift
import RxCocoa
import PopupDialog

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
    case termsAndConditions
    case privacyPolicy
    case userAgreement
    case aboutUs
    case logout
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol, ImageHeaderViewDelegate {
    
    @IBOutlet weak var topMenuLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Home", "Online Shop", "Ask a Doctor", "Upload Prescription", "Social wall"
        , "Help Centre", "Privacy Policy", "User Agreement", "About Us"]
    var menusLogined = ["Home", "Online Shop", "Upload Prescription", "Social wall", "Ask a Doctor", "Notifications", "Invite a Friend", "Help Centre", "Terms and Conditions", "Privacy Policy", "User Agreement", "About Us", "Logout"]
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
    var favoriteViewController: UIViewController!
    var userProfileViewController: UIViewController!
    //TEST:
    var topUpViewController:UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    var sub1: Bool = false
    var sub2: Bool = false
    
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
        let socialWallStoryboard = UIStoryboard(name: "SocialWall", bundle: nil)
        let favoriteStoryboard = UIStoryboard(name: "Favorite", bundle: nil)
        
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.homeViewController = UINavigationController(rootViewController: homeViewController)
        
        let onlineShopViewController = mainStoryboard.instantiateViewController(withIdentifier: "OnlineShopViewController") as! OnlineShopViewController
        self.onlineShopViewController = UINavigationController(rootViewController: onlineShopViewController)
        
        let askaDoctorViewController = askaDoctorStoryboard.instantiateViewController(withIdentifier: "AskaDoctorViewController") as! AskaDoctorViewController
        self.askaDoctorViewController = UINavigationController(rootViewController: askaDoctorViewController)
        
        let uploadPrescriptionViewController = mainStoryboard.instantiateViewController(withIdentifier: "UploadPrescriptionViewController") as! UploadPrescriptionViewController
        self.uploadPrescriptionViewController = UINavigationController(rootViewController: uploadPrescriptionViewController)
        
        let socialWallViewController = socialWallStoryboard.instantiateViewController(withIdentifier: "SocialWallViewController") as! SocialWallViewController
        self.socialWallViewController = UINavigationController(rootViewController: socialWallViewController)
        
        let helpCentreViewController = mainStoryboard.instantiateViewController(withIdentifier: "HelpCentreViewController") as! HelpCentreViewController
        self.helpCentreViewController = UINavigationController(rootViewController: helpCentreViewController)
        
        let privacyPolicyViewController = mainStoryboard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        self.privacyPolicyViewController = UINavigationController(rootViewController: privacyPolicyViewController)
        
        let userAgreementViewController = mainStoryboard.instantiateViewController(withIdentifier: "UserAgreementViewController") as! UserAgreementViewController
        self.userAgreementViewController = UINavigationController(rootViewController: userAgreementViewController)
        
        let aboutUsViewController = mainStoryboard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        self.aboutUsViewController = UINavigationController(rootViewController: aboutUsViewController)
        
        //TEST:
        let topUpVC = mainStoryboard.instantiateViewController(withIdentifier: "TopUpViewController") as! TopUpViewController
        self.topUpViewController = UINavigationController(rootViewController: topUpVC)
        
        let notificationsViewController = mainStoryboard.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
        self.notificationsViewController = UINavigationController(rootViewController: notificationsViewController)
        
        let inviteaFriendViewController = mainStoryboard.instantiateViewController(withIdentifier: "InviteaFriendViewController") as! InviteaFriendViewController
        self.inviteaFriendViewController = UINavigationController(rootViewController: inviteaFriendViewController)
        
        let signInViewController = loginStoryboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.signInViewController = UINavigationController(rootViewController: signInViewController)
        
        let favoriteViewController = favoriteStoryboard.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
        self.favoriteViewController = UINavigationController(rootViewController: favoriteViewController)
        
        let userProfileViewController = mainStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
        self.userProfileViewController = UINavigationController(rootViewController: userProfileViewController)
        
        self.tableView.registerCellClass(MenuTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
        imageHeaderView.delegate = self
        
        updateUIByLogin()
        
        NotificationCenter.default.rx.notification(Notification.Name("UserLoginedNotification"))
            .subscribe(onNext: { _ in
                self.slideMenuController()?.changeMainViewController(self.homeViewController, close: true)
                self.tableView.reloadData()
                self.setRightBarButton()
                self.updateUIByLogin()
                self.imageHeaderView.updateUIByLogin()
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(Notification.Name("ChangeMenuTab"))
            .subscribe(onNext: { notification in
                let s = notification.object as! String
                if(Global.user != nil) {
                    switch s {
                    case "UploadPrescription":
                        self.changeViewController(LeftMenuLogined.uploadPrescription)
                        self.tableView.selectRow(at: IndexPath(row: 2, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
                    case "OnlineShop":
                        self.tableView.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
                        self.changeViewController(LeftMenuLogined.onlineShop)
                    case "AskaDoctor":
                        self.changeViewController(LeftMenuLogined.askaDoctor)
                        self.tableView.selectRow(at: IndexPath(row: 4, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
                    case "SocialWall":
                        self.changeViewController(LeftMenuLogined.socialWall)
                        self.tableView.selectRow(at: IndexPath(row: 3, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
                    default:
                        break
                    }
                } else {
                    switch s {
                    case "UploadPrescription":
                        self.changeViewController(LeftMenu.uploadPrescription)
                        self.tableView.selectRow(at: IndexPath(row: 3, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
                    case "OnlineShop":
                        self.changeViewController(LeftMenu.onlineShop)
                        self.tableView.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
                    case "AskaDoctor":
                        self.changeViewController(LeftMenu.askaDoctor)
                        self.tableView.selectRow(at: IndexPath(row: 2, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
                    case "SocialWall":
                        self.changeViewController(LeftMenu.socialWall)
                        self.tableView.selectRow(at: IndexPath(row: 4, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
                    default:
                        break
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    func goToSignIn() {
        slideMenuController()?.changeMainViewController(signInViewController, close: true)
    }
    
    func goToFavorite() {
        slideMenuController()?.changeMainViewController(favoriteViewController, close: true)
    }
    
    func goToUserProfile() {
        slideMenuController()?.changeMainViewController(userProfileViewController, close: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 187)
        view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .home:
            slideMenuController()?.changeMainViewController(homeViewController, close: true)
        case .onlineShop:
            slideMenuController()?.changeMainViewController(onlineShopViewController, close: true)
        case .askaDoctor:
            requireLogin()
        case .uploadPrescription:
            requireLogin()
        case .socialWall:
            slideMenuController()?.changeMainViewController(socialWallViewController, close: true)
        case .helpCentre:
            slideMenuController()?.changeMainViewController(helpCentreViewController, close: true)
        case .privacyPolicy:
            slideMenuController()?.changeMainViewController(privacyPolicyViewController, close: true)
        case .userAgreement:
            slideMenuController()?.changeMainViewController(userAgreementViewController, close: true)
        case .aboutUs:
//            slideMenuController()?.changeMainViewController(aboutUsViewController, close: true)
                          slideMenuController()?.changeMainViewController(topUpViewController, close: true)
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
        case .termsAndConditions:
            break
        case .privacyPolicy:
            slideMenuController()?.changeMainViewController(privacyPolicyViewController, close: true)
        case .userAgreement:
            slideMenuController()?.changeMainViewController(userAgreementViewController, close: true)
        case .aboutUs:
            slideMenuController()?.changeMainViewController(aboutUsViewController, close: true)
            slideMenuController()?.changeMainViewController(topUpViewController, close: true)
        case .notifications:
            slideMenuController()?.changeMainViewController(notificationsViewController, close: true)
        case .inviteaFriend:
            slideMenuController()?.changeMainViewController(inviteaFriendViewController, close: true)
        case .logout:
            Global.user = nil
            ApiManager.logout()
            slideMenuController()?.changeMainViewController(signInViewController, close: true)
        }
    }
    
    func updateUIByLogin() {
        if Global.user != nil {
            self.topMenuLayoutConstraint.constant = 187
        } else {
            self.topMenuLayoutConstraint.constant = 85
        }
    }
    
    func requireLogin() {
        let requireLoginViewController = RequireLoginViewController(nibName: "RequireLoginViewController", bundle: nil)
        let popup = PopupDialog(viewController: requireLoginViewController, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        let cancelButton = CancelButton(title: NSLocalizedString("Cancel", comment: ""), height: 40) { }
        let loginButton = DefaultButton(title: NSLocalizedString("Login", comment: ""), height: 40) {
            self.slideMenuController()?.changeMainViewController(self.signInViewController, close: true)
        }
        popup.addButtons([cancelButton, loginButton])
        self.present(popup, animated: true, completion: nil)
        self.tableView.selectRow(at: IndexPath(row: -1, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
    }
}

extension LeftViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(Global.user != nil) {
            if let menu = LeftMenuLogined(rawValue: indexPath.row) {
                switch menu {
                case .home, .helpCentre, .termsAndConditions, .aboutUs, .notifications, .inviteaFriend, .logout :
                    return MenuTableViewCell.height()
                case .onlineShop, .askaDoctor, .uploadPrescription, .socialWall:
                    if(sub1) {
                        return MenuTableViewCell.height()
                    } else {
                        return 0
                    }
                case .privacyPolicy, .userAgreement:
                    if(sub2) {
                        return MenuTableViewCell.height()
                    } else {
                        return 0
                    }
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
        if(Global.user != nil) {
            if let menu = LeftMenuLogined(rawValue: indexPath.row) {
                if(indexPath.row == 0 || indexPath.row == 8) {
                    if(indexPath.row == 0) {
                        sub1 = !sub1
                    } else if (indexPath.row == 8) {
                        sub2 = !sub2
                    }
                    tableView.beginUpdates()
                    tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
                    tableView.endUpdates()
                } else {
                    self.changeViewController(menu)
                }
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
        if(Global.user != nil) {
            return menusLogined.count
        } else {
            return menus.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(Global.user != nil) {
            if let menu = LeftMenuLogined(rawValue: indexPath.row) {
                switch menu {
                case .home, .onlineShop, .askaDoctor, .uploadPrescription, .socialWall, .helpCentre, .termsAndConditions,
                     .privacyPolicy, .userAgreement, .aboutUs, .notifications, .inviteaFriend, .logout :
                    let cell = Bundle.main.loadNibNamed("MenuTableViewCell", owner: self, options: nil)?.first as! MenuTableViewCell
                    switch menu {
                    case .onlineShop, .askaDoctor, .uploadPrescription, .socialWall, .privacyPolicy, .userAgreement:
                        cell.setData(image: loadIcon(menu), string: menusLogined[indexPath.row], submenu: true)
                    default:
                        cell.setData(image: loadIcon(menu), string: menusLogined[indexPath.row], submenu: false)
                    }
                    cell.clipsToBounds = true
                    return cell
                }
            }
        } else if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .home, .onlineShop, .askaDoctor, .uploadPrescription, .socialWall, .helpCentre, .privacyPolicy, .userAgreement, .aboutUs :
                let cell = Bundle.main.loadNibNamed("MenuTableViewCell", owner: self, options: nil)?.first as! MenuTableViewCell
                cell.setData(image: loadIcon(menu), string: menus[indexPath.row], submenu: false)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func loadIcon(_ menu: LeftMenu) -> UIImage {
        switch menu {
        case .home:
            return #imageLiteral(resourceName: "menu-home")
        case .onlineShop:
            return #imageLiteral(resourceName: "menu-online-shop")
        case .askaDoctor:
            return #imageLiteral(resourceName: "menu-ask-doc")
        case .uploadPrescription:
            return #imageLiteral(resourceName: "menu-upload-prescription")
        case .socialWall:
            return #imageLiteral(resourceName: "menu-social-wall")
        case .helpCentre:
            return #imageLiteral(resourceName: "menu-help-center")
        case .privacyPolicy:
            return #imageLiteral(resourceName: "menu-privacy-policy")
        case .userAgreement:
            return #imageLiteral(resourceName: "menu-user-agreement")
        case .aboutUs:
            return #imageLiteral(resourceName: "menu-about-us")
        }
    }
    
    func loadIcon(_ menu: LeftMenuLogined) -> UIImage {
        switch menu {
        case .home:
            return #imageLiteral(resourceName: "menu-home")
        case .onlineShop:
            return #imageLiteral(resourceName: "menu-online-shop")
        case .askaDoctor:
            return #imageLiteral(resourceName: "menu-ask-doc")
        case .uploadPrescription:
            return #imageLiteral(resourceName: "menu-upload-prescription")
        case .socialWall:
            return #imageLiteral(resourceName: "menu-social-wall")
        case .helpCentre:
            return #imageLiteral(resourceName: "menu-help-center")
        case .privacyPolicy:
            return #imageLiteral(resourceName: "menu-privacy-policy")
        case .userAgreement:
            return #imageLiteral(resourceName: "menu-user-agreement")
        case .aboutUs:
            return #imageLiteral(resourceName: "menu-about-us")
        case .notifications:
            return #imageLiteral(resourceName: "menu-notification")
        case .inviteaFriend:
            return #imageLiteral(resourceName: "menu-invite-a-friend")
        case .termsAndConditions:
            return #imageLiteral(resourceName: "menu-term-and-condition")
        case .logout:
            return #imageLiteral(resourceName: "menu-log-out")
        }
    }
}
