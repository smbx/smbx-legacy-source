Attribute VB_Name = "modLayers"
Option Explicit
'this sub handles layers and events

Public Sub ShowLayer(LayerName As String, Optional NoEffect As Boolean = False) 'shows a layer
    Dim A As Integer
    Dim B As Integer
    Dim tempLocation As Location
    If LayerName = "" Then Exit Sub
    For A = 0 To 100
        If LCase(Layer(A).Name) = LCase(LayerName) Then
            Layer(A).Hidden = False
            If Layer(A).Name = "Destroyed Blocks" Then Layer(A).Hidden = True
            If Layer(A).Name = "Spawned NPCs" Then Layer(A).Hidden = False
        End If
    Next A
    For A = 1 To numNPCs
        If LCase(NPC(A).Layer) = LCase(LayerName) Then
            If NPC(A).Hidden = True Then
                If NoEffect = False And NPC(A).Generator = False Then
                    tempLocation = NPC(A).Location
                    tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                    tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, tempLocation
                End If
                If LevelEditor = False Then
                    If NPCWontHurt(NPC(A).Type) = False And NPCIsABonus(NPC(A).Type) = False And NPC(A).Active = True Then
                        For B = 1 To numPlayers
                            If CheckCollision(Player(B).Location, NPC(A).Location) = True Then
                                Player(B).Immune = 120
                            End If
                        Next B
                    End If
                End If
            End If
            NPC(A).Hidden = False
            NPC(A).GeneratorActive = True
            NPC(A).Reset(1) = True
            NPC(A).Reset(2) = True
            If NPC(A).Generator = False Then
                NPC(A).Active = True
                NPC(A).TimeLeft = 1
            End If
            CheckSectionNPC A
        End If
    Next A
    For A = 1 To numBlock
        If LCase(Block(A).Layer) = LCase(LayerName) Then
        
            
            'If Not (Block(A).DefaultType = 0 And Block(A).Layer = "Destroyed Blocks") Then
            
                If Block(A).Hidden = True Then
                    If NoEffect = False And Block(A).Invis = False Then
                        tempLocation = Block(A).Location
                        tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                        tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                        NewEffect 10, tempLocation
                    End If
                End If
                Block(A).Hidden = False
            End If
            If LayerName = "Destroyed Blocks" Then
                If Block(A).DefaultType > 0 Then
                    If Block(A).Layer = LayerName Then Block(A).Layer = "Default"
                    Block(A).Special = Block(A).DefaultSpecial
                    Block(A).Type = Block(A).DefaultType
                End If
            End If
        'End If
    Next A
    For A = 1 To numBackground + numLocked
        If LCase(Background(A).Layer) = LCase(LayerName) Then
            If Background(A).Hidden = True Then
                If NoEffect = False Then
                    tempLocation = Background(A).Location
                    tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                    tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, tempLocation
                End If
            End If
            Background(A).Hidden = False
        End If
    Next A
    For A = 1 To numWarps
        If LCase(Warp(A).Layer) = LCase(LayerName) Then Warp(A).Hidden = False
    Next A
    For A = 1 To numWater
        If LCase(Water(A).Layer) = LCase(LayerName) Then Water(A).Hidden = False
    Next A
End Sub

Public Sub HideLayer(LayerName As String, Optional NoEffect As Boolean = False) 'hides a layer
    Dim A As Integer
    Dim tempLocation As Location
    If LayerName = "" Then Exit Sub
    For A = 0 To 100
        If LCase(Layer(A).Name) = LCase(LayerName) Then
            Layer(A).Hidden = True
        End If
    Next A
    For A = 1 To numNPCs
        If LCase(NPC(A).Layer) = LCase(LayerName) Then
            If NPC(A).Hidden = False Then
                If NoEffect = False And NPC(A).Generator = False Then
                    tempLocation = NPC(A).Location
                    tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                    tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, tempLocation
                End If
            End If
            NPC(A).Hidden = True
            If NPC(A).Generator = False Then Deactivate A
        End If
    Next A
    For A = 1 To numBlock
        If LCase(Block(A).Layer) = LCase(LayerName) Then
            If Block(A).Hidden = False Then
                If NoEffect = False And Block(A).Invis = False Then
                    tempLocation = Block(A).Location
                    tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                    tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, tempLocation
                End If
            End If
            Block(A).Hidden = True
        End If
    Next A
    For A = 1 To numBackground + numLocked
        If LCase(Background(A).Layer) = LCase(LayerName) Then
            If Background(A).Hidden = False Then
                If NoEffect = False Then
                    tempLocation = Background(A).Location
                    tempLocation.X = tempLocation.X + tempLocation.Width / 2 - EffectWidth(10) / 2
                    tempLocation.Y = tempLocation.Y + tempLocation.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, tempLocation
                End If
            End If
            Background(A).Hidden = True
        End If
    Next A
    For A = 1 To numWarps
        If LCase(Warp(A).Layer) = LCase(LayerName) Then Warp(A).Hidden = True
    Next A
    For A = 1 To numWater
        If LCase(Water(A).Layer) = LCase(LayerName) Then Water(A).Hidden = True
    Next A
