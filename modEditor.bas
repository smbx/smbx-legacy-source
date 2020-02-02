Attribute VB_Name = "modEditor"
Option Explicit
Private ScrollDelay As Integer 'slows down the camera movement when scrolling through a level
Public Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Public Type POINTAPI
    X As Long
    Y As Long
End Type
Public CursorPos As POINTAPI
Public HasCursor As Boolean
Public NoReallyKillIt As Boolean
Public curSection As Integer

Public Sub UpdateEditor()
'this sub handles the level editor
'it is still called when the player is testing a level in the editor in windowed mode
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim qLevel As Integer
    Dim CanPlace As Boolean 'Determines if something is in the way
    Dim tempBool As Boolean
    Dim grabBool As Boolean
    Dim tempLocation As Location
    If Debugger = True Then
        frmLevelDebugger.UpdateDisplay
    End If
    GameMenu = False
    If EditorControls.Mouse1 = False Then MouseRelease = True
    If LevelEditor = True Then numPlayers = 0
    If MagicHand = True Then
        MouseMove EditorCursor.X, EditorCursor.Y, True
        frmNPCs.chkMessage.Enabled = False
    Else
        frmNPCs.chkMessage.Enabled = True
        FreezeNPCs = False
        LevelMacro = 0
        LevelMacroCounter = 0
    End If
    If MagicHand = False And ScreenType <> 0 Then
        ScreenType = 0
        SetupScreens
    End If
    If MagicHand = False Then
        If GetKeyState(vbKeyPageUp) And KEY_PRESSED Then
            If ScrollRelease = True Then
                ScrollRelease = False
                frmLevelSettings.optSection(curSection).Value = False
                curSection = curSection - 1
                If curSection < 0 Then curSection = 0
                If EditorCursor.Mode = 2 Then frmLevelSettings.optSection(curSection).Value = True
            End If
        ElseIf GetKeyState(vbKeyPageDown) And KEY_PRESSED Then
            If ScrollRelease = True Then
                ScrollRelease = False
                frmLevelSettings.optSection(curSection).Value = False
                curSection = curSection + 1
                If curSection > 20 Then curSection = 20
                If EditorCursor.Mode = 2 Then frmLevelSettings.optSection(curSection).Value = True
            End If
        Else
            ScrollRelease = True
        End If
    
    
        If (vScreenY(1) + 8) Mod 32 <> 0 Then
            vScreenY(1) = Int(vScreenY(1) / 32) * 32 - 8
        End If
        If vScreenX(1) Mod 32 <> 0 Then
            vScreenX(1) = Int(vScreenX(1) / 32) * 32
        End If
    Else
        curSection = Player(1).Section
        frmLevelSettings.optSection(Player(1).Section).Value = True
    End If
    If WorldEditor = True Then
        frmLevelEditor.mnuWorldEditor.Enabled = False
        frmLevelEditor.mnuLevelEditor.Enabled = True
        frmLevelEditor.menuView.Visible = False
        frmLevelEditor.MenuTest.Visible = False
        frmLevelEditor.picLevel.Visible = False
        frmLevelEditor.picWorld.Visible = True
    Else
        frmLevelEditor.mnuWorldEditor.Enabled = True
        frmLevelEditor.mnuLevelEditor.Enabled = False
        frmLevelEditor.menuView.Visible = True
        frmLevelEditor.MenuTest.Visible = True
        frmLevelEditor.picWorld.Visible = False
        frmLevelEditor.picLevel.Visible = True
    End If
    GetCursorPos CursorPos
    
    With CursorPos
        If .X * 15 > frmLevelEditor.Left + frmLevelWindow.Left + 200 And .X * 15 < frmLevelEditor.Left + frmLevelWindow.Left + frmLevelWindow.Width + 100 And .Y * 15 > frmLevelEditor.Top + frmLevelWindow.Top + 1150 And .Y * 15 < frmLevelEditor.Top + frmLevelWindow.Top + frmLevelWindow.Height + 700 Then
        Else
            HideCursor
        End If
    End With

   
    If frmLevelEditor.Enabled = True Then
        GetEditorControls
        If GetKeyState(vbKeyShift) And KEY_PRESSED Then
            ScrollDelay = 0
        End If
        If MagicHand = True Then ScrollDelay = 10
        If ScrollDelay <= 0 Then
            With EditorControls
                If .Up = True Then
                    vScreenY(1) = vScreenY(1) + 32
                    EditorCursor.Location.Y = EditorCursor.Location.Y - 32
                    ScrollDelay = 2
                    MouseRelease = True
                End If
                If .Down = True Then
                    vScreenY(1) = vScreenY(1) - 32
                    EditorCursor.Location.Y = EditorCursor.Location.Y + 32
                    ScrollDelay = 2
                    MouseRelease = True
                End If
                If .Left = True Then
                    vScreenX(1) = vScreenX(1) + 32
                    EditorCursor.Location.X = EditorCursor.Location.X - 32
                    ScrollDelay = 2
                    MouseRelease = True
                End If
                If .Right = True Then
                    vScreenX(1) = vScreenX(1) - 32
                    EditorCursor.Location.X = EditorCursor.Location.X + 32
                    ScrollDelay = 2
                    MouseRelease = True
                End If
            End With
        Else
            ScrollDelay = ScrollDelay - 1
        End If
        SetCursor
        
        'this is where objects are placed/grabbed/deleted
        
        With EditorCursor
            If EditorControls.Mouse1 = True Then
                CanPlace = True
                If .Mode = 13 Or .Mode = 14 Then
                    If MouseRelease = True Then
                        For A = 1 To 2
                            If CursorCollision(.Location, PlayerStart(A)) = True Then
                                PlaySound 23
                                .Location = PlayerStart(A)
                                PlayerStart(A).X = 0
                                PlayerStart(A).Y = 0
                                frmLevelEditor.optCursor(2).Value = True
                                frmLevelSettings.optLevel(3 + A).Value = True
                                .Mode = 2
                                MouseMove .X, .Y
                                MouseRelease = False
                                Netplay.sendData "v" & A & "|" & PlayerStart(A).X & "|" & PlayerStart(A).Y & "|" & PlayerStart(A).Width & "|" & PlayerStart(A).Height & LB
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numNPCs
                            tempLocation = NPC(A).Location
                            If NPC(A).Type = 91 Then tempLocation.Y = tempLocation.Y - 16
                            If CursorCollision(.Location, tempLocation) = True And NPC(A).Hidden = False Then
                                PlaySound 23
                                B = 0
                                frmLevelEditor.optCursor(4).Value = True
                                If NPC(A).Type = 91 Or NPC(A).Type = 284 Or NPC(A).Type = 283 Or (NPC(A).Type = 96 And NPC(A).Special <> 0 And NPC(A).Special <> 96) Then
                                    If NPC(A).Special > 0 Then
                                        Do While frmNPCs.NPC(NPC(A).Special).Visible = False
                                            frmNPCs.optGame(B).Value = True
                                            B = B + 1
                                            If B > frmNPCs.optGame.Count - 1 Then Exit Do
                                        Loop
                                    End If
                                Else
                                    Do While frmNPCs.NPC(NPC(A).Type).Visible = False
                                        frmNPCs.optGame(B).Value = True
                                        B = B + 1
                                        If B > frmNPCs.optGame.Count - 1 Then Exit Do
                                    Loop
                                End If
                                frmNPCs.NPC(NPC(A).Type).Value = True
                                frmNPCs.NPCText = NPC(A).Text
                                If NPC(A).Inert = True Then
                                    frmNPCs.Friendly.Caption = "Yes"
                                Else
                                    frmNPCs.Friendly.Caption = "No"
                                End If
                                If NPC(A).Stuck = True Then
                                    frmNPCs.DontMove.Caption = "Yes"
                                Else
                                    frmNPCs.DontMove.Caption = "No"
                                End If
                                If NPC(A).Legacy = True Then
                                    frmNPCAdvanced.Legacy.Caption = "Yes"
                                    frmNPCAdvanced.Show
                                Else
                                    frmNPCAdvanced.Legacy.Caption = "No"
                                End If
                                
                                If NPC(A).Type = 288 Or NPC(A).Type = 289 Or (NPC(A).Type = 91 And NPC(A).Special = 288) Then
                                    frmNPCAdvanced.Show
                                    frmNPCAdvanced.WarpSection.ListIndex = NPC(A).Special2
                                    frmNPCAdvanced.WarpSection.Text = frmNPCAdvanced.WarpSection.List(frmNPCAdvanced.WarpSection.ListIndex)
                                End If
                                frmAdvanced.AttLayer = NPC(A).AttLayer
                                If frmAdvanced.AttLayer <> "" Then frmAdvanced.Show
                                frmAdvanced.TriggerActivate = NPC(A).TriggerActivate
                                frmAdvanced.TriggerDeath = NPC(A).TriggerDeath
                                frmAdvanced.TriggerTalk = NPC(A).TriggerTalk
                                frmAdvanced.TriggerLast = NPC(A).TriggerLast
                                If frmAdvanced.TriggerActivate <> "" Or frmAdvanced.TriggerDeath <> "" Or frmAdvanced.TriggerTalk <> "" Or frmAdvanced.TriggerLast <> "" Then
                                    frmAdvanced.Show
                                End If
                                If NPC(A).Generator = True Then
                                    frmGenerator.Show
                                    frmGenerator.Spawn.Caption = "Yes"
                                    frmGenerator.scrDelay.Value = NPC(A).GeneratorTimeMax
                                    frmGenerator.optEffect(NPC(A).GeneratorEffect).Value = True
                                    frmGenerator.optSpawnDirection(NPC(A).GeneratorDirection).Value = True
                                    frmGenerator.CheckSpawn
                                Else
                                    frmGenerator.Spawn.Caption = "No"
                                End If
                                If NPC(A).Type = 91 Then
                                    frmNPCs.Buried.Caption = "Yes"
                                    If NPC(A).Special > 0 Then frmNPCs.NPC(NPC(A).Special).Value = True
                                Else
                                    frmNPCs.Buried.Caption = "No"
                                End If
                                
                                If NPC(A).Type = 283 Then
                                    frmNPCs.Bubble.Caption = "Yes"
                                    If NPC(A).Special > 0 Then frmNPCs.NPC(NPC(A).Special).Value = True
                                Else
                                    frmNPCs.Bubble.Caption = "No"
                                End If
                                
                                If NPC(A).Type = 284 Then
                                    frmNPCs.Lakitu.Caption = "Yes"
                                    If NPC(A).Special > 0 Then frmNPCs.NPC(NPC(A).Special).Value = True
                                Else
                                    frmNPCs.Lakitu.Caption = "No"
                                End If
                                
                                If NPC(A).Type = 96 Then
                                    If NPC(A).Special <> 0 And NPC(A).Special <> 96 Then
                                        frmNPCs.Egg.Caption = "Yes"
                                        If NPC(A).Special > 0 Then frmNPCs.NPC(NPC(A).Special).Value = True
                                    End If
                                Else
                                    frmNPCs.Egg.Caption = "No"
                                End If
                                If NPCIsAParaTroopa(NPC(A).Type) = True Then
                                    frmNPCAdvanced.cmbPara.ListIndex = NPC(A).Special
                                    frmNPCAdvanced.Show
                                End If
                                If NPCIsCheep(NPC(A).Type) = True Then
                                    frmNPCAdvanced.cmbCheep.ListIndex = NPC(A).Special
                                    frmNPCAdvanced.Show
                                End If
                                If NPC(A).Type = 260 Then
                                    frmNPCAdvanced.scrFire.Value = NPC(A).Special
                                    frmNPCAdvanced.Show
                                End If
                                For B = 0 To frmLayers.lstLayer.ListCount - 1
                                    If LCase(NPC(A).Layer) = LCase(frmLayers.lstLayer.List(B)) Then
                                        frmLayers.lstLayer.ListIndex = B
                                        Exit For
                                    End If
                                Next B
                                frmNPCs.optNPCDirection(NPC(A).Direction + 1).Value = True
                                EditorCursor.Mode = 4
                                EditorCursor.Location.X = NPC(A).Location.X
                                EditorCursor.Location.Y = NPC(A).Location.Y
                                SetCursor
                                Netplay.sendData Netplay.EraseNPC(A, 1) & "p23" & LB
                                KillNPC A, 9
                                MouseRelease = False
                                tempBool = True
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numBlock
                            If BlockIsSizable(Block(A).Type) = False Then
                                If CursorCollision(.Location, Block(A).Location) = True And Block(A).Hidden = False Then
                                    PlaySound 23
                                    frmLevelEditor.optCursor(1).Value = True
                                    B = 0
                                    Do While frmBlocks.Block(Block(A).Type).Visible = False
                                        If B > frmBlocks.optGame.Count - 1 Then Exit Do
                                        frmBlocks.optGame(B).Value = True
                                        If B = 0 Then
                                            For C = 0 To frmBlocks.SMB3.Count - 1
                                                frmBlocks.optSMB3(C).Value = True
                                                If frmBlocks.Block(Block(A).Type).Visible = True Then Exit For
                                            Next C
                                        End If
                                        If B = 1 Then
                                            For C = 0 To frmBlocks.SMB2.Count - 1
                                                frmBlocks.optSMB2(C).Value = True
                                                If frmBlocks.Block(Block(A).Type).Visible = True Then Exit For
                                            Next C
                                        End If
                                        If B = 2 Then
                                            For C = 0 To frmBlocks.SMB1.Count - 1
                                                frmBlocks.optSMB1(C).Value = True
                                                If frmBlocks.Block(Block(A).Type).Visible = True Then Exit For
                                            Next C
                                        End If
                                        If B = 3 Then
                                            For C = 0 To frmBlocks.SMW.Count - 1
                                                frmBlocks.optSMW(C).Value = True
                                                If frmBlocks.Block(Block(A).Type).Visible = True Then Exit For
                                            Next C
                                        End If
                                        If B = 4 Then
                                            For C = 0 To frmBlocks.Misc.Count - 1
                                                frmBlocks.optMisc(C).Value = True
                                                If frmBlocks.Block(Block(A).Type).Visible = True Then Exit For
                                            Next C
                                        End If
                                        B = B + 1
                                    Loop
                                    frmBlocks.Block(Block(A).Type).Value = True
                                    frmAdvancedBlock.TriggerHit.Text = Block(A).TriggerHit
                                    frmAdvancedBlock.TriggerDeath.Text = Block(A).TriggerDeath
                                    frmAdvancedBlock.TriggerLast = Block(A).TriggerLast
                                    If Block(A).Special >= 1 And Block(A).Special <= 99 Then
                                        frmBlocks.optBlockS.Value = -Block(A).Special
                                    ElseIf Block(A).Special > 1000 Then
                                        frmBlocks.optBlockS.Value = Block(A).Special - 1000
                                    End If
                                    If Block(A).Invis = True Then
                                        frmBlocks.cmdInvis.Caption = "Yes"
                                    Else
                                        frmBlocks.cmdInvis.Caption = "No"
                                    End If
                                    If Block(A).Slippy = True Then
                                        frmBlocks.cmdSlip.Caption = "Yes"
                                    Else
                                        frmBlocks.cmdSlip.Caption = "No"
                                    End If
                                    For B = 0 To frmLayers.lstLayer.ListCount - 1
                                        If LCase(Block(A).Layer) = LCase(frmLayers.lstLayer.List(B)) Then
                                            frmLayers.lstLayer.ListIndex = B
                                            Exit For
                                        End If
                                    Next B
                                    EditorCursor.Mode = 1
                                    EditorCursor.Location.X = Block(A).Location.X
                                    EditorCursor.Location.Y = Block(A).Location.Y
                                    SetCursor
                                    Netplay.sendData Netplay.EraseBlock(A, 1)
                                    KillBlock A, False
                                    MouseRelease = False
                                    FindSBlocks
                                    Exit For
                                End If
                            End If
                        Next A
                    End If
                    If MouseRelease = True And MagicHand = False Then
                        For A = 1 To numWarps
                            If CursorCollision(.Location, Warp(A).Entrance) And Warp(A).Hidden = False Then
                                PlaySound 23
                                Warp(A).PlacedEnt = False
                                If Warp(A).NoYoshi = True Then
                                    frmWarp.cmdYoshi.Caption = "Yes"
                                Else
                                    frmWarp.cmdYoshi.Caption = "No"
                                End If
                                If Warp(A).WarpNPC = True Then
                                    frmWarp.cmdNPC.Caption = "Yes"
                                Else
                                    frmWarp.cmdNPC.Caption = "No"
                                End If
                                If Warp(A).Locked = True Then
                                    frmWarp.cmdLocked.Caption = "Yes"
                                Else
                                    frmWarp.cmdLocked.Caption = "No"
                                End If
                                frmLevelEditor.optCursor(5).Value = True
                                If Warp(A).MapWarp = True Then
                                    frmWarp.chkMapWarp.Value = 1
                                Else
                                    frmWarp.chkMapWarp.Value = 0
                                End If
                                frmWarp.optE(1).Value = True
                                frmWarp.optDirection(Warp(A).Direction).Value = True
                                frmWarp.optDirection2(Warp(A).Direction2).Value = True
                                frmWarp.optEffect(Warp(A).Effect).Value = True
                                frmWarp.txtLevel = Warp(A).level
                                frmWarp.scrWarp.Value = Warp(A).LevelWarp
                                frmWarp.chkEntrance.Value = Val(Warp(A).LevelEnt)
                                frmWarp.txtStars = Warp(A).Stars
                                If frmWarp.txtStars = 0 Then frmWarp.txtStars = ""
                                frmWarp.txtX = Warp(A).MapX
                                frmWarp.txtY = Warp(A).MapY
                                If frmWarp.txtX = -1 Then frmWarp.txtX = ""
                                If frmWarp.txtY = -1 Then frmWarp.txtY = ""
                                MouseRelease = False
                                If Warp(A).LevelEnt = True Then
                                    frmWarp.chkEntrance = 1
                                    Warp(A).PlacedExit = False
                                End If
                                If nPlay.Online = True Then Netplay.sendData Netplay.AddWarp(A)
                                Exit For
                            ElseIf CursorCollision(.Location, Warp(A).Exit) Then
                                PlaySound 23
                                Warp(A).PlacedExit = False
                                If Warp(A).NoYoshi = True Then
                                    frmWarp.cmdYoshi.Caption = "Yes"
                                Else
                                    frmWarp.cmdYoshi.Caption = "No"
                                End If
                                If Warp(A).WarpNPC = True Then
                                    frmWarp.cmdNPC.Caption = "Yes"
                                Else
                                    frmWarp.cmdNPC.Caption = "No"
                                End If
                                If Warp(A).Locked = True Then
                                    frmWarp.cmdLocked.Caption = "Yes"
                                Else
                                    frmWarp.cmdLocked.Caption = "No"
                                End If
                                frmLevelEditor.optCursor(5).Value = True
                                If Warp(A).MapWarp = True Then
                                    frmWarp.chkMapWarp.Value = 1
                                Else
                                    frmWarp.chkMapWarp.Value = 0
                                End If
                                frmWarp.optE(2).Value = True
                                frmWarp.optDirection(Warp(A).Direction).Value = True
                                frmWarp.optDirection2(Warp(A).Direction2).Value = True
                                frmWarp.optEffect(Warp(A).Effect).Value = True
                                frmWarp.txtLevel = Warp(A).level
                                frmWarp.scrWarp.Value = Warp(A).LevelWarp
                                frmWarp.chkEntrance.Value = Warp(A).LevelEnt
                                frmWarp.txtStars = Warp(A).Stars
                                If frmWarp.txtStars = 0 Then frmWarp.txtStars = ""
                                frmWarp.txtX = Warp(A).MapX
                                frmWarp.txtY = Warp(A).MapY
                                If frmWarp.txtX = -1 Then frmWarp.txtX = ""
                                If frmWarp.txtY = -1 Then frmWarp.txtY = ""
                                MouseRelease = False
                                If Warp(A).LevelEnt = True Then
                                    frmWarp.chkEntrance = 1
                                    Warp(A).PlacedEnt = False
                                End If
                                If nPlay.Online = True Then Netplay.sendData Netplay.AddWarp(A)
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = numBackground To 1 Step -1
                            If CursorCollision(.Location, Background(A).Location) = True And Background(A).Hidden = False Then
                                PlaySound 23
                                frmLevelEditor.optCursor(3).Value = True
                                B = 0
                                Do While frmBackgrounds.Background(Background(A).Type).Visible = False
                                    frmBackgrounds.optGame(B).Value = True
                                    B = B + 1
                                Loop
                                For B = 0 To frmLayers.lstLayer.ListCount - 1
                                    If LCase(Background(A).Layer) = LCase(frmLayers.lstLayer.List(B)) Then
                                        frmLayers.lstLayer.ListIndex = B
                                        Exit For
                                    End If
                                Next B
                                frmBackgrounds.Background(Background(A).Type).Value = True
                                EditorCursor.Location.X = Background(A).Location.X
                                EditorCursor.Location.Y = Background(A).Location.Y
                                SetCursor
                                Netplay.sendData Netplay.EraseBackground(A, 1) & "p23" & LB
                                Background(A) = Background(numBackground)
                                numBackground = numBackground - 1
                                If MagicHand = True Then UpdateBackgrounds
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numBlock
                            If BlockIsSizable(Block(A).Type) = True Then
                                If CursorCollision(.Location, Block(A).Location) = True And Block(A).Hidden = False Then
                                    PlaySound 23
                                    frmLevelEditor.optCursor(1).Value = True
                                    B = 0
                                    Do While frmBlocks.Block(Block(A).Type).Visible = False
                                        If B > frmBlocks.optGame.Count - 1 Then Exit Do
                                        frmBlocks.optGame(B).Value = True
                                        If B = 0 Then
                                            For C = 0 To frmBlocks.SMB3.Count - 1
                                                frmBlocks.optSMB3(C).Value = True
                                                If frmBlocks.Block(Block(A).Type).Visible = True Then Exit For
                                            Next C
                                        End If
                                        If B = 1 Then
                                            For C = 0 To frmBlocks.SMB2.Count - 1
                                                frmBlocks.optSMB2(C).Value = True
                                                If frmBlocks.Block(Block(A).Type).Visible = True Then Exit For
                                            Next C
                                        End If
                                        If B = 2 Then
                                            For C = 0 To frmBlocks.SMB1.Count - 1
                                                frmBlocks.optSMB1(C).Value = True
                                                If frmBlocks.Block(Block(A).Type).Visible = True Then Exit For
                                            Next C
                                        End If
                                        If B = 3 Then
                                            For C = 0 To frmBlocks.SMW.Count - 1
                                                frmBlocks.optSMW(C).Value = True
                                                If frmBlocks.Block(Block(A).Type).Visible = True Then Exit For
                                            Next C
                                        End If
                                        If B = 4 Then
                                            For C = 0 To frmBlocks.Misc.Count - 1
                                                frmBlocks.optMisc(C).Value = True
                                                If frmBlocks.Block(Block(A).Type).Visible = True Then Exit For
                                            Next C
                                        End If
                                        B = B + 1
                                    Loop
                                    frmBlocks.Block(Block(A).Type).Value = True
                                    If Block(A).Special >= 1 And Block(A).Special <= 99 Then
                                        frmBlocks.optBlockS.Value = -Block(A).Special
                                    ElseIf Block(A).Special > 1000 Then
                                        frmBlocks.optBlockS.Value = Block(A).Special - 1000
                                    End If
                                    If Block(A).Invis = True Then
                                        frmBlocks.cmdInvis.Caption = "Yes"
                                    Else
                                        frmBlocks.cmdInvis.Caption = "No"
                                    End If
                                    If Block(A).Slippy = True Then
                                        frmBlocks.cmdSlip.Caption = "Yes"
                                    Else
                                        frmBlocks.cmdSlip.Caption = "No"
                                    End If
                                    For B = 0 To frmLayers.lstLayer.ListCount - 1
                                        If LCase(Block(A).Layer) = LCase(frmLayers.lstLayer.List(B)) Then
                                            frmLayers.lstLayer.ListIndex = B
                                            Exit For
                                        End If
                                    Next B
                                    frmAdvancedBlock.TriggerHit = Block(A).TriggerHit
                                    frmAdvancedBlock.TriggerDeath = Block(A).TriggerDeath
                                    frmAdvancedBlock.TriggerLast = Block(A).TriggerLast
                                    frmBlocks.BlockW.Value = Block(A).Location.Width / 32
                                    frmBlocks.BlockH.Value = Block(A).Location.Height / 32
                                    EditorCursor.Mode = 1
                                    EditorCursor.Location.X = Block(A).Location.X
                                    EditorCursor.Location.Y = Block(A).Location.Y
                                    SetCursor
                                    Netplay.sendData Netplay.EraseBlock(A, 1)
                                    KillBlock A, False
                                    MouseRelease = False
                                    FindSBlocks
                                    Exit For
                                End If
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numWater
                            If CursorCollision(.Location, Water(A).Location) = True Then
                                PlaySound 23
                                frmLevelEditor.optCursor(15).Value = True
                                frmWater.WaterW = Water(A).Location.Width / 32
                                frmWater.WaterH = Water(A).Location.Height / 32
                                If .Water.Quicksand = True Then
                                    frmWater.Quicksand.Caption = "Yes"
                                Else
                                    frmWater.Quicksand.Caption = "No"
                                End If
                                If nPlay.Online = True Then Netplay.sendData "y" & A & LB & "p23" & LB
                                Water(A) = Water(numWater)
                                numWater = numWater - 1
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numWorldMusic
                            If CursorCollision(.Location, WorldMusic(A).Location) = True Then
                                PlaySound 23
                                frmLevelEditor.optCursor(11).Value = True
                                .Mode = 11
                                .Location = WorldMusic(A).Location
                                SetCursor
                                frmMusic.optMusic(WorldMusic(A).Type).Value = True
                                WorldMusic(A) = WorldMusic(numWorldMusic)
                                numWorldMusic = numWorldMusic - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numWorldPaths
                            If CursorCollision(.Location, WorldPath(A).Location) = True Then
                                PlaySound 23
                                frmLevelEditor.optCursor(10).Value = True
                                frmPaths.WorldPath(WorldPath(A).Type).Value = True
                                .Mode = 10
                                .Location = WorldPath(A).Location
                                SetCursor
                                WorldPath(A) = WorldPath(numWorldPaths)
                                numWorldPaths = numWorldPaths - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = numScenes To 1 Step -1
                            If CursorCollision(.Location, Scene(A).Location) = True Then
                                PlaySound 23
                                frmLevelEditor.optCursor(8).Value = True
                                frmScene.Scene(Scene(A).Type).Value = True
                                .Mode = 8
                                .Location = Scene(A).Location
                                SetCursor
                                MouseMove .X, .Y
                                For B = A To numScenes - 1
                                    Scene(B) = Scene(B + 1)
                                Next B
                                numScenes = numScenes - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numWorldLevels
                            If CursorCollision(.Location, WorldLevel(A).Location) = True Then
                                PlaySound 23
                                frmLevelEditor.optCursor(9).Value = True
                                frmLevels.WorldLevel(WorldLevel(A).Type).Value = True
                                With WorldLevel(A)
                                    frmLevels.txtLevelName = .LevelName
                                    frmLevels.txtFilename = .FileName
                                    frmLevels.scrWarp.Value = .StartWarp
                                    If .WarpX = -1 Then
                                        frmLevels.txtX = ""
                                    Else
                                        frmLevels.txtX = .WarpX
                                    End If
                                    If .WarpY = -1 Then
                                        frmLevels.txtY = ""
                                    Else
                                        frmLevels.txtY = .WarpY
                                    End If
                                    If .Path = True Then
                                        frmLevels.chkPath.Value = 1
                                    Else
                                        frmLevels.chkPath.Value = 0
                                    End If
                                    If .Path2 = True Then
                                        frmLevels.chkPath2.Value = 1
                                    Else
                                        frmLevels.chkPath2.Value = 0
                                    End If
                                    If .Start = True Then
                                        frmLevels.chkStart.Value = 1
                                    Else
                                        frmLevels.chkStart.Value = 0
                                    End If
                                    If .Visible = True Then
                                        frmLevels.chkVisible.Value = 1
                                    Else
                                        frmLevels.chkVisible.Value = 0
                                    End If
                                    For B = 1 To 4
                                        frmLevels.cmbExit(B).ListIndex = .LevelExit(B) + 1
                                    Next B
                                End With
                                .Mode = 9
                                .Location = WorldLevel(A).Location
                                SetCursor
                                WorldLevel(A) = WorldLevel(numWorldLevels)
                                numWorldLevels = numWorldLevels - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numTiles
                            If CursorCollision(.Location, Tile(A).Location) = True Then
                                PlaySound 23
                                frmLevelEditor.optCursor(7).Value = True
                                frmTiles.Tile(Tile(A).Type).Value = True
                                If frmTiles.Tile(Tile(A).Type).Visible = False Then
                                    For B = 0 To frmTiles.Game.Count - 1
                                        frmTiles.optGame(B).Value = True
                                        If frmTiles.Tile(Tile(A).Type).Visible = True Then Exit For
                                    Next B
                                End If
                                .Mode = 7
                                .Location = Tile(A).Location
                                SetCursor
                                Tile(A) = Tile(numTiles)
                                numTiles = numTiles - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                ElseIf .Mode = 15 Then ' Water
                    If MouseRelease = True Then
                        MouseRelease = False
                        CanPlace = True
                        For A = 1 To numWater
                            If Water(A).Location.X = .Location.X And Water(A).Location.Y = .Location.Y And Water(A).Location.Height = .Location.Height And Water(A).Location.Width = .Location.Width Then
                                CanPlace = False
                                Exit For
                            End If
                        Next A
                        If CanPlace = True Then
                            numWater = numWater + 1
                            Water(numWater) = .Water
                            If nPlay.Online = True Then Netplay.sendData Netplay.AddWater(numWater)
                        End If
                    End If
                ElseIf .Mode = 0 Or .Mode = 6 Then   'Eraser
                    If MouseRelease = True Then
                        For A = 1 To numNPCs
                            tempLocation = NPC(A).Location
                            If NPC(A).Type = 91 Then tempLocation.Y = tempLocation.Y - 16
                            If CursorCollision(.Location, tempLocation) = True And NPC(A).Hidden = False Then
                                If Int(Rnd * 2) = 0 Then
                                    NPC(A).Location.SpeedX = Physics.NPCShellSpeed / 2
                                Else
                                    NPC(A).Location.SpeedX = -(Physics.NPCShellSpeed / 2)
                                End If
                                Netplay.sendData Netplay.EraseNPC(A, 0)
                                If NPCIsABonus(NPC(A).Type) Or NPCIsACoin(NPC(A).Type) Then
                                    KillNPC A, 4 'Kill the bonus/coin
                                Else
                                    KillNPC A, 2 'Kill the NPC
                                End If
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numBlock
                            If BlockIsSizable(Block(A).Type) = False Then
                                If CursorCollision(.Location, Block(A).Location) = True And Block(A).Hidden = False Then
                                    Netplay.sendData Netplay.EraseBlock(A)
                                    KillBlock A 'Erase the block
                                    FindSBlocks
                                    MouseRelease = False
                                    Exit For
                                End If
                            End If
                        Next A
                    End If
                    If MouseRelease = True And MagicHand = False Then
                        For A = 1 To numWarps
                            tempLocation = Warp(A).Entrance
                            tempLocation.Height = 32
                            tempLocation.Width = 32
                            If CursorCollision(.Location, tempLocation) Then
                                KillWarp A
                                If nPlay.Online = True Then Netplay.sendData "B" & A & LB
                                MouseRelease = False
                                Exit For
                            End If
                            tempLocation = Warp(A).Exit
                            tempLocation.Height = 32
                            tempLocation.Width = 32
                            If CursorCollision(.Location, tempLocation) Then
                                KillWarp A
                                If nPlay.Online = True Then Netplay.sendData "B" & A & LB
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = numBackground To 1 Step -1
                            If CursorCollision(.Location, Background(A).Location) = True And Background(A).Hidden = False Then
                                Netplay.sendData Netplay.EraseBackground(A, 0)
                                With Background(A)
                                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                                    NewEffect 10, .Location
                                    PlaySound 36
                                End With
                                Background(A) = Background(numBackground)
                                numBackground = numBackground - 1
                                MouseRelease = False
                                If MagicHand = True Then UpdateBackgrounds
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = numBlock To 1 Step -1
                            If BlockIsSizable(Block(A).Type) = True Then
                                If CursorCollision(.Location, Block(A).Location) = True And Block(A).Hidden = False Then
                                    Netplay.sendData Netplay.EraseBlock(A)
                                    KillBlock A 'Erase the block
                                    FindSBlocks
                                    MouseRelease = False
                                    Exit For
                                End If
                            End If
                        Next A
                    End If
                    If MouseRelease = True And LevelEditor = True Then
                        For A = 1 To numWater
                            tempLocation = Water(A).Location
                            If CursorCollision(.Location, tempLocation) = True And Water(A).Hidden = False Then
                                PlaySound 36
                                If nPlay.Online = True Then Netplay.sendData "y" & A & LB & "p36" & LB
                                Water(A) = Water(numWater)
                                numWater = numWater - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numWorldMusic
                            If CursorCollision(.Location, WorldMusic(A).Location) = True Then
                                tempLocation = WorldMusic(A).Location
                                tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                                tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                                NewEffect 10, tempLocation
                                PlaySound 9
                                WorldMusic(A) = WorldMusic(numWorldMusic)
                                numWorldMusic = numWorldMusic - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numWorldPaths
                            If CursorCollision(.Location, WorldPath(A).Location) = True Then
                                tempLocation = WorldPath(A).Location
                                tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                                tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                                NewEffect 10, tempLocation
                                PlaySound 9
                                WorldPath(A) = WorldPath(numWorldPaths)
                                numWorldPaths = numWorldPaths - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = numScenes To 1 Step -1
                            If CursorCollision(.Location, Scene(A).Location) = True Then
                                tempLocation = Scene(A).Location
                                tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                                tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                                NewEffect 10, tempLocation
                                PlaySound 9
                                For B = A To numScenes - 1
                                    Scene(B) = Scene(B + 1)
                                Next B
                                numScenes = numScenes - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numWorldLevels
                            If CursorCollision(.Location, WorldLevel(A).Location) = True Then
                                tempLocation = WorldLevel(A).Location
                                tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                                tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                                NewEffect 10, tempLocation
                                PlaySound 9
                                WorldLevel(A) = WorldLevel(numWorldLevels)
                                numWorldLevels = numWorldLevels - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                    If MouseRelease = True Then
                        For A = 1 To numTiles
                            If CursorCollision(.Location, Tile(A).Location) = True Then
                                tempLocation = Tile(A).Location
                                tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                                tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                                NewEffect 10, tempLocation
                                PlaySound 9
                                Tile(A) = Tile(numTiles)
                                numTiles = numTiles - 1
                                MouseRelease = False
                                Exit For
                            End If
                        Next A
                    End If
                ElseIf .Mode = 1 Then 'Blocks
                    For A = 1 To numBlock
                        If Not BlockIsSizable(Block(A).Type) And Not BlockIsSizable(.Block.Type) Then
                            If CursorCollision(.Location, Block(A).Location) = True And Block(A).Hidden = False Then
                                CanPlace = False
                            End If
                        Else
                            If Block(A).Type = .Block.Type Then
                                If .Location.X = Block(A).Location.X And .Location.Y = Block(A).Location.Y Then CanPlace = False
                            End If
                        End If
                    Next A
                    If Not BlockIsSizable(.Block.Type) And Not .Block.Type = 370 Then
                        For A = 1 To numNPCs
                            If NPC(A).Type <> 91 And NPC(A).Type <> 259 And NPC(A).Type <> 260 Then
                                If CursorCollision(.Location, NPC(A).Location) = True And NPC(A).Hidden = False And NPC(A).Active = True Then
                                    CanPlace = False
                                End If
                            End If
                        Next A
                        For A = 1 To 2
                            If CursorCollision(.Location, PlayerStart(A)) = True And MagicHand = False Then CanPlace = False
                        Next A
                    End If
                    If CanPlace = True Then 'Nothing is in the way
                        If frmBlocks.chkFill.Value = 1 Then
                            BlockFill EditorCursor.Block.Location
                            If MagicHand = True Then
                                For A = -FLBlocks To FLBlocks
                                    FirstBlock(A) = 1
                                    LastBlock(A) = numBlock
                                Next A
                                BlocksSorted = False
                            End If
                            FindSBlocks
                        Else
                            If numBlock < maxBlocks Then 'Not out of blocks
                                numBlock = numBlock + 1
                                Block(numBlock) = EditorCursor.Block
                                Block(numBlock).DefaultType = Block(numBlock).Type
                                Block(numBlock).DefaultSpecial = Block(numBlock).Special
                                If MagicHand = True Then
                                    For A = -FLBlocks To FLBlocks
                                        FirstBlock(A) = 1
                                        LastBlock(A) = numBlock
                                    Next A
                                    BlocksSorted = False
                                End If
                            End If
                            FindSBlocks
                            If nPlay.Online = True Then
                                Netplay.sendData Netplay.AddBlock(numBlock)
                            End If
                        End If
                        
                    End If
                ElseIf .Mode = 2 And MagicHand = False Then 'Level
                    If frmLevelSettings.optLevel(0).Value = True Then 'Top
                        level(curSection).Y = Int(.Location.Y / 32) * 32
                        If level(curSection).Height - level(curSection).Y < 600 Then level(curSection).Y = level(curSection).Height - 600
                    ElseIf frmLevelSettings.optLevel(1).Value = True Then 'Left
                        level(curSection).X = Int(.Location.X / 32) * 32
                        If level(curSection).Width - level(curSection).X < 800 Then level(curSection).X = level(curSection).Width - 800
                    ElseIf frmLevelSettings.optLevel(2).Value = True Then 'Right
                        level(curSection).Width = Int(.Location.X / 32) * 32
                        If level(curSection).Width - level(curSection).X < 800 Then level(curSection).Width = level(curSection).X + 800
                    ElseIf frmLevelSettings.optLevel(3).Value = True Then 'Bottom
                        level(curSection).Height = Int(.Location.Y / 32) * 32
                        If level(curSection).Height - level(curSection).Y < 600 Then level(curSection).Height = level(curSection).Y + 600
                    ElseIf frmLevelSettings.optLevel(4).Value = True Or frmLevelSettings.optLevel(5).Value = True Then
                        If frmLevelSettings.optLevel(4).Value = True Then
                            B = 1
                        Else
                            B = 2
                        End If
                        For A = 1 To 2
                            If CursorCollision(.Location, PlayerStart(A)) = True And A <> B Then CanPlace = False
                        Next A
                        For A = 1 To numBlock
                            If CursorCollision(.Location, Block(A).Location) = True And Block(A).Hidden = False And Block(A).Invis = False And BlockIsSizable(Block(A).Type) = False And BlockNoClipping(Block(A).Type) = False And BlockOnlyHitspot1(Block(A).Type) = False And BlockSlope(Block(A).Type) = 0 And BlockSlope2(Block(A).Type) = 0 Then CanPlace = False
                        Next A
                        If CanPlace = True Then
                            If frmLevelSettings.optLevel(4).Value = True Then
                                PlayerStart(1) = .Location
                                Netplay.sendData "v" & 1 & "|" & PlayerStart(1).X & "|" & PlayerStart(1).Y & "|" & PlayerStart(1).Width & "|" & PlayerStart(1).Height & LB
                            Else
                                PlayerStart(2) = .Location
                                Netplay.sendData "v" & 2 & "|" & PlayerStart(2).X & "|" & PlayerStart(2).Y & "|" & PlayerStart(2).Width & "|" & PlayerStart(2).Height & LB
                            End If
                        End If
                    End If
                    If frmLevelSettings.optLevel(0).Value = True Or frmLevelSettings.optLevel(1).Value = True Or frmLevelSettings.optLevel(2).Value = True Or frmLevelSettings.optLevel(3).Value = True Then
                        Netplay.sendData "g" & curSection & "|" & level(curSection).X & "|" & level(curSection).Y & "|" & level(curSection).Width & "|" & level(curSection).Height
                    End If
                ElseIf .Mode = 3 Then 'Backgrounds
                    For A = 1 To numBackground
                        If .Background.Type = Background(A).Type Then
                            If CursorCollision(.Location, Background(A).Location) = True And Background(A).Hidden = False Then CanPlace = False
                        End If
                    Next A
                    If CanPlace = True Then 'Nothing is in the way
                        If numBackground < maxBackgrounds Then 'Not out of backgrounds
                            numBackground = numBackground + 1
                            Background(numBackground) = EditorCursor.Background
                            If MagicHand = True Then UpdateBackgrounds
                            Netplay.sendData Netplay.AddBackground(numBackground)
                        End If
                    End If
                ElseIf .Mode = 4 Then 'NPCs
                    If .NPC.Type <> 91 And .NPC.Type <> 259 And .NPC.Type <> 260 Then
                        For A = 1 To numBlock
                            If Not BlockIsSizable(Block(A).Type) Then
                                If CursorCollision(.Location, Block(A).Location) = True And Block(A).Hidden = False And BlockSlope(Block(A).Type) = 0 And BlockSlope2(Block(A).Type) = 0 Then CanPlace = False
                            End If
                        Next A
                    End If
                    For A = 1 To numNPCs
                        If CursorCollision(.Location, NPC(A).Location) = True And NPC(A).Hidden = False And NPC(A).Active = True And (NPC(A).Type <> 159 Or .NPC.Type = 159) Then
                            If NPC(A).Generator = False Or NPC(A).Type = .NPC.Type Then
                                If (Not .NPC.Type = 208 And Not NPC(A).Type = 208) Or (.NPC.Type = 208 And NPC(A).Type = 208) Then
                                    If NPCIsAVine(NPC(A).Type) = False Then
                                        CanPlace = False
                                    End If
                                End If
                            End If
                        End If
                    Next A
                    For A = 1 To 2
                        If CursorCollision(.Location, PlayerStart(A)) = True And MagicHand = False Then CanPlace = False
                    Next A
                    If MouseRelease = False Then CanPlace = False
                    If CanPlace = True Then 'Nothing is in the way
                        If numNPCs < maxNPCs - 20 Then 'Not out of npcs
                            MouseRelease = False
                            numNPCs = numNPCs + 1
                            If frmNPCs.Bubble.Caption = "Yes" And frmNPCs.optNPCDirection(1).Value = True Then
                                EditorCursor.NPC.Direction = 0
                                EditorCursor.NPC.DefaultDirection = 0
                            End If
                            NPC(numNPCs) = EditorCursor.NPC
                            Netplay.sendData Netplay.AddNPC(numNPCs)
                            If MagicHand = False Then NPCSort
                            If MagicHand = True Then

                                
                                With NPC(numNPCs)
                                    .FrameCount = 0
                                    .Active = True
                                    .TimeLeft = 10
                                    .DefaultDirection = .Direction
                                    .DefaultLocation = .Location
                                    .DefaultSpecial = .Special
                                End With
                                CheckSectionNPC numNPCs
                            End If
                        End If
                    End If
                ElseIf .Mode = 5 Then 'Warps
                    For A = 1 To numWarps + 1
                        If Warp(A).PlacedEnt = False Or Warp(A).PlacedExit = False Then
                            Exit For
                        End If
                    Next A
                    If A > numWarps Then numWarps = A
                    Warp(A).Layer = .Layer
                    Warp(A).Effect = EditorCursor.Warp.Effect
                    Warp(A).Direction2 = EditorCursor.Warp.Direction2
                    Warp(A).Direction = EditorCursor.Warp.Direction
                    Warp(A).level = EditorCursor.Warp.level
                    Warp(A).LevelEnt = EditorCursor.Warp.LevelEnt
                    Warp(A).LevelWarp = EditorCursor.Warp.LevelWarp
                    Warp(A).Stars = EditorCursor.Warp.Stars
                    Warp(A).NoYoshi = EditorCursor.Warp.NoYoshi
                    Warp(A).WarpNPC = EditorCursor.Warp.WarpNPC
                    Warp(A).Locked = EditorCursor.Warp.Locked
                    If frmWarp.chkMapWarp.Value = 0 Then
                        Warp(A).MapWarp = False
                    Else
                        Warp(A).MapWarp = True
                    End If
                    Warp(A).MapX = Val(frmWarp.txtX.Text)
                    Warp(A).MapY = Val(frmWarp.txtY.Text)
                    If frmWarp.txtX.Text = "" And frmWarp.txtY.Text = "" Then
                        Warp(A).MapX = -1
                        Warp(A).MapY = -1
                    End If
                    If frmWarp.optE(1).Value = True Or Warp(A).level <> "" Or Warp(A).LevelEnt = True Or Warp(A).MapWarp = True Then
                        EditorCursor.Warp.Entrance = EditorCursor.Location
                        Warp(A).Entrance = EditorCursor.Warp.Entrance
                        EditorControls.Mouse1 = False
                        Warp(A).PlacedEnt = True
                    End If
                    If frmWarp.optE(2).Value = True Or Warp(A).level <> "" Or Warp(A).LevelEnt = True Or Warp(A).MapWarp = True Then
                        EditorCursor.Warp.Exit = EditorCursor.Location
                        Warp(A).Exit = EditorCursor.Warp.Exit
                        EditorControls.Mouse1 = False
                        Warp(A).PlacedExit = True
                    End If
                    If nPlay.Online = True Then Netplay.sendData Netplay.AddWarp(A)
                ElseIf .Mode = 7 Then 'Tiles
                    For A = 1 To numTiles
                        If CursorCollision(.Location, Tile(A).Location) = True Then CanPlace = False
                    Next A
                    If CanPlace = True Then 'Nothing is in the way
                        If numTiles < maxTiles Then 'Not out of blocks
                            numTiles = numTiles + 1
                            Tile(numTiles) = EditorCursor.Tile
                        End If
                    End If
                ElseIf .Mode = 8 Then 'Scenery
                    For A = 1 To numScenes
                        If CursorCollision(.Location, Scene(A).Location) = True Then
                            If .Scene.Type = Scene(A).Type Then
                                If .Scene.Location.X = Scene(A).Location.X And .Scene.Location.Y = Scene(A).Location.Y Then CanPlace = False
                            End If
                        End If
                    Next A
                    For A = 1 To numWorldLevels
                        If CursorCollision(.Location, WorldLevel(A).Location) = True Then CanPlace = False
                    Next A
                    If CanPlace = True Then
                        If numScenes < maxScenes Then
                            numScenes = numScenes + 1
                            Scene(numScenes) = EditorCursor.Scene
                        End If
                    End If
                ElseIf .Mode = 9 Then 'Level
                    For A = 1 To numWorldPaths
                        If CursorCollision(.Location, WorldPath(A).Location) = True Then CanPlace = False
                    Next A
                    For A = 1 To numScenes
                        If CursorCollision(.Location, Scene(A).Location) = True Then CanPlace = False
                    Next A
                    For A = 1 To numWorldLevels
                        If CursorCollision(.Location, WorldLevel(A).Location) = True Then
                            CanPlace = False
                            qLevel = A
                        End If
                    Next A
                    If CanPlace = True Then
                        If numWorldLevels < maxWorldLevels Then
                            numWorldLevels = numWorldLevels + 1
                            WorldLevel(numWorldLevels) = EditorCursor.WorldLevel
                        End If
                    End If
                ElseIf .Mode = 10 Then 'Paths
                    For A = 1 To numWorldPaths
                        If CursorCollision(.Location, WorldPath(A).Location) = True Then CanPlace = False
                    Next A
                    For A = 1 To numWorldLevels
                        If CursorCollision(.Location, WorldLevel(A).Location) = True Then CanPlace = False
                    Next A
                    If CanPlace = True Then
                        If numWorldPaths < maxWorldPaths Then
                            numWorldPaths = numWorldPaths + 1
                            WorldPath(numWorldPaths) = EditorCursor.WorldPath
                        End If
                    End If
                ElseIf .Mode = 11 Then 'Music
                    For A = 1 To numWorldMusic
                        If CursorCollision(.Location, WorldMusic(A).Location) = True Then CanPlace = False
                    Next A
                    If CanPlace = True Then
                        .WorldMusic.Location = .Location
                        numWorldMusic = numWorldMusic + 1
                        WorldMusic(numWorldMusic) = .WorldMusic
                    End If
                End If
            End If
        End With
        If MagicHand = False Then
            For A = 1 To numNPCs
                With NPC(A)
                    '.Frame = EditorNPCFrame(.Type, .Direction)
                    NPCFrames A
                End With
            Next A
        End If
    End If
