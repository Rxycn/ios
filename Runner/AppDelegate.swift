import Flutter
import UIKit
import GoogleMaps
import FirebaseCore // Importe Firebase
import GoogleSignIn // Importez GoogleSignIn
import FirebaseAuth // Importe FirebaseAuth pour l'authentification

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Initialise Firebase
        FirebaseApp.configure()
        
        // Clé API Google Maps
        GMSServices.provideAPIKey("AIzaSyCFYlauNS6GmrICGKydRjdRHLE4977TGBQ")
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Gérer les deep links
    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        // Laissez Google Sign-In gérer l'URL en premier
        if GIDSignIn.sharedInstance.handle(url) {
            return true
        }

        // Laissez le SDK Firebase Auth général essayer de gérer l'URL.
        // Ceci est important pour d'autres flux d'authentification comme la connexion par lien email
        // ou certaines redirections de vérification d'application (comme reCAPTCHA pour Phone Auth).
        if Auth.auth().canHandle(url) {
            return true
        }
        return super.application(app, open: url, options: options)
    }

    // Gérer les Universal Links (optionnel, si utilisé)
    override func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        // Si tu utilises Firebase Dynamic Links, tu peux ajouter la gestion ici
        return super.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
}
