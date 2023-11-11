; ModuleID = 'example5.c'
source_filename = "example5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [19 x i8] c"Sink received: %d\0A\00", align 1

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
define dso_local void @sink(i32 noundef %data) #0 !dbg !21 {
entry:
  %data.addr = alloca i32, align 4
  store i32 %data, i32* %data.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %data.addr, metadata !25, metadata !DIExpression()), !dbg !26
  %0 = load i32, i32* %data.addr, align 4, !dbg !27
  %call = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([19 x i8], [19 x i8]* @.str, i64 0, i64 0), i32 noundef %0), !dbg !28
  ret void, !dbg !29
}

declare dso_local i32 @printf(i8* noundef, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @multiply(double noundef %a, double noundef %b) #0 !dbg !30 {
entry:
  %a.addr = alloca double, align 8
  %b.addr = alloca double, align 8
  store double %a, double* %a.addr, align 8
  call void @llvm.dbg.declare(metadata double* %a.addr, metadata !31, metadata !DIExpression()), !dbg !32
  store double %b, double* %b.addr, align 8
  call void @llvm.dbg.declare(metadata double* %b.addr, metadata !33, metadata !DIExpression()), !dbg !34
  %0 = load double, double* %a.addr, align 8, !dbg !35
  %1 = load double, double* %b.addr, align 8, !dbg !36
  %mul = fmul double %0, %1, !dbg !37
  ret double %mul, !dbg !38
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local double @difference(double noundef %a, double noundef %b) #0 !dbg !39 {
entry:
  %a.addr = alloca double, align 8
  %b.addr = alloca double, align 8
  store double %a, double* %a.addr, align 8
  call void @llvm.dbg.declare(metadata double* %a.addr, metadata !40, metadata !DIExpression()), !dbg !41
  store double %b, double* %b.addr, align 8
  call void @llvm.dbg.declare(metadata double* %b.addr, metadata !42, metadata !DIExpression()), !dbg !43
  %0 = load double, double* %a.addr, align 8, !dbg !44
  %1 = load double, double* %b.addr, align 8, !dbg !45
  %sub = fsub double %0, %1, !dbg !46
  ret double %sub, !dbg !47
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @src() #0 !dbg !48 {
entry:
  %num1 = alloca double, align 8
  %num2 = alloca double, align 8
  %sum = alloca double, align 8
  %diff = alloca double, align 8
  %mult = alloca double, align 8
  call void @llvm.dbg.declare(metadata double* %num1, metadata !51, metadata !DIExpression()), !dbg !52
  call void @llvm.dbg.declare(metadata double* %num2, metadata !53, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.declare(metadata double* %sum, metadata !55, metadata !DIExpression()), !dbg !56
  call void @llvm.dbg.declare(metadata double* %diff, metadata !57, metadata !DIExpression()), !dbg !58
  call void @llvm.dbg.declare(metadata double* %mult, metadata !59, metadata !DIExpression()), !dbg !60
  %0 = load double, double* %num1, align 8, !dbg !61
  %tobool = fcmp une double %0, 0.000000e+00, !dbg !61
  br i1 %tobool, label %if.then, label %if.else, !dbg !63

if.then:                                          ; preds = %entry
  %1 = load double, double* %num1, align 8, !dbg !64
  %2 = load double, double* %num2, align 8, !dbg !66
  %call = call double @add(double noundef %1, double noundef %2), !dbg !67
  call void @sink(i32 noundef 0), !dbg !68
  br label %if.end, !dbg !69

if.else:                                          ; preds = %entry
  %3 = load double, double* %num1, align 8, !dbg !70
  %4 = load double, double* %num2, align 8, !dbg !72
  %call1 = call double @multiply(double noundef %3, double noundef %4), !dbg !73
  call void @sink(i32 noundef 0), !dbg !74
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret i32 0, !dbg !75
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !76 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @src(), !dbg !77
  ret i32 0, !dbg !78
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 14.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "example5.c", directory: "/home/project/test_cases/custom", checksumkind: CSK_MD5, checksum: "943406ee2d03236162494e02f0457d8e")
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
!21 = distinct !DISubprogram(name: "sink", scope: !1, file: !1, line: 9, type: !22, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!22 = !DISubroutineType(types: !23)
!23 = !{null, !24}
!24 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!25 = !DILocalVariable(name: "data", arg: 1, scope: !21, file: !1, line: 9, type: !24)
!26 = !DILocation(line: 9, column: 15, scope: !21)
!27 = !DILocation(line: 10, column: 35, scope: !21)
!28 = !DILocation(line: 10, column: 5, scope: !21)
!29 = !DILocation(line: 11, column: 1, scope: !21)
!30 = distinct !DISubprogram(name: "multiply", scope: !1, file: !1, line: 13, type: !9, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!31 = !DILocalVariable(name: "a", arg: 1, scope: !30, file: !1, line: 13, type: !11)
!32 = !DILocation(line: 13, column: 24, scope: !30)
!33 = !DILocalVariable(name: "b", arg: 2, scope: !30, file: !1, line: 13, type: !11)
!34 = !DILocation(line: 13, column: 34, scope: !30)
!35 = !DILocation(line: 14, column: 12, scope: !30)
!36 = !DILocation(line: 14, column: 16, scope: !30)
!37 = !DILocation(line: 14, column: 14, scope: !30)
!38 = !DILocation(line: 14, column: 5, scope: !30)
!39 = distinct !DISubprogram(name: "difference", scope: !1, file: !1, line: 17, type: !9, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!40 = !DILocalVariable(name: "a", arg: 1, scope: !39, file: !1, line: 17, type: !11)
!41 = !DILocation(line: 17, column: 26, scope: !39)
!42 = !DILocalVariable(name: "b", arg: 2, scope: !39, file: !1, line: 17, type: !11)
!43 = !DILocation(line: 17, column: 36, scope: !39)
!44 = !DILocation(line: 18, column: 12, scope: !39)
!45 = !DILocation(line: 18, column: 16, scope: !39)
!46 = !DILocation(line: 18, column: 14, scope: !39)
!47 = !DILocation(line: 18, column: 5, scope: !39)
!48 = distinct !DISubprogram(name: "src", scope: !1, file: !1, line: 21, type: !49, scopeLine: 21, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!49 = !DISubroutineType(types: !50)
!50 = !{!24}
!51 = !DILocalVariable(name: "num1", scope: !48, file: !1, line: 23, type: !11)
!52 = !DILocation(line: 23, column: 12, scope: !48)
!53 = !DILocalVariable(name: "num2", scope: !48, file: !1, line: 23, type: !11)
!54 = !DILocation(line: 23, column: 18, scope: !48)
!55 = !DILocalVariable(name: "sum", scope: !48, file: !1, line: 23, type: !11)
!56 = !DILocation(line: 23, column: 24, scope: !48)
!57 = !DILocalVariable(name: "diff", scope: !48, file: !1, line: 23, type: !11)
!58 = !DILocation(line: 23, column: 29, scope: !48)
!59 = !DILocalVariable(name: "mult", scope: !48, file: !1, line: 23, type: !11)
!60 = !DILocation(line: 23, column: 35, scope: !48)
!61 = !DILocation(line: 24, column: 8, scope: !62)
!62 = distinct !DILexicalBlock(scope: !48, file: !1, line: 24, column: 8)
!63 = !DILocation(line: 24, column: 8, scope: !48)
!64 = !DILocation(line: 25, column: 13, scope: !65)
!65 = distinct !DILexicalBlock(scope: !62, file: !1, line: 24, column: 13)
!66 = !DILocation(line: 25, column: 19, scope: !65)
!67 = !DILocation(line: 25, column: 9, scope: !65)
!68 = !DILocation(line: 26, column: 9, scope: !65)
!69 = !DILocation(line: 27, column: 5, scope: !65)
!70 = !DILocation(line: 28, column: 18, scope: !71)
!71 = distinct !DILexicalBlock(scope: !62, file: !1, line: 27, column: 10)
!72 = !DILocation(line: 28, column: 24, scope: !71)
!73 = !DILocation(line: 28, column: 9, scope: !71)
!74 = !DILocation(line: 29, column: 9, scope: !71)
!75 = !DILocation(line: 31, column: 5, scope: !48)
!76 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 34, type: !49, scopeLine: 34, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!77 = !DILocation(line: 35, column: 5, scope: !76)
!78 = !DILocation(line: 36, column: 5, scope: !76)