End Sub

Public Sub GetEditorControls()
    If HasCursor = True Then
        With EditorControls
            If GetKeyState(vbKeyUp) And KEY_PRESSED Then
                .Up = True
            Else
                .Up = False
            End If
            If GetKeyState(vbKeyDown) And KEY_PRESSED Then
                .Down = True
            Else
                .Down = False
            End If
            If GetKeyState(vbKeyLeft) And KEY_PRESSED Then
                .Left = True
            Else
                .Left = False
            End If
            If GetKeyState(vbKeyRight) And KEY_PRESSED Then
                .Right = True
            Else
                .Right = False
            End If
        End With
    End If
End Sub

Public Sub SetCursor()
    Dim A As Integer
    For A = 0 To frmLevelEditor.optCursor.Count - 1
        If frmLevelEditor.optCursor(A).Value = True Then
            EditorCursor.Mode = A
            Exit For
        End If
    Next A
    With EditorCursor
        If .Mode = 6 And WorldEditor = False Then .Mode = 13
        .Layer = frmLayers.lstLayer.List(frmLayers.lstLayer.ListIndex)
        If .Mode = 0 Or .Mode = 6 Then 'Eraser
            .Location.Width = 18
            .Location.Height = 8
        ElseIf .Mode = 13 Or .Mode = 14 Then 'Selection
            .Location.Width = 4
            .Location.Height = 4
        ElseIf .Mode = 15 Then 'Water
            .Location.Height = frmWater.WaterH * 32
            .Location.Width = frmWater.WaterW * 32
            .Water.Location = .Location
            .Water.Buoy = 0 'frmWater.scrBuoy / 100
            .Water.Layer = .Layer
            If frmWater.Quicksand.Caption = "Yes" Then
                .Water.Quicksand = True
            Else
                .Water.Quicksand = False
            End If
        ElseIf .Mode = 1 Then  'Blocks
            If .Block.Type = 0 Then .Block.Type = 1
            .Block.Location = .Location
            .Block.Layer = .Layer
            .Block.TriggerHit = frmAdvancedBlock.TriggerHit.Text
            .Block.TriggerDeath = frmAdvancedBlock.TriggerDeath.Text
            .Block.TriggerLast = frmAdvancedBlock.TriggerLast.Text
            For A = 1 To frmBlocks.Block.Count
                If frmBlocks.Block(A).Value = True And frmBlocks.Block(A).Visible = True Then
                    .Block.Type = A
                    Exit For
                End If
            Next A
            If BlockWidth(.Block.Type) > 0 Then
                .Block.Location.Width = BlockWidth(.Block.Type)
            Else
                .Block.Location.Width = 32
            End If
            If BlockHeight(.Block.Type) > 0 Then
                .Block.Location.Height = BlockHeight(.Block.Type)
            Else
                .Block.Location.Height = 32
            End If
            If BlockIsSizable(.Block.Type) Then
                .Block.Location.Width = frmBlocks.BlockW * 32
                .Block.Location.Height = frmBlocks.BlockH * 32
            End If
            .Location.Width = .Block.Location.Width
            .Location.Height = .Block.Location.Height
            
