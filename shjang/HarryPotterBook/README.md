# Harry Potter Book

## Description

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

Results:
As stated above, this app is supposed to be simple, so I choosed static libs, obviously dependencies are interchangable depending on the purpose.

Proof of Deletion: 
>> Target -> Frameworks, Libraries, and Embedded Content, There is only Snapkit (static lib)

## Todo: 
* Pages Saved: User should know the pages attributes (expanded state / activated button) in case where user exit out the app. This means that the only the initialization step, it sets to 0 index (first book)
* Image Caching
    * Depending on the request through network. save it into memory or disk