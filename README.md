# DrawerSideBar

A smooth, customizable slide-out drawer navigation library for SwiftUI

DrawerSideBar is a lightweight SwiftUI package that brings smooth slide-out drawer navigation with a beautiful scale and reveal effect, safe area handling, and full customization — all in a few lines of code.

---

## Preview

<img width="300" alt="DrawerSideBar Preview" src="https://github.com/user-attachments/assets/533ef5c3-c362-4da1-a48c-d894feeaa641" />
<img width="300" alt="DrawerSideBar Preview" src="https://github.com/user-attachments/assets/74b92111-8d6d-4b52-bf0a-201617e3b4bb" />
<img width="300" alt="DrawerSideBar GIF" src="https://github.com/user-attachments/assets/575cb9da-90f5-44f9-b2e9-5c3daa2cfaf8" />

---

## Requirements

- iOS 17.0+
- Swift 5.9+
- Xcode 15.0+

---

## Installation

### Swift Package Manager

1. In Xcode go to **File → Add Package Dependencies**
2. Paste the URL:
```
https://github.com/shubhamKachhiya/DrawerSideBar.git
```
3. Select version **1.0.0** and click **Add Package**

---

## Usage

### Basic (No external control needed)
```swift
import DrawerSideBar

SideBarNavigationView {  safeArea in
    // Your Sidebar View
    ZStack {
        Color.blue
        VStack(alignment: .leading) {
            Text("Sidebar Content")
                .foregroundColor(.white)
        }
        .padding(.top, safeArea.top)
        .padding(.bottom, safeArea.bottom)
    }
} main: { safeArea in
    // Your Main View
    ZStack {
        Color.white
        VStack {
            Text("Main Content")
        }
        .padding(.top, safeArea.top)
        .padding(.bottom, safeArea.bottom)
    }
}
```

### Advanced (With external control)
```swift
import DrawerSideBar

struct ContentView: View {
    
    @State var name: String = "Main Content"
    @State var isSideBarOpened = false
    
    var body: some View {
        SideBarNavigationView(isSideBarOpened: $isSideBarOpened, sideBarWidthRatio: 0.7, mainViewScaleSize: 0.8) { safeArea in
            
            Sidebar(safeArea: safeArea, action: { name in
                self.name = name
                isSideBarOpened = false
            })
            
        } main: { safeArea in
            MainView(safeArea: safeArea, name: self.name)
        }
        
        
    }
}
```

---

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `isSideBarOpened` | `Binding<Bool>` | `.constant(false)` | Control sidebar open/close from outside |
| `sideBarWidthRatio` | `CGFloat` | `0.7` | Sidebar width as ratio of screen width (0.0 to 1.0) |
| `mainViewScaleSize` | `CGFloat` | `0.8` | Main view scale when drawer is open (0.0 to 1.0) |
| `sideBar` | `ViewBuilder` | — | Your custom sidebar view |
| `main` | `ViewBuilder` | — | Your custom main view |

---

## Features

- ✅ Fully customizable sidebar and main view
- ✅ Smooth scale and reveal animation
- ✅ Swipe gesture support
- ✅ Safe area handled automatically via closure
- ✅ Control sidebar programmatically via `@Binding`
- ✅ Lightweight — no dependencies
- ✅ Pure SwiftUI

---

## License

DrawerSideBar is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

---

## Author

Made by [Shubham Kachhiya](https://github.com/shubhamKachhiya)
