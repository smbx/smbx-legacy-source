Attribute VB_Name = "modSorting"
Option Explicit

Public Sub qSortBlocksY(min As Integer, max As Integer) 'quicksort the blocks Y
    Dim medBlock As Block
    Dim hi As Integer
    Dim lo As Integer
    Dim i As Integer
    If min >= max Then Exit Sub
    i = Int((max + min) / 2)
    medBlock = Block(i)
    Block(i) = Block(min)
    lo = min
    hi = max
    Do
        Do While Block(hi).Location.Y >= medBlock.Location.Y
            hi = hi - 1
            If hi <= lo Then Exit Do
        Loop
        If hi <= lo Then
            Block(lo) = medBlock
            Exit Do
        End If
        Block(lo) = Block(hi)
        lo = lo + 1
        Do While Block(lo).Location.Y < medBlock.Location.Y
            lo = lo + 1
            If lo >= hi Then Exit Do
        Loop
        If lo >= hi Then
            lo = hi
            Block(hi) = medBlock
            Exit Do
        End If
        Block(hi) = Block(lo)
    Loop
    qSortBlocksY min, lo - 1
    qSortBlocksY lo + 1, max
End Sub

Public Sub qSortBlocksX(min As Integer, max As Integer) 'quicksort the blocks X
    Dim medBlock As Block
    Dim hi As Integer
    Dim lo As Integer
    Dim i As Integer
    If min >= max Then Exit Sub
    i = Int((max + min) / 2)
    medBlock = Block(i)
    Block(i) = Block(min)
    lo = min
    hi = max
    Do
        Do While Block(hi).Location.X >= medBlock.Location.X
            hi = hi - 1
            If hi <= lo Then Exit Do
        Loop
        If hi <= lo Then
            Block(lo) = medBlock
            Exit Do
        End If
        Block(lo) = Block(hi)
        lo = lo + 1
        Do While Block(lo).Location.X < medBlock.Location.X
            lo = lo + 1
            If lo >= hi Then Exit Do
        Loop
        If lo >= hi Then
            lo = hi
            Block(hi) = medBlock
            Exit Do
        End If
        Block(hi) = Block(lo)
    Loop
    qSortBlocksX min, lo - 1
    qSortBlocksX lo + 1, max
End Sub

Public Sub qSortBackgrounds(min As Integer, max As Integer) 'quicksort the backgrounds
    Dim medBackground As Background
    Dim medBackgroundPri
    Dim hi As Integer
    Dim lo As Integer
    Dim i As Integer
    If min >= max Then Exit Sub
    i = Int((max + min) / 2)
    medBackground = Background(i)
    medBackgroundPri = BackGroundPri(i)
    Background(i) = Background(min)
    lo = min
    hi = max
    Do
        Do While BackGroundPri(hi) >= medBackgroundPri

            hi = hi - 1
            If hi <= lo Then Exit Do
        Loop
        If hi <= lo Then
            Background(lo) = medBackground
            Exit Do
        End If
        Background(lo) = Background(hi)
        lo = lo + 1
        Do While BackGroundPri(lo) < medBackgroundPri
            lo = lo + 1
            If lo >= hi Then Exit Do
        Loop
        If lo >= hi Then
            lo = hi
            Background(hi) = medBackground
            Exit Do
        End If
        Background(hi) = Background(lo)
    Loop
    qSortBackgrounds min, lo - 1
    qSortBackgrounds lo + 1, max
End Sub

Public Sub FindBlocks() 'create a table of contents for blocks for an optimization
    Dim A As Double
    Dim B As Double
    Dim C As Integer
    Dim curBlk As Integer
    Dim fBool As Boolean
    curBlk = 1
    For A = -FLBlocks To FLBlocks
        For B = curBlk To numBlock
            If Block(B).Location.X + Block(B).Location.Width >= A * 32 Then
                curBlk = B
                Exit For
            End If
        Next B
        FirstBlock(A) = curBlk
    Next A
    curBlk = numBlock
    For A = FLBlocks To -FLBlocks Step -1
        fBool = False
        For B = curBlk To 1 Step -1
            If Block(B).Location.X <= A * 32 Then
                curBlk = B
                Exit For
            End If
        Next B
        LastBlock(A) = curBlk
    Next A
    BlocksSorted = True
End Sub

