
//===- SVF-Project -------------------------------------//
//
//                     SVF: Static Value-Flow Analysis
//
// Copyright (C) <2013->  <Yulei Sui>
//

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//===-----------------------------------------------------------------------===//
#include "SVF-LLVM/LLVMUtil.h"
#include "SVF-LLVM/SVFIRBuilder.h"
#include "WPA/Andersen.h"
#include "Graphs/PTACallGraph.h"

#include <iostream>
#include <vector>
#include <set>
#include <string>

using namespace llvm;
using namespace std;
using namespace SVF;

bool reachedPrinted = false;

static llvm::cl::opt<std::string> InputFilename(cl::Positional,
        llvm::cl::desc("<input bitcode>"), llvm::cl::init("-"));

std::vector<std::string> splitString(std::stringstream str, char delim){
    std::vector<std::string> seglist;
    std::string segment;
    while(std::getline(str, segment, delim)){
        seglist.push_back(segment);
    }
    return seglist;
}

void printPath(vector<string> & path){
    if(!reachedPrinted){
        cout << "Reachable" << endl;
        reachedPrinted = true;
    }
    for(string s : path){
        cout << s;
    }
    cout << endl;
}

void bfs(bool srcFound,
ICFGNode* iNode,
unordered_set<const ICFGNode*> & visited,
vector<string> & path,
unordered_map<const ICFGNode*, string> & cycleSourceNodeToPathNameMap){
    if (FunEntryICFGNode::classof(iNode)) {
        string funName = dyn_cast<const SVF::FunEntryICFGNode>(iNode)->getFun()->getName();
        if(srcFound && funName == "sink"){
            path.pop_back();
            printPath(path);
            path.push_back("-->");
            return;
        }
    }
    for (ICFGNode::const_iterator it = iNode->OutEdgeBegin(), eit =
                iNode->OutEdgeEnd(); it != eit; ++it)
    {
        ICFGEdge* edge = *it;
        ICFGNode* succNode = edge->getDstNode();
        if (visited.find(succNode) == visited.end())
        {
            visited.insert(succNode);
            if (FunEntryICFGNode::classof(succNode)) {
                string funName = dyn_cast<const SVF::FunEntryICFGNode>(succNode)->getFun()->getName();
                if(funName == "src"){
                    srcFound = true;
                    visited.clear();
                    visited.insert(succNode);
                }
            }
            if(srcFound){
                if(cycleSourceNodeToPathNameMap.count(succNode) != 0){
                    path.push_back(cycleSourceNodeToPathNameMap.at(succNode));
                    path.push_back("-->");
                    bfs(srcFound, succNode, visited, path, cycleSourceNodeToPathNameMap);
                    path.pop_back();
                    path.pop_back();
                }
                path.push_back(std::to_string(succNode->getId()));
                path.push_back("-->");
            }
            bfs(srcFound, succNode, visited, path, cycleSourceNodeToPathNameMap);
            if(visited.find(succNode) != visited.end()) {visited.erase(succNode);}
            if(srcFound){
                path.pop_back();
                path.pop_back();
            }
            if (FunEntryICFGNode::classof(succNode)) {
                string funName = dyn_cast<const SVF::FunEntryICFGNode>(succNode)->getFun()->getName();
                if(funName == "src"){
                    srcFound = false;
                }
            }
        }
    }
}

string getCycle(const ICFGNode* currNode,
const ICFGNode* currNodeCycle,
const unordered_map<const ICFGNode*, const ICFGNode*> & predecessorMap){
    string firstId = std::to_string(currNodeCycle->getId());
    string path = "Cycle[" + firstId + "-->";
    currNodeCycle = predecessorMap.at(currNodeCycle);
    while(currNodeCycle != currNode){
        path += std::to_string(currNodeCycle->getId()) + "-->";
        currNodeCycle = predecessorMap.at(currNodeCycle);
    }
    path += std::to_string(currNodeCycle->getId())+ "-->" + firstId + "]";
    return path;
}

