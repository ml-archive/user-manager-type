### This library has been deprecated and the repo has been archived. 
### The code is still here and you can still clone it, however the library will not receive any more updates or support.

# User Manager Type

![Plaforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nodes-ios/user-manager-type/blob/master/LICENSE)

`UserManagerType` is a protocol that makes it easier to implement a user manager system for your iOS app.


## 📝 Requirements

* iOS 8.0+
* Swift 3.0+

## 📦 Installation

### Carthage
~~~bash
github "nodes-ios/user-manager-type" ~> 2.0
~~~

> Last versions compatible with lower Swift versions:  
>
> **Swift 2.3**  
> `github "nodes-ios/user-manager-type" == 1.2.0`
>
> **Swift 2.2**  
> `github "nodes-ios/user-manager-type" == 1.1.2`

 
## 💻 Usage

Create a `UserManager` class, that conforms to the `UserManagerType` protocol. Don't forget about the

```swift
import UserManagerType
```

Specify the `UserType` typealias to your User class. In the case of this example, the class/struct that we use for a user is called `User`.

```swift
typealias UserType = User
```

And that's it. You now have a fully working UserManager, which can store the current user, the current user's token, log out the current user or check if the current user is logged in. 

Have a look at the `UserManagerType`'s interface:

```swift
///  Get or set the current user object
public static var currentUser: UserType? { get set }

/// Get or set the token string
public static var token: String? { get set }

/// Logout current user and set the object with the key `User` to nil and optionally set token to nil.
public static func logoutCurrentUser(clearToken clear: Bool)

/// Check if someone is logged in
public static var isLoggedIn: Bool { get }
```
## 🔎 Examples
You probably need to **send an auth token in all your API request headers**. You can get the token like this:

``` swift
let auth = UserManager.token ?? ""
```

Anywhere in the code where you need to **access the currently logged in user**, you can do this:

```swift
if let currentUser = UserManager.currentUser {
	// do your stuff here
}
```

After calling your API's login method, if it succeeded, make sure you **set the token on the `UserManager`**. Setting it only on the `UserManager.currentUser` won't work.

```swift
ConnectionManager.login(username: username, password: password, completion: { (response) in
	switch response.result {
    case .success(let user):
    UserManager.currentUser = user
    UserManager.token = user.token
    // do whatever else needs to be done here
    
    case .failure(let error):
	// handle the error
})
```

There are some REST APIs that always return the token on the user object, in all the calls. For those, setting the token separately on the `UserManager` might seem redundant. But other REST APIs only send the token in the response to the login method. If there's a `/me` API call that returns the current user, but without his token, then in the `UserManager`, the `currentUser` would have an empty or nil token (dependin on how you deserialize it). We chose to have the token stored directly on the `UserManager` to accomodate both situations.

To **log out the current user**, you can do this:
```swift
UserManager.logoutCurrentUser(clearToken: true)
```
This will clear the current user and the token. You will still need to handle the UI for that (i.e. take the user back to the login flow)

## 👥 Credits
Made with ❤️ at [Nodes](http://nodesagency.com).

## 📄 License
**UserManagerType** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/user-manager-type/blob/master/LICENSE) file for more info.