Public Sub BlockSort() 'sizable block sorting
    Dim A As Integer
    Dim B As Integer
    Dim tempBlock As Block
    'Sort Sizable Blocks
    For A = 1 To numBlock
        If BlockIsSizable(Block(A).Type) Then
            For B = 1 To A - 1
                If Not BlockIsSizable(Block(B).Type) Then
                    tempBlock = Block(A)
                    Block(A) = Block(B)
                    Block(B) = tempBlock
                    Exit For
                End If
            Next B
        End If
    Next A
    For A = 1 To numBlock
        If BlockIsSizable(Block(A).Type) Then
            For B = 1 To numBlock
                If BlockIsSizable(Block(B).Type) Then
                    If B <> 1 Then
                        If Block(A).Location.Y < Block(B).Location.Y And A > B Then
                            tempBlock = Block(A)
                            Block(A) = Block(B)
                            Block(B) = tempBlock
                        ElseIf Block(A).Location.Y > Block(B).Location.Y And A < B Then
                            tempBlock = Block(A)
                            Block(A) = Block(B)
                            Block(B) = tempBlock
                        End If
                    End If
                End If
            Next B
        End If
    Next A
End Sub

Public Sub BlockSort2() 'Super Block sorting / slow and only used when saving
    Dim A As Integer
    Dim B As Integer
    Dim tempBlock As Block
    Dim sortAgain As Boolean
    Do
        sortAgain = False
        For A = 1 To numBlock
            For B = 1 To numBlock
                If B <> A Then
                    If Block(A).Location.Y < Block(B).Location.Y And A > B Then
                        tempBlock = Block(A)
                        Block(A) = Block(B)
                        Block(B) = tempBlock
                        sortAgain = True
                    End If
                End If
            Next B
        Next A
    Loop While sortAgain = True
End Sub

Public Sub BackgroundSort()
    Dim A As Integer
    Dim B As Integer
    Dim tempBackground As Background
    Dim sortAgain As Boolean
    Do
        sortAgain = False
        For A = 1 To numBackground
            For B = 1 To numBackground
                If B <> A Then
                    If BackGroundPri(A) < BackGroundPri(B) And A > B Then
                        tempBackground = Background(A)
                        Background(A) = Background(B)
                        Background(B) = tempBackground
                        sortAgain = True
                    End If
                End If
            Next B
        Next A
    Loop While sortAgain = True
End Sub

Public Function BackGroundPri(A As Integer) As Double 'finds where the backgrounds should be put to set drawing priority
    'Lower Numbers get drawn first
    With Background(A)
        If .Type = 11 Or .Type = 12 Or .Type = 60 Or .Type = 61 Then
            BackGroundPri = 20
        ElseIf .Type = 65 Or .Type = 26 Or .Type = 82 Or .Type = 83 Or .Type = 164 Or .Type = 165 Or .Type = 166 Or .Type = 167 Or .Type = 168 Or .Type = 169 Then               'WATER
            
            BackGroundPri = 26
        ElseIf .Type = 168 Or .Type = 159 Or .Type = 172 Or .Type = 66 Or .Type = 158 Then              'WATER FALLS
            BackGroundPri = 25
        ElseIf .Type = 75 Or .Type = 76 Or .Type = 77 Or .Type = 78 Or .Type = 14 Then
            BackGroundPri = 10
        ElseIf .Type = 79 Or .Type = 52 Then
            BackGroundPri = 30
        ElseIf .Type = 70 Or .Type = 71 Or .Type = 72 Or .Type = 73 Or .Type = 74 Or .Type = 141 Then
            BackGroundPri = 90
        ElseIf .Type = 139 Or .Type = 140 Or .Type = 48 Then
            BackGroundPri = 80
        ElseIf .Type = 65 Or .Type = 165 Then
            BackGroundPri = 150
        ElseIf Foreground(.Type) = True Then
            BackGroundPri = 125
        ElseIf .Type = 66 Then
            BackGroundPri = 50
        ElseIf .Type = 99 Then
            BackGroundPri = 99 'Always doors + 1
        ElseIf .Type = 87 Or .Type = 88 Or .Type = 92 Or .Type = 107 Or .Type = 105 Or .Type = 104 Then 'Doors
            BackGroundPri = 98
        ElseIf .Type >= 129 And .Type <= 131 Then
            BackGroundPri = 76
        ElseIf .Type = 1 Then
            BackGroundPri = 77
        Else
            BackGroundPri = 75
        End If
        BackGroundPri = BackGroundPri + Background(A).Location.X / 10000000
    End With
End Function

