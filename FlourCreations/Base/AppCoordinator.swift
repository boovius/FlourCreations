import UIKit
import SwiftUI

class AppCoordinator: Coordinator {
  var navigationController: UINavigationController
  let window: UIWindow
  let appSession: AppSessionType
  var childCoordinators = [Coordinator]()
  
  init(window: UIWindow, appSession: AppSessionType = AppSession.shared) {
    self.window = window
    self.navigationController = UINavigationController()
    self.appSession = appSession
  }
  
  func start() {
    let viewModel = GalleryViewModel()
    window.rootViewController = UIHostingController(rootView: Gallery(viewModel: viewModel))
    
//    if appSession.isLoggedIn(user: appSession.currentUser) {
//      presentGallery()
//    } else {
//      presentSignIn()
//    }
    
    window.makeKeyAndVisible()
  }
}

// MARK: Presentation Methods

extension AppCoordinator {
  func presentGallery() {
    let feedCoordinator = FeedCoordinator(navigationController)
    feedCoordinator.start()
    childCoordinators.append(feedCoordinator)
  }
  
  func presentSignIn() {
    let signInCoordinator = SignInCoordinator(navigationController)
    signInCoordinator.delegate = self
    signInCoordinator.start()
    childCoordinators.append(signInCoordinator)
  }
}

// MARK: SignInCoordinatorDelegate

extension AppCoordinator: SignInCoordinatorDelegate {
  func finishSignInFlow(coordinator: SignInCoordinator) {
    childDidFinish(coordinator)
    presentGallery()
  }
}

