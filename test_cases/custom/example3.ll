; ModuleID = 'example3.c'
source_filename = "example3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [19 x i8] c"Sink received: %d\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%lf\00", align 1

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
define dso_local double @mutiply(double noundef %a, double noundef %b) #0 !dbg !30 {
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
define dso_local i32 @src() #0 !dbg !39 {
entry:
  %num1 = alloca double, align 8
  %num2 = alloca double, align 8
  %sum = alloca double, align 8
  %difference = alloca double, align 8
  %i = alloca i32, align 4
  call void @llvm.dbg.declare(metadata double* %num1, metadata !42, metadata !DIExpression()), !dbg !43
  call void @llvm.dbg.declare(metadata double* %num2, metadata !44, metadata !DIExpression()), !dbg !45
  call void @llvm.dbg.declare(metadata double* %sum, metadata !46, metadata !DIExpression()), !dbg !47
  call void @llvm.dbg.declare(metadata double* %difference, metadata !48, metadata !DIExpression()), !dbg !49
  %call = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), double* noundef %num1), !dbg !50
  %call1 = call i32 (i8*, ...) @__isoc99_scanf(i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0), double* noundef %num2), !dbg !51
  call void @llvm.dbg.declare(metadata i32* %i, metadata !52, metadata !DIExpression()), !dbg !54
  store i32 0, i32* %i, align 4, !dbg !54
  br label %for.cond, !dbg !55

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !56
  %conv = sitofp i32 %0 to double, !dbg !56
  %1 = load double, double* %num1, align 8, !dbg !58
  %cmp = fcmp olt double %conv, %1, !dbg !59
  br i1 %cmp, label %for.body, label %for.end, !dbg !60

for.body:                                         ; preds = %for.cond
  %2 = load double, double* %num1, align 8, !dbg !61
  %3 = load double, double* %num2, align 8, !dbg !63
  %call3 = call double @add(double noundef %2, double noundef %3), !dbg !64
  store double %call3, double* %sum, align 8, !dbg !65
  br label %for.inc, !dbg !66

for.inc:                                          ; preds = %for.body
  %4 = load i32, i32* %i, align 4, !dbg !67
  %inc = add nsw i32 %4, 1, !dbg !67
  store i32 %inc, i32* %i, align 4, !dbg !67
  br label %for.cond, !dbg !68, !llvm.loop !69

for.end:                                          ; preds = %for.cond
  call void @sink(i32 noundef 0), !dbg !72
  ret i32 0, !dbg !73
}

declare dso_local i32 @__isoc99_scanf(i8* noundef, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !74 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @src(), !dbg !75
  ret i32 0, !dbg !76
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 14.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "example3.c", directory: "/home/project/test_cases/custom", checksumkind: CSK_MD5, checksum: "85bc31a2f95f067acd549ed9da80f3a3")
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
!30 = distinct !DISubprogram(name: "mutiply", scope: !1, file: !1, line: 13, type: !9, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!31 = !DILocalVariable(name: "a", arg: 1, scope: !30, file: !1, line: 13, type: !11)
!32 = !DILocation(line: 13, column: 23, scope: !30)
!33 = !DILocalVariable(name: "b", arg: 2, scope: !30, file: !1, line: 13, type: !11)
!34 = !DILocation(line: 13, column: 33, scope: !30)
!35 = !DILocation(line: 14, column: 12, scope: !30)
!36 = !DILocation(line: 14, column: 16, scope: !30)
!37 = !DILocation(line: 14, column: 14, scope: !30)
!38 = !DILocation(line: 14, column: 5, scope: !30)
!39 = distinct !DISubprogram(name: "src", scope: !1, file: !1, line: 17, type: !40, scopeLine: 17, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!40 = !DISubroutineType(types: !41)
!41 = !{!24}
!42 = !DILocalVariable(name: "num1", scope: !39, file: !1, line: 19, type: !11)
!43 = !DILocation(line: 19, column: 12, scope: !39)
!44 = !DILocalVariable(name: "num2", scope: !39, file: !1, line: 19, type: !11)
!45 = !DILocation(line: 19, column: 18, scope: !39)
!46 = !DILocalVariable(name: "sum", scope: !39, file: !1, line: 19, type: !11)
!47 = !DILocation(line: 19, column: 24, scope: !39)
!48 = !DILocalVariable(name: "difference", scope: !39, file: !1, line: 19, type: !11)
!49 = !DILocation(line: 19, column: 29, scope: !39)
!50 = !DILocation(line: 20, column: 5, scope: !39)
!51 = !DILocation(line: 21, column: 5, scope: !39)
!52 = !DILocalVariable(name: "i", scope: !53, file: !1, line: 22, type: !24)
!53 = distinct !DILexicalBlock(scope: !39, file: !1, line: 22, column: 5)
!54 = !DILocation(line: 22, column: 13, scope: !53)
!55 = !DILocation(line: 22, column: 9, scope: !53)
!56 = !DILocation(line: 22, column: 20, scope: !57)
!57 = distinct !DILexicalBlock(scope: !53, file: !1, line: 22, column: 5)
!58 = !DILocation(line: 22, column: 22, scope: !57)
!59 = !DILocation(line: 22, column: 21, scope: !57)
!60 = !DILocation(line: 22, column: 5, scope: !53)
!61 = !DILocation(line: 24, column: 19, scope: !62)
!62 = distinct !DILexicalBlock(scope: !57, file: !1, line: 23, column: 5)
!63 = !DILocation(line: 24, column: 25, scope: !62)
!64 = !DILocation(line: 24, column: 15, scope: !62)
!65 = !DILocation(line: 24, column: 13, scope: !62)
!66 = !DILocation(line: 25, column: 5, scope: !62)
!67 = !DILocation(line: 22, column: 29, scope: !57)
!68 = !DILocation(line: 22, column: 5, scope: !57)
!69 = distinct !{!69, !60, !70, !71}
!70 = !DILocation(line: 25, column: 5, scope: !53)
!71 = !{!"llvm.loop.mustprogress"}
!72 = !DILocation(line: 27, column: 5, scope: !39)
!73 = !DILocation(line: 28, column: 5, scope: !39)
!74 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 31, type: !40, scopeLine: 31, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!75 = !DILocation(line: 32, column: 5, scope: !74)
!76 = !DILocation(line: 33, column: 5, scope: !74)