End Sub

Public Sub SetLayer(LayerName As String)
    Dim A As Integer
    For A = 0 To frmLayers.lstLayer.ListCount - 1
        If LCase(LayerName) = LCase(frmLayers.lstLayer.List(A)) Then frmLayers.lstLayer.ListIndex = A
    Next A
End Sub

Public Sub ProcEvent(EventName As String, Optional NoEffect As Boolean = False)
'this is for events that have just been triggered
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim D As Integer
    Dim plr As Integer
    Dim tempBool As Boolean
    Dim tempLevel As Location
    Dim screenLoc As vScreen
    Dim tX As Double
    Dim tY As Double
    If EventName = "" Or LevelEditor = True Then Exit Sub
    For A = 0 To 100
        If LCase(EventName) = LCase(Events(A).Name) Then
            For B = 0 To maxSections
                If Events(A).Music(B) = -2 Then
                    bgMusic(B) = bgMusicREAL(B)
                    If B = Player(1).Section Or (numPlayers = 2 And B = Player(2).Section) Then StartMusic B
                ElseIf Events(A).Music(B) <> -1 Then
                    bgMusic(B) = Events(A).Music(B)
                    If B = Player(1).Section Or (numPlayers = 2 And B = Player(2).Section) Then StartMusic B
                End If
                If Events(A).Background(B) = -2 Then
                    Background2(B) = Background2REAL(B)
                ElseIf Events(A).Background(B) <> -1 Then
                    Background2(B) = Events(A).Background(B)
                End If
                If Events(A).level(B).X = -2 Then
                    level(B) = LevelREAL(B)
                ElseIf Events(A).level(B).X <> -1 Then
                    tempLevel = level(B)
                    level(B) = Events(A).level(B)
                    If Events(A).AutoStart = False And Events(A).Name <> "Level - Start" Then
                        For C = 1 To numPlayers
                            With Player(C)
                                'If .Section = B Then
                                .Section = B
                                    tempBool = False
                                    If .Location.X + .Location.Width >= level(B).X Then
                                        If .Location.X <= level(B).Width Then
                                            If .Location.Y + .Location.Height >= level(B).Y Then
                                                If .Location.Y <= level(B).Height Then
                                                    tempBool = True 'Check to see if player is still in section after resizing
                                                    plr = C
                                                End If
                                            End If
                                        End If
                                    End If
                                    If tempBool = False Then
                                        For D = 1 To numPlayers
                                            If D <> C And Player(D).Section = B Then
                                                If Player(D).Location.X + Player(D).Location.Width >= level(B).X Then
                                                    If Player(D).Location.X <= level(B).Width Then
                                                        If Player(D).Location.Y + Player(D).Location.Height >= level(B).Y Then
                                                            If Player(D).Location.Y <= level(B).Height Then 'Move to another player who is still in the section
                                                                .Location.X = Player(D).Location.X + Player(D).Location.Width / 2 - .Location.Width / 2
                                                                .Location.Y = Player(D).Location.Y + Player(D).Location.Height - .Location.Height
                                                                .Effect = 9
                                                                .Effect2 = D
                                                                Exit For
                                                            End If
                                                        End If
                                                    End If
                                                End If
                                            End If
                                        Next D
                                    End If
                                'End If
                            End With
                        Next C
                    End If
                    If Events(A).Name <> "Level - Start" Then
                        C = plr
                        If numPlayers = 2 And DScreenType <> 5 Then
                            tX = vScreenX(C)
                            tY = vScreenY(C)
                            level(B) = tempLevel
                            screenLoc = vScreen(C)
                            SoundPause(13) = 10
                            DynamicScreen
                            GetvScreenAverage
                            qScreen = True
                            qScreenX(1) = vScreenX(1)
                            qScreenY(1) = vScreenY(1)
                            If screenLoc.Width = 400 Then
                                If qScreenX(1) < tX + screenLoc.Left Then
                                    qScreenX(1) = qScreenX(1) + 200
                                Else
                                    qScreenX(1) = qScreenX(1) - 200
                                End If
                            End If
                            If screenLoc.Height = 300 Then
                                If qScreenY(1) < tY + screenLoc.Top Then
                                    qScreenY(1) = qScreenY(1) + 150
                                Else
                                    qScreenY(1) = qScreenY(1) - 150
                                End If
                            End If
                            If -qScreenX(1) < level(Player(C).Section).X Then qScreenX(1) = -level(Player(C).Section).X
                            If -qScreenX(1) + frmMain.ScaleWidth > level(Player(C).Section).Width Then qScreenX(1) = -(level(Player(C).Section).Width - ScreenW)
                            If -qScreenY(1) < level(Player(C).Section).Y Then qScreenY(1) = -level(Player(C).Section).Y
                            If -qScreenY(1) + frmMain.ScaleHeight > level(Player(C).Section).Height Then qScreenY(1) = -(level(Player(C).Section).Height - ScreenH)
                            level(B) = Events(A).level(B)
                        Else
                            qScreen = True
                            qScreenX(1) = vScreenX(1)
                            qScreenY(1) = vScreenY(1)
                        End If
                        overTime = 0
                        GoalTime = GetTickCount + 1000
                        fpsCount = 0
                        cycleCount = 0
                        gameTime = 0
                        fpsTime = 0
                    End If
                End If
            Next B
            For B = 0 To 20
                If NoEffect = True Then
                    HideLayer Events(A).HideLayer(B), NoEffect
                    ShowLayer Events(A).ShowLayer(B), NoEffect
                Else
                    HideLayer Events(A).HideLayer(B), Events(A).LayerSmoke
                    ShowLayer Events(A).ShowLayer(B), Events(A).LayerSmoke
                End If
                If Not Events(A).ToggleLayer(B) = "" Then
                    For C = 0 To 100
                        If Layer(C).Name = Events(A).ToggleLayer(B) Then
                            If Layer(C).Hidden = True Then
                                ShowLayer Layer(C).Name, Events(A).LayerSmoke
                            Else
                                HideLayer Layer(C).Name, Events(A).LayerSmoke
                            End If
                        End If
                    Next C
                End If
            Next B
            If Events(A).MoveLayer <> "" Then
                For B = 0 To 100
                    If Layer(B).Name = Events(A).MoveLayer Then
                        Layer(B).EffectStop = True
                        Layer(B).SpeedX = Events(A).SpeedX
                        Layer(B).SpeedY = Events(A).SpeedY
                        If Layer(B).SpeedX = 0 And Layer(B).SpeedY = 0 Then
'stop layer
                            Layer(B).EffectStop = False
                            For C = 1 To numBlock
                                If Block(C).Layer = Layer(B).Name Then
                                    Block(C).Location.SpeedX = Layer(B).SpeedX
                                    Block(C).Location.SpeedY = Layer(B).SpeedY
                                End If
                            Next C
                            For C = 1 To numNPCs
                                If NPC(C).Layer = Layer(B).Name Then
                                    If NPCIsAVine(NPC(C).Type) Or NPC(C).Type = 91 Then
                                        NPC(C).Location.SpeedX = 0
                                        NPC(C).Location.SpeedY = 0
                                    End If
                                End If
                            Next C
                        End If
                    End If
                Next B
            End If
            AutoX(Events(A).AutoSection) = Events(Events(A).AutoSection).AutoX
            AutoY(Events(A).AutoSection) = Events(Events(A).AutoSection).AutoY
            If Events(A).Text <> "" Then
                MessageText = Events(A).Text
                PauseGame 1
                MessageText = ""
            End If
            If Events(A).Sound > 0 Then
                SoundPause(Events(A).Sound) = 0
                PlaySound Events(A).Sound
            End If
            If Events(A).EndGame = 1 Then
                For B = 0 To maxSections
                    bgMusic(B) = 0
                Next B
                StopMusic
                LevelMacroCounter = 0
                LevelMacro = 5
            End If
            If Events(A).Controls.AltJump = True Or Events(A).Controls.AltRun = True Or Events(A).Controls.Down = True Or Events(A).Controls.Drop = True Or Events(A).Controls.Jump = True Or Events(A).Controls.Left = True Or Events(A).Controls.Right = True Or Events(A).Controls.Run = True Or Events(A).Controls.Start = True Or Events(A).Controls.Up = True Then
                ForcedControls = True
            Else
                ForcedControls = False
            End If
            ForcedControl = Events(A).Controls
            tempBool = False
            If Events(A).TriggerEvent <> "" Then
                If Events(A).TriggerDelay = 0 Then
                    For B = 0 To 100
                        If Events(B).Name = Events(A).TriggerEvent Then
                            If Events(B).TriggerEvent = Events(A).Name Then
                                tempBool = True
                            End If
                            Exit For
                        End If
                    Next B
                    If tempBool = False Then ProcEvent Events(A).TriggerEvent
                Else
                    newEventNum = newEventNum + 1
                    NewEvent(newEventNum) = Events(A).TriggerEvent
                    newEventDelay(newEventNum) = Events(A).TriggerDelay * 6.5
                End If
            End If
        End If
    Next A
