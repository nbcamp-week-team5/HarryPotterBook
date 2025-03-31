# Harry Potter Book

## Description

### Directory Tree

## Installations w Dependencies (snp.kit)
You can certainly add the dependencies to your project, in my case, was `snapKit`. 
When you install `snapKit` you have to choose wheter you want to use static library or dynamic library
(ex: snapKit-Dynamic => Dynamic Library, snapKit => Static Library)

### Static vs Dynamic Lib
*Static Libs*
* are intended for making simple app (in my case)
* No runtime dependency: The executable is self-contained and doesn't require external files to run
* Faster Execution: Since all code is already part of the executable, there is no need for dynamic linking at runtime

*Dynamic Libs*
* Smaller executables: The application does not include the library code, reducing its size (not large size as static lib)
* Memory efficiency: Shared libraries allow multiple applications to use a single instance of the library in memory, saving resources
* Need to be link or load dynamic lib in run time (runtime dependency)
* Slower startup: Dynamic linking at runtime can slightly increase application startup time (maybe very minimal, but it is good to use modular sometimes if you have multiple libs).

### Results:
As stated above, this app is supposed to be simple, so I choosed static libs, obviously dependencies are interchangable depending on the purpose.

Proof of Deletion: 
>> Target -> Frameworks, Libraries, and Embedded Content, There is only Snapkit (static lib)

---

## I don't want to use "Asset.xcassets", Here is why!
As far as the project goes, and I've done research about Asset.xcassets. It's best not to load the assets into Asset.xcassets (Reasoning: [Image Loader](https://www.notion.so/Image-Loader-1adf2a8721a18093a34ff970672999e2)). For practical reason, I chose to load image from Network, where I can have a full control of concurrency

## Challenges 
* Loading Images Asynchronously was a bit difficult for me with using compleition (maybe I didn't try enough). But I know that Image Loader always have to be done asynchronously.
* There was often time that userDefaults save the unexpected index. (That's why in Line 51 ~ 54). I save the default data
```
// push default data for index 0
if userDefaultsService.load(forKey: UserDefaultsKeys.selectedIndex) == nil {
    userDefaultsService.save(0, forKey: UserDefaultsKeys.selectedIndex)
}
```
* Instead of using UserDefaults Data, it would be great to use CoreData (as far as I know, you can visualize the status for index / page expand states)

## Changes I've made
* My app was suppoed to send the UIImage directly to `BriefView`, which it wasn't the great idea when `MVVM` architecutre is used. So I am sending the `Data` instead. Then Views retrieve that data, and convert it into `UIImage()`.
* Image Caches are implemented for `.memory -> .disk` order

### Trouble Shotings
* If you want to fetch the image from specific branch, you shouldn't use `github.com` as a link. 

**As-Is**
>> "https://github.com/nbcamp-week-team5/HarryPotterBook/tree/feat/shjang/shjang/HarryPotterBook/HarryPotterBook/Resource/img"

**To-Be**
>> "https://raw.githubusercontent.com/nbcamp-week-team5/HarryPotterBook/feat/shjang/shjang/HarryPotterBook/HarryPotterBook/Resource/img"

**Trouble Shooting**
![alt text](loadingFailed.png)

### Resource 
* [Loading Image from URL on Swift](https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift)
* [How to use DispatchGroup](https://ruslandzhafarov.medium.com/how-to-use-dispatchgroup-part-2-a964c446db94)
* [uploadTask, URLSessionUploadTask](https://ios-development.tistory.com/1419)
* [MIME Type](https://developer.mozilla.org/ko/docs/Web/HTTP/Guides/MIME_types)