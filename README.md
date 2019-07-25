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

## Handy user interface (Spec 2 only)

![image](https://user-images.githubusercontent.com/7606540/61800552-8767d100-ae2d-11e9-8450-b5080326995e.png)
