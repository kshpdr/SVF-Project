
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

#include <iostream>
#include <vector>
#include <set>
#include <string>

using namespace llvm;
using namespace std;
using namespace SVF;

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

/*!
 * An example to query/collect all successor nodes from a ICFGNode (iNode) along control-flow graph (ICFG)
 */
void traverseOnICFG(ICFG* icfg, const Instruction* inst)
{
    SVFInstruction* svfinst = LLVMModuleSet::getLLVMModuleSet()->getSVFInstruction(inst);

    ICFGNode* iNode = icfg->getICFGNode(svfinst);
    FIFOWorkList<const ICFGNode*> worklist;
    Set<const ICFGNode*> visited;
    worklist.push(iNode);

    /// Traverse along VFG
    while (!worklist.empty())
    {
        const ICFGNode* iNode = worklist.pop();
        for (ICFGNode::const_iterator it = iNode->OutEdgeBegin(), eit =
                    iNode->OutEdgeEnd(); it != eit; ++it)
        {
            ICFGEdge* edge = *it;
            ICFGNode* succNode = edge->getDstNode();
            if (visited.find(succNode) == visited.end())
            {
                visited.insert(succNode);
                worklist.push(succNode);
            }
        }
    }
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

    /// This is necessary if we want to consider indirect function calls. It can be interesting to speak with a TA
    /// To see if this is necessary. This can also plot the call graph which is more intuitive than the ICFG.
    // PTACallGraph* callgraph = AndersenWaveDiff::createAndersenWaveDiff(svfir)->getPTACallGraph();
    // builder.updateCallGraph(callgraph);
    // callgraph->dump("/home/project/graphs/call_graph_" + graphFileName);

    /// ICFG
    ICFG* icfg = svfir->getICFG();
    // icfg->updateCallGraph(callgraph); // This is necessary when considering indirect function calls.
    icfg->dump("/home/project/graphs/icfg_" + graphFileName);


    Andersen* ander = AndersenWaveDiff::createAndersenWaveDiff(svfir);
    PTACallGraph* callgraph = ander->getPTACallGraph();

    VFG* vfg = new VFG(callgraph);

    /// Sparse value-flow graph (SVFG)
    SVFGBuilder svfBuilder;
    SVFG* svfg = svfBuilder.buildFullSVFG(ander);
    LLVMModuleSet::getLLVMModuleSet()->dumpModulesToFile(".svf.bc");

    const SVFFunction* mainFunc = svfModule->getSVFFunction("main");
    // const BasicBlock* entryBB = &(mainFunc->getLLVMFuntcion()->getEntryBlock());
    const SVFInstruction* mainInst = mainFunc->getEntryBlock()->front();
    // traverseOnICFG(icfg, mainInst);

    return 0;
}
