Attribute VB_Name = "modCustom"
Option Explicit

Public Sub SaveNPCDefaults()
    Dim A As Integer
    With NPCDefaults
        For A = 1 To maxNPCType
            .NPCFrameOffsetX(A) = NPCFrameOffsetX(A)
            .NPCFrameOffsetY(A) = NPCFrameOffsetY(A)
            .NPCWidth(A) = NPCWidth(A)
            .NPCHeight(A) = NPCHeight(A)
            .NPCWidthGFX(A) = NPCWidthGFX(A)
            .NPCHeightGFX(A) = NPCHeightGFX(A)
            .NPCIsAShell(A) = NPCIsAShell(A)
            .NPCIsABlock(A) = NPCIsABlock(A)
            .NPCIsAHit1Block(A) = NPCIsAHit1Block(A)
            .NPCIsABonus(A) = NPCIsABonus(A)
            .NPCIsACoin(A) = NPCIsACoin(A)
            .NPCIsAVine(A) = NPCIsAVine(A)
            .NPCIsAnExit(A) = NPCIsAnExit(A)
            .NPCIsAParaTroopa(A) = NPCIsAParaTroopa(A)
            .NPCIsCheep(A) = NPCIsCheep(A)
            .NPCJumpHurt(A) = NPCJumpHurt(A)
            .NPCNoClipping(A) = NPCNoClipping(A)
            .NPCScore(A) = NPCScore(A)
            .NPCCanWalkOn(A) = NPCCanWalkOn(A)
            .NPCGrabFromTop(A) = NPCGrabFromTop(A)
            .NPCTurnsAtCliffs(A) = NPCTurnsAtCliffs(A)
            .NPCWontHurt(A) = NPCWontHurt(A)
            .NPCMovesPlayer(A) = NPCMovesPlayer(A)
            .NPCStandsOnPlayer(A) = NPCStandsOnPlayer(A)
            .NPCIsGrabbable(A) = NPCIsGrabbable(A)
            .NPCIsBoot(A) = NPCIsBoot(A)
            .NPCIsYoshi(A) = NPCIsYoshi(A)
            .NPCIsToad(A) = NPCIsToad(A)
            .NPCNoYoshi(A) = NPCNoYoshi(A)
            .NPCForeground(A) = NPCForeground(A)
            .NPCIsABot(A) = NPCIsABot(A)
            .NPCDefaultMovement(A) = NPCDefaultMovement(A)
            .NPCIsVeggie(A) = NPCIsVeggie(A)
            .NPCSpeedvar(A) = NPCSpeedvar(A)
            .NPCNoFireBall(A) = NPCNoFireBall(A)
            .NPCNoIceBall(A) = NPCNoIceBall(A)
            .NPCNoGravity(A) = NPCNoGravity(A)
            NPCFrameSpeed(A) = 8
        Next A
    End With
End Sub

Public Sub LoadNPCDefaults()
    Dim A As Integer
    With NPCDefaults
        For A = 1 To maxNPCType
            NPCFrameOffsetX(A) = .NPCFrameOffsetX(A)
            NPCFrameOffsetY(A) = .NPCFrameOffsetY(A)
            NPCWidth(A) = .NPCWidth(A)
            NPCHeight(A) = .NPCHeight(A)
            NPCWidthGFX(A) = .NPCWidthGFX(A)
            NPCHeightGFX(A) = .NPCHeightGFX(A)
            NPCIsAShell(A) = .NPCIsAShell(A)
            NPCIsABlock(A) = .NPCIsABlock(A)
            NPCIsAHit1Block(A) = .NPCIsAHit1Block(A)
            NPCIsABonus(A) = .NPCIsABonus(A)
            NPCIsACoin(A) = .NPCIsACoin(A)
            NPCIsAVine(A) = .NPCIsAVine(A)
            NPCIsAnExit(A) = .NPCIsAnExit(A)
            NPCIsAParaTroopa(A) = .NPCIsAParaTroopa(A)
            NPCIsCheep(A) = .NPCIsCheep(A)
            NPCJumpHurt(A) = .NPCJumpHurt(A)
            NPCNoClipping(A) = .NPCNoClipping(A)
            NPCScore(A) = .NPCScore(A)
            NPCCanWalkOn(A) = .NPCCanWalkOn(A)
            NPCGrabFromTop(A) = .NPCGrabFromTop(A)
            NPCTurnsAtCliffs(A) = .NPCTurnsAtCliffs(A)
            NPCWontHurt(A) = .NPCWontHurt(A)
            NPCMovesPlayer(A) = .NPCMovesPlayer(A)
            NPCStandsOnPlayer(A) = .NPCStandsOnPlayer(A)
            NPCIsGrabbable(A) = .NPCIsGrabbable(A)
            NPCIsBoot(A) = .NPCIsBoot(A)
            NPCIsYoshi(A) = .NPCIsYoshi(A)
            NPCIsToad(A) = .NPCIsToad(A)
            NPCNoYoshi(A) = .NPCNoYoshi(A)
            NPCForeground(A) = .NPCForeground(A)
            NPCIsABot(A) = .NPCIsABot(A)
            NPCDefaultMovement(A) = .NPCDefaultMovement(A)
            NPCIsVeggie(A) = .NPCIsVeggie(A)
            NPCSpeedvar(A) = .NPCSpeedvar(A)
            NPCNoFireBall(A) = .NPCNoFireBall(A)
            NPCNoIceBall(A) = .NPCNoIceBall(A)
            NPCNoGravity(A) = .NPCNoGravity(A)
            NPCFrame(A) = 0
            NPCFrameSpeed(A) = 8
            NPCFrameStyle(A) = 0
        Next A
    End With
End Sub

Public Sub FindCustomNPCs(Optional cFilePath As String = "")
    Dim A As Integer
    If Dir(FileNamePath & "\npc*.txt") <> "" Then
        For A = 1 To maxNPCType
            If Dir(FileNamePath & "\npc-" & A & ".txt") <> "" Then
                LoadCustomNPC A, FileNamePath & "\npc-" & A & ".txt"
            End If
        Next A
    End If
    If cFilePath <> "" Then
        If Dir(cFilePath & "\npc*.txt") <> "" Then
            For A = 1 To maxNPCType
                If Dir(cFilePath & "\npc-" & A & ".txt") <> "" Then
                    LoadCustomNPC A, cFilePath & "\npc-" & A & ".txt"
                End If
            Next A
        End If
    End If
End Sub

Private Sub LoadCustomNPC(A As Integer, cFileName As String)
    Dim newStr As String
    Open cFileName For Input As #1
        Do Until EOF(1)
            Input #1, newStr
            newStr = FixComma(newStr)
            If LCase(Left(newStr, Len("gfxoffsetx="))) = "gfxoffsetx=" Then NPCFrameOffsetX(A) = Mid(newStr, Len("gfxoffsetx=") + 1)
            If LCase(Left(newStr, Len("gfxoffsety="))) = "gfxoffsety=" Then NPCFrameOffsetY(A) = Mid(newStr, Len("gfxoffsety=") + 1)
            If LCase(Left(newStr, Len("width="))) = "width=" Then NPCWidth(A) = Mid(newStr, Len("width=") + 1)
            If LCase(Left(newStr, Len("height="))) = "height=" Then NPCHeight(A) = Mid(newStr, Len("height=") + 1)
            If LCase(Left(newStr, Len("gfxwidth="))) = "gfxwidth=" Then NPCWidthGFX(A) = Mid(newStr, Len("gfxwidth=") + 1)
            If LCase(Left(newStr, Len("gfxheight="))) = "gfxheight=" Then NPCHeightGFX(A) = Mid(newStr, Len("gfxheight=") + 1)
            If LCase(Left(newStr, Len("score="))) = "score=" Then NPCScore(A) = Mid(newStr, Len("score=") + 1)
            If LCase(Left(newStr, Len("playerblock="))) = "playerblock=" Then NPCMovesPlayer(A) = Mid(newStr, Len("playerblock=") + 1)
            If LCase(Left(newStr, Len("playerblocktop="))) = "playerblocktop=" Then NPCCanWalkOn(A) = Mid(newStr, Len("playerblocktop=") + 1)
            If LCase(Left(newStr, Len("npcblock="))) = "npcblock=" Then NPCIsABlock(A) = Mid(newStr, Len("npcblock=") + 1)
            If LCase(Left(newStr, Len("npcblocktop="))) = "npcblocktop=" Then NPCIsAHit1Block(A) = Mid(newStr, Len("npcblocktop=") + 1)
            If LCase(Left(newStr, Len("grabside="))) = "grabside=" Then NPCIsGrabbable(A) = Mid(newStr, Len("grabside=") + 1)
            If LCase(Left(newStr, Len("grabtop="))) = "grabtop=" Then NPCGrabFromTop(A) = Mid(newStr, Len("grabtop=") + 1)
            If LCase(Left(newStr, Len("jumphurt="))) = "jumphurt=" Then NPCJumpHurt(A) = Mid(newStr, Len("jumphurt=") + 1)
            If LCase(Left(newStr, Len("nohurt="))) = "nohurt=" Then NPCWontHurt(A) = Mid(newStr, Len("nohurt=") + 1)
            If LCase(Left(newStr, Len("noblockcollision="))) = "noblockcollision=" Then NPCNoClipping(A) = Mid(newStr, Len("noblockcollision=") + 1)
            If LCase(Left(newStr, Len("cliffturn="))) = "cliffturn=" Then NPCTurnsAtCliffs(A) = Mid(newStr, Len("cliffturn=") + 1)
            If LCase(Left(newStr, Len("noyoshi="))) = "noyoshi=" Then NPCNoYoshi(A) = Mid(newStr, Len("noyoshi=") + 1)
            If LCase(Left(newStr, Len("foreground="))) = "foreground=" Then NPCForeground(A) = Mid(newStr, Len("foreground=") + 1)
            If LCase(Left(newStr, Len("speed="))) = "speed=" Then NPCSpeedvar(A) = Mid(newStr, Len("speed=") + 1)
            If LCase(Left(newStr, Len("nofireball="))) = "nofireball=" Then NPCNoFireBall(A) = Mid(newStr, Len("nofireball=") + 1)
            If LCase(Left(newStr, Len("noiceball="))) = "noiceball=" Then NPCNoIceBall(A) = Mid(newStr, Len("noiceball=") + 1)
            If LCase(Left(newStr, Len("nogravity="))) = "nogravity=" Then NPCNoGravity(A) = Mid(newStr, Len("nogravity=") + 1)
            If LCase(Left(newStr, Len("frames="))) = "frames=" Then NPCFrame(A) = Mid(newStr, Len("frames=") + 1)
            If LCase(Left(newStr, Len("framespeed="))) = "framespeed=" Then NPCFrameSpeed(A) = Mid(newStr, Len("framespeed=") + 1)
            If LCase(Left(newStr, Len("framestyle="))) = "framestyle=" Then NPCFrameStyle(A) = Mid(newStr, Len("framestyle=") + 1)
        Loop
    Close #1
End Sub