void getCyclesWithDFS(ICFGNode* iNode,
unordered_set<const ICFGNode*> & visited,
unordered_set<const ICFGNode*> & visitedInCurrentPath,
unordered_map<const ICFGNode*, const ICFGNode*> predecessorMap,
unordered_map<const ICFGNode*, string> & cycleSourceNodeToPathNameMap){
    for (ICFGNode::const_iterator it = iNode->OutEdgeBegin(), eit =
                iNode->OutEdgeEnd(); it != eit; ++it)
    {
        ICFGEdge* edge = *it;
        ICFGNode* succNode = edge->getDstNode();
        if (visitedInCurrentPath.find(succNode) != visitedInCurrentPath.end()){
            string s = getCycle(iNode, succNode, predecessorMap);
            cycleSourceNodeToPathNameMap.insert({succNode, s});
        }
        if (visited.find(succNode) == visited.end())
        {
            visited.insert(succNode);
            visitedInCurrentPath.insert(succNode);
            predecessorMap.insert({iNode, succNode});
            getCyclesWithDFS(succNode, visited, visitedInCurrentPath, predecessorMap, cycleSourceNodeToPathNameMap);
            visitedInCurrentPath.erase(succNode);
        }
    }
    return;
}

void traverseOnICFG(PTACallGraph* callgraph, ICFG* icfg, const SVFInstruction* svfinst)
{
    ICFGNode* iNode = icfg->getICFGNode(svfinst);
    unordered_set<const ICFGNode*> visited;
    unordered_set<const ICFGNode*> visited_for_cycles;
    unordered_map<const ICFGNode*, const ICFGNode*> predecessorMap;
    unordered_map<const ICFGNode*, string> cycleSourceNodeToPathNameMap;
    vector<string> path;
    getCyclesWithDFS(iNode, visited, visited_for_cycles, predecessorMap, cycleSourceNodeToPathNameMap);
    visited.clear();
    bfs(false, iNode, visited, path, cycleSourceNodeToPathNameMap);
}

int main(int argc, char ** argv) {

    int arg_num = 0;
    char **arg_value = new char*[argc];
    std::vector<std::string> moduleNameVec;
    SVF::LLVMUtil::processArguments(argc, argv, arg_num, arg_value, moduleNameVec);
    cl::ParseCommandLineOptions(arg_num, arg_value,
                                "Whole Program Points-to Analysis\n");

    SVFModule* svfModule = LLVMModuleSet::getLLVMModuleSet()->buildSVFModule(moduleNameVec);
    string graphFileName = splitString((std::stringstream) moduleNameVec.back(), '/').back();

    /// Build Program Assignment Graph (SVFIR)
    SVFIRBuilder builder(svfModule);
    SVFIR* svfir = builder.build();

    std::cout.setstate(std::ios::failbit);
    PTACallGraph* callgraph = AndersenWaveDiff::createAndersenWaveDiff(svfir)->getPTACallGraph();
    builder.updateCallGraph(callgraph);
    callgraph->dump("/home/project/graphs/call_graph_" + graphFileName);

    /// ICFG
    ICFG* icfg = svfir->getICFG();
    icfg->dump("/home/project/graphs/icfg_" + graphFileName);

    const SVFFunction* mainFunc = svfModule->getSVFFunction("main");
    const SVFInstruction* mainInst = mainFunc->getEntryBlock()->front();

    // Example of getting a function name of the call node
    SVF::PTACallGraphNode* ptaCallNode = callgraph->getCallGraphNode(mainFunc);
    const SVF::SVFFunction* svfFunction = ptaCallNode->getFunction();

    std::cout.clear() ;
    traverseOnICFG(callgraph, icfg, mainInst);
    if(!reachedPrinted){
        cout << "Unreachable" << endl;
    }

    return 0;
}
