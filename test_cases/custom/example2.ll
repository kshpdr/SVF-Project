; ModuleID = 'example2.c'
source_filename = "example2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%lf\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @add(double noundef %a, double noundef %b) #0 !dbg !8 {
entry:
  %a.addr = alloca double, align 8
  %b.addr = alloca double, align 8
  store double %a, double* %a.addr, align 8
  call void @llvm.dbg.declare(metadata double* %a.addr, metadata !13, metadata !DIExpression()), !dbg !14
  store double %b, double* %b.addr, align 8
  call void @llvm.dbg.declare(metadata double* %b.addr, metadata !15, metadata !DIExpression()), !dbg !16
  %0 = load double, double* %a.addr, align 8, !dbg !17
  %1 = load double, double* %b.addr, align 8, !dbg !18
  %add = fadd double %0, %1, !dbg !19
  ret double %add, !dbg !20
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @subtract(double noundef %a, double noundef %b) #0 !dbg !21 {
entry:
  %a.addr = alloca double, align 8
  %b.addr = alloca double, align 8
  store double %a, double* %a.addr, align 8
  call void @llvm.dbg.declare(metadata double* %a.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store double %b, double* %b.addr, align 8
  call void @llvm.dbg.declare(metadata double* %b.addr, metadata !24, metadata !DIExpression()), !dbg !25
  %0 = load double, double* %a.addr, align 8, !dbg !26
  %1 = load double, double* %b.addr, align 8, !dbg !27
  %sub = fsub double %0, %1, !dbg !28
  ret double %sub, !dbg !29
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !30 {
entry:
  %retval = alloca i32, align 4
  %num1 = alloca double, align 8
  %num2 = alloca double, align 8
  %sum = alloca double, align 8
  %difference = alloca double, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata double* %num1, metadata !34, metadata !DIExpression()), !dbg !35
  call void @llvm.dbg.declare(metadata double* %num2, metadata !36, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.declare(metadata double* %sum, metadata !38, metadata !DIExpression()), !dbg !39
  call void @llvm.dbg.declare(metadata double* %difference, metadata !40, metadata !DIExpression()), !dbg !41
  %call = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), double* noundef %num1), !dbg !42
  %call1 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), double* noundef %num2), !dbg !43
  %0 = load double, double* %num1, align 8, !dbg !44
  %tobool = fcmp une double %0, 0.000000e+00, !dbg !44
  br i1 %tobool, label %if.then, label %if.else, !dbg !46

if.then:                                          ; preds = %entry
  %1 = load double, double* %num1, align 8, !dbg !47
  %2 = load double, double* %num2, align 8, !dbg !49
  %call2 = call double @add(double noundef %1, double noundef %2), !dbg !50
  store double %call2, double* %sum, align 8, !dbg !51
  br label %if.end, !dbg !52

if.else:                                          ; preds = %entry
  %3 = load double, double* %num1, align 8, !dbg !53
  %4 = load double, double* %num2, align 8, !dbg !55
  %call3 = call double @subtract(double noundef %3, double noundef %4), !dbg !56
  store double %call3, double* %difference, align 8, !dbg !57
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret i32 0, !dbg !58
}

declare dso_local i32 @__isoc99_scanf(i8* noundef, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 14.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "example2.c", directory: "/home/project/test_cases/custom", checksumkind: CSK_MD5, checksum: "8d85d0d1cdc12b544d95f3baa71b2d8b")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"uwtable", i32 1}
!6 = !{i32 7, !"frame-pointer", i32 2}
!7 = !{!"clang version 14.0.0"}
!8 = distinct !DISubprogram(name: "add", scope: !1, file: !1, line: 4, type: !9, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11, !11}
!11 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!12 = !{}
!13 = !DILocalVariable(name: "a", arg: 1, scope: !8, file: !1, line: 4, type: !11)
!14 = !DILocation(line: 4, column: 19, scope: !8)
!15 = !DILocalVariable(name: "b", arg: 2, scope: !8, file: !1, line: 4, type: !11)
!16 = !DILocation(line: 4, column: 29, scope: !8)
!17 = !DILocation(line: 5, column: 12, scope: !8)
!18 = !DILocation(line: 5, column: 16, scope: !8)
!19 = !DILocation(line: 5, column: 14, scope: !8)
!20 = !DILocation(line: 5, column: 5, scope: !8)
!21 = distinct !DISubprogram(name: "subtract", scope: !1, file: !1, line: 9, type: !9, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!22 = !DILocalVariable(name: "a", arg: 1, scope: !21, file: !1, line: 9, type: !11)
!23 = !DILocation(line: 9, column: 24, scope: !21)
!24 = !DILocalVariable(name: "b", arg: 2, scope: !21, file: !1, line: 9, type: !11)
!25 = !DILocation(line: 9, column: 34, scope: !21)
!26 = !DILocation(line: 10, column: 12, scope: !21)
!27 = !DILocation(line: 10, column: 16, scope: !21)
!28 = !DILocation(line: 10, column: 14, scope: !21)
!29 = !DILocation(line: 10, column: 5, scope: !21)
!30 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !31, scopeLine: 13, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!31 = !DISubroutineType(types: !32)
!32 = !{!33}
!33 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!34 = !DILocalVariable(name: "num1", scope: !30, file: !1, line: 15, type: !11)
!35 = !DILocation(line: 15, column: 12, scope: !30)
!36 = !DILocalVariable(name: "num2", scope: !30, file: !1, line: 15, type: !11)
!37 = !DILocation(line: 15, column: 18, scope: !30)
!38 = !DILocalVariable(name: "sum", scope: !30, file: !1, line: 15, type: !11)
!39 = !DILocation(line: 15, column: 24, scope: !30)
!40 = !DILocalVariable(name: "difference", scope: !30, file: !1, line: 15, type: !11)
!41 = !DILocation(line: 15, column: 29, scope: !30)
!42 = !DILocation(line: 16, column: 5, scope: !30)
!43 = !DILocation(line: 17, column: 5, scope: !30)
!44 = !DILocation(line: 18, column: 8, scope: !45)
!45 = distinct !DILexicalBlock(scope: !30, file: !1, line: 18, column: 8)
!46 = !DILocation(line: 18, column: 8, scope: !30)
!47 = !DILocation(line: 20, column: 19, scope: !48)
!48 = distinct !DILexicalBlock(scope: !45, file: !1, line: 18, column: 13)
!49 = !DILocation(line: 20, column: 25, scope: !48)
!50 = !DILocation(line: 20, column: 15, scope: !48)
!51 = !DILocation(line: 20, column: 13, scope: !48)
!52 = !DILocation(line: 21, column: 5, scope: !48)
!53 = !DILocation(line: 24, column: 31, scope: !54)
!54 = distinct !DILexicalBlock(scope: !45, file: !1, line: 21, column: 10)
!55 = !DILocation(line: 24, column: 37, scope: !54)
!56 = !DILocation(line: 24, column: 22, scope: !54)
!57 = !DILocation(line: 24, column: 20, scope: !54)
!58 = !DILocation(line: 26, column: 5, scope: !30)