'old code
'            If frmBlocks.optBlockSpecial(0).Value = True Then
'                .Block.Special = 0 'Nothing in the block
'            ElseIf frmBlocks.optBlockSpecial(1).Value = True Then
'                .Block.Special = 100 'Block contains a mushroom
'            ElseIf frmBlocks.optBlockSpecial(2).Value = True Then
'                .Block.Special = 1 'Block contains 1 coin
'            ElseIf frmBlocks.optBlockSpecial(3).Value = True Then
'                .Block.Special = 10 'Block contains 10 coins
'            ElseIf frmBlocks.optBlockSpecial(4).Value = True Then
'                .Block.Special = 101 'Block contains a goomba
'            ElseIf frmBlocks.optBlockSpecial(5).Value = True Then
'                .Block.Special = 102 'Block contains a Fire Flower
'            ElseIf frmBlocks.optBlockSpecial(6).Value = True Then
'                .Block.Special = 103 'Block contains a Leaf
'            ElseIf frmBlocks.optBlockSpecial(7).Value = True Then
'                .Block.Special = 104 'Block contains a Shoe
'            ElseIf frmBlocks.optBlockSpecial(8).Value = True Then
'                .Block.Special = 201 'Block contains a 1 up
'            ElseIf frmBlocks.optBlockSpecial(9).Value = True Then
'                .Block.Special = 105 'Block contains a Green Yoshi
'            End If
            If frmBlocks.optBlockS.Value < 0 Then
                .Block.Special = -frmBlocks.optBlockS.Value
            ElseIf frmBlocks.optBlockS.Value > 0 Then
                .Block.Special = 1000 + frmBlocks.optBlockS.Value
            Else
                .Block.Special = 0
            End If
            If frmBlocks.cmdInvis.Caption = "Yes" Then
                .Block.Invis = True
            Else
                .Block.Invis = False
            End If
            If frmBlocks.cmdSlip.Caption = "Yes" Then
                .Block.Slippy = True
            Else
                .Block.Slippy = False
            End If
        ElseIf .Mode = 2 Then 'Level
            If frmLevelSettings.optLevel(4).Value = True Then
                .Location.Width = Physics.PlayerWidth(1, 2) 'Mario
                .Location.Height = Physics.PlayerHeight(1, 2)
            ElseIf frmLevelSettings.optLevel(5).Value = True Then
                .Location.Width = Physics.PlayerWidth(2, 2) 'Luigi
                .Location.Height = Physics.PlayerHeight(2, 2)
            Else
                .Location.Width = 4 '32
                .Location.Height = 4 '32
            End If
        ElseIf .Mode = 3 Then 'Background
            .Background.Layer = .Layer
            .Background.Location = .Location
            For A = 1 To frmBackgrounds.Background.Count
                If frmBackgrounds.Background(A).Value = True And frmBackgrounds.Background(A).Visible = True Then
                    .Background.Type = A
                    Exit For
                End If
            Next A
            .Background.Location.Width = BackgroundWidth(.Background.Type)
            .Background.Location.Height = BackgroundHeight(.Background.Type)
            .Location.Width = .Background.Location.Width
            .Location.Height = .Background.Location.Height
        ElseIf .Mode = 4 Then 'NPCs
            .NPC.Special = 0
            .NPC.Layer = .Layer
            .NPC.Location = .Location
            For A = 1 To frmNPCs.NPC.Count
                If frmNPCs.NPC(A).Value = True And frmNPCs.NPC(A).Visible = True Then
                    .NPC.Type = A
                    Exit For
                End If
            Next A
            If frmNPCs.Buried.Caption = "Yes" Then
                .NPC.Special = .NPC.Type
                .NPC.Type = 91
            ElseIf frmNPCs.Egg.Caption = "Yes" Then
                .NPC.Special = .NPC.Type
                .NPC.Type = 96
            ElseIf frmNPCs.Bubble.Caption = "Yes" Then
                .NPC.Special = .NPC.Type
                .NPC.Type = 283
            ElseIf frmNPCs.Lakitu.Caption = "Yes" Then
                .NPC.Special = .NPC.Type
                .NPC.Type = 284
            End If
            
            If .NPC.Type = 288 Or .NPC.Type = 289 Or (.NPC.Type = 91 And .NPC.Special = 288) Then  'Door potion
                .NPC.Special2 = frmNPCAdvanced.WarpSection.ListIndex
            End If
            
            If NPCIsAParaTroopa(.NPC.Type) Then
                .NPC.Special = frmNPCAdvanced.cmbPara.ListIndex
            End If
            If NPCIsCheep(.NPC.Type) Then
                .NPC.Special = frmNPCAdvanced.cmbCheep.ListIndex
            End If
            If .NPC.Type = 260 Then .NPC.Special = frmNPCAdvanced.scrFire.Value
            .NPC.Text = ""
            For A = 1 To Len(frmNPCs.NPCText.Text)
                If Mid(frmNPCs.NPCText.Text, A, 1) = Chr(34) Then
                    .NPC.Text = .NPC.Text & "'"
                Else
                    .NPC.Text = .NPC.Text & Mid(frmNPCs.NPCText.Text, A, 1)
                End If
            Next A
            If frmGenerator.Spawn.Caption = "Yes" Then
                .NPC.Generator = True
                .NPC.GeneratorTimeMax = frmGenerator.scrDelay.Value
                For A = 1 To 4
                    If frmGenerator.optSpawnDirection(A).Value = True Then .NPC.GeneratorDirection = A
                Next A
                For A = 1 To 2
                    If frmGenerator.optEffect(A).Value = True Then .NPC.GeneratorEffect = A
                Next A
            Else
                .NPC.Generator = False
            End If
            If NPCWidth(.NPC.Type) > 0 Then
                .NPC.Location.Width = NPCWidth(.NPC.Type)
            Else
                .NPC.Location.Width = 32
            End If
            If NPCHeight(.NPC.Type) > 0 Then
                .NPC.Location.Height = NPCHeight(.NPC.Type)
            Else
                .NPC.Location.Height = 32
            End If
            .Location.Width = .NPC.Location.Width
            .Location.Height = .NPC.Location.Height
            If frmNPCs.optNPCDirection(2).Value = True Then
                .NPC.Direction = 1
            ElseIf frmNPCs.optNPCDirection(0).Value = True Then
                .NPC.Direction = -1
            Else
                .NPC.Direction = 0
            End If
            If frmNPCs.DontMove.Caption = "Yes" Then
                .NPC.Stuck = True
            Else
                .NPC.Stuck = False
            End If
            If frmNPCs.Friendly.Caption = "Yes" Then
                .NPC.Inert = True
            Else
                .NPC.Inert = False
            End If
            If frmNPCAdvanced.Legacy.Caption = "Yes" Then
                .NPC.Legacy = True
            Else
                .NPC.Legacy = False
            End If
            .NPC.TriggerActivate = frmAdvanced.TriggerActivate.Text
            .NPC.TriggerDeath = frmAdvanced.TriggerDeath.Text
            .NPC.TriggerTalk = frmAdvanced.TriggerTalk.Text
            .NPC.TriggerLast = frmAdvanced.TriggerLast.Text
            .NPC.AttLayer = frmAdvanced.AttLayer.Text
            .NPC.Frame = EditorNPCFrame(.NPC.Type, .NPC.Direction)
            .NPC.Active = True
        ElseIf .Mode = 5 Then 'Warps
            .Warp.Layer = .Layer
            EditorCursor.Location.Width = 32
            EditorCursor.Location.Height = 32
            EditorCursor.Warp.Entrance = EditorCursor.Location
            EditorCursor.Warp.Exit = EditorCursor.Location
            EditorCursor.Warp.level = frmWarp.txtLevel.Text
            EditorCursor.Warp.LevelWarp = frmWarp.scrWarp.Value
            EditorCursor.Warp.LevelEnt = frmWarp.chkEntrance.Value
            EditorCursor.Warp.Stars = Val(frmWarp.txtStars)
            If frmWarp.cmdYoshi.Caption = "Yes" Then
                EditorCursor.Warp.NoYoshi = True
            Else
                EditorCursor.Warp.NoYoshi = False
            End If
            If frmWarp.cmdNPC.Caption = "Yes" Then
                EditorCursor.Warp.WarpNPC = True
            Else
                EditorCursor.Warp.WarpNPC = False
            End If
            If frmWarp.cmdLocked.Caption = "Yes" Then
                EditorCursor.Warp.Locked = True
            Else
                EditorCursor.Warp.Locked = False
            End If
            For A = 0 To frmWarp.optEffect.Count - 1
                If frmWarp.optEffect(A).Value = True Then
                    EditorCursor.Warp.Effect = A
                    Exit For
                End If
            Next A
            For A = 1 To frmWarp.optDirection.Count
                If frmWarp.optDirection(A).Value = True Then
                    EditorCursor.Warp.Direction = A
                    Exit For
                End If
            Next A
            For A = 1 To frmWarp.optDirection2.Count
                If frmWarp.optDirection2(A).Value = True Then
                    EditorCursor.Warp.Direction2 = A
                    Exit For
                End If
            Next A
        ElseIf .Mode = 6 Then 'Eraser
            .Location.Width = 32
            .Location.Height = 32
        ElseIf .Mode = 7 Then 'Tiles
            For A = 1 To frmTiles.Tile.Count
                If frmTiles.Tile(A).Value = True Then
                    .Tile.Type = A
                    Exit For
                End If
            Next A
            .Location.Width = TileWidth(.Tile.Type)
            .Location.Height = TileHeight(.Tile.Type)
            .Tile.Location = .Location
        ElseIf .Mode = 8 Then 'Scene
            For A = 1 To frmScene.Scene.Count
                If frmScene.Scene(A).Value = True Then
                    .Scene.Type = A
                    .Scene.Active = True
                    Exit For
                End If
            Next A
            .Location.Width = SceneWidth(.Scene.Type)
            .Location.Height = SceneHeight(.Scene.Type)
            .Scene.Location = .Location
        ElseIf .Mode = 9 Then 'Levels
            For A = 1 To frmLevels.WorldLevel.Count - 1
                If frmLevels.WorldLevel(A).Value = True Then
                    .WorldLevel.Type = A
                    .WorldLevel.Active = True
                    Exit For
                End If
            Next A
            .Location.Width = 32
            .Location.Height = 32
            .WorldLevel.Location = .Location
            .WorldLevel.FileName = frmLevels.txtFilename.Text
            If .WorldLevel.FileName <> "" And Right(.WorldLevel.FileName, 4) <> LCase(".lvl") Then .WorldLevel.FileName = .WorldLevel.FileName & ".lvl"
            .WorldLevel.StartWarp = Val(frmLevels.scrWarp.Value)
            .WorldLevel.LevelName = frmLevels.txtLevelName.Text
            .WorldLevel.Visible = False
            .WorldLevel.Start = False
            .WorldLevel.Path = False
            .WorldLevel.Path2 = False
            If frmLevels.chkVisible.Value > 0 Then .WorldLevel.Visible = True
            If frmLevels.chkStart.Value > 0 Then .WorldLevel.Start = True
            If frmLevels.chkPath.Value > 0 Then .WorldLevel.Path = True
            If frmLevels.chkPath2.Value > 0 Then .WorldLevel.Path2 = True
            If frmLevels.txtX.Text = "" Then
                .WorldLevel.WarpX = -1
            Else
                .WorldLevel.WarpX = Val(frmLevels.txtX.Text)
            End If
            If frmLevels.txtX.Text = "" Then
                .WorldLevel.WarpY = -1
            Else
                .WorldLevel.WarpY = Val(frmLevels.txtY.Text)
            End If

            
            
            For A = 1 To 4
                If frmLevels.cmbExit(A).ListIndex < 0 Then frmLevels.cmbExit(A).ListIndex = 0
                .WorldLevel.LevelExit(A) = frmLevels.cmbExit(A).ListIndex - 1
            Next A
        ElseIf .Mode = 10 Then 'Paths
            For A = 1 To frmPaths.WorldPath.Count
                If frmPaths.WorldPath(A).Value = True Then
                    .WorldPath.Type = A
                    .WorldPath.Active = True
                    Exit For
                End If
            Next A
            .Location.Width = 32
            .Location.Height = 32
            .WorldPath.Location = .Location
        ElseIf .Mode = 11 Then 'World Music
            .Location.Height = 32
            .Location.Width = 32
            .WorldMusic.Location = .Location
            For A = 0 To frmMusic.optMusic.Count - 1
                If frmMusic.optMusic(A).Value = True Then
                    .WorldMusic.Type = A
                    Exit For
                End If
            Next A
        End If
    End With
