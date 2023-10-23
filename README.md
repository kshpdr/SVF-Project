Repository to host the Georgia Tech CS 4240 Project 3 / 6430 SVF Project

Go from C to LLVM IR (human readable):
```
clang -S -c -g -fno-discard-value-names -emit-llvm example.c -o example.ll
```

and from LLVM IR (.ll) to the binary (.bc):
```
llvm-as example.ll -o example.bc
```
For debugging, you should move the .vscode folder form ~/project directory to the home directory of the container. This is because only the ~/project is mapped to a volume. Thus, each time that the container is restared files placed under the home directory will be lost.