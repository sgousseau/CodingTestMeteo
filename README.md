# CodingTestMeteo

Affichage de la météo de Paris avec OpenWeatherMap.

## Explications

* MVVM standard avec un business layer sous forme de gestionnaire de données (WeatherManager) utilisant un utilitaire réseau (NetworkService) et/ou un utilitaire de stockage (StorageService).
* Dissociation de l’utilitaire réseau et des endpoints constituant l’API et intégration dans WeatherManager.
* Exemple d’utilisation d’un pattern Strategy (NetworkService, StorageService) pour définir quel type et donc quelle stratégie de service utiliser (exemple avec les services AlamofireNetwork, JustNetwork - qui ne sont pas implémentés).
* Utilisation partielle de [RxSwift](https://github.com/ReactiveX/RxSwift) permettant une déclaration de séquences symbolisant les traitements asynchrones de manière séquentielle.
* Utilisation de [QuickType](https://app.quicktype.io) pour générer les bases des modèles Codable
* Utilisation des [NSAttributedString](https://developer.apple.com/documentation/foundation/nsattributedstring) et [NSMutableString](https://developer.apple.com/documentation/foundation/nsmutablestring)

## Reste à faire et optimisations
* Coder une vraie vue détail qui ressemble à quelque chose :-)
* Configurer [Hero](https://github.com/HeroTransitions/Hero).
* Externaliser le parsing des objets en dehors du NetworkService.
* Ajouter la sauvegarde des endpoints utilisé pour être synchro avec l’ensemble de l’état d’une liste de forecast sauvegardée. (Utile si le endpoint est paginé, évidemment).
* Code Rx à 100% (factoriser la partie Rx des managers. Utiliser une version Rx du NetworkService et StorageService, Utiliser des bindings pour les variables).
* Tests Rx avec [RxTests](https://cocoapods.org/pods/RxTests) et [RxBlocking](https://cocoapods.org/pods/RxBlocking).
* Code coverage à 100% (Tester l'ensemble du viewModel), actuellement 59%.
* Préparer des UIView / Xibs, IBInspectable & IBDesignable et les intégrer dans un framework permettant d’enrayer les erreurs de builds en cycle (malgré l’option désactivée dans Xcode, les IBInspectable et IBDesignable peuvent causer ces builds en cycle).
* Utiliser des icons Lottie
* Utilisation de la Restauration (RestaurationId) pour démarrer encore plus rapidement l’application avec les dernières données
* Google Sheet pour les traductions + App Script pour la génération des fichiers de localization

## Libs concrètement utilisées

* [Hero](https://github.com/HeroTransitions/Hero) - Transitions d'écran
* [RxSwift](https://github.com/ReactiveX/RxSwift) - Traitements asynchrones et séquentiels
* [R.swift](https://github.com/mac-cain13/R.swift) - Gestion des assets
