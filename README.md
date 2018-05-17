# RGRoutable

**RGRoutable** is a protocol oriented library to handle screen navigation/routing in iOS. It works well with or without storyboard. One can also say that it's an alternative to segue, string based navigation api, and provides a nice type based navigation.

## Usage

Let's say if `HomeViewController` wants to be a part of navigation in the app then it can simply conform to `Routable` protocol which only has one required constraint to satisfy i.e. provide an instance of `Router`,

```swift
class HomeViewController: UIViewController, Routable {

	let router = Router()
}
```

Now three things can happen with `HomeViewController`,

- push/present a new controller
- pop/dismiss itself
- receive some data when one of its `presentedViewController` got removed

#### Push/Present a new controller

```swift
router.onNext?(...)
```

#### Pop/Dismiss itself

```swift
router.onComplete(...)
```

#### Receive some data when one of its `presentedViewController` got removed

```swift
router.onReturn = { ... handle incoming data ... }
```

### How to make routes?
Let's represent the various routes of `HomeViewController` in the form of an enum, say `Route`,

```swift
extension HomeViewController {

	enum Route: RoutableData {
		case settings
		case profile
	}
}
```

And let's make a class, say `AppRouter`, which could take care of deciding which screen and how to open it like present or push,

```swift
final class AppRouter {

	var homeVC: HomeViewController {
		let controller = HomeViewController.instance()
		controller.router.onNext = { [weak self] payload in
			guard 
				let this = self, 
				let route = payload.data as? HomeViewController.Route 
				else { return }
			switch route {
			case .settings: 
				payload.sender?.present(next: this.settingsVC)
			case .profile: 
				payload.sender?.push(next: this.profileVC)
			}
		}
		return controller
	}

	var settingsVC: SettingsViewController {
		...
	}

	var profileVC: ProfileViewController {
		...
	}
}
```

## Core Architecture

**RGRoutable** contains the following core entities,

- [`Router`](Source/Core/Router.swift)
- [`Routable`](Source/Core/Routable.swift)
- [`RoutableData`](Source/Core/Routable.swift)
- [`RouterPayload`](Source/Core/RouterPayload.swift)

### Router

```swift
public typealias RouteHandler = ((RoutablePayload) -> Void)

public class Router {
	
	public var onNext: RouteHandler?
	public var onReturn: RouteHandler?
	public var onComplete: RouteHandler
}
```

### Routable

```swift
public protocol Routable: class {
	
	var router: Router { get }
	
	func present(next: Routable)
	func push(next: Routable)
	func remove(payload: RoutablePayload?)
}
```

### RoutableData

```swift
public protocol RoutableData {}
```

### RouterPayload

```swift
public final class RoutablePayload {
	
	public let data: RoutableData?
	public weak var sender: Routable?
	
	public init(data: RoutableData? = nil, sender: Routable) {
		self.data = data
		self.sender = sender
	}
}
```

## Installation

### Cocoapods

To integrate RGRoutable into your Xcode project using CocoaPods, specify it in your Podfile:

#### Swift 4

```
pod 'RGRoutable', :git => 'https://github.com/riteshhgupta/RGRoutable.git'
```

#### Swift 4 + ReactiveSwift

```
pod 'RGRoutable/ReactiveSwift', :git => 'https://github.com/riteshhgupta/RGRoutable.git'
```

## Contributing

Contributions are welcome and encouraged! Open an [issue](https://github.com/riteshhgupta/RGRoutable/issues/new) or submit a [pull request](https://github.com/riteshhgupta/RGRoutable/compare) 🚀

## Licence

RGRoutable is available under the MIT license. See the LICENSE file for more info.