End Sub

Public Sub PositionCursor()
    If EditorCursor.Mode = 4 And frmNPCs.Buried.Caption = "Yes" Then
        EditorCursor.Location.Y = EditorCursor.Location.Y + 16
    End If
    If EditorCursor.Mode = 9 Then
        frmLevels.lblX = EditorCursor.Location.X
        frmLevels.lblY = EditorCursor.Location.Y
    End If
    If EditorCursor.Mode = 13 Or EditorCursor.Mode = 14 Or (EditorCursor.Mode = 2 And frmLevelSettings.optLevel(4).Value = False And frmLevelSettings.optLevel(5).Value = False) Then Exit Sub
    If frmLevelEditor.chkAlign.Value = 0 Then
        EditorCursor.Location.X = EditorCursor.Location.X - EditorCursor.Location.Width + 4
        EditorCursor.Location.Y = EditorCursor.Location.Y - EditorCursor.Location.Height + 12
        Exit Sub
    End If
    If EditorCursor.Mode = 2 And (frmLevelSettings.optLevel(4).Value = True Or frmLevelSettings.optLevel(5).Value = True) Then
        EditorCursor.Location.X = EditorCursor.Location.X - 14
    End If
    If EditorCursor.Mode = 2 Or EditorCursor.Mode = 4 Then
        If Not (EditorCursor.Mode = 4 And frmNPCs.NPC(52).Value = True) Then
            With EditorCursor.Location
                If EditorCursor.Location.Width Mod 32 <> 0 Then
                    If EditorCursor.Location.Width > 32 Then
                        EditorCursor.Location.X = EditorCursor.Location.X - (EditorCursor.Location.Width Mod 32) / 2
                    ElseIf EditorCursor.Location.Width <= 16 Then
                        EditorCursor.Location.X = EditorCursor.Location.X + (32 Mod EditorCursor.Location.Width) / 2
                        EditorCursor.Location.X = EditorCursor.Location.X + (32 - EditorCursor.Location.Width) / 2
                    ElseIf EditorCursor.Location.Width < 32 Then
                        EditorCursor.Location.X = EditorCursor.Location.X + (32 Mod EditorCursor.Location.Width) / 2
                    Else
                        EditorCursor.Location.X = EditorCursor.Location.X + (32 Mod EditorCursor.Location.Width) / 2
                    End If
                End If
                If EditorCursor.Location.Height Mod 32 <> 0 Then
                    EditorCursor.Location.Y = EditorCursor.Location.Y - EditorCursor.Location.Height Mod 32
                End If
            End With
        End If
    End If
    With EditorCursor
        If .Mode = 3 Then
            If frmBackgrounds.Background(13).Value = True And frmBackgrounds.Background(13).Visible = True Then  'End level container
                .Location.X = .Location.X - 12
                .Location.Y = .Location.Y - 12
            End If
            If frmBackgrounds.Background(156).Value = True Or frmBackgrounds.Background(157).Value = True Then
                .Location.Y = .Location.Y + 16
            End If
        ElseIf .Mode = 4 Then
            If frmNPCs.NPC(245).Value = True Or frmNPCs.NPC(8).Value = True Or frmNPCs.NPC(270).Value = True Or frmNPCs.NPC(93).Value = True Or frmNPCs.NPC(180).Value = True Or frmNPCs.NPC(179).Value = True Or frmNPCs.NPC(37).Value = True Or frmNPCs.NPC(51).Value = True Then        'Piranha Plants
                .Location.X = .Location.X + 16
            ElseIf frmNPCs.NPC(197).Value = True Then
                .Location.X = .Location.X - 8
                .Location.Y = .Location.Y + 16
            End If
            If frmNPCs.Buried.Caption = "Yes" Then
                If frmLevelEditor.chkAlign.Value = False Then
                    .Location.Y = .Location.Y + 16
                Else
                    .Location.Y = .Location.Y + 32
                End If
            ElseIf frmNPCs.NPC(105).Value = True Then
                .Location.Y = .Location.Y + 22
            ElseIf frmNPCs.NPC(106).Value = True Then
                .Location.Y = .Location.Y + 16
            ElseIf frmNPCs.NPC(260).Value = True Then
                .Location.Y = .Location.Y - 8
            End If
        End If
        If .Mode = 4 Then
            If NPCHeight(.NPC.Type) < 32 Then .Location.Y = .Location.Y + 32
        End If
    End With
