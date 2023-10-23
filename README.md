Repository to host the Georgia Tech CS 4240 Project 3 / 6430 SVF Project

Go from C to LLVM IR (human readable):
```
clang -S -c -g -fno-discard-value-names -emit-llvm example.c -o example.ll
```

and from LLVM IR (.ll) to the binary (.bc):
```
llvm-as example.ll -o example.bc
```
For debugging, you should move the .vscode folder form ~/project directory to the home directory of the container. This is because only the ~/project is mapped to a volume. Thus, each time that the container is restared files placed under the home directory may be lost.

Currently, the binary can takes a program as input and generates the icfg.dot file, where we can visualize the graph. This is located under `~/project/graphs`. To visualize ICFG graphs, you can use this [webiste](https://dreampuf.github.io/GraphvizOnline/#digraph%20G%20%7B%0A%0A%20%20subgraph%20cluster_0%20%7B%0A%20%20%20%20style%3Dfilled%3B%0A%20%20%20%20color%3Dlightgrey%3B%0A%20%20%20%20node%20%5Bstyle%3Dfilled%2Ccolor%3Dwhite%5D%3B%0A%20%20%20%20a0%20-%3E%20a1%20-%3E%20a2%20-%3E%20a3%3B%0A%20%20%20%20label%20%3D%20%22process%20%231%22%3B%0A%20%20%7D%0A%0A%20%20subgraph%20cluster_1%20%7B%0A%20%20%20%20node%20%5Bstyle%3Dfilled%5D%3B%0A%20%20%20%20b0%20-%3E%20b1%20-%3E%20b2%20-%3E%20b3%3B%0A%20%20%20%20label%20%3D%20%22process%20%232%22%3B%0A%20%20%20%20color%3Dblue%0A%20%20%7D%0A%20%20start%20-%3E%20a0%3B%0A%20%20start%20-%3E%20b0%3B%0A%20%20a1%20-%3E%20b3%3B%0A%20%20b2%20-%3E%20a3%3B%0A%20%20a3%20-%3E%20a0%3B%0A%20%20a3%20-%3E%20end%3B%0A%20%20b3%20-%3E%20end%3B%0A%0A%20%20start%20%5Bshape%3DMdiamond%5D%3B%0A%20%20end%20%5Bshape%3DMsquare%5D%3B%0A%7D)

Some To do's:
- [x] Build the ICFG and plot it for debugging.
- [ ] Develop a function that can find the `src()` node and cast it to the rigth type to start the DFS.
- [ ] Develop a function that can find the `sink()` node and cast it to the rigth type.
- [ ] Develop a function that can tell if a node is IntraICFGNode, CallICFGNode, FunEntryICFGNode or FunExitICFGNode. This will be usefull for the graph traversal.
- [ ] Ask TAs if we also want to include undirect function call in our analysis.
- [ ] Ask TAs which kind of nodes we want to consider for our graph traversal, and which Node Ids should be in the output.
- [ ] Develop the BFS algorithm for path reachanbility.
- [ ] Develop an algorithm leveraging backtracking to find all paths from `src()` to `sink()`.