import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let appDiContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //
    }
}