End Sub

Public Sub HideCursor()
    EditorCursor.Location.X = vScreenX(1) - 800
    EditorCursor.X = vScreenX(1) - 800
    EditorCursor.Location.Y = vScreenY(1) - 600
    EditorCursor.Y = vScreenY(1) - 600
    HasCursor = False
    With EditorControls
        .Down = False
        .Left = False
        .Mouse1 = False
        .Right = False
        .Up = False
    End With
End Sub

Public Sub KillWarp(A As Integer)
    Dim blankWarp As Warp
    Warp(A) = Warp(numWarps)
    Warp(numWarps) = blankWarp
    numWarps = numWarps - 1
End Sub

Public Sub zTestLevel()
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim blankPlayer As Player
    qScreen = False
    If nPlay.Online = True Then Checkpoint = ""
    If FullFileName <> "" Or nPlay.Online = True Then
        If nPlay.Online = False Then
            A = MsgBox("Do you want to save the level first? All changes since last save will be lost.", vbYesNoCancel, "Save first?")
        Else
            A = 1
        End If
        If A = 2 Then
        Else
            If A = 6 Then SaveLevel FullFileName
            For A = 1 To numCharacters
                SavedChar(A) = blankPlayer
                SavedChar(A).State = 1
                SavedChar(A).Character = A
            Next A
            
            For A = 1 To numNPCs
                With NPC(A)
                    'If .Generator = True Then
                        .TimeLeft = 0
                        .Active = False
                        
                    'End If
                End With
            Next A
            
            GamePaused = False
            MessageText = ""
            frmNPCs.chkMessage.Value = 0
            BattleLives(1) = 3
            BattleLives(2) = 3
            BattleWinner = 0
            BattleOutro = 0
            frmLevelEditor.mnuOnline.Enabled = False
            Player(1).Hearts = 1
            Player(2).Hearts = 1
            StopMusic
            Score = 0
            Coins = 0
            Lives = 3
            If numPlayers = 0 Then numPlayers = 1
            If numPlayers > 2 Or nPlay.Online = True Then
                For A = 1 To numPlayers
                    Player(A).Hearts = 0
                    Player(A).State = testPlayer(1).State
                    Player(A).HeldBonus = 0
                    Player(A).Dead = False
                    Player(A).Mount = testPlayer(1).Mount
                    Player(A).MountType = testPlayer(1).MountType
                    Player(A).Character = testPlayer(1).Character
                    If Player(A).Character = 0 Then Player(1).Character = 1
                Next A
            Else
                For A = 2 To 1 Step -1
                    Player(A).State = testPlayer(A).State
                    Player(A).HeldBonus = 0
                    Player(A).Dead = False
                    Player(A).Mount = testPlayer(A).Mount
                    Player(A).MountType = testPlayer(A).MountType
                    Player(A).Character = testPlayer(A).Character
                    If Player(A).Character = 0 Then Player(A).Character = A
                    SavedChar(Player(A).Character) = Player(A)
                Next A
            End If
            LevelEditor = False
            SetupPlayers
            MagicHand = True
            If TestFullscreen = True Then
                ChangeScreen
                DoEvents
                frmMain.Show
                frmLevelEditor.Hide
                MagicHand = False
            End If
            If nPlay.Online = False Then
                OpenLevel FullFileName
            Else
                qSortNPCsY 1, C
                qSortNPCsY C + 1, numNPCs
                qSortBlocksX 1, numBlock
                B = 1
                For A = 2 To numBlock
                    If Block(A).Location.X > Block(B).Location.X Then
                        qSortBlocksY B, A - 1
                        B = A
                    End If
                Next A
                qSortBlocksY B, A - 1
                qSortBackgrounds 1, numBackground
                FindBlocks
                UpdateBackgrounds
                FindSBlocks
                LevelMacro = 0
                B = 0
                For A = 1 To 15
                    If nPlay.Mode = 1 And nPlay.ClientCon(A) = False Then nPlay.Player(A).Active = False
                    If nPlay.Player(A).Active = True Then
                        B = A + 1
                    End If
                Next A
                numPlayers = B
                For A = 0 To maxSections
                    LevelREAL(A) = level(A)
                Next A
                For A = 1 To numNPCs
                    With NPC(A)
                        .DefaultType = .Type
                        .Location.Width = NPCWidth(.Type)
                        .Location.Height = NPCHeight(.Type)
                        .DefaultLocation = .Location
                        .DefaultDirection = .Direction
                        .Active = True
                        .JustActivated = 1
                        .TimeLeft = 1
                        CheckSectionNPC numNPCs
                    End With
                Next A
            End If
            If SingleCoop > 0 Then ScreenType = 6
            SetupScreens
            TestLevel = True
            LevelSelect = False
            EndLevel = False
            ReturnWarp = 0
            StartWarp = 0
            frmLayers.Hide
            frmEvents.Hide
            frmLevelEditor.menuFile.Enabled = False
            frmLevelEditor.MenuTest.Enabled = False
            frmLevelEditor.mnuMode.Enabled = False
            frmLevelEditor.optCursor(5).Enabled = False
            frmLevelEditor.optCursor(15).Enabled = False
            frmLevelEditor.optCursor(13).Value = True
            frmTestSettings.Hide
            For A = 0 To frmLevelSettings.optLevel.Count - 1
                frmLevelSettings.optLevel(A).Enabled = False
            Next A
            For A = 0 To frmLevelSettings.optSection.Count - 1
                frmLevelSettings.optSection(A).Enabled = False
            Next A
            If numPlayers = 1 Then
                ScreenType = 1
            Else
                ScreenType = 5
            End If
        End If
    Else
        MsgBox "You must save or load the level first", vbOKOnly, "No filename"
    End If