Public Sub NPCSort()
    Dim A As Integer
    Dim B As Integer
    Dim tempNPC As NPC
    For A = 1 To numNPCs
        If NPCIsACoin(NPC(A).Type) Then
            For B = 1 To A - 1
                If Not NPCIsACoin(NPC(B).Type) Then
                    tempNPC = NPC(A)
                    NPC(A) = NPC(B)
                    NPC(B) = tempNPC
                    Exit For
                End If
            Next B
        End If
    Next A
End Sub

Public Sub FindSBlocks() 'sorts sizable blocks
    
    Dim A As Integer
    sBlockNum = 0
    For A = 1 To numBlock
        If BlockIsSizable(Block(A).Type) Then
            sBlockNum = sBlockNum + 1
            sBlockArray(sBlockNum) = A
        End If
    Next A
    qSortSBlocks 1, sBlockNum
End Sub

Public Sub qSortSBlocks(min As Integer, max As Integer)
    Dim medBlock As Integer
    Dim hi As Integer
    Dim lo As Integer
    Dim i As Integer
    If min >= max Then Exit Sub
    
    i = Int((max + min) / 2)
    medBlock = sBlockArray(i)
    sBlockArray(i) = sBlockArray(min)
    lo = min
    hi = max
    Do
        Do While Block(sBlockArray(hi)).Location.Y >= Block(medBlock).Location.Y
            hi = hi - 1
            If hi <= lo Then Exit Do
        Loop
        If hi <= lo Then
            sBlockArray(lo) = medBlock
            Exit Do
        End If
        sBlockArray(lo) = sBlockArray(hi)
        lo = lo + 1
        Do While Block(sBlockArray(lo)).Location.Y < Block(medBlock).Location.Y
            lo = lo + 1
            If lo >= hi Then Exit Do
        Loop
        If lo >= hi Then
            lo = hi
            sBlockArray(hi) = medBlock
            Exit Do
        End If
        sBlockArray(hi) = sBlockArray(lo)
    Loop
    qSortSBlocks min, lo - 1
    qSortSBlocks lo + 1, max
End Sub

Public Sub qSortNPCsY(min As Integer, max As Integer)
    Dim medNPC As NPC
    Dim hi As Integer
    Dim lo As Integer
    Dim i As Integer
    If min >= max Then Exit Sub
    i = Int((max + min) / 2)
    medNPC = NPC(i)
    NPC(i) = NPC(min)
    lo = min
    hi = max
    Do
        Do While NPC(hi).Location.Y < medNPC.Location.Y
            hi = hi - 1
            If hi <= lo Then Exit Do
        Loop
        If hi <= lo Then
            NPC(lo) = medNPC
            Exit Do
        End If
        NPC(lo) = NPC(hi)
        lo = lo + 1
        Do While NPC(lo).Location.Y >= medNPC.Location.Y
            lo = lo + 1
            If lo >= hi Then Exit Do
        Loop
        If lo >= hi Then
            lo = hi
            NPC(hi) = medNPC
            Exit Do
        End If
        NPC(hi) = NPC(lo)
    Loop
    qSortNPCsY min, lo - 1
    qSortNPCsY lo + 1, max
End Sub

Public Sub UpdateBackgrounds()
    Dim A As Integer
    Dim B As Integer
    LastBackground = numBackground
    MidBackground = 1
    For A = 1 To numBackground
        If BackGroundPri(A) >= 25 Then
            For B = A To numBackground
                If BackGroundPri(B) >= 100 Then
                    LastBackground = B - 1
                    Exit For
                End If
            Next B
            Exit For
        End If
    Next A
    MidBackground = A

    If noUpdate = False Then
        Netplay.sendData "s" & numBackground & LB
    End If
End Sub

Public Sub qSortTempBlocksX(min As Integer, max As Integer)
    Dim medBlock As Block
    Dim hi As Integer
    Dim lo As Integer
    Dim i As Integer
    If min >= max Then Exit Sub
    i = Int((max + min) / 2)
    medBlock = Block(i)
    Block(i) = Block(min)
    lo = min
    hi = max
    Do
        Do While Block(hi).Location.X >= medBlock.Location.X
            hi = hi - 1
            If hi <= lo Then Exit Do
        Loop
        If hi <= lo Then
            Block(lo) = medBlock
            Exit Do
        End If
        Block(lo) = Block(hi)
        lo = lo + 1
        Do While Block(lo).Location.X < medBlock.Location.X
            lo = lo + 1
            If lo >= hi Then Exit Do
        Loop
        If lo >= hi Then
            lo = hi
            Block(hi) = medBlock
            Exit Do
        End If
        Block(hi) = Block(lo)
    Loop
    qSortBlocksX min, lo - 1
    qSortBlocksX lo + 1, max
End Sub

