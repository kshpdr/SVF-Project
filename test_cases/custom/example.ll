; ModuleID = 'example.c'
source_filename = "example.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [19 x i8] c"Sink received: %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @sink(i32 noundef %data) #0 !dbg !8 {
entry:
  %data.addr = alloca i32, align 4
  store i32 %data, i32* %data.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %data.addr, metadata !13, metadata !DIExpression()), !dbg !14
  %0 = load i32, i32* %data.addr, align 4, !dbg !15
  %call = call i32 (i8*, ...) @printf(i8* noundef getelementptr inbounds ([19 x i8], [19 x i8]* @.str, i64 0, i64 0), i32 noundef %0), !dbg !16
  ret void, !dbg !17
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @printf(i8* noundef, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @src() #0 !dbg !18 {
entry:
  %data = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %data, metadata !21, metadata !DIExpression()), !dbg !22
  store i32 42, i32* %data, align 4, !dbg !22
  %0 = load i32, i32* %data, align 4, !dbg !23
  call void @sink(i32 noundef %0), !dbg !24
  ret void, !dbg !25
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !26 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @src(), !dbg !29
  ret i32 0, !dbg !30
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 14.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "example.c", directory: "/home/project/test_cases/custom", checksumkind: CSK_MD5, checksum: "0ead89ce0d2f3eef49076be7e5de6164")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 7, !"uwtable", i32 1}
!6 = !{i32 7, !"frame-pointer", i32 2}
!7 = !{!"clang version 14.0.0"}
!8 = distinct !DISubprogram(name: "sink", scope: !1, file: !1, line: 3, type: !9, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !{}
!13 = !DILocalVariable(name: "data", arg: 1, scope: !8, file: !1, line: 3, type: !11)
!14 = !DILocation(line: 3, column: 15, scope: !8)
!15 = !DILocation(line: 4, column: 35, scope: !8)
!16 = !DILocation(line: 4, column: 5, scope: !8)
!17 = !DILocation(line: 5, column: 1, scope: !8)
!18 = distinct !DISubprogram(name: "src", scope: !1, file: !1, line: 7, type: !19, scopeLine: 7, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!19 = !DISubroutineType(types: !20)
!20 = !{null}
!21 = !DILocalVariable(name: "data", scope: !18, file: !1, line: 8, type: !11)
!22 = !DILocation(line: 8, column: 9, scope: !18)
!23 = !DILocation(line: 9, column: 10, scope: !18)
!24 = !DILocation(line: 9, column: 5, scope: !18)
!25 = !DILocation(line: 10, column: 1, scope: !18)
!26 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !27, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !12)
!27 = !DISubroutineType(types: !28)
!28 = !{!11}
!29 = !DILocation(line: 13, column: 5, scope: !26)
!30 = !DILocation(line: 14, column: 5, scope: !26)