End Sub

Public Function EditorNPCFrame(A As Integer, C As Single, Optional N As Integer) As Integer

'find the default left/right frames for NPCs

    If A > maxNPCType Then Exit Function
    Dim B As Single
    Dim D As Integer
    Dim E As Integer
    B = C
    Do While B = 0
        B = Int(Rnd * 3) - 1
    Loop
    If LevelEditor = False Then C = B
    If A = 241 Then EditorNPCFrame = 4
    If A = 195 Then EditorNPCFrame = 3
    'suits
    If N > 0 Then
        With NPC(N)
            If A = 169 Or A = 170 Then
                E = 0
                For D = 1 To numPlayers
                    If Player(D).Dead = False And Player(D).Section = .Section And Player(D).Character <> 3 And Player(D).Character <> 4 And Player(D).TimeToLive = 0 Then
                        If E = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(D).Location.X + Player(D).Location.Width / 2)) + Abs(.Location.Y + .Location.Height / 2 - (Player(D).Location.Y + Player(D).Location.Height / 2)) < D Then
                            E = Abs(.Location.X + .Location.Width / 2 - (Player(D).Location.X + Player(D).Location.Width / 2)) + Abs(.Location.Y + .Location.Height / 2 - (Player(D).Location.Y + Player(D).Location.Height / 2))
                            If Player(D).Character = 5 Then
                                EditorNPCFrame = 1
                            Else
                                EditorNPCFrame = 0
                            End If
                        End If
                    End If
                Next D
            End If
        End With
    End If
    
    
    If A = 135 Or A = 4 Or A = 6 Or A = 19 Or A = 20 Or A = 23 Or A = 25 Or A = 28 Or A = 36 Or A = 38 Or A = 42 Or A = 43 Or A = 44 Or A = 193 Or A = 35 Or A = 191 Or A = 52 Or A = 72 Or A = 77 Or A = 108 Or (A >= 109 And A <= 112) Or (A >= 121 And A <= 124) Or A = 125 Or (A >= 129 And A <= 132) Or A = 136 Or A = 158 Or A = 164 Or A = 163 Or A = 162 Or A = 165 Or A = 166 Or A = 189 Or A = 199 Or A = 209 Or A = 207 Or A = 229 Or A = 230 Or A = 232 Or A = 236 Or A = 233 Or A = 173 Or A = 175 Or A = 177 Or A = 178 Or A = 176 Then     'Koopa troopas / Shy guy
        If B = -1 Then
            EditorNPCFrame = 0
        Else
            EditorNPCFrame = 2
        End If
    End If
    'Bullet Bills
    If A = 17 Or A = 18 Or A = 29 Or A = 31 Or A = 84 Or A = 94 Or A = 198 Or NPCIsYoshi(A) Or A = 101 Or A = 102 Or A = 181 Or A = 81 Then
        If B = -1 Then
            EditorNPCFrame = 0
        Else
            EditorNPCFrame = 1
        End If
    End If
    'Hammer Bros.
    If A = 29 Or A = 55 Or A = 75 Or A = 78 Or A = 168 Or A = 234 Then
        If B = -1 Then
            EditorNPCFrame = 0
        Else
            EditorNPCFrame = 3
        End If
    End If
    If A = 34 Then
        If B = -1 Then
            EditorNPCFrame = 1
        Else
            EditorNPCFrame = 0
        End If
    End If
    If A = 201 Then
        If B = -1 Then
            EditorNPCFrame = 0
        Else
            EditorNPCFrame = 8
        End If
    End If
    If A = 137 Then
        If B = -1 Then
            EditorNPCFrame = 0
        Else
            EditorNPCFrame = 6
        End If
    End If
    If A = 86 Or (A >= 117 And A <= 120) Or A = 200 Then
        If B = -1 Then
            EditorNPCFrame = 0
        Else
            EditorNPCFrame = 5
        End If
    End If
    'winged koopa / bob-omb buddy
    If A = 76 Or A = 107 Or A = 160 Or A = 161 Or A = 167 Or A = 203 Or A = 204 Then
        If B = -1 Then
            EditorNPCFrame = 0
        Else
            EditorNPCFrame = 4
        End If
    End If
    'Birdo
    If A = 39 Or A = 208 Then
        If B = -1 Then
            EditorNPCFrame = 0
        Else
            EditorNPCFrame = 5
        End If
    End If
    If A = 45 Then EditorNPCFrame = BlockFrame(4)
    If A = 56 Then
        EditorNPCFrame = SpecialFrame(2)
        If B = 1 Then EditorNPCFrame = EditorNPCFrame + 4
    End If
    If A = 57 Then 'smb3 belt
        If B = -1 Then
            EditorNPCFrame = SpecialFrame(4)
        Else
            EditorNPCFrame = 3 - SpecialFrame(4)
        End If
    End If
    If A = 60 Or A = 62 Or A = 64 Or A = 66 Then
        If B = -1 Then EditorNPCFrame = 1
    End If
End Function

Public Sub MouseMove(X As Single, Y As Single, Optional nCur As Boolean = False)
    Dim A As Integer
    HasCursor = True
    A = 1
    If SingleCoop > 0 Then
        A = SingleCoop
    ElseIf ScreenType = 5 And vScreen(2).Visible = True Then
        If X < vScreen(2).Left + vScreen(2).Width Then
            If X > vScreen(2).Left Then
                If Y < vScreen(2).Top + vScreen(2).Height Then
                    If Y > vScreen(2).Top Then
                        A = 2
                    End If
                End If
            End If
        End If
    Else
        A = 1
    End If
    With EditorCursor
        If .Mode = 0 Or .Mode = 6 Or .Mode = 13 Or .Mode = 14 Or frmLevelEditor.chkAlign.Value = 0 Then
            .Location.X = X - vScreenX(A)
            .Location.Y = Y - vScreenY(A)
            PositionCursor
        Else
            If MagicHand = True Then
                If (vScreenY(A) + 8) Mod 32 <> 0 Then
                    vScreenY(A) = Int(vScreenY(A) / 32) * 32 - 8
                End If
                If vScreenX(A) Mod 32 <> 0 Then
                    vScreenX(A) = Int(vScreenX(A) / 32) * 32
                End If
            End If
            If (.Mode = 1 And (frmBlocks.Block(534).Value = True Or frmBlocks.Block(535).Value = True Or frmBlocks.Block(536).Value = True Or frmBlocks.Block(537).Value = True)) Or .Mode = 5 Or (EditorCursor.Mode = 4 And frmNPCs.NPC(52).Value = True) Or (EditorCursor.Mode = 3 And (frmBackgrounds.Background(71).Value = True Or frmBackgrounds.Background(72).Value = True Or frmBackgrounds.Background(73).Value = True Or frmBackgrounds.Background(141).Value = True Or frmBackgrounds.Background(74).Value = True Or frmBackgrounds.Background(70).Value = True Or frmBackgrounds.Background(100).Value = True)) Or (EditorCursor.Mode = 4 And (frmGenerator.Spawn.Caption = "Yes" Or frmNPCs.NPC(209).Value = True Or frmNPCs.NPC(256).Value = True Or frmNPCs.NPC(257).Value = True Or frmNPCs.NPC(260).Value = True)) Then
                If Not (.Location.X = Int(X / 16) * 16 - vScreenX(A) And .Location.Y + 8 = Int(Y / 16) * 16 - vScreenY(A)) Then
                    .Location.X = Int(X / 16) * 16 - vScreenX(A)
                    .Location.Y = Int(Y / 16) * 16 - vScreenY(A)
                    .Location.Y = .Location.Y - 8
                    PositionCursor
                End If
            ElseIf .Mode = 2 Then
                If frmLevelSettings.optLevel(4).Value = False And frmLevelSettings.optLevel(5).Value = False Then
                    .Location.X = X - vScreenX(A)
                    .Location.Y = Y - vScreenY(A)
                ElseIf Not (.Location.X = Int(X / 8) * 8 - vScreenX(A) And .Location.Y + 8 = Int(Y / 8) * 8 - vScreenY(A)) Then
                    .Location.X = Int(X / 8) * 8 - vScreenX(A)
                    .Location.Y = Int(Y / 8) * 8 - vScreenY(A)
                    .Location.Y = .Location.Y - 8
                    PositionCursor
                End If
            ElseIf .Mode = 8 Then
                .Location.X = Int(X / 16) * 16 - vScreenX(A)
                .Location.Y = Int(Y / 16) * 16 - vScreenY(A)
                .Location.Y = .Location.Y - 8
                PositionCursor
            ElseIf .Mode = 15 Then
                .Location.X = Int(X / 16) * 16 - vScreenX(A)
                .Location.Y = Int(Y / 16) * 16 - vScreenY(A)
                .Location.Y = .Location.Y - 8
                PositionCursor
            Else
                .Location.X = Int(X / 32) * 32 - vScreenX(A)
                .Location.Y = Int(Y / 32) * 32 - vScreenY(A)
                .Location.Y = .Location.Y - 8
                PositionCursor
            End If
        End If
        .Location.X = .Location.X - vScreen(A).Left
        .Location.Y = .Location.Y - vScreen(A).Top
    End With
    If nPlay.Online = True And nCur = True Then
        If nPlay.Mode = 0 Then
            Netplay.sendData "f" & X - vScreenX(A) & "|" & Y - vScreenY(A) 'Netplay
        Else
            SetCursor
            Netplay.sendData "f" & "0|" & X - vScreenX(A) & "|" & Y - vScreenY(A) 'Netplay
        End If
    End If