End Sub

Public Sub UpdateEvents()
'this is for evetns that have a delay to call other events
'this sub also updates the screen position for autoscroll levels
    Dim A As Integer
    Dim B As Integer
    If FreezeNPCs = True Then Exit Sub
    If GameMenu = False Then
        For B = 1 To numPlayers
            If Not (Player(B).Effect = 0 Or Player(B).Effect = 3 Or Player(B).Effect = 9 Or Player(B).Effect = 10) Then
                Exit Sub
            End If
        Next B
    End If
    If newEventNum > 0 Then
        For A = 1 To newEventNum
            If newEventDelay(A) > 0 Then
                newEventDelay(A) = newEventDelay(A) - 1
            Else
                ProcEvent NewEvent(A)
                newEventDelay(A) = newEventDelay(newEventNum)
                NewEvent(A) = NewEvent(newEventNum)
                newEventNum = newEventNum - 1
            End If
        Next A
    End If
    For A = 0 To maxSections
        If AutoX(A) <> 0 Or AutoY(A) <> 0 Then
            level(A).X = level(A).X + AutoX(A)
            level(A).Width = level(A).Width + AutoX(A)
            level(A).Y = level(A).Y + AutoY(A)
            level(A).Height = level(A).Height + AutoY(A)
            If level(A).Width > LevelREAL(A).Width Then
                level(A).Width = LevelREAL(A).Width
                level(A).X = LevelREAL(A).Width - 800
            End If
            If level(A).X < LevelREAL(A).X Then
                level(A).Width = LevelREAL(A).X + 800
                level(A).X = LevelREAL(A).X
            End If
            If level(A).Height > LevelREAL(A).Height Then
                level(A).Height = LevelREAL(A).Height
                level(A).Y = LevelREAL(A).Height - 800
            End If
            If level(A).Y < LevelREAL(A).Y Then
                level(A).Height = LevelREAL(A).Y + 800
                level(A).Y = LevelREAL(A).Y
            End If
        End If
    Next A
End Sub

Public Sub UpdateLayers()
'this is mainly for moving layers
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    
    Dim FreezeLayers As Boolean
    
    If GameMenu = False Then
        For B = 1 To numPlayers
            If Not (Player(B).Effect = 0 Or Player(B).Effect = 3 Or Player(B).Effect = 9 Or Player(B).Effect = 10) Then
                For A = 0 To 100
                    If Layer(A).Name <> "" And (Layer(A).SpeedX <> 0 Or Layer(A).SpeedY <> 0) And Layer(A).EffectStop = True Then
                        For C = 1 To numBlock
                            If Block(C).Layer = Layer(A).Name Then
                                Block(C).Location.SpeedX = 0
                                Block(C).Location.SpeedY = 0
                            End If
                        Next C
                    End If
                Next A
                FreezeLayers = True
            End If
        Next B
    End If
    
    For A = 0 To 100
        If FreezeNPCs = True Then
            If Layer(A).Name <> "" And (Layer(A).SpeedX <> 0 Or Layer(A).SpeedY <> 0) Then
                For B = 1 To numBlock
                    If Block(B).Layer = Layer(A).Name Then
                        Block(B).Location.SpeedX = 0
                        Block(B).Location.SpeedY = 0
                    End If
                Next B
            End If
        Else
            If Layer(A).Name <> "" And (Layer(A).SpeedX <> 0 Or Layer(A).SpeedY <> 0) And Not (FreezeLayers = True And Layer(A).EffectStop = True) Then
                For B = 1 To numBlock
                    If Block(B).Layer = Layer(A).Name Then
                        If Layer(A).SpeedX <> 0 Then
                            If BlocksSorted = True Then
                                For C = -FLBlocks To FLBlocks
                                    FirstBlock(C) = 1
                                    LastBlock(C) = numBlock
                                Next C
                                BlocksSorted = False
                            End If
                        End If
                        Block(B).Location.X = Block(B).Location.X + Layer(A).SpeedX
                        Block(B).Location.Y = Block(B).Location.Y + Layer(A).SpeedY
                        Block(B).Location.SpeedX = Layer(A).SpeedX
                        Block(B).Location.SpeedY = Layer(A).SpeedY
                    End If
                Next B
                For B = 1 To numBackground + numLocked
                    If Background(B).Layer = Layer(A).Name Then
                        Background(B).Location.X = Background(B).Location.X + Layer(A).SpeedX
                        Background(B).Location.Y = Background(B).Location.Y + Layer(A).SpeedY
                    End If
                Next B
                For B = 1 To numWater
                    If Water(B).Layer = Layer(A).Name Then
                        Water(B).Location.X = Water(B).Location.X + Layer(A).SpeedX
                        Water(B).Location.Y = Water(B).Location.Y + Layer(A).SpeedY
                    End If
                Next B
                For B = 1 To numNPCs
                    If NPC(B).Layer = Layer(A).Name Then
                        NPC(B).DefaultLocation.X = NPC(B).DefaultLocation.X + Layer(A).SpeedX
                        NPC(B).DefaultLocation.Y = NPC(B).DefaultLocation.Y + Layer(A).SpeedY
                        If NPC(B).Active = False Or NPC(B).Generator = True Or NPC(B).Effect <> 0 Or NPCIsACoin(NPC(B).Type) Or NPC(B).Type = 8 Or NPC(B).Type = 37 Or NPC(B).Type = 51 Or NPC(B).Type = 52 Or NPC(B).Type = 46 Or NPC(B).Type = 93 Or NPC(B).Type = 74 Or NPCIsAVine(NPC(B).Type) Or NPC(B).Type = 192 Or NPC(B).Type = 197 Or NPC(B).Type = 91 Or NPC(B).Type = 211 Or NPC(B).Type = 256 Or NPC(B).Type = 257 Or NPC(B).Type = 245 Then
                            If NPC(B).Type = 91 Or NPC(B).Type = 211 Then
                                NPC(B).Location.SpeedX = Layer(A).SpeedX
                                NPC(B).Location.SpeedY = Layer(A).SpeedY
                            ElseIf NPCIsAVine(NPC(B).Type) = True Then
                                NPC(B).Location.SpeedX = Layer(A).SpeedX
                                NPC(B).Location.SpeedY = Layer(A).SpeedY
                            End If
                            If NPC(B).Active = False Then
                                NPC(B).Location.X = NPC(B).DefaultLocation.X
                                NPC(B).Location.Y = NPC(B).DefaultLocation.Y
                                If NPC(B).Type = 8 Or NPC(B).Type = 74 Or NPC(B).Type = 93 Or NPC(B).Type = 256 Or NPC(B).Type = 245 Then
                                    NPC(B).Location.Y = NPC(B).Location.Y + NPC(B).DefaultLocation.Height
                                ElseIf NPC(B).Type = 52 And NPC(B).Direction = -1 Then
                                    NPC(B).Location.X = NPC(B).Location.X + NPC(B).DefaultLocation.Width
                                End If
                            Else
                                NPC(B).Location.X = NPC(B).Location.X + Layer(A).SpeedX
                                NPC(B).Location.Y = NPC(B).Location.Y + Layer(A).SpeedY
                            End If
                            If NPC(B).Effect = 4 Then
                                If NPC(B).Effect3 = 1 Or NPC(B).Effect3 = 3 Then
                                    NPC(B).Effect2 = NPC(B).Effect2 + Layer(A).SpeedY
                                Else
                                    NPC(B).Effect2 = NPC(B).Effect2 + Layer(A).SpeedX
                                End If
                            End If
                            If NPC(B).Active = False Then
                                If NPC(B).AttLayer <> "" Then
                                     For C = 1 To 100
                                         If NPC(B).AttLayer = Layer(C).Name Then
                                             Layer(C).SpeedX = Layer(A).SpeedX
                                             Layer(C).SpeedY = Layer(A).SpeedY
                                         End If
                                     Next C
                                 End If
                             End If
                        End If
                    End If
                Next B
                For B = 1 To numWarps
                    If Warp(B).Layer = Layer(A).Name Then
                        Warp(B).Entrance.X = Warp(B).Entrance.X + Layer(A).SpeedX
                        Warp(B).Entrance.Y = Warp(B).Entrance.Y + Layer(A).SpeedY
                        Warp(B).Exit.X = Warp(B).Exit.X + Layer(A).SpeedX
                        Warp(B).Exit.Y = Warp(B).Exit.Y + Layer(A).SpeedY
                    End If
                Next B
            End If
        End If
    Next A
End Sub


