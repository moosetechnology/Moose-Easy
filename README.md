# Moose-Easy

Master: [![Build Pass](https://travis-ci.org/moosetechnology/Moose-Easy.svg?branch=master)](https://travis-ci.org/moosetechnology/Moose-Easy)

Tools to facilitate access to Moose, e.g., generating MSE files from source code.

# Famix Maker 

Create MSE files easily, provided you have installed [VerveineJ](https://github.com/moosetechnology/VerveineJ).

```Smalltalk
wizard := MooseEasyFamixMaker new
    verveineJScriptPath: 'path/to/verveinej.sh' asFileReference;
    javaSourcePath: 'path/to/java/project/src' asFileReference;
    mseDestinationPath: 'path/to/mseFile.mse' asFileReference.
wizard generateMSE.
```

## Handy user interface (Spec 2, Moose 8 only)

```Smalltalk
MooseEasyFamixMakerPresenter open
```

![image](https://user-images.githubusercontent.com/7606540/61800552-8767d100-ae2d-11e9-8450-b5080326995e.png)

## Version management 

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

- **X** defines the major version number
- **Y** defines the minor version number 
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.