End Sub

Public Sub ResetNPC(A As Integer)
    Dim blankNPC As NPC
    NPC(0) = blankNPC
    NPC(0).Frame = EditorNPCFrame(A, EditorCursor.NPC.Direction)
    EditorCursor.NPC.Frame = NPC(0).Frame
    EditorCursor.NPC.FrameCount = NPC(0).FrameCount
    NPC(0).Frame = 0
End Sub

Public Sub BlockFill(Loc As Location)
Dim tempBool As Boolean
Dim tempLoc As Location
Dim A As Integer
    If Loc.X >= level(curSection).X - 30 Then
    If Loc.Y >= level(curSection).Y - 30 Then
    If Loc.X + Loc.Width <= level(curSection).Width + 30 Then
    If Loc.Y + Loc.Height <= level(curSection).Height + 30 Then
        tempBool = True
        For A = 1 To numBlock
            If Block(A).Hidden = False Then
                If CursorCollision(Loc, Block(A).Location) = True Then
                    tempBool = False
                    Exit For
                End If
            End If
        Next A
    End If
    End If
    End If
    End If
    If tempBool = True Then
        numBlock = numBlock + 1
        Block(numBlock) = EditorCursor.Block
        Block(numBlock).DefaultType = Block(numBlock).Type
        Block(numBlock).DefaultSpecial = Block(numBlock).Special
        Block(numBlock).Location = Loc
        tempLoc = Loc
        tempLoc.X = tempLoc.X - Loc.Width
        BlockFill tempLoc 'left
        tempLoc = Loc
        tempLoc.X = tempLoc.X + Loc.Width
        BlockFill tempLoc 'right
        tempLoc = Loc
        tempLoc.Y = tempLoc.Y - Loc.Height
        BlockFill tempLoc 'top
        tempLoc = Loc
        tempLoc.Y = tempLoc.Y + Loc.Height
        BlockFill tempLoc 'bottom
    End If
End Sub






