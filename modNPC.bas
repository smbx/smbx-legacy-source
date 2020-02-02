Attribute VB_Name = "modNPC"
Option Explicit

Public Sub UpdateNPCs()
'this is 1 of the 2 clusterfuck subs in the code, be weary

'misc variables used mainly for arrays
    Dim A As Integer
    Dim B As Integer
    Dim C As Single
    Dim D As Single
    Dim E As Double
    Dim F As Single
    
    Dim tempStr As String
    Dim oldSlope As Integer 'previous sloped block the npc was on
    Dim tempNPC As NPC
    Dim HitSpot As Integer 'used for collision detection
    Dim tempHit As Double
    Dim tmpBlock As Block
    Dim tempHitBlock As Integer
    Dim tempSpeedA As Single
    Dim tempSpeedB As Single
    Dim tempTurn As Boolean 'used for turning the npc around
    Dim tempLocation As Location
    Dim tempLocation2 As Location
    Dim preBeltLoc As Location
    Dim beltCount As Single
    Dim tempBlockHit(1 To 2) As Integer 'Hit block from below code
    Dim winningBlock As Integer 'More code for hitting the block from below
    Dim numTempBlock As Integer
    Dim speedVar As Single 'percent of the NPC it should actually moved. this helps when underwater
    
    Dim tempBool As Boolean
    Dim tempBool2 As Boolean
    Dim tempBool3 As Boolean
    Dim newY As Single
    Dim straightLine As Boolean
    Dim blankBlock As Block
    Dim noBelt As Boolean
    Dim oldBeltSpeed As Single
    Dim beltFixX As Single
    Dim oldDirection As Integer
    
        'used for collision detection
    Dim fBlock As Long
    Dim lBlock As Long
    Dim fBlock2 As Long
    Dim lBlock2 As Long
    Dim bCheck2 As Integer
    Dim bCheck As Integer
    Dim newAct(1 To maxNPCs) As Integer
    Dim addBelt As Single
    Dim numAct As Integer
    Dim beltClear As Boolean 'stops belt movement when on a wall
    Dim resetBeltSpeed As Boolean
    Dim PlrMid As Double
    Dim Slope As Double
    Dim SlopeTurn As Boolean
    Dim timeStr As String
    
    Dim lyrX As Double 'for attaching to layers
    Dim lyrY As Double 'for attaching to layers
    
    NPC(0).Location.SpeedX = 0
    NPC(0).Location.SpeedY = 0
    
    If LevelMacro > 0 Then
        If PSwitchTime > 0 Then PSwitchTime = 100
        If PSwitchStop > 0 Then PSwitchStop = 100
    End If
    
    'used for the p switches
    If PSwitchStop > 0 Then 'time stop
        If PSwitchStop = Physics.NPCPSwitch Then
            StopMusic
            StartMusic -1
            PlaySound 32
        End If
        If PSwitchTime > 2 Then PSwitchTime = 2
        PSwitchStop = PSwitchStop - 1
        If PSwitchStop <= 0 Then
            FreezeNPCs = False
            StopMusic
            StartMusic Player(PSwitchPlayer).Section
        End If
    End If
    
    If FreezeNPCs = True Then 'When time is paused
        StopHit = 0
        For A = numNPCs To 1 Step -1 ' check to see if NPCs should be killed
            With NPC(A)
                If NPCIsBoot(.Type) Or NPCIsYoshi(.Type) Then
                    If .CantHurt > 0 Then
                        .CantHurt = .CantHurt - 1
                        If .CantHurt = 0 Then .CantHurtPlayer = 0
                    End If
                End If
                If .TimeLeft > 0 Then .TimeLeft = .TimeLeft - 1
                If .Immune > 0 Then .Immune = .Immune - 1
                .JustActivated = 0
                .Chat = False
                If .TimeLeft = 0 Then Deactivate A
                If .Killed > 0 Then
                    If .Location.SpeedX = 0 Then
                        .Location.SpeedX = Rnd * 2 - 1
                        If .Location.SpeedX < 0 Then
                            .Location.SpeedX = .Location.SpeedX - 0.5
                        Else
                            .Location.SpeedX = .Location.SpeedX + 0.5
                        End If
                    End If
                    KillNPC A, .Killed
                End If
            End With
        Next A
        CharStuff
        Exit Sub
    End If
    
    
    If CoinMode = True Then 'this is a cheat code
        If Lives >= 99 And Coins >= 99 Then
            CoinMode = False
        Else
            PlaySound 14
            Coins = Coins + 1
            If Coins >= 100 Then
                If Lives < 99 Then
                    Lives = Lives + 1
                    PlaySound 15
                    Coins = Coins - 100
                Else
                    Coins = 99
                End If
            End If
        End If
    End If
    
    
    
    For A = 1 To numNPCs
        With NPC(A)
            If .RespawnDelay > 0 Then
                .Reset(1) = False
                .Reset(2) = False
                .RespawnDelay = .RespawnDelay - 1
            End If
            If .Hidden = True Then Deactivate A
            If .TailCD > 0 Then
                .TailCD = .TailCD - 1
            End If
            If A > maxNPCs - 100 Then .Killed = 9
            'generator code
            If .Generator = True Then
                .Active = False
                If .Hidden = False Then
                    .TimeLeft = 0
                    .GeneratorTime = .GeneratorTime + 1
                    If .GeneratorTime >= .GeneratorTimeMax * 6.5 Then .GeneratorTime = .GeneratorTimeMax * 6.5
                    If .GeneratorActive = True Then
                        .GeneratorActive = False
                        If .GeneratorTime >= .GeneratorTimeMax * 6.5 Then
                            tempBool = False
                            For B = 1 To numNPCs
                                If B <> A And NPC(B).Active = True And NPC(B).Type <> 57 Then
                                    If CheckCollision(.Location, NPC(B).Location) = True Then tempBool = True
                                End If
                            Next B
                            If .Type <> 91 Then
                                For B = 1 To numBlock
                                    If Block(B).Hidden = False And BlockIsSizable(Block(B).Type) = False Then
                                        If CheckCollision(.Location, newLoc(Block(B).Location.X + 0.1, Block(B).Location.Y + 0.1, Block(B).Location.Width - 0.2, Block(B).Location.Height - 0.2)) = True Then tempBool = True
                                    End If
                                Next B
                                For B = 1 To numPlayers
                                    If Player(B).Dead = False And Player(B).TimeToLive = 0 Then
                                        If CheckCollision(.Location, Player(B).Location) = True Then tempBool = True
                                    End If
                                Next B
                            End If
                            If numNPCs = maxNPCs - 100 Then tempBool = True
                            If tempBool = True Then
                                .GeneratorTime = .GeneratorTimeMax
                            Else
                                .GeneratorTime = 0
                                numNPCs = numNPCs + 1
                                NPC(numNPCs) = NPC(A)
                                If .GeneratorEffect = 1 Then
                                    NPC(numNPCs).Layer = .Layer
                                    NPC(numNPCs).Effect3 = .GeneratorDirection
                                    NPC(numNPCs).Effect = 4
                                    NPC(numNPCs).Location.SpeedX = 0
                                    NPC(numNPCs).TimeLeft = 100
                                    If .GeneratorDirection = 1 Then
                                        If NPCHeightGFX(.Type) > .Location.Height Then
                                            NPC(numNPCs).Location.Y = .Location.Y + NPCHeightGFX(.Type)
                                            NPC(numNPCs).Effect2 = NPC(numNPCs).Location.Y - (NPCHeightGFX(.Type) - .Location.Height)
                                        Else
                                            NPC(numNPCs).Location.Y = .Location.Y + .Location.Height
                                            NPC(numNPCs).Effect2 = NPC(numNPCs).Location.Y
                                        End If
                                    ElseIf .GeneratorDirection = 3 Then
                                        If NPCHeightGFX(.Type) > .Location.Height Then
                                            NPC(numNPCs).Location.Y = .Location.Y - .Location.Height
                                            NPC(numNPCs).Effect2 = NPC(numNPCs).Location.Y + .Location.Height + (NPCHeightGFX(.Type) - .Location.Height)
                                        Else
                                            NPC(numNPCs).Location.Y = .Location.Y - .Location.Height
                                            NPC(numNPCs).Effect2 = NPC(numNPCs).Location.Y + .Location.Height
                                        End If
                                    ElseIf .GeneratorDirection = 2 Then
                                        NPC(numNPCs).Location.Y = NPC(numNPCs).Location.Y - 4
                                        NPC(numNPCs).Location.X = .Location.X + .Location.Width
                                        NPC(numNPCs).Effect2 = NPC(numNPCs).Location.X
                                    ElseIf .GeneratorDirection = 4 Then
                                        NPC(numNPCs).Location.Y = NPC(numNPCs).Location.Y - 4
                                        NPC(numNPCs).Location.X = .Location.X - .Location.Width
                                        NPC(numNPCs).Effect2 = NPC(numNPCs).Location.X + .Location.Width
                                    End If
                                ElseIf .GeneratorEffect = 2 Then ' projectile
                                    NPC(numNPCs).Layer = "Spawned NPCs"
                                    PlaySound 22
                                    NPC(numNPCs).Projectile = True
                                    If NPC(numNPCs).Type = 17 Then NPC(numNPCs).Projectile = False 'Normal Bullet Bills
                                    
                                    If NPC(numNPCs).Type = 45 Then NPC(numNPCs).Special = 1
                                    If .GeneratorDirection = 1 Then
                                        NPC(numNPCs).Location.SpeedY = -10
                                        NPC(numNPCs).Location.SpeedX = 0
                                        NewEffect 10, newLoc(.Location.X, .Location.Y + 16, 32, 32)
                                        If NPCIsVeggie(NPC(numNPCs).Type) = True Then
                                            NPC(numNPCs).Location.SpeedX = Rnd * 2 - 1
                                            'NPC(numNPCs).Location.SpeedY = -1
                                        End If
                                    ElseIf .GeneratorDirection = 2 Then
                                        NPC(numNPCs).Location.SpeedX = -Physics.NPCShellSpeed
                                        NewEffect 10, newLoc(.Location.X + 16, .Location.Y, 32, 32)
                                    ElseIf .GeneratorDirection = 3 Then
                                        NPC(numNPCs).Location.SpeedY = 8
                                        NPC(numNPCs).Location.SpeedX = 0
                                        NewEffect 10, newLoc(.Location.X, .Location.Y - 16, 32, 32)
                                    Else
                                        NPC(numNPCs).Location.SpeedX = Physics.NPCShellSpeed
                                        SoundPause(3) = 1
                                        NewEffect 10, newLoc(.Location.X - 16, .Location.Y, 32, 32)
                                    End If
                                End If
                                With NPC(numNPCs)
                                    .Direction = .DefaultDirection
                                    .Frame = EditorNPCFrame(.Type, .Direction)
                                    .DefaultDirection = .Direction
                                    .DefaultType = 0
                                    .Generator = False
                                    .Active = True
                                    .TimeLeft = 100
                                    .TriggerActivate = NPC(A).TriggerActivate
                                    .TriggerDeath = NPC(A).TriggerDeath
                                    .TriggerLast = NPC(A).TriggerLast
                                    .TriggerTalk = NPC(A).TriggerTalk
                                    CheckSectionNPC numNPCs
                                    If .TriggerActivate <> "" Then ProcEvent .TriggerActivate
                                    If .Type = 287 Then .Type = RandomBonus
                                End With
                            End If
                        End If
                    End If
                End If
            End If
            
            If .Type = 57 And .Hidden = False Then
                CheckSectionNPC A
                C = 0
                For B = 1 To numPlayers
                    If Player(B).Section = .Section Then C = 1
                Next B
                If C = 1 Then
                    .TimeLeft = 100
                    .Active = True
                    .JustActivated = 0
                End If
            End If
            numAct = 0
            C = 0
            
            If .TimeLeft = 1 Or .JustActivated <> 0 Then
                If .Type = 169 Or .Type = 170 Then .Frame = EditorNPCFrame(.Type, .Direction, A)
            End If
            
            If .JustActivated <> 0 Then
                If .Active = True And .TimeLeft > 1 And .Type <> 57 And .Type <> 46 And .Type <> 212 And NPCIsACoin(.Type) = False Then  'And .Type <> 47
                    If .TriggerActivate <> "" Then ProcEvent .TriggerActivate
                    tempLocation = .Location
                    tempLocation.Y = tempLocation.Y - 32
                    tempLocation.X = tempLocation.X - 32
                    tempLocation.Width = tempLocation.Width + 64
                    tempLocation.Height = tempLocation.Height + 64
                    For B = 1 To numNPCs
                        If (NPC(B).Active = False) And B <> A And NPC(B).Reset(1) = True And NPC(B).Reset(2) = True Then
                            If CheckCollision(tempLocation, NPC(B).Location) = True Then
                                numAct = numAct + 1
                                newAct(numAct) = B
                                NPC(B).Active = True
                                NPC(B).TimeLeft = .TimeLeft
                                NPC(B).JustActivated = 1
                                NPC(B).Section = .Section
                                If B < A Then
                                    If NPC(B).TriggerActivate <> "" Then ProcEvent NPC(B).TriggerActivate
                                End If
                            End If
                        ElseIf B <> A And NPC(B).Active = True And NPC(B).TimeLeft < .TimeLeft - 1 Then
                            If CheckCollision(tempLocation, NPC(B).Location) = True Then NPC(B).TimeLeft = .TimeLeft - 1
                        End If
                    Next B
                    Do While numAct > C
                        C = C + 1
                        With NPC(newAct(C))
                            If .Type <> 57 And .Type <> 46 And .Type <> 212 And .Type <> 47 And NPCIsACoin(.Type) = False Then
                                tempLocation = .Location
                                tempLocation.Y = tempLocation.Y - 32
                                tempLocation.X = tempLocation.X - 32
                                tempLocation.Width = tempLocation.Width + 64
                                tempLocation.Height = tempLocation.Height + 64
                                For B = 1 To numNPCs
                                    If (NPC(B).Active = False) And B <> A And NPC(B).Reset(1) = True And NPC(B).Reset(2) = True Then
                                        If CheckCollision(tempLocation, NPC(B).Location) = True Then
                                            numAct = numAct + 1
                                            newAct(numAct) = B
                                            NPC(B).Active = True
                                            NPC(B).TimeLeft = .TimeLeft
                                            NPC(B).JustActivated = 1
                                            NPC(B).Section = .Section
                                            If B < A Then
                                                If NPC(B).TriggerActivate <> "" Then ProcEvent NPC(B).TriggerActivate
                                            End If
                                            
                                        End If
                                    End If
                                Next B
                            End If
                        End With
                    Loop
                End If
                If .Type = 208 Then
                    For B = 1 To numNPCs
                        If NPC(B).Type <> 208 And NPC(B).Effect = 0 And NPC(B).Active = True Then
                            If NPCNoClipping(NPC(B).Type) = False Then
                                If .Location.Y < NPC(B).Location.Y Then
                                    If .Location.Y + .Location.Height > NPC(B).Location.Y + NPC(B).Location.Height Then
                                        If .Location.Y < NPC(B).Location.Y Then
                                            If .Location.Y + .Location.Height > NPC(B).Location.Y + NPC(B).Location.Height Then
                                                NPC(B).Frame = EditorNPCFrame(NPC(B).Type, NPC(B).Direction)
                                                NPC(B).Effect = 208
                                            End If
                                        End If
                                    End If
                                End If
                            End If
                        End If
                    Next B
                End If
            End If
            .tempBlock = 0
            If .Type = 60 Or .Type = 62 Or .Type = 64 Or .Type = 66 Then
                .Active = True
                .TimeLeft = 100
            End If
            
            If NPC(A).Location.Width = 32 Then
                If Not .Type = 57 And Not .Type = 84 Then


'If .Type = 58 Or .Type = 21 Then
                    If Not (NPCIsAnExit(.Type) Or .Type = 8 Or .Type = 51 Or .Type = 52 Or .Type = 74 Or .Type = 256 Or .Type = 257 Or .Type = 93 Or .Type = 245) Then
                        NPC(A).Location.X = NPC(A).Location.X + 0.015
                    End If
                    
                    
                    NPC(A).Location.Width = NPC(A).Location.Width - 0.03
                End If
            ElseIf NPC(A).Location.Width = 256 Then
                NPC(A).Location.Width = 255.9
            ElseIf NPC(A).Location.Width = 128 Then
                NPC(A).Location.Width = 127.9
            End If
            
            If (.Active = True And .TimeLeft > 1) Then
            
                If .Type = 45 And .Special = 1 Then
                    If .Projectile = True Then
                        .Special2 = 0
                    Else
                        .Special2 = .Special2 + 1
                        If .Special2 >= 450 Then
                            NewEffect 10, .Location
                            .Killed = 9
                        End If
                    End If
                End If
            
                If NPCIsABlock(.Type) Or NPCIsAHit1Block(.Type) Or (NPCCanWalkOn(.Type) = True And Not (NPCIsCheep(.Type) And .Special = 2)) Then
                    If .Projectile = False And .HoldingPlayer = 0 And .Effect = 0 And Not (.Type = 45 And .Special = 1) And Not ((.Type = 46 Or .Type = 212) And .Special = 1) Or .Type = 58 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70 Then
                        numBlock = numBlock + 1
                        Block(numBlock) = blankBlock
                        Block(numBlock).Type = 0
                        Block(numBlock).Location = .Location
                        Block(numBlock).Location.Y = Int(Block(numBlock).Location.Y + 0.02)
                        Block(numBlock).IsPlayer = .standingOnPlayer
                        Block(numBlock).standingOnPlayerY = .standingOnPlayerY
                        Block(numBlock).IsReally = A
                        If .Type = 56 Then Block(numBlock).Type = 25
                        If NPCIsAHit1Block(.Type) = True Or (NPCCanWalkOn(.Type) = True And Not NPCIsABlock(.Type)) Then Block(numBlock).Type = 26
                        If NPCCanWalkOn(.Type) = True And NPCIsAHit1Block(.Type) = False And NPCIsABlock(.Type) = False Then Block(numBlock).noProjClipping = True
                        With Block(numBlock)
                            If NPC(A).Type = 26 And .Location.Height <> 32 Then
                                .Location.Y = .Location.Y - 16
                                .Location.Height = .Location.Height + 16
                            End If
                            .Location.SpeedX = .Location.SpeedX + NPC(A).BeltSpeed
                            .IsNPC = NPC(A).Type
                        End With
                        numTempBlock = numTempBlock + 1
                        .tempBlock = numBlock
                    End If
                End If
            End If
        End With
    Next A
    For A = 1 To numPlayers
        With Player(A)
            If .Mount = 2 Then
                numBlock = numBlock + 1
                Block(numBlock) = blankBlock
                Block(numBlock).Type = 25
                Block(numBlock).Location = .Location
                With Block(numBlock)
                    .Location.X = Int(.Location.X) + 1
                    .Location.Y = Int(.Location.Y) + 1
                    .Location.Width = Int(.Location.Width) + 1
                    .IsPlayer = A
                End With
                numTempBlock = numTempBlock + 1
            End If
        End With
    Next A
    If numTempBlock > 1 Then
        qSortBlocksX numBlock + 1 - numTempBlock, numBlock
    End If
    For A = numBlock + 1 - numTempBlock To numBlock
        NPC(Block(A).IsReally).tempBlock = A
    Next A
    For A = 1 To numNPCs
        Physics.NPCGravity = Physics.NPCGravityReal
        With NPC(A)
            
            lyrX = .Location.X
            lyrY = .Location.Y
            
            If .RealSpeedX <> 0 Then
                .Location.SpeedX = .RealSpeedX
                .RealSpeedX = 0
            End If
        
        
            StopHit = 0
            If .Projectile = False Or .Type = 50 Or .Type = 78 Then .Multiplier = 0
            If .Immune > 0 Then .Immune = .Immune - 1
            If .Type = 56 And .TimeLeft > 1 Then .TimeLeft = 100
            If .JustActivated <> 0 Then
                If .Active = True Then
                    If .Type = 197 Then
                        tempLocation = NPC(A).Location
                        tempLocation.Height = 8000
                        C = 0
                        For B = 1 To numBlock
                            If CheckCollision(tempLocation, Block(B).Location) = True Then
                                If C = 0 Then
                                    C = B
                                Else
                                    If Block(B).Location.Y < Block(C).Location.Y Then C = B
                                End If
                            End If
                        Next B
                        If C > 0 Then
                            .Special2 = Block(C).Location.Y + 4
                            .Location.Y = Block(C).Location.Y - .Location.Height
                            .Special = 1
                        End If
                    ElseIf .Type = 199 Then 'blaarg
                        .Location.Y = .DefaultLocation.Y + .Location.Height + 36
                        
                        
                    
                    ElseIf .Type = 17 Or .Type = 18 Or (NPCIsCheep(.Type) And .Special = 2) Or .Type = 42 Then 'Special Start for Jumping Fish and Bullet Bills
                        If .TimeLeft <= 1 Then
                            .Active = False
                            .TimeLeft = 0
                        ElseIf .Direction = -1 And .Location.X < Player(.JustActivated).Location.X Then
                            .Active = False
                            .TimeLeft = 0
                        ElseIf .Direction = 1 And .Location.X > Player(.JustActivated).Location.X Then
                            .Active = False
                            .TimeLeft = 0
                        ElseIf (NPCIsCheep(.Type) And .Special = 2) Then
                            .Location.Y = level(Player(.JustActivated).Section).Height - 0.1
                            .Location.SpeedX = (1 + (.Location.Y - .DefaultLocation.Y) * 0.005) * .Direction
                            .Special5 = 1
                        ElseIf Not .Type = 42 Then
                            PlaySound 22
                        End If
                    ElseIf .Type = 21 Then
                        .Special = 100
                    End If
                End If
                If .Type = 84 Or .Type = 181 Then .Special = Int(Rnd * 200)
                .JustActivated = 0
                .CantHurt = 0
                .CantHurtPlayer = 0
                If .Type = 21 Then .Projectile = False
                If .Type = 22 Then .Projectile = False
            ElseIf Not (NPCIsCheep(.Type) And .Special = 2) And Not .Type = 12 Then
                If GameMenu = False And .Location.Y > level(.Section).Height + 16 Then
                    NPCHit A, 9
                End If
            End If
            

            
'Normal operations start here
            


            If NPCIsAVine(.Type) Then
                '.Location.SpeedX = 0
                '.Location.SpeedY = 0
                If .Type = 213 Or .Type = 214 Then
                    .Frame = BlockFrame(5)
                ElseIf .Type >= 215 And .Type <= 220 Then
                    .Frame = SpecialFrame(7)
                End If

            ElseIf .Active = True And .Killed = 0 And .Generator = False Then
            
            
                speedVar = 1
                If .Slope > 0 And Not (NPCIsAShell(.Type) Or (.Type = 45 And .Special = 1)) Then
                    If (.Location.SpeedX > 0 And BlockSlope(Block(.Slope).Type) = -1) Or .Location.SpeedX < 0 And BlockSlope(Block(.Slope).Type) = 1 Then
                        If Not NPCCanWalkOn(.Type) Or NPCIsABlock(.Type) Or .Type = 78 Then speedVar = (1 - Block(.Slope).Location.Height / Block(.Slope).Location.Width * 0.4)
                    End If
                End If
                speedVar = 1
                
                If .Projectile = False Then speedVar = speedVar * NPCSpeedvar(.Type)
            
'water check

                'Things immune to water's effects
                If .Type = 12 Or .Type = 17 Or .Type = 18 Or .Type = 30 Or .Type = 38 Or .Type = 42 Or .Type = 43 Or .Type = 44 Or .Type = 85 Or .Type = 87 Or .Type = 108 Or .Type = 171 Or .Type = 292 Or .Type = 197 Or .Type = 202 Or .Type = 210 Or .Type = 225 Or .Type = 226 Or .Type = 227 Or .Type = 47 Or .Type = 284 Or .Type = 179 Or .Type = 270 Or .Type = 269 Or (NPCIsACoin(.Type) And .Special = 0) Or .Type = 266 Or .Type = 259 Or .Type = 260 Then
                    .Wet = 0
                    .Quicksand = 0
                Else
                    If .Wet > 0 Then .Wet = .Wet - 1
                    If .Quicksand > 0 Then .Quicksand = .Quicksand - 1
                    If UnderWater(.Section) = True Then .Wet = 2
                    For B = 1 To numWater
                        If Water(B).Hidden = False Then
                            If CheckCollision(.Location, Water(B).Location) = True Then
                                If .Wet = 0 And NPCIsACoin(.Type) = False Then
                                    If .Location.SpeedY >= 1 Then
                                        tempLocation.Width = 32
                                        tempLocation.Height = 32
                                        tempLocation.X = .Location.X + .Location.Width / 2 - tempLocation.Width / 2
                                        tempLocation.Y = .Location.Y + .Location.Height - tempLocation.Height
                                        NewEffect 114, tempLocation
                                    End If
                                    If Not (NPCIsCheep(.Type) And .Special = 1) And .Type <> 34 And .Type <> 13 Then
                                        If .Location.SpeedY > 0.5 Then .Location.SpeedY = 0.5
                                        If .Location.SpeedY < -0.5 Then .Location.SpeedY = -0.5
                                    Else
                                        If .Location.SpeedY > 2 Then .Location.SpeedY = 2
                                        If .Location.SpeedY < -2 Then .Location.SpeedY = -2
                                    End If
                                    If .Type = 104 Then
                                        .Special = .Location.SpeedY
                                    End If
                                End If
                                If Water(B).Quicksand = True Then .Quicksand = 2
                                .Wet = 2
                            End If
                        End If
                    Next B
                End If
                If .Wet = 1 And .Location.SpeedY < -1 Then
                    tempLocation.Width = 32
                    tempLocation.Height = 32
                    tempLocation.X = .Location.X + .Location.Width / 2 - tempLocation.Width / 2
                    tempLocation.Y = .Location.Y + .Location.Height - tempLocation.Height
                    NewEffect 114, tempLocation
                End If
                
                
                If .Wet > 0 Then
                    If .Type = 263 Then
                        .Projectile = True
                        Physics.NPCGravity = -Physics.NPCGravityReal * 0.2
                    Else
                        Physics.NPCGravity = Physics.NPCGravityReal * 0.2
                    End If
                    If .Type = 195 And .Special4 = 1 Then
                        .Special5 = 0
                    ElseIf Not NPCIsCheep(.Type) And .Type <> 190 And .Type <> 205 And .Type <> 206 And .Type <> 207 Then
                        speedVar = speedVar * 0.5
                    ElseIf NPCIsCheep(.Type) And .Special = 2 And .Location.SpeedY > 0 Then
                        speedVar = speedVar * 0.5
                    End If
                    If .Location.SpeedY >= 3 Then .Location.SpeedY = 3 'Terminal Velocity in water
                    If .Location.SpeedY < -3 Then .Location.SpeedY = -3
                ElseIf Not (.Type <> 190 And NPCIsCheep(.Type) = False) Then
                    .WallDeath = .WallDeath + 2
                    If .WallDeath >= 10 Then .WallDeath = 10
                End If
                If .Quicksand > 0 And NPCNoClipping(.Type) = False Then
                    .Location.SpeedY = .Location.SpeedY + 1
                    If .Location.SpeedY < -1 Then
                        .Location.SpeedY = -1
                    ElseIf .Location.SpeedY > 0.5 Then
                        .Location.SpeedY = 0.5
                    End If
                    speedVar = speedVar * 0.3
                End If

            
            

                If .Type = 147 Then
                    B = Int(Rnd * 9)
                    .Type = 139 + B
                    If .Type = 147 Then .Type = 92
                    .Location.X = .Location.X + .Location.Width / 2
                    .Location.Y = .Location.Y + .Location.Height / 2
                    .Location.Width = NPCWidth(.Type)
                    .Location.Height = NPCHeight(.Type)
                    .Location.X = .Location.X - .Location.Width / 2
                    .Location.Y = .Location.Y - .Location.Height / 2
                End If
                If .Text <> "" Then
                    .Chat = False
                    tempLocation = .Location
                    tempLocation.Y = tempLocation.Y - 25
                    tempLocation.Height = tempLocation.Height + 50
                    tempLocation.X = tempLocation.X - 25
                    tempLocation.Width = tempLocation.Width + 50
                    For B = 1 To numPlayers
                        If CheckCollision(tempLocation, Player(B).Location) = True Then .Chat = True
                    Next B
                End If
                oldDirection = .Direction
                If .Type = 17 Or .Type = 18 Then
                    If .CantHurt > 0 Then
                        .CantHurt = 10000
                        If .Type = 18 Then .Location.SpeedX = 4 * .Direction
                    End If
                    If .TimeLeft > 3 And BattleMode = False Then .TimeLeft = 3
                End If
                
                If .Type = 267 Or .Type = 268 Or .Type = 280 Or .Type = 281 Then 'koopalings
                    If .TimeLeft > 1 Then .TimeLeft = Physics.NPCTimeOffScreen

                End If
                
                CheckSectionNPC A
                If (.Type = 86 Or .Type = 259 Or .Type = 260) And .TimeLeft > 1 Then
                    .TimeLeft = 100
                End If
                If Not (.Type = 13 Or (NPCIsCheep(.Type) And .Special = 2) Or .Type = 50 Or .Type = 56 Or .Type = 60 Or .Type = 62 Or .Type = 64 Or .Type = 66 Or .Type = 86 Or NPCIsYoshi(.Type)) And .HoldingPlayer = 0 Then
                    C = 0
                    For B = 1 To numPlayers
                        If Player(B).Section = .Section Then C = 1
                    Next B
                    If C = 0 And .TimeLeft > 1 Then .TimeLeft = 0
                End If
                If (.Type = 225 Or .Type = 226 Or .Type = 227) And .TimeLeft > 10 Then .TimeLeft = 100
                If .TimeLeft > 10 And NoTurnBack(.Section) = True Then .TurnBackWipe = True
                If .TimeLeft < 1 Then
                    Deactivate A
                End If
                .TimeLeft = .TimeLeft - 1
                If .Effect = 0 Then
                
                
                
                'this code is for NPCs that are being held by a player
                
                    If .HoldingPlayer > 0 Then 'NPC is held
                        .standingOnPlayer = 0
                        If .Type = 56 Then
                            Player(.HoldingPlayer).HoldingNPC = 0
                            .HoldingPlayer = 0
                        End If
                        If Player(.HoldingPlayer).HoldingNPC = A And Player(.HoldingPlayer).TimeToLive = 0 And Player(.HoldingPlayer).Dead = False Then  'Player and NPC are on the same page
                            .Multiplier = 0
                            If .Type = 159 Then
                                Player(.HoldingPlayer).HoldingNPC = 0
                                .HoldingPlayer = 0
                                .Killed = 9
                                NewEffect 10, .Location
                            End If
                            If NPCIsYoshi(.Type) = True Then
                                .Special = .Type
                                .Type = 96
                            End If
                            If .Type = 91 Then
                                If .Special = 0 Then .Special = 147
                                .Generator = False
                                .Frame = 0
                                .Type = .Special
                                .Special = 0
                                If NPCIsYoshi(.Type) Then
                                    .Special = .Type
                                    .Type = 96
                                End If
                                If Not (.Type = 21 Or .Type = 22 Or .Type = 26 Or .Type = 31 Or .Type = 32 Or .Type = 238 Or .Type = 239 Or .Type = 193 Or .Type = 191 Or .Type = 35 Or .Type = 193 Or .Type = 49 Or NPCIsAnExit(.Type)) Then
                                    .DefaultType = 0
                                End If
                                .Location.Height = NPCHeight(.Type)
                                .Location.Width = NPCWidth(.Type)
                                If .Type = 147 Then
                                    B = Int(Rnd * 9)
                                    .Type = 139 + B
                                    If .Type = 147 Then .Type = 92
                                    .Location.X = .Location.X + .Location.Width / 2
                                    .Location.Y = .Location.Y + .Location.Height / 2
                                    .Location.Width = NPCWidth(.Type)
                                    .Location.Height = NPCHeight(.Type)
                                    .Location.X = .Location.X - .Location.Width / 2
                                    .Location.Y = .Location.Y - .Location.Height / 2
                                End If
                            End If
                            If .Type = 45 Then
                                .Special = 1
                            End If
                            If .Type = 133 Then
                                .Location.X = .Location.X + .Location.Width / 2
                                .Location.Y = .Location.Y + .Location.Height / 2
                                .Type = 138
                                .Location.Height = NPCHeight(.Type)
                                .Location.Width = NPCWidth(.Type)
                                .Location.X = .Location.X - .Location.Width / 2
                                .Location.Y = .Location.Y - .Location.Height / 2
                            End If
                            .TimeLeft = 100
                            .BeltSpeed = 0
                            If .Type = (NPCIsCheep(.Type) And .Special = 2) Then .Special5 = 0
                            .Direction = Player(.HoldingPlayer).Direction 'Face the player
                            .Location.SpeedY = Player(.HoldingPlayer).Location.SpeedY
                            .Location.SpeedX = 0
                            If Not (.Type = 195 Or .Type = 22 Or .Type = 26 Or .Type = 32 Or .Type = 238 Or .Type = 239 Or .Type = 193 Or .Type = 35 Or .Type = 191 Or .Type = 193 Or .Type = 49 Or .Type = 134 Or (.Type >= 154 And .Type <= 157) Or .Type = 31 Or .Type = 240 Or .Type = 278 Or .Type = 279 Or .Type = 292) Then
                                For B = 1 To numNPCs
                                    If B <> A And NPC(B).Active = True And (NPC(B).HoldingPlayer = 0 Or (BattleMode = True And NPC(B).HoldingPlayer <> .HoldingPlayer)) And Not NPCIsABonus(NPC(B).Type) And (Not NPC(B).Type = 13 Or (BattleMode = True And NPC(B).CantHurtPlayer <> .HoldingPlayer)) And (Not NPC(B).Type = 265 Or (BattleMode = True And NPC(B).CantHurtPlayer <> .HoldingPlayer)) And Not NPC(B).Type = 21 And Not NPC(B).Type = 22 And Not NPC(B).Type = 26 And Not NPC(B).Type = 31 And Not NPC(B).Type = 32 And Not NPC(B).Type = 238 And NPC(B).Type <> 239 And Not NPC(B).Type = 191 And Not NPC(B).Type = 35 And Not NPC(B).Type = .Type = 193 And Not NPC(B).Type = 37 And Not NPC(B).Type = 180 And Not NPC(B).Type = 38 And Not NPC(B).Type = 39 And Not (NPC(B).Type = 45 And NPC(B).Special = 0) And Not NPC(B).Type = 91 And Not NPC(B).Type = 159 And Not NPC(B).Type = 195 And Not (NPC(B).Type = 30 And NPC(B).Projectile = True) And NPC(B).Type <> 241 And NPC(B).Type <> 263 And NPC(B).Type <> 291 Then
                                       If .CantHurtPlayer <> NPC(B).CantHurtPlayer And NPC(B).Killed = 0 And (Player(.HoldingPlayer).StandingOnNPC <> B) And NPC(B).Inert = False Then
                                            If CheckCollision(.Location, NPC(B).Location) = True Then
                                                NPCHit B, 3, A
                                                If NPC(B).Killed > 0 Then
                                                    NPC(B).Location.SpeedX = Physics.NPCShellSpeed * 0.5 * -Player(.HoldingPlayer).Direction
                                                    NPCHit A, 5, B
                                                End If
                                                If .Killed > 0 Then .Location.SpeedX = Physics.NPCShellSpeed * 0.5 * Player(.HoldingPlayer).Direction
                                                Exit For
                                            End If
                                        End If
                                    End If
                                Next B
                            End If
                            If .Type = 237 Or .Type = 263 Then   'Yoshi Ice
                                If Rnd * 100 > 93 Then
                                    tempLocation.Height = EffectHeight(80)
                                    tempLocation.Width = EffectWidth(80)
                                    tempLocation.SpeedX = 0
                                    tempLocation.SpeedY = 0
                                    tempLocation.X = .Location.X - tempLocation.Width / 2 + Rnd * .Location.Width - 4
                                    tempLocation.Y = .Location.Y - tempLocation.Height / 2 + Rnd * .Location.Height - 4
                                    NewEffect 80, tempLocation
                                End If
                            End If
                        Else 'Player and NPC are not on the same page
                            Player(.HoldingPlayer).HoldingNPC = 0
                            If .Type = 272 Then .Projectile = True
                            .Location.SpeedX = 0
                            .Location.SpeedY = 0
                            If .Type = 29 Then
                                .Killed = 3
                                .Direction = -.Direction
                            End If
                            If .Type = 17 Then
                                PlaySound 22
                                .Location.SpeedX = 5 * .Direction
                                .Projectile = True
                                .CantHurt = 1000
                                .CantHurtPlayer = .HoldingPlayer
                            End If
                            .HoldingPlayer = 0
                        End If
                    Else 'NPC is not held
                        If .CantHurt <= 0 Then .CantHurtPlayer = 0
                        tempHit = 0
                        tempBlockHit(1) = 0
                        tempBlockHit(2) = 0
                        winningBlock = 0
                        If LevelWrap(.Section) = True And .Type <> 30 And .Type <> 108 Then  'Level wraparound
                              If .Location.X + .Location.Width < level(.Section).X Then
                                  .Location.X = level(.Section).Width - 1
                              ElseIf .Location.X > level(.Section).Width Then
                                  .Location.X = level(.Section).X - .Location.Width + 1
                              End If
                        End If
                        If NoTurnBack(.Section) = True And .Location.X < level(.Section).X - .Location.Width - 32 Then NPCHit A, 9
                        If .CantHurt > 0 Then
                            If Not .Type = 21 Then .CantHurt = .CantHurt - 1
                        Else
                            .CantHurtPlayer = 0
                        End If
                        If .Projectile = True Then
                            If .CantHurtPlayer <> 0 Then .BattleOwner = .CantHurtPlayer
                        Else
                            .BattleOwner = 0
                        End If
                        If NPCIsAShell(.Type) Then
                            .Special4 = .Special4 - 1
                            If .Special4 < 0 Then .Special4 = 0
                        End If
                        If .TurnAround = True Then
                            If (.Type = 267 Or .Type = 280) And .Special = 0 Then  'larry koopa
                                If Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 < .Location.X + .Location.Width / 2 Then
                                    If .Special2 < 0 Then
                                        .Special3 = .Special3 + 30
                                    End If
                                    .Special2 = -1
                                Else
                                    If .Special2 > 0 Then
                                        .Special3 = .Special3 + 30
                                    End If
                                    .Special2 = 1
                                End If
                                
                            End If
                        
                            If .Type = 265 Then NPCHit A, 3, A
                            If NPCIsAShell(.Type) = True And .Location.SpeedX <> 0 And .Special4 = 0 Then
                                .Special4 = 5
                                tempLocation.Height = 0
                                tempLocation.Width = 0
                                tempLocation.Y = .Location.Y + .Location.Height / 2 - 16
                                tempLocation.X = .Location.X - 16
                                If .Direction = 1 Then tempLocation.X = .Location.X + .Location.Width - 16
                                NewEffect 132, tempLocation
                            End If
                            If .Type = 179 Then
                                .Special2 = -.Special2
                            End If
                            If Not (NPCIsAShell(.Type)) And Not .Type = 13 And Not .Type = 78 And Not .Type = 17 And Not .Type = 86 And Not NPCIsABot(.Type) And .Type <> 40 And .Type <> 133 And NPCIsVeggie(.Type) = False And .Type <> 160 And .Type <> 206 And .Type <> 205 And .Type <> 207 And .Type <> 265 And .Type <> 266 Then 'Don't turn around if a shell or a fireball
                                .Location.SpeedX = -.Location.SpeedX
                                If .tempBlock > 0 Then Block(.tempBlock).Location.SpeedX = -Block(.tempBlock).Location.SpeedX
                            End If
                            .TurnAround = False
                        End If

                        If .Type = 179 Then PlaySound 74 'play saw sound
'NPC Movement Code
                        

                        
                    'Default Movement Code
                        If (NPCDefaultMovement(.Type) = True Or (NPCIsCheep(.Type) = True And .Special <> 2)) And Not ((.Type = 55 Or .Type = 119) And .Special > 0) And .Type <> 91 Then
                            If .Direction = 0 Then
                                If Int(Rnd * 2) = 0 Then
                                    .Direction = -1
                                Else
                                    .Direction = 1
                                End If
                            End If
                            If NPCCanWalkOn(.Type) = True Then
                                If .Location.SpeedX < Physics.NPCWalkingOnSpeed And .Location.SpeedX > -Physics.NPCWalkingOnSpeed Then
                                    If .Projectile = False Then .Location.SpeedX = Physics.NPCWalkingOnSpeed * .Direction
                                End If
                                If .Location.SpeedX > Physics.NPCWalkingOnSpeed Then
                                    .Location.SpeedX = .Location.SpeedX - 0.05
                                    If .Projectile = False Then .Location.SpeedX = .Location.SpeedX - 0.1
                                ElseIf .Location.SpeedX < -Physics.NPCWalkingOnSpeed Then
                                    .Location.SpeedX = .Location.SpeedX + 0.05
                                    If .Projectile = False Then .Location.SpeedX = .Location.SpeedX + 0.1
                                End If
                            ElseIf .Type = 125 Then
                                If .Location.SpeedX < 2 And .Location.SpeedX > -2 Then
                                    If .Projectile = False Then .Location.SpeedX = 2 * .Direction
                                End If
                                If .Location.SpeedX > 2 Then
                                    .Location.SpeedX = .Location.SpeedX - 0.05
                                ElseIf .Location.SpeedX < -2 Then
                                    .Location.SpeedX = .Location.SpeedX + 0.05
                                End If
                            ElseIf Not (.Type >= 117 And .Type <= 120 And .Projectile = True) Then
                                If .Location.SpeedX < Physics.NPCWalkingSpeed And .Location.SpeedX > -Physics.NPCWalkingSpeed Then
                                    If .Projectile = False Then
                                        .Location.SpeedX = Physics.NPCWalkingSpeed * .Direction
                                    End If
                                End If
                                If .Location.SpeedX > Physics.NPCWalkingSpeed Then
                                    .Location.SpeedX = .Location.SpeedX - 0.05
                                ElseIf .Location.SpeedX < -Physics.NPCWalkingSpeed Then
                                    .Location.SpeedX = .Location.SpeedX + 0.05
                                End If
                            End If
                        ElseIf .Type = 203 Then
                            If .Location.SpeedX > -2 And .Location.SpeedX < 2 Then
                                .Location.SpeedX = 2 * .Direction
                            End If
                        ElseIf .Type = 204 Then
                            If .Location.SpeedX > -2.5 And .Location.SpeedX < 2.5 Then
                                .Location.SpeedX = 2.5 * .Direction
                            End If
                            
            'Slow things down that shouldnt move
                        ElseIf .Type = 21 Or .Type = 22 Or .Type = 25 Or .Type = 26 Or .Type = 31 Or .Type = 32 Or .Type = 238 Or .Type = 239 Or .Type = 35 Or .Type = 191 Or .Type = 193 Or (.Type = 40 And .Projectile = True) Or .Type = 49 Or .Type = 58 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70 Or (NPCIsVeggie(.Type) And .Projectile = False) Or (.Type = 29 And .Projectile = True) Or (.Projectile = True And (.Type = 54 And .Type = 15)) Or .Type = 75 Or .Type = 84 Or .Type = 181 Or .Type = 94 Or .Type = 198 Or .Type = 96 Or .Type = 134 Or .Type = 137 Or .Type = 101 Or .Type = 102 Or (NPCIsYoshi(.Type) And .Special = 0) Or (.Type >= 154 And .Type <= 157) Or .Type = 166 Or (.Type = 39 And .Projectile = True) Or .Type = 170 Or .Type = 169 Or .Type = 183 Or .Type = 188 Or .Type = 97 Or .Type = 196 Or .Type = 182 Or .Type = 240 Or .Type = 241 Or .Type = 249 Or .Type = 250 Or .Type = 254 Or .Type = 255 Or .Type = 278 Or .Type = 279 Or .Type = 277 Or .Type = 264 Or .Type = 288 Or .Type = 275 Then
                            If .Location.SpeedX > 0 Then
                                .Location.SpeedX = .Location.SpeedX - 0.05
                            ElseIf .Location.SpeedX < 0 Then
                                .Location.SpeedX = .Location.SpeedX + 0.05
                            End If
                            If .Location.SpeedX >= -0.05 And .Location.SpeedX <= 0.05 Then
                                .Location.SpeedX = 0
                            End If
                            If .Location.SpeedY >= -Physics.NPCGravity And .Location.SpeedY <= Physics.NPCGravity Then
                                If .Location.SpeedX > 0 Then
                                    .Location.SpeedX = .Location.SpeedX - 0.3
                                ElseIf .Location.SpeedX < 0 Then
                                    .Location.SpeedX = .Location.SpeedX + 0.3
                                End If
                                If .Location.SpeedX >= -0.3 And .Location.SpeedX <= 0.3 Then .Location.SpeedX = 0
                            End If
                        ElseIf .Type = 78 Then
                            .Projectile = True
                            .Direction = .DefaultDirection
                            .Location.SpeedX = 1 * .DefaultDirection
                            For B = 1 To numPlayers
                                If Not (Player(B).Effect = 0 Or Player(B).Effect = 3) Then
                                    .Location.SpeedX = 0
                                    .Location.SpeedY = 0
                                End If
                            Next B
                        'Mushroom Movement Code
                        ElseIf .Type = 9 Or .Type = 273 Or .Type = 90 Or .Type = 153 Or .Type = 184 Or .Type = 185 Or .Type = 186 Or .Type = 187 Or .Type = 163 Or .Type = 164 Then
                            If .Direction = 0 Then 'Move toward the closest player
                                C = 0
                                For B = 1 To numPlayers
                                    If Player(B).Dead = False And Player(B).Section = .Section Then
                                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                            .Direction = -Player(B).Direction
                                        End If
                                    End If
                                Next B
                            End If
                            If .Location.SpeedX < Physics.NPCMushroomSpeed And .Location.SpeedX > -Physics.NPCMushroomSpeed Then
                                If .Projectile = False Then .Location.SpeedX = Physics.NPCMushroomSpeed * .Direction
                            End If
                            If .Location.SpeedX > Physics.NPCMushroomSpeed Then
                                .Location.SpeedX = .Location.SpeedX - 0.05
                            ElseIf .Location.SpeedX < -Physics.NPCMushroomSpeed Then
                                .Location.SpeedX = .Location.SpeedX + 0.05
                            End If
                        ElseIf .Type = 194 Then
                            .Projectile = True
                            C = 0
                            For B = 1 To numPlayers
                                If Player(B).Dead = False And Player(B).Section = .Section Then
                                    If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                        C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                        If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                                            .Direction = -1
                                        Else
                                            .Direction = 1
                                        End If
                                    End If
                                End If
                            Next B
                            .Location.SpeedX = .Location.SpeedX + 0.1 * .Direction
                            If .Location.SpeedX < -4 Then .Location.SpeedX = -4
                            If .Location.SpeedX > 4 Then .Location.SpeedX = 4
                        'Yoshi Fireball
                        ElseIf .Type = 108 Then
                            .Projectile = True
                            If .Location.SpeedX = 0 Then .Location.SpeedX = 5 * .Direction
                        'bully
                        ElseIf .Type = 168 Then
                            If .Projectile = False And .Special2 = 0 Then
                                C = 0
                                For B = 1 To numPlayers
                                    If Player(B).Dead = False And Player(B).Section = .Section Then
                                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                            If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                                                .Direction = -1
                                            Else
                                                .Direction = 1
                                            End If
                                        End If
                                    End If
                                Next B
                                .Location.SpeedX = .Location.SpeedX + 0.05 * .Direction
                                If .Location.SpeedX >= 3 Then .Location.SpeedX = 3
                                If .Location.SpeedX <= -3 Then .Location.SpeedX = -3
                            Else
                                If .Location.SpeedX > 0.1 Then
                                    .Location.SpeedX = .Location.SpeedX - 0.075
                                ElseIf .Location.SpeedX < -0.1 Then
                                    .Location.SpeedX = .Location.SpeedX + 0.075
                                End If
                                If .Location.SpeedX >= -0.1 And .Location.SpeedX <= 0.1 Then
                                    .Special2 = 0
                                End If
                            End If
                        ElseIf .Type = 190 Then
                            If .Special = 1 Then
                                .Location.SpeedX = 2 * .Direction
                            End If
                            
                        'Big Koopa Movement Code
                        ElseIf .Type = 15 Then
                            If .Location.SpeedX < 0 Then
                                .Direction = -1
                            Else
                                .Direction = 1
                            End If
                            If .Special = 0 Or .Special = 3 Then
                                If .Location.SpeedX < 3.5 And .Location.SpeedX > -3.5 Then
                                    .Location.SpeedX = .Location.SpeedX + (0.1 * .Direction)
                                End If
                                If .Location.SpeedX > 3.5 Then
                                    .Location.SpeedX = .Location.SpeedX - 0.05
                                ElseIf .Location.SpeedX < -3.5 Then
                                    .Location.SpeedX = .Location.SpeedX + 0.05
                                End If
                                If .Special = 3 Then .Location.SpeedY = -6
                            ElseIf .Special = 2 Then
                                .Location.SpeedX = .Location.SpeedX + (0.2 * .Direction)
                            ElseIf .Special = 3 Then
                                .Location.SpeedY = -6
                            Else
                                If .Location.SpeedX > 0 Then
                                    .Location.SpeedX = .Location.SpeedX - 0.05
                                ElseIf .Location.SpeedX < 0 Then
                                    .Location.SpeedX = .Location.SpeedX + 0.05
                                End If
                                If .Location.SpeedX > -0.5 And .Location.SpeedX < 0.5 Then .Location.SpeedX = 0.0001 * .Direction
                            End If
                        'spiney eggs
                        ElseIf .Type = 48 Then
                            If .CantHurt > 0 Then
                                .Projectile = True
                                .CantHurt = 100
                            Else
                                C = 0
                                For B = 1 To numPlayers
                                    If Player(B).Dead = False And Player(B).Section = .Section Then
                                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                            If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                                                .Direction = -1
                                            Else
                                                .Direction = 1
                                            End If
                                        End If
                                    End If
                                Next B
                                If .Direction = 1 And .Location.SpeedX < 4 Then .Location.SpeedX = .Location.SpeedX + 0.04
                                If .Direction = -1 And .Location.SpeedX > -4 Then .Location.SpeedX = .Location.SpeedX - 0.04
                            End If
                        ElseIf .Type = 17 Or .Type = 18 Then
                            If .CantHurt < 1000 Then .Location.SpeedX = 4 * .Direction
                        ElseIf .Type = 42 Then
                            .Location.SpeedX = 2 * .Direction
                        End If
                        'yoshi
                        If NPCIsYoshi(.Type) Then
                            If .Special = 0 Then
                                If .Location.SpeedY = 0 Or .Slope > 0 Then
                                    If .Wet = 0 Then
                                        .Location.SpeedY = -2.1
                                    Else
                                        .Location.SpeedY = -1.1
                                    End If
                                End If
                            Else
                                If .Location.SpeedX < 3 And .Location.SpeedX > -3 Then
                                    If .Projectile = False Then .Location.SpeedX = 3 * .Direction
                                End If
                            End If
                        End If
                        If Not .Type = 39 And Not .Type = 46 And Not .Type = 212 And Not .Type = 56 And Not .Type = 57 And Not .Type = 60 And Not .Type = 62 And Not .Type = 64 And Not .Type = 66 And Not .Type = 84 And Not .Type = 181 And Not .Type = 85 And Not .Type = 22 And Not .Type = 49 And Not .Type = 50 And Not (.Type >= 104 And .Type <= 106) Then
                            If .Location.SpeedX < 0 Then 'Find the NPCs direction
                                .Direction = -1
                            ElseIf .Location.SpeedX > 0 Then
                                .Direction = 1
                            End If
                        End If
                        'Reset Speed when no longer a projectile
                        'If Not (NPCIsAShell(.Type) Or .Type = 8 Or .Type = 93 Or .Type = 74 Or .Type = 51 Or .Type = 52 Or .Type = 12 Or .Type = 14 Or .Type = 13 Or .Type = 15 Or NPCIsABonus(.Type) Or .Type = 17 Or .Type = 18 Or .Type = 21 Or .Type = 22 Or .Type = 25 Or .Type = 26 Or .Type = 29 Or .Type = 30 Or .Type = 31 Or .Type = 32 Or .Type = 35 Or .Type = 37 Or .Type = 38 Or .Type = 39 Or .Type = 40 Or .Type = 42 Or .Type = 43 Or .Type = 44 Or .Type = 45 Or .Type = 46 Or .Type = 47 Or .Type = 48 Or .Type = 76 Or .Type = 49 Or .Type = 54 Or .Type = 56 Or .Type = 57 Or .Type = 58 Or .Type = 60 Or .Type = 62 Or .Type = 64 Or .Type = 66 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70 Or .Type = 78 Or .Type = 84 Or .Type = 85 Or .Type = 87 Or (.Type = 55 And .Special > 0) Or (.Type >= 79 And .Type <= 83) Or .Type = 86 Or .Type = 92 Or .Type = 94 Or NPCIsYoshi(.Type) Or .Type = 96 Or .Type = 101 Or .Type = 102) And .Projectile = False Then
                        If (NPCDefaultMovement(.Type) = True Or (NPCIsCheep(.Type) = True And .Special <> 2)) And Not ((.Type = 55 Or .Type = 119) And .Special > 0) And .Projectile = False Then
                            If NPCCanWalkOn(.Type) = False Then
                                If NPCCanWalkOn(.Type) = True Then
                                    .Location.SpeedX = Physics.NPCWalkingOnSpeed * .Direction
                                ElseIf .Type = 125 Then
                                    .Location.SpeedX = 2 * .Direction
                                Else
                                    .Location.SpeedX = Physics.NPCWalkingSpeed * .Direction
                                End If
                                
                                
                                If (NPCIsCheep(.Type) And .Special <> 1) And .Projectile = False Then
                                    If .Wet = 0 Then
                                        If .Special5 >= 0 Then
                                            .Special2 = .Special2 - 1
                                        End If
                                    Else
                                        .Special2 = 6
                                        .Special3 = .Location.SpeedX
                                    End If
                                    If .Special2 <= 0 Then
                                        .Special3 = .Special3 * 0.99
                                        If .Special3 > -0.1 And .Special3 < 0.1 Then .Special3 = 0
                                        .Location.SpeedX = .Special3
                                    End If
                                End If
                                
                                If NPCIsCheep(.Type) And .Special = 1 And .Projectile = False Then
                                    .Location.SpeedX = Physics.NPCWalkingOnSpeed * 2 * .Direction
                                End If
                                
                                
                            End If
                        End If
                        If .Type = 135 And .Projectile = False And .Special2 = 1 Then .Location.SpeedX = 0



'NPC Gravity
If NPCNoGravity(.Type) = False Then

                        If .Type = 13 Or .Type = 265 Then
                            .CantHurt = 100
                            If .Special < 2 Then
                                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity * 1.5
                            ElseIf .Special = 3 Then
                            'peach fireball changes
                                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity * 0.9
                                If .Location.SpeedX > 3 Then
                                    .Location.SpeedX = .Location.SpeedX - 0.04
                                ElseIf .Location.SpeedX < -3 Then
                                    .Location.SpeedX = .Location.SpeedX + 0.04
                                End If
                            ElseIf .Special = 4 Then
                            
                            'toad fireball changes
                                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity * 1.3
                                If .Location.SpeedX < 8 And .Location.SpeedX > 0 Then
                                    .Location.SpeedX = .Location.SpeedX + 0.03
                                ElseIf .Location.SpeedX > -8 And .Location.SpeedX < 0 Then
                                    .Location.SpeedX = .Location.SpeedX - 0.03
                                End If
                            ElseIf .Special = 5 Then 'link fireballs float
                            Else
                                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity * 1.3
                            End If
                            
                        ElseIf .Type = 17 Or .Type = 18 Then
                            .Location.SpeedY = 0
                        
                        ElseIf (NPCIsCheep(.Type) And .Special = 2) And .Projectile = False Then
                            If .Special5 = 1 Then
                                If .Location.Y > .DefaultLocation.Y Then
                                    .Location.SpeedY = -4 - (.Location.Y - .DefaultLocation.Y) * 0.02
                                Else
                                    .Special5 = 0
                                End If
                            Else
                                'If .Location.SpeedY < 2 + (.Location.Y - .DefaultLocation.Y) * 0.02 Then
                                    .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity * 0.4
                                'End If
                            End If
                        ElseIf .Type <> 225 And .Type <> 226 And .Type <> 227 And Not (NPCIsCheep(.Type) And .Special = 2) And .Type <> 210 And .Type <> 211 And .Type <> 133 And .Type <> 97 And .Type <> 196 And .Type <> 87 And .Type <> 8 And .Type <> 245 And .Type <> 246 And .Type <> 93 And .Type <> 74 And .Type <> 256 And .Type <> 257 And Not NPCIsAParaTroopa(.Type) And .Type <> 51 And .Type <> 52 And .Type <> 34 And .Type <> 37 And .Type <> 180 And .Type <> 38 And .Type <> 42 And .Type <> 43 And .Type <> 44 And Not .Type = 47 And Not .Type = 56 And Not .Type = 57 And Not .Type = 60 And Not .Type = 62 And Not .Type = 64 And Not .Type = 66 And Not .Type = 85 And Not (NPCIsACoin(.Type) And .Special = 0) And Not .Type = 105 And Not .Type = 106 And Not .Type = 108 And Not .Type = 197 And Not .Type = 199 And Not .Type = 203 And Not .Type = 204 And ((Not .Type = 205 And Not .Type = 206 And Not .Type = 207)) And Not .Type = 209 And Not .Type = 91 And .Type <> 269 And .Type <> 270 And .Type <> 255 Then
                            If .Type <> 271 And .Type <> 272 And .Type <> 276 And .Type <> 282 And .Type <> 283 And .Type <> 284 And .Type <> 289 And .Type <> 290 And .Type <> 291 And .Type <> 292 Then 'no gravity
                                If NPCIsCheep(.Type) And .Special = 4 And .Projectile = False Then .Location.SpeedX = 0
                                If .Wet = 2 And (.Type = 190) Then
                                    .Location.SpeedY = .Location.SpeedY - Physics.NPCGravity * 0.5
                                ElseIf .Wet = 2 And NPCIsCheep(.Type) And .Special <> 2 And .Projectile = False Then   ' Fish cheep
                                    If (.Location.X < .DefaultLocation.X - 100 And .Direction = -1) Or (.Location.X > .DefaultLocation.X + 100 And .Direction = 1) Then
                                        If .Special = 3 Then .TurnAround = True
                                    End If
                                    If .Special = 4 Then
    
                                        
                                        If .Location.SpeedY = 0 Then .Special4 = 1
                                        If .Location.SpeedY = 0.01 Then .Special4 = 0
                                        
                                        .Location.SpeedX = 0
                                        If .Location.SpeedY > 2 Then .Location.SpeedY = 2
                                        If .Location.SpeedY < -2 Then .Location.SpeedY = -2
                                        If .Location.Y > .DefaultLocation.Y + 25 Then
                                            .Special4 = 1
                                        ElseIf .Location.Y < .DefaultLocation.Y - 25 Then
                                            .Special4 = 0
                                        End If
                                        If .Special4 = 0 Then
                                            .Location.SpeedY = .Location.SpeedY + 0.05
                                        Else
                                            .Location.SpeedY = .Location.SpeedY - 0.05
                                        End If
                                    Else
                                        If .Special4 = 0 Then
                                            .Location.SpeedY = .Location.SpeedY - 0.025
                                            If .Location.SpeedY <= -1 Then .Special4 = 1
                                            If .Special = 3 And .Location.SpeedY <= -0.5 Then .Special4 = 1
                                        Else
                                            .Location.SpeedY = .Location.SpeedY + 0.025
                                            If .Location.SpeedY >= 1 Then .Special4 = 0
                                            If .Special = 3 And .Location.SpeedY >= 0.5 Then .Special4 = 0
                                        End If
                                    End If
                                ElseIf NPCIsCheep(.Type) And .Special = 1 And .Special5 = 1 Then
                                    .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity * 0.6
                                ElseIf .Type = 278 Or .Type = 278 Then
                                    .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity * 0.75
                                    If .Location.SpeedY > Physics.NPCGravity * 15 Then .Location.SpeedY = Physics.NPCGravity * 15
                                ElseIf .Type <> 259 And .Type <> 260 Then
                                    .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity
                                End If
                            End If
                        End If
                        
                        
                        If .Type = 291 Then
                            .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity * 0.8
                            'If .Location.SpeedY >= 5 Then .Location.SpeedY = 5
                            If .Location.SpeedX < -0.005 Then
                                .Location.SpeedX = .Location.SpeedX + 0.02
                            ElseIf .Location.SpeedX > 0.005 Then
                                .Location.SpeedX = .Location.SpeedX - 0.02
                            Else
                                .Location.SpeedX = 0
                            End If
                            
                            
                        End If
                        
ElseIf .Projectile = True Then
    .Location.SpeedY = .Location.SpeedY * 0.95
    If .Location.SpeedY > -0.1 And .Location.SpeedY < 0.1 Then
        .Projectile = False
        .Location.SpeedY = 0
    End If
End If

                        If .Location.SpeedY >= 8 And .Type <> 259 And .Type <> 260 Then .Location.SpeedY = 8
                        If .Type = 40 Then
                            If .Projectile = False Then
                                .Location.SpeedY = 0 'egg code
                                If .Location.SpeedX = 0 Then
                                    .Projectile = True
                                End If
                            End If
                        End If
                        If (.Type = 45 Or .Type = 46 Or .Type = 212) And .Special = 0 Then .Location.SpeedY = 0
                        If .Type = 50 Or .Type = 211 Then
                            .Location.SpeedX = 0
                            .Location.SpeedY = 0
                        End If
                        NPCSpecial A
'Dont move
                        If .Stuck = True And .Projectile = False And .Type <> 34 Then    'face closest player
                            .Location.SpeedX = 0
                            If Not (.Type = 189 And .Special > 0) Then
                                C = 0
                                For B = 1 To numPlayers
                                    If Player(B).Dead = False And Player(B).Section = .Section Then
                                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                            If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                                                .Direction = -1
                                            Else
                                                .Direction = 1
                                            End If
                                        End If
                                    End If
                                Next B
                            End If
                        End If
'Actual Movement

                        If .Type = 78 Then
                            For B = 1 To numPlayers
                                If Not (Player(B).Effect = 0 Or Player(B).Effect = 3 Or Player(B).Effect = 9 Or Player(B).Effect = 10) Then
                                    .Location.SpeedX = 0
                                    Exit For
                                End If
                            Next B
                        End If
                        If .Type = 263 Then
                            If .Projectile = True Or .Wet > 0 Or .HoldingPlayer > 0 Then
                                .Special3 = 0
                            ElseIf .Special3 = 1 Then
                                .Location.SpeedX = 0
                                .Location.SpeedY = 0
                            End If
                        End If
                        If (.Type = 96 And .Special2 = 1) Or .Type = 151 Or .Type = 159 Then
                            .Location.SpeedX = 0
                            .Location.SpeedY = 0
                        ElseIf .Type = 160 Or .Type = 188 Then
                            .Location.SpeedY = 0
                        End If
                        If .Type = 192 Then
                            .Projectile = False
                            .Location.SpeedX = 0
                            .Location.SpeedY = 0
                        End If
                        If .Type = 190 Then
                            For B = 1 To numPlayers
                                If Not (Player(B).Effect = 0 Or Player(B).Effect = 3 Or Player(B).Effect = 9 Or Player(B).Effect = 10) Then
                                    .Location.SpeedX = 0
                                    .Location.SpeedY = 0
                                End If
                            Next B
                        End If


                        If .Type = 247 And .Projectile = False Then
                            speedVar = speedVar * 0.7
                            If .Special2 < 2 Then
                                speedVar = speedVar * 0.7
                                .Special2 = .Special2 + 1
                            End If
                        End If
                        
                        If (Not NPCIsAnExit(.Type) Or .Type = 97 Or .Type = 196) And Not .Type = 14 And Not .Type = 57 Then
                            If Not NPCIsAParaTroopa(.Type) And Not .Type = 91 Then
                                .Location.X = .Location.X + .Location.SpeedX * speedVar
                                .Location.Y = .Location.Y + .Location.SpeedY
                            End If
                        Else
                            If Not (.Location.X = .DefaultLocation.X And .Location.Y = .DefaultLocation.Y) Or .Type = 14 Then
                                .Location.SpeedX = .Location.SpeedX * 0.99
                                .Location.X = .Location.X + .Location.SpeedX
                                .Location.Y = .Location.Y + .Location.SpeedY
                                If .Projectile = False Then .Location.SpeedX = 0
                            End If
                        End If
                        'End If 'end of freezenpcs
                        
                        If .Type = 263 And .Special = 3 Then .BeltSpeed = 0
                        
                        
'projectile check
    If .Type = 13 Or .Type = 108 Or .Type = 265 Or .Type = 266 Or .Type = 171 Or .Type = 292 Then .Projectile = True
                        
'make things projectiles
                        If .Type = 58 Or .Type = 21 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70 Or (.Type >= 78 And .Type <= 83) Then
                            If .Location.SpeedY > Physics.NPCGravity * 20 Then
                                .Projectile = True
                            Else
                                .Projectile = False
                            End If
                        End If
                        If .Type = 78 Then .Projectile = True
                        If .Type = 241 And (.Location.SpeedY > 2 Or .Location.SpeedY < -2) Then .Projectile = True
'Special NPCs code
                        SpecialNPC A
'Block Collision

If .Type = 179 Then .Location.Height = 24

                        If .Pinched1 > 0 Then .Pinched1 = .Pinched1 - 1
                        If .Pinched2 > 0 Then .Pinched2 = .Pinched2 - 1
                        If .Pinched3 > 0 Then .Pinched3 = .Pinched3 - 1
                        If .Pinched4 > 0 Then .Pinched4 = .Pinched4 - 1
                        If .MovingPinched > 0 Then .MovingPinched = .MovingPinched - 1

                        newY = 0
                        oldBeltSpeed = .BeltSpeed
                        resetBeltSpeed = False
                        beltClear = False
                        .BeltSpeed = 0
                        beltCount = 0
                        addBelt = 0
                        .onWall = False
                        tempSpeedA = 0
                        oldSlope = .Slope
                        SlopeTurn = False
                        .Slope = 0
                        If .Location.X < -(FLBlocks - 1) * 32 Then .Location.X = -(FLBlocks - 1) * 32
                        If .Location.X + .Location.Width > (FLBlocks + 1) * 32 Then .Location.X = (FLBlocks + 1) * 32 - .Location.Width
                        
                        If Not (NPCIsACoin(.Type) And .Special = 0) And Not (.Type = 45 And .Special = 0) And Not .Type = 57 And Not .Type = 85 And Not .Type = 91 And Not .Type = 97 And Not .Type = 196 And Not (.Type >= 104 And .Type <= 106) And Not (NPCIsAnExit(.Type) And ((.DefaultLocation.X = .Location.X And .DefaultLocation.Y = .Location.Y) Or .Inert = True)) And Not .Type = 159 And Not .Type = 192 And Not .Type = 202 And Not (.Type = 246 Or .Type = 255 Or .Type = 259 Or .Type = 260) Then
                        
                            If (NPCNoClipping(.Type) = False Or (.Projectile = True)) And Not (.Type = 40 And .Projectile = True) And Not .Type = 50 And .standingOnPlayer = 0 And Not (NPCIsVeggie(.Type) And .Projectile = True) And Not .Type = 30 And Not .Type = 18 And Not .Type = 108 And Not (NPCIsCheep(.Type) = True And .Special = 2) And Not .Type = 272 Then
                                For bCheck = 1 To 2
                                    If bCheck = 1 Then
                                        fBlock = FirstBlock(Int(NPC(A).Location.X / 32) - 1)
                                        lBlock = LastBlock(Int((NPC(A).Location.X + NPC(A).Location.Width) / 32) + 1)
                                    Else
                                        fBlock = numBlock + 1 - numTempBlock
                                        lBlock = numBlock
                                    End If
                                    For B = fBlock To lBlock
'If Not .Block = B And Not .tempBlock = B And Not (.Projectile = True And Block(B).noProjClipping = True) And BlockNoClipping(Block(B).Type) = False And Block(B).Hidden = False And Block(B).Hidden = False Then
                                        
                                        


If .Location.X + .Location.Width >= Block(B).Location.X Then
If .Location.X <= Block(B).Location.X + Block(B).Location.Width Then
If .Location.Y + .Location.Height >= Block(B).Location.Y Then
If .Location.Y <= Block(B).Location.Y + Block(B).Location.Height Then
                                        
                                        'If CheckCollision(.Location, Block(B).Location) = True Then
                                        
                                        
                                        
                                            If Not .Block = B And Not .tempBlock = B And Not (.Projectile = True And Block(B).noProjClipping = True) And BlockNoClipping(Block(B).Type) = False And Block(B).Hidden = False Then
                                                If Block(B).IsNPC = 78 And NPCNoClipping(.Type) = False And .Type <> 17 Then NPCHit A, 8
                                                
                                                If Block(B).IsNPC <> 57 And (NPCIsABlock(Block(B).IsNPC) Or NPCIsAHit1Block(Block(B).IsNPC) Or NPCCanWalkOn(Block(B).IsNPC)) Then
                                                    HitSpot = NPCFindCollision(.Location, Block(B).Location)
                                                Else
                                                    HitSpot = FindCollisionBelt(.Location, Block(B).Location, oldBeltSpeed)
                                                End If
                                                If NPCIsCheep(.Type) Then
                                                    If .Wet = 0 Then
                                                        If .WallDeath >= 9 Then
                                                            HitSpot = 0
                                                        End If
                                                    End If
                                                End If
                                                If .Type = 171 Or .Type = 266 Or .Type = 292 Then
                                                    If Block(B).Type = 457 Then
                                                        KillBlock B
                                                    End If
                                                    HitSpot = 0
                                                End If
                                                If .Type = 266 Then HitSpot = 0
                                                If Block(B).IsPlayer > 0 And ((NPCStandsOnPlayer(.Type) = False And .Type <> 13) Or .Inert = True) Then HitSpot = 0
                                                If (NPCIsCheep(.Type) And .Special = 2) And HitSpot <> 3 Then HitSpot = 0
                                                If Block(B).Invis = True Then
                                                    If HitSpot <> 3 Then HitSpot = 0
                                                End If
                                                If HitSpot = 5 Then
                                                    If CheckHitSpot1(.Location, Block(B).Location) = True Then HitSpot = 1
                                                End If
                                                If .Type = 58 Or .Type = 21 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70 Then
                                                    If Block(B).IsPlayer > 0 Or Block(B).IsNPC = 56 Then
                                                        HitSpot = 0
                                                        .Location.SpeedX = -.Location.SpeedX
                                                    End If
                                                End If
                                                If .Type >= 78 And .Type <= 83 And HitSpot <> 1 Then HitSpot = 0
                                                If .Type = 48 And (Block(B).IsNPC = 22 Or Block(B).IsNPC = 49) Then  'spiney eggs don't walk on special items
                                                    HitSpot = 0
                                                End If
                                                If .Type = 190 And Block(B).IsNPC > 0 Then HitSpot = 0
                                                If .Type = 86 Then
                                                    If HitSpot <> 1 And .Special > 0 Then
                                                        If Block(B).Location.X < level(.Section).X + 48 Or Block(B).Location.X > level(.Section).Width - 80 Then
                                                            .Special = 0
                                                        Else
                                                            HitSpot = 0
                                                            resetBeltSpeed = True
                                                        End If
                                                    ElseIf HitSpot = 3 Then
                                                        If .Special4 = 3 Then
                                                            .Frame = 10
                                                            .Special3 = 21
                                                            .Special = 1
                                                            .Location.SpeedX = 0
                                                        End If
                                                    End If
                                                End If
                                                
                                                If .Type = 13 Or .Type = 265 Then
                                                    If Block(B).Type = 626 And .Special = 1 Then HitSpot = 0
                                                    If Block(B).Type = 627 And .Special = 2 Then HitSpot = 0
                                                    If Block(B).Type = 628 And .Special = 3 Then HitSpot = 0
                                                    If Block(B).Type = 629 And .Special = 4 Then HitSpot = 0
                                                End If
                                                
                                                If .Type = 13 Or .Type = 108 Then
                                                    If Block(B).Type = 621 Or Block(B).Type = 620 Then
                                                        NPCHit A, 3, A
                                                        If Block(B).Type = 621 Then
                                                            Block(B).Type = 109
                                                        Else
                                                            Block(B).Layer = "Destroyed Blocks"
                                                            Block(B).Hidden = True
                                                            numNPCs = numNPCs + 1
                                                            With NPC(numNPCs)
                                                                .Location.Width = 28
                                                                .Location.Height = 32
                                                                .Type = 10
                                                                .Location.Y = Block(B).Location.Y
                                                                .Location.X = Block(B).Location.X + 2
                                                                .Active = True
                                                                .DefaultType = .Type
                                                                .DefaultLocation = .Location
                                                                .TimeLeft = 100
                                                                CheckSectionNPC numNPCs
                                                            End With
                                                        End If
                                                    End If
                                                End If
                                                
                                                If (.Type = 37 Or .Type = 180) And HitSpot <> 1 Then HitSpot = 0
                                                If Block(B).IsNPC = 57 And HitSpot = 5 Then
                                                    If .Location.X + .Location.Width / 2 < Block(B).Location.X + Block(B).Location.Width / 2 Then
                                                        HitSpot = 4
                                                    Else
                                                        HitSpot = 2
                                                    End If
                                                End If
                                                If .Type = 13 Or .Type = 265 Then
                                                    If NPCIsABonus(Block(B).IsNPC) Then HitSpot = 0
                                                End If
                                                If .Type = 15 And HitSpot = 5 Then
                                                    If .WallDeath >= 5 Then
                                                        .Killed = 3
                                                    Else
                                                        HitSpot = 3
                                                    End If
                                                End If
                                                If BlockIsSizable(Block(B).Type) And HitSpot <> 1 Then HitSpot = 0
                                                If BlockIsSizable(Block(B).Type) Or BlockOnlyHitspot1(Block(B).Type) = True Then
                                                    If HitSpot <> 1 Or (NPCIsAParaTroopa(.Type) And .Special <> 1) Then HitSpot = 0
                                                End If
                                                If .Type = 133 And HitSpot > 0 Then .Killed = 4
                                                If .Type = 134 And .Projectile = True And HitSpot <> 0 Then .Special = 1000
                                                If .Shadow = True And HitSpot <> 1 And Not (Block(B).Special > 0 And .Projectile = True) Then HitSpot = 0
                                                
                                                
                                                'vine makers
                                                If .Type = 225 Or .Type = 226 Or .Type = 227 Then
                                                    If HitSpot = 3 Then
                                                        .Special = 1
                                                    End If
                                                End If
                                                
                                                If .Type = 197 And Block(B).IsNPC > 0 Then HitSpot = 0
                                                
                                                


                                                If (.Type = 205 Or .Type = 206 Or .Type = 207) Then
                                                    .Special5 = 0
                                                    If HitSpot = 1 Then
                                                        If .Special = 4 And .Location.X + 0.99 = Block(B).Location.X + Block(B).Location.Width Then
                                                            HitSpot = 0
                                                        End If
                                                        If .Special = 2 And .Location.X + .Location.Width - 0.99 = Block(B).Location.X Then
                                                            HitSpot = 0
                                                        End If
                                                    End If
                                                    If BlockIsSizable(Block(B).Type) = True Or BlockOnlyHitspot1(Block(B).Type) = True Then HitSpot = 0
                                                    If BlockSlope2(Block(B).Type) <> 0 And HitSpot = 3 Then
                                                        If .Special = 4 And .Special2 = -1 Then
                                                            If .Location.X - 0.01 = Block(B).Location.X Then
                                                                .Special = 3
                                                                .Special2 = 1
                                                                .Location.SpeedX = -.Location.SpeedY
                                                            End If
                                                        End If
                                                    End If
                                                    If BlockSlope2(Block(B).Type) <> 0 And HitSpot = 1 Then
                                                        If .Special = 4 Then HitSpot = 2
                                                        If .Special = 2 Then HitSpot = 4
                                                    End If
                                                    If .Special = 3 Then
                                                        If BlockSlope2(Block(B).Type) <> 0 Then
                                                            If HitSpot = 2 Or HitSpot = 4 Then
                                                                HitSpot = 0
                                                            End If
                                                        ElseIf HitSpot = 2 Or HitSpot = 4 Then
                                                            HitSpot = 0
                                                        End If
                                                    End If
                                                End If
                                                
                                                

                                                If BlockSlope2(Block(B).Type) <> 0 And HitSpot > 0 And ((.Location.Y > Block(B).Location.Y) Or ((.Type = 205 Or .Type = 206 Or .Type = 207) And .Special = 3)) Then
                                                    
                                                    If HitSpot = 5 Then
                                                        If .Special = 2 And .Special2 = 1 Then
                                                            .Special2 = 1
                                                            .Special = 3
                                                        End If
                                                        If .Special = 4 And .Special2 = 1 Then
                                                            .Special2 = -1
                                                            .Special = 3
                                                        End If
                                                    End If
                                                
                                                    HitSpot = 0
                                                    If BlockSlope2(Block(B).Type) = 1 Then
                                                        PlrMid = .Location.X + .Location.Width
                                                    Else
                                                        PlrMid = .Location.X
                                                    End If
                                                    Slope = (PlrMid - Block(B).Location.X) / Block(B).Location.Width
                                                    If BlockSlope2(Block(B).Type) > 0 Then Slope = 1 - Slope
                                                    If Slope < 0 Then Slope = 0
                                                    If Slope > 1 Then Slope = 1
                                                    
                                                    If .Location.Y < Block(B).Location.Y + Block(B).Location.Height - (Block(B).Location.Height * Slope) - 0.1 Then

                                                        If .Type = 13 Or .Type = 17 Or .Type = 265 Then NPCHit A, 3, A
                                                        
                                                        If .Type = 263 Then
                                                            If .Location.SpeedY < -2 Then NPCHit A, 3, A
                                                        End If
                                                        


                                                        If .Location.SpeedY = Physics.NPCGravity Or .Slope > 0 Or oldSlope > 0 Then

                                                            

                                                            
                                                            If (.Special = 2 Or .Special = 4) And .Special2 = -1 Then
                                                                If .Special = 4 Then .Special2 = 1
                                                                If .Special = 2 Then .Special2 = -1
                                                                .Special = 3
                                                            
                                                            End If

                                                        
                                                            PlrMid = .Location.Y
                                                            Slope = (PlrMid - Block(B).Location.Y) / Block(B).Location.Height
                                                            If Slope < 0 Then Slope = 0
                                                            If Slope > 1 Then Slope = 1
                                                            If BlockSlope2(Block(B).Type) < 0 Then
                                                                .Location.X = Block(B).Location.X + Block(B).Location.Width - (Block(B).Location.Width * Slope)
                                                            Else
                                                                .Location.X = Block(B).Location.X + (Block(B).Location.Width * Slope) - .Location.Width
                                                            End If
                                                            SlopeTurn = True
                                                            If .Location.SpeedX < 0 Then
                                                                HitSpot = 2
                                                            Else
                                                                HitSpot = 4
                                                            End If
                                                        Else
                                                            .Location.Y = Block(B).Location.Y + Block(B).Location.Height - (Block(B).Location.Height * Slope)
                                                            If .Type = 205 Or .Type = 206 Or .Type = 207 Then
                                                                .Location.Y = .Location.Y + 1
                                                                tempBlockHit(1) = 0
                                                                tempBlockHit(2) = 0
                                                            End If
                                                            If .Location.SpeedY < -0.01 Then .Location.SpeedY = -0.01 + Block(B).Location.SpeedY
                                                            
                                                            If NPCIsAParaTroopa(.Type) = True Then
                                                                .Location.SpeedY = .Location.SpeedY + 2
                                                            End If
                                                            
                                                        End If
                                                    End If
                                                 End If
                                                
                                                
                                                
                                                If BlockSlope(Block(B).Type) <> 0 And HitSpot > 0 Then
                                                    HitSpot = 0
                                                    If .Location.Y + .Location.Height <= Block(B).Location.Y + Block(B).Location.Height + .Location.SpeedY + 4 Then
                                                        If .Location.X < Block(B).Location.X + Block(B).Location.Width And .Location.X + .Location.Width > Block(B).Location.X Then
                                                        


                                                                

                                                            If BlockSlope(Block(B).Type) = 1 Then
                                                                PlrMid = .Location.X
                                                            Else
                                                                PlrMid = .Location.X + .Location.Width
                                                            End If
                                                            Slope = (PlrMid - Block(B).Location.X) / Block(B).Location.Width
                                                            If BlockSlope(Block(B).Type) < 0 Then Slope = 1 - Slope
                                                            If Slope < 0 Then Slope = 0
                                                            If Slope > 100 Then Slope = 100
                                                            If tempHitBlock > 0 Then
                                                                If BlockIsSizable(Block(tempHitBlock).Type) = False Then
                                                                    If Block(tempHitBlock).Location.Y <> Block(B).Location.Y Then
                                                                        tempHitBlock = 0
                                                                        tempHit = 0
                                                                    End If
                                                                End If
                                                            End If
                                                            If .Location.Y >= Block(B).Location.Y + (Block(B).Location.Height * Slope) - .Location.Height - 0.1 Then
                                                                If .Type = 241 And .Location.SpeedY > 2 Then NPCHit A, 4, A
                                                                If (.Type = 205 Or .Type = 206 Or .Type = 207) And .Special = 3 Then
                                                                    .Special = 1
                                                                    .Special2 = -.Special2
                                                                End If
                                                                
                                                                If .Type = 17 Or .Type = 40 Then 'Bullet bills crash on slopes
                                                                    .Slope = 1
                                                                    If .Location.SpeedX < 0 Then
                                                                        HitSpot = 2
                                                                    Else
                                                                        HitSpot = 4
                                                                    End If
                                                                Else
                                                                
                                                                
                                                                    .Location.Y = Block(B).Location.Y + (Block(B).Location.Height * Slope) - .Location.Height - 0.1
                                                                    If NPCIsCheep(.Type) Then
                                                                        .TurnAround = True
                                                                    End If
                                                                    .Slope = B
                                                                    HitSpot = 1
                                                                    'Fireballs dont go up steep slopes
                                                                    If Block(B).Location.Height / Block(B).Location.Width >= 1 And ((BlockSlope(Block(B).Type) = -1 And .Location.SpeedX > 0) Or (BlockSlope(Block(B).Type) = 1 And .Location.SpeedX < 0)) Then
                                                                        If (.Type = 13 And .Special <> 2 And .Special <> 3) Or (.Type = 265 And .Special = 5) Then
                                                                            If .Location.SpeedX < 0 Then
                                                                                HitSpot = 2
                                                                            Else
                                                                                HitSpot = 4
                                                                            End If
                                                                        End If
                                                                    End If
                                                                    If NPCIsAShell(.Type) Or (.Type = 45 And .Special = 1) Or .Type = 263 Then
                                                                        If .Location.SpeedY > .Location.SpeedX * (Block(B).Location.Height / Block(B).Location.Width) * BlockSlope(Block(B).Type) Then
                                                                            .Location.SpeedY = .Location.SpeedX * (Block(B).Location.Height / Block(B).Location.Width) * BlockSlope(Block(B).Type)
                                                                            HitSpot = 0
                                                                            If .Location.SpeedY > 0 Then .Location.SpeedY = 0
                                                                        End If
                                                                    End If
                                                                End If
                                                            End If
                                                        End If
                                                    End If
                                                End If
                                                

                                                
                                                If .Type = 206 Or .Type = 205 Or .Type = 207 Then
                                                    If .Special = 3 And (HitSpot = 2 Or HitSpot = 4) Then
                                                        If Block(B).Location.Y + Block(B).Location.Height <= .Location.Y + 1 Then
                                                            HitSpot = 3
                                                        End If
                                                    End If
                                                    If Block(B).IsNPC > 0 Then HitSpot = 0
                                                End If
                                                
                                                If BlockKills(Block(B).Type) And (HitSpot > 0 Or .Slope = B) Then NPCHit A, 6, B
                                                
                                                If .Type = 13 And Block(B).IsNPC = 263 Then HitSpot = 0
                                                
                                                If .Type = 96 And HitSpot = 1 Then
                                                    If (.Location.SpeedY > 2 And HitSpot = 1) Or (.Location.SpeedY < -2 And HitSpot = 3) Or (.Location.SpeedX > 2 And HitSpot = 4) Or (.Location.SpeedX < -2 And HitSpot = 2) Then
                                                        .Special2 = 1
                                                    End If
                                                End If
                                                If HitSpot = 5 Then
                                                    If .Slope > 0 And Block(B).Location.Y + Block(B).Location.Height < .Location.Y + 4 Then
                                                        If (Block(B).Location.X + Block(B).Location.Width < .Location.X + 4 Or Block(B).Location.X > .Location.X + .Location.Width - 4) Then
                                                            HitSpot = 0
                                                        End If
                                                    End If
                                                End If
'beech koopa kicking an ice block
                                                If (.Type = 55 Or .Type) = 119 And Block(B).IsNPC = 45 Then
                                                    If HitSpot = 2 Or HitSpot = 4 Then
                                                        If .Location.SpeedY = Physics.NPCGravity Or .Location.SpeedY = 0 Or .Slope > 0 Or oldSlope > 0 And NPC(Block(B).IsReally).Projectile = False Then
                                                            NPC(Block(B).IsReally).Special = 1
                                                            .Special = 10
                                                            Player(numPlayers + 1).Direction = .Direction
                                                            .Location.X = .Location.X - .Direction
                                                            NPCHit Block(B).IsReally, 1, numPlayers + 1
                                                            HitSpot = 0
                                                        End If
                                                    End If
                                                End If
                                                If .Type = 179 And Block(B).IsNPC > 0 Then
                                                    HitSpot = 0
                                                End If
                                                If Block(B).IsNPC = 208 Or Block(B).IsNPC = 209 Then
                                                    If .Projectile = True Then
                                                        NPCHit Block(B).IsReally, 3, A
                                                        NPCHit A, 4, Block(B).IsReally
                                                    End If
                                                End If
                                                
                                                

                                                If (.Type = 237 Or .Type = 263) And (HitSpot = 2 Or HitSpot = 4 Or HitSpot = 5) Then
                                                    If Block(B).IsNPC = 263 Then
                                                        NPCHit Block(B).IsReally, 3, Block(B).IsReally
                                                        NPC(Block(B).IsReally).Location.SpeedX = -.Location.SpeedX
                                                        .Multiplier = .Multiplier + 1
                                                    End If
                                                    NPCHit A, 3, A
                                                End If
                                                
                                                If .Type = 263 And (HitSpot = 1 Or HitSpot = 3 Or HitSpot = 5) Then
                                                    If .Location.SpeedX > -Physics.NPCShellSpeed * 0.8 And .Location.SpeedX < Physics.NPCShellSpeed * 0.8 Then
                                                        If .Location.SpeedY > 5 Or .Location.SpeedY < -2 Then NPCHit A, 3, A
                                                    End If
                                                End If
                                                
                                                If NPCIsACoin(.Type) And .Special = 0 And HitSpot > 0 Then
                                                    NPCHit A, 3, A
                                                End If
                                                
                                                If Block(B).Location.SpeedX <> 0 And (HitSpot = 2 Or HitSpot = 4) Then .MovingPinched = 2
                                                If Block(B).Location.SpeedY <> 0 And (HitSpot = 1 Or HitSpot = 3) Then .MovingPinched = 2
                                                
                                                If .TimeLeft > 1 Then
                                                    If HitSpot = 1 Then
                                                        .Pinched1 = 2
                                                    ElseIf HitSpot = 2 Then
                                                        .Pinched2 = 2
                                                    ElseIf HitSpot = 3 Then
                                                        .Pinched3 = 2
                                                    ElseIf HitSpot = 4 Then
                                                        .Pinched4 = 2
                                                    ElseIf HitSpot = 5 Then
                                                        If .Location.X + .Location.Width / 2 < Block(B).Location.X + Block(B).Location.Width / 2 Then
                                                            C = (Block(B).Location.X + Block(B).Location.Width / 2) - (.Location.X + .Location.Width / 2)
                                                            D = 2
                                                        Else
                                                            C = (.Location.X + .Location.Width / 2) - (Block(B).Location.X + Block(B).Location.Width / 2)
                                                            D = 4
                                                        End If
                                                        
                                                        If .Location.Y + .Location.Height / 2 < Block(B).Location.Y + Block(B).Location.Height / 2 Then
                                                            If C < (Block(B).Location.Y + Block(B).Location.Height / 2) - (.Location.Y + .Location.Height / 2) Then D = 1
                                                        Else
                                                            If C < (.Location.Y + .Location.Height / 2) - (Block(B).Location.Y + Block(B).Location.Height / 2) Then D = 3
                                                        End If
                                                        
                                                        If D = 1 Then .Pinched1 = 2
                                                        If D = 2 Then .Pinched2 = 2
                                                        If D = 3 Then .Pinched3 = 2
                                                        If D = 4 Then .Pinched4 = 2
                                                        
                                                        If Block(B).Location.SpeedX <> 0 And (D = 2 Or D = 4) Then .MovingPinched = 2
                                                        If Block(B).Location.SpeedY <> 0 And (D = 1 Or D = 3) Then .MovingPinched = 2
                                                        
                                                        
                                                        
                                                        'If Not (.Location.Y + .Location.Height - .Location.SpeedY <= Block(B).Location.Y - Block(B).Location.SpeedY) Then .Pinched1 = 2
                                                        'If Not (.Location.Y - .Location.SpeedY >= Block(B).Location.Y + Block(B).Location.Height - Block(B).Location.SpeedY) Then .Pinched3 = 2
                                                        'If Not (.Location.X + .Location.Width - .Location.SpeedX <= Block(B).Location.X - Block(B).Location.SpeedX) Then .Pinched2 = 2
                                                        'If Not (.Location.X - .Location.SpeedX >= Block(B).Location.X + Block(B).Location.Width - Block(B).Location.SpeedX) Then .Pinched4 = 2
                                                    End If
                                                    If .MovingPinched > 0 Then
                                                        If (.Pinched1 > 0 And .Pinched3 > 0) Or (.Pinched2 > 0 And .Pinched4 > 0) Then
                                                            If HitSpot > 1 Then HitSpot = 0
                                                            .Damage = .Damage + 10000
                                                            .Immune = 0
                                                            NPC(0).Multiplier = 0
                                                            NPCHit A, 3, 0
                                                        End If
                                                    End If
                                                End If
                                                
                                                If HitSpot = 1 And .Type = 241 And .Location.SpeedY > 2 Then NPCHit A, 4, A
                                                If HitSpot = 1 And .Type = 247 And Block(B).IsNPC = 247 Then
                                                    NPC(Block(B).IsReally).Special = -3
                                                    .Special2 = 0
                                                End If
                                                If (.Type = 13 Or .Type = 265) And .Special = 5 And HitSpot > 0 Then NPCHit A, 3, A
                                                If .Type = 265 And HitSpot > 1 Then NPCHit A, 3, A
                                                If .Type = 283 And BlockIsSizable(Block(B).Type) = False Then NPCHit A, 3, A
                                                If .Type = 286 And HitSpot = 1 Then .Special = 1
                                                If .Type = 288 And HitSpot = 1 Then
                                                    .Special3 = 1
                                                    .Projectile = False
                                                End If
                                                If .Type = 291 And HitSpot > 0 Then NPCHit A, 3, A
'hitspot 1
                                                If HitSpot = 1 Then 'Hitspot 1
                                                    If (.Type = 13 Or .Type = 265) And .Location.SpeedX = 0 Then NPCHit A, 4, A
                                                    
                                                
                                                    If .Type = 197 Then .Special = 1
                                                    If .Type = 231 Or .Type = 235 Then
                                                        .Special4 = 1
                                                    End If
                                                    tempSpeedA = Block(B).Location.SpeedY
                                                    If tempSpeedA < 0 Then tempSpeedA = 0
                                                    If NPC(Block(B).IsReally).Type <> 57 And NPC(Block(B).IsReally).Type <> 60 And NPC(Block(B).IsReally).Type <> 62 And NPC(Block(B).IsReally).Type <> 64 And NPC(Block(B).IsReally).Type <> 66 And Block(B).IsReally > 0 Then
                                                        If NPC(Block(B).IsReally).TimeLeft < .TimeLeft - 1 Then
                                                            NPC(Block(B).IsReally).TimeLeft = .TimeLeft - 1
                                                        ElseIf NPC(Block(B).IsReally).TimeLeft - 1 > .TimeLeft Then
                                                            .TimeLeft = NPC(Block(B).IsReally).TimeLeft - 1
                                                        End If
                                                    End If
                                                    If .Type = 45 And .Special = 1 And .Location.SpeedX = 0 And .Location.SpeedY > 7.95 Then NPCHit A, 4, A
                                                    If .Type = 37 Or .Type = 180 Then
                                                        .Special = 2
                                                    End If
                                                    
                                                    If (.Type = 58 Or .Type = 21 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70) And .Location.SpeedY > Physics.NPCGravity * 20 Then PlaySound 37
                                                    If .Type = 78 And .Location.SpeedY > Physics.NPCGravity * 10 Then PlaySound 37
                                                    If WalkingCollision3(.Location, Block(B).Location, oldBeltSpeed) = True Or .Location.Width > 32 Then
                                                        resetBeltSpeed = True
                                                        If Block(B).IsNPC <> 0 Then
                                                            If Block(B).Location.SpeedY > 0 And Block(B).IsNPC >= 60 And Block(B).IsNPC <= 66 Then
                                                                tempHit = Block(B).Location.Y - .Location.Height - 0.01 + Block(B).Location.SpeedY
                                                            Else
                                                                tempHit = Block(B).Location.Y - .Location.Height - 0.01
                                                            End If
                                                            tempHitBlock = B
                                                        Else
                                                            tempHitBlock = B
                                                            tempHit = Block(B).Location.Y - .Location.Height - 0.01
                                                        End If
                                                        If Block(B).IsNPC >= 60 And Block(B).IsNPC <= 66 Then
                                                            .BeltSpeed = 0
                                                            beltCount = 0
                                                        End If
                                                        If .Location.X > Block(B).Location.X Then
                                                            C = .Location.X - 0.01
                                                        Else
                                                            C = Block(B).Location.X - 0.01
                                                        End If
                                                        If .Location.X + .Location.Width < Block(B).Location.X + Block(B).Location.Width Then
                                                            C = .Location.X + .Location.Width - C + 0.01
                                                        Else
                                                            C = Block(B).Location.X + Block(B).Location.Width - C + 0.01
                                                        End If
                                                        If Block(B).IsPlayer = 0 Then
                                                            If Block(B).IsNPC > 0 Then
                                                                .BeltSpeed = .BeltSpeed + Block(B).Location.SpeedX * C * NPCSpeedvar(Block(B).IsNPC)
                                                            Else
                                                                .BeltSpeed = .BeltSpeed + Block(B).Location.SpeedX * C
                                                            End If
                                                            beltCount = beltCount + C
                                                        End If
                                                    End If
                                                    If tempHitBlock = B Then
                                                        If .Type = 48 Then
                                                            If .Location.SpeedY > 2 Then
                                                                .Location.SpeedY = -.Location.SpeedY * 0.7 + Block(B).Location.SpeedY
                                                                If .Slope = 0 Then .Location.Y = Block(B).Location.Y - .Location.Height - 0.01
                                                                tempHit = 0
                                                                tempHitBlock = 0
                                                            End If
                                                        End If
                                                        If ((NPCStandsOnPlayer(.Type) = True And .Projectile = False) Or NPCIsAShell(.Type) And .Location.SpeedX = 0) And Block(B).IsPlayer > 0 Then
                                                                 .standingOnPlayerY = Block(B).standingOnPlayerY + .Location.Height
                                                                .standingOnPlayer = Block(B).IsPlayer
                                                                If .standingOnPlayer = 0 And Block(B).IsNPC = 56 Then
                                                                    .TimeLeft = 100
                                                                End If
                                                        End If
                                                        If .Projectile = True Then
                                                            
                                                            If .Type = 13 Then
                                                                If .Special = 4 Then
                                                                    .Location.SpeedY = -3 + Block(B).Location.SpeedY
                                                                Else
                                                                    .Location.SpeedY = -5 + Block(B).Location.SpeedY
                                                                End If
                                                                If .Slope = 0 Then .Location.Y = Block(B).Location.Y - .Location.Height - 0.01
                                                                tempHit = 0
                                                            ElseIf .Type = 265 Then
                                                                .Location.SpeedY = -7 + Block(B).Location.SpeedY
                                                                If .Slope = 0 Then .Location.Y = Block(B).Location.Y - .Location.Height - 0.01
                                                                tempHit = 0
                                                                If Block(B).Slippy = False Then .Special5 = .Special5 + 1
                                                                If .Special5 >= 3 Then NPCHit A, 3, A
                                                            ElseIf .Type >= 117 And .Type <= 120 Then
                                                                
                                                            
                                                            ElseIf .Bouce = True Or .Location.SpeedY > 5.8 Or ((.Type = 22 Or .Type = 49) And (.Location.SpeedY > 2 Or (.Location.SpeedX > 1 Or .Location.SpeedX < -1))) Then
                                                                .Bouce = False
                                                                If NPCIsAShell(.Type) Or (.Type = 45 And .Special = 1) Or .Type = 263 Then
                                                                    If .Slope = 0 Then .Location.SpeedY = -.Location.SpeedY * 0.5
                                                                    For C = 1 To numPlayers
                                                                        With Player(C)
                                                                            If .StandingOnNPC = A Then
                                                                                NPC(A).Location.SpeedY = 0
                                                                                Exit For
                                                                            End If
                                                                        End With
                                                                    Next C
                                                                    
                                                                ElseIf .Type = 58 Or .Type = 21 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70 Or (.Type >= 78 And .Type <= 83) Then
                                                                    .Location.SpeedY = 0
                                                                ElseIf .Type = 86 Or .Type = 96 Then
                                                                    .Projectile = False
                                                                    .Location.SpeedY = 0
                                                                Else
                                                                    .Location.SpeedY = -.Location.SpeedY * 0.6
                                                                End If
                                                                If .Slope = 0 Then .Location.Y = Block(B).Location.Y - .Location.Height - 0.01
                                                                tempHit = 0
                                                            ElseIf .Type <> 78 And .Type <> 17 And .Type <> 13 Then
                                                                If NPCMovesPlayer(.Type) = True Then
                                                                    If .Location.SpeedX = 0 Then
                                                                        tempBool = False
                                                                        For C = 1 To numPlayers
                                                                            If CheckCollision(.Location, Player(C).Location) = True Then
                                                                                tempBool = True
                                                                                Exit For
                                                                            End If
                                                                        Next C
                                                                        If tempBool = False Then .Projectile = False
                                                                    End If
                                                                ElseIf .Type = 168 Then
                                                                    If .Location.SpeedX > -0.1 And .Location.SpeedX < 0.1 Then .Projectile = False
                                                                ElseIf Not (NPCIsAShell(.Type) Or (.Type = 45 And .Special = 1) Or .Type = 48) Then
                                                                    .Projectile = False
                                                                ElseIf .Location.SpeedX = 0 Then
                                                                    .Projectile = False
                                                                End If
                                                            End If
                                                        End If
                                                    End If
                                                ElseIf HitSpot = 2 Then 'Hitspot 2
                                                    If BlockSlope(Block(oldSlope).Type) = 1 And Block(oldSlope).Location.Y = Block(B).Location.Y Then
                                                    Else
                                                        beltClear = True
                                                        If .Type = 86 Then .Location.SpeedX = 0
                                                        addBelt = .Location.X
                                                        resetBeltSpeed = True
                                                        If .Type = 13 And .Special = 3 Then
                                                            If .Special2 = 0 Then
                                                                .Special2 = 1
                                                                .Location.SpeedX = -.Location.SpeedX
                                                            Else
                                                                NPCHit A, 4, A
                                                            End If
                                                        ElseIf .Type = 13 Or .Type = 40 Then NPCHit A, 4, A
                                                        End If
                                                        If .Type = 45 And .Special = 1 Then NPCHit A, 4, A
                                                        If .Slope = 0 And SlopeTurn = False Then .Location.X = Block(B).Location.X + Block(B).Location.Width + 0.01
                                                        If Not (.Type = 13 Or .Type = 78 Or .Type = 17) Then .TurnAround = True
                                                        If NPCIsAParaTroopa(.Type) = True Then .Location.SpeedX = .Location.SpeedX - Block(B).Location.SpeedX * 1.2
                                                        If NPCIsAShell(.Type) = True Then .Location.SpeedX = -.Location.SpeedX
                                                        addBelt = .Location.X - addBelt
                                                End If
                                                ElseIf HitSpot = 4 Then 'Hitspot 4
                                                    beltClear = True
                                                    If .Type = 86 Then .Location.SpeedX = 0
                                                    resetBeltSpeed = True
                                                    addBelt = .Location.X
                                                    If .Type = 13 And .Special = 3 Then
                                                        If .Special2 = 0 Then
                                                            .Special2 = 1
                                                            .Location.SpeedX = -.Location.SpeedX
                                                        Else
                                                            NPCHit A, 4, A
                                                        End If
                                                    ElseIf .Type = 13 Or .Type = 40 Then NPCHit A, 4, A
                                                    End If
                                                    If .Type = 45 And .Special = 1 Then NPCHit A, 4, A
                                                    If .Slope = 0 And SlopeTurn = False Then .Location.X = Block(B).Location.X - .Location.Width - 0.01
                                                    If Not (.Type = 13 Or .Type = 78 Or .Type = 17) Then .TurnAround = True
                                                    If NPCIsAParaTroopa(.Type) = True Then .Location.SpeedX = .Location.SpeedX - Block(B).Location.SpeedX * 1.2
                                                    If NPCIsAShell(.Type) = True Then .Location.SpeedX = -.Location.SpeedX
                                                    addBelt = .Location.X - addBelt
                                                ElseIf HitSpot = 3 Then  'Hitspot 3
                                                    If .Type = 45 And .Special = 1 Then NPCHit A, 4, A
                                                    If .Type = 15 Then .Special3 = 0
                                                    If tempBlockHit(1) = 0 Then
                                                        tempBlockHit(1) = B
                                                    Else
                                                        tempBlockHit(2) = B
                                                    End If
                                                    If NPCIsAParaTroopa(.Type) Then
                                                        .Location.SpeedY = 2 + Block(B).Location.SpeedY
                                                        .Location.Y = Block(B).Location.Y + Block(B).Location.Height + 0.1
                                                    End If
                                                ElseIf HitSpot = 5 Then 'Hitspot 5
                                                    If .Type = 13 Or .Type = 40 Then NPCHit A, 4, A
                                                    beltClear = True
                                                    If .Type = 86 Then
                                                        .Location.SpeedX = 0
                                                    End If
                                                    .onWall = True
                                                    If .WallDeath >= 5 And Not NPCIsABonus(.Type) = True And .Type <> 278 And .Type <> 279 And .Type <> 191 And .Type <> 21 And .Type <> 22 And .Type <> 26 And .Type <> 29 And .Type <> 31 And .Type <> 32 And .Type <> 35 And .Type <> 191 And .Type <> 193 And .Type <> 49 And .Type <> 134 And Not .Type = 158 And Not .Type = 195 And Not .Type = 241 And Not ((.Type >= 154 And .Type <= 157)) Then 'walldeath stuff
                                                        .Location.SpeedX = Physics.NPCShellSpeed * 0.5 * .Direction
                                                        If NPCIsVeggie(.Type) Then
                                                            .Projectile = True
                                                        ElseIf .Type = 135 Then
                                                            NPCHit A, 4, A
                                                        ElseIf .Type = 291 Then
                                                            NPCHit A, 3, A
                                                        Else
                                                            NewEffect 75, .Location
                                                            .Killed = 3
                                                        End If
                                                    ElseIf .Type <> 48 And Not (NPCIsABlock(.Type) And Block(B).IsNPC > 0) And Not Block(B).IsNPC = 57 Then
                                                        addBelt = .Location.X
                                                        If .Location.X + .Location.Width / 2 < Block(B).Location.X + Block(B).Location.Width * 0.5 Then
                                                            .Location.X = Block(B).Location.X - .Location.Width - 0.01
                                                        Else
                                                            .Location.X = Block(B).Location.X + Block(B).Location.Width + 0.01
                                                        End If
                                                        addBelt = .Location.X - addBelt
                                                        If .Type = 15 Then
                                                            .Location.SpeedY = 0
                                                            .Location.Y = Block(B).Location.Y - .Location.Height - 0.01
                                                        End If
                                                        If .Type <> 13 And .Type <> 78 And .Type <> 265 Then .TurnAround = True
                                                        If NPCIsAShell(.Type) = True Then
                                                            If .Location.X < Block(B).Location.X And .Location.SpeedX > 0 Then
                                                                .Location.SpeedX = -.Location.SpeedX
                                                            ElseIf .Location.X + .Location.Width > Block(B).Location.X + Block(B).Location.Width And .Location.SpeedX < 0 Then
                                                                .Location.SpeedX = -.Location.SpeedX
                                                            End If
                                                        End If
                                                      End If
                                                End If
                                                If .Projectile And Not .Type = 13 And Not .Type = 265 And Not .Type = 58 And Not (.Type = 21 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70) Then        'Hit the block if the NPC is a projectile
                                                    If HitSpot = 2 Or HitSpot = 4 Or HitSpot = 5 Then
                                                        BlockHit B
                                                        PlaySound 3
                                                        If .Type = 17 Then 'Bullet Bills
                                                            .Location.SpeedX = -.Location.SpeedX
                                                            NPCHit A, 4, A
                                                            BlockHitHard B
                                                            Exit For
                                                        End If
                                                        If NPCIsAShell(.Type) Or (.Type = 45 And .Special = 1) Or .Type = 263 Then
                                                            BlockHitHard B
                                                            If Block(B).Type = 4 Or Block(B).Type = 188 Or Block(B).Type = 60 Or Block(B).Type = 90 Then .TimeLeft = Physics.NPCTimeOffScreen
                                                        End If
                                                    End If
                                                End If
                                            End If
                                        'End If

                                        

End If
End If
End If
Else
    If (bCheck = 2 Or BlocksSorted = True) And PSwitchTime = 0 Then Exit For
End If
                                    Next B
                                    If numTempBlock = 0 Then Exit For
                                Next bCheck
                            End If
                            
                            If tempBlockHit(1) > 0 Then 'find out which block was hit from below
                                If tempBlockHit(2) = 0 Then
                                    winningBlock = tempBlockHit(1)
                                Else
                                    With Block(tempBlockHit(1)).Location
                                        C = .X + .Width * 0.5
                                    End With
                                    With Block(tempBlockHit(2)).Location
                                        D = .X + .Width * 0.5
                                    End With
                                    C = C - (.Location.X + .Location.Width * 0.5)
                                    D = D - (.Location.X + .Location.Width * 0.5)
                                    If C < 0 Then C = -C
                                    If D < 0 Then D = -D
                                    If C < D Then
                                        winningBlock = tempBlockHit(1)
                                    Else
                                        winningBlock = tempBlockHit(2)
                                    End If
                                End If
                                If .Type = 13 Or .Type = 265 Then 'Kill the fireball
                                    NPCHit A, 4
                                ElseIf .Projectile Or Block(winningBlock).Invis = True Then    'Hit the block hard if the NPC is a projectile
                                    If Not (.Type = 58 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70 Or .Type = 21) Then
                                        If .Location.SpeedY < -0.05 Then
                                            BlockHit winningBlock
                                            PlaySound 3
                                            If NPCIsAShell(.Type) Or .Type = 263 Then BlockHitHard winningBlock
                                        Else
                                            .Projectile = False
                                        End If
                                    End If
                                End If
                                If Not NPCIsAParaTroopa(.Type) Then
                                    .Location.Y = Block(winningBlock).Location.Y + Block(winningBlock).Location.Height + 0.01
                                    .Location.SpeedY = 0.01 + Block(B).Location.SpeedY
                                End If
                            End If
                            If NPCIsAShell(.Type) Then
                                If .Special > 0 Then
                                    .Location.SpeedX = .Location.SpeedX * 0.9
                                    .Frame = 0
                                    .FrameCount = 0
                                    If .Location.SpeedX > -0.3 And .Location.SpeedX < 0.3 Then
                                        .Location.SpeedX = 0
                                        .Special = 0
                                        .Projectile = False
                                    End If
                                End If
                            End If
                            If .Type = 78 And .Location.SpeedX <> 0 Then
                                .Location.SpeedX = 1 * .DefaultDirection
                            End If
 'beltspeed code
                            If resetBeltSpeed = False Then
                                If .Type = 86 And .Special = 1 Then
                                    .Special = 0
                                End If
                                If oldBeltSpeed >= 1 Or oldBeltSpeed <= -1 Then
                                    .BeltSpeed = oldBeltSpeed - .oldAddBelt
                                    beltCount = 1
                                    If .BeltSpeed >= 2.1 Then
                                        .BeltSpeed = .BeltSpeed - 0.1
                                    ElseIf .BeltSpeed <= -2.1 Then
                                        .BeltSpeed = .BeltSpeed + 0.1
                                    End If
                                 End If
                            End If
                            If .BeltSpeed <> 0 Then
                                preBeltLoc = .Location
                                .BeltSpeed = .BeltSpeed / beltCount
                                .BeltSpeed = .BeltSpeed * speedVar
                                .Location.X = .Location.X + .BeltSpeed
                                D = .BeltSpeed
                                tempLocation = .Location
                                tempLocation.Y = tempLocation.Y + 1
                                tempLocation.Height = tempLocation.Height - 2
                                tempLocation.Width = tempLocation.Width / 2
                                If .BeltSpeed > 0 Then
                                    tempLocation.X = tempLocation.X + tempLocation.Width
                                End If
                                    If Not (.Type >= 79 And .Type <= 83) And .Inert = False Then
                                        For C = 1 To numNPCs
                                            If A <> C And NPC(C).Active = True And NPC(C).Projectile = False Then
                                                If NPC(C).Killed = 0 And NPC(C).standingOnPlayer = 0 And NPC(C).HoldingPlayer = 0 And NPCNoClipping(NPC(C).Type) = False And NPC(C).Effect = 0 And NPC(C).Inert = False Then   'And Not NPCIsABlock(NPC(C).Type) Then
                                                    tempLocation2 = preBeltLoc
                                                    tempLocation2.Width = tempLocation2.Width - 4
                                                    tempLocation2.X = tempLocation2.X + 2
                                                    If CheckCollision(tempLocation, NPC(C).Location) Then
                                                        If Not CheckCollision(tempLocation2, NPC(C).Location) Then
                                                            If .TimeLeft - 1 > NPC(C).TimeLeft Then
                                                                NPC(C).TimeLeft = .TimeLeft - 1
                                                            ElseIf .TimeLeft < NPC(C).TimeLeft - 1 Then
                                                                .TimeLeft = NPC(C).TimeLeft - 1
                                                            End If
                                                            .onWall = True
                                                            If (.Location.SpeedX > 0 And NPC(C).Location.X > .Location.X) Or (.Location.SpeedX < 0 And NPC(C).Location.X < .Location.X) Then
                                                                .TurnAround = True
                                                            End If
                                                            If (NPC(C).Location.SpeedX > 0 And .Location.X > NPC(C).Location.X) Or (NPC(C).Location.SpeedX < 0 And .Location.X < NPC(C).Location.X) Then
                                                                NPC(C).TurnAround = True
                                                            End If
                                                            .Location = preBeltLoc
                                                        End If
                                                    End If
                                                End If
                                            End If
                                        Next C
                                    End If
                                If .Location.X = preBeltLoc.X Then
                                    .BeltSpeed = 0
                                    addBelt = 0
                                    If .tempBlock > 0 Then Block(.tempBlock).Location.SpeedX = 0
                                End If
                            End If
                            If .onWall = False Then .BeltSpeed = .BeltSpeed + addBelt
                            .oldAddBelt = addBelt
                            If beltClear = True Then .BeltSpeed = 0
                            
                            If .Type = 37 Or .Type = 180 Then
                                .BeltSpeed = 0
                            End If
'End Block Collision
                            'If .Type = 12 Then .Projectile = True 'Stop the big fireballs from getting killed from tha lava
                            If .Type = 194 Then .Projectile = True
                            
                            If .Type = 179 Then
                                .Location.Height = NPCHeight(.Type)
                                .Projectile = True
                            End If
                            
'NPC Collision

If .Inert = False And .Type <> 159 And .Type <> 22 And .Type <> 26 And Not (.Type = 30 And .Projectile = False) And .Type <> 32 And .Type <> 35 And Not (.Type = 40 And .Projectile = False) And Not ((.Type = 58 Or .Type = 60 Or .Type = 62 Or .Type = 64 Or .Type = 66 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70 Or .Type = 21) And .Projectile = False) And Not (.Type = 45 And .Special = 0) And Not (.Type = 48 And .Projectile = False) And .Type <> 49 And .Type <> 46 And .Type <> 56 And Not .Type = 57 And Not NPCIsYoshi(.Type) And Not (.Type >= 78 And .Type <= 83) And Not (.Type = 96 And .Projectile = False) And Not (.Type >= 117 And .Type <= 120 And .Projectile = True And .CantHurt > 0) And Not (NPCIsAShell(.Type) And .Projectile = False) And Not (.Projectile = True And .Type >= 117 And .Type <= 120) And .Type <> 133 And Not (NPCIsToad(.Type) = False And .Projectile = False And .Location.SpeedX = 0 And (.Location.SpeedY = 0 Or .Location.SpeedY = Physics.NPCGravity)) Then
If Not NPCIsACoin(.Type) And .Type <> 240 And .Type <> 212 And .Type <> 205 And .Type <> 206 And .Type <> 207 And .Type <> 191 And .Type <> 193 And Not (NPCIsCheep(.Type) And .Special = 2) And Not .Generator = True And .Type <> 246 And .Type <> 260 And .Type <> 276 And .Type <> 278 And .Type <> 279 And .Type <> 282 And .Type <> 288 And .Type <> 289 Then

                                For B = 1 To numNPCs
                                    If NPC(B).Active = True Then
                                        If Not NPCIsACoin(NPC(B).Type) Then
                                            If CheckCollision(.Location, NPC(B).Location) = True Then
                                                If B <> A Then
                                                    If Not (NPC(B).Type = 15 And NPC(B).Special = 4) And Not (NPCIsToad(NPC(B).Type)) And Not (NPC(B).Type >= 104 And NPC(B).Type <= 106) And Not (NPC(B).Type >= 154 And NPC(B).Type <= 157) And Not NPC(B).Type = 159 And Not NPC(B).Type = 202 And NPCIsAVine(NPC(B).Type) = False And NPC(B).Type <> 265 And NPC(B).Type <> 260 And NPC(B).Type <> 291 Then
                                                        'If Not (NPC(B).Type = 133) And NPC(B).HoldingPlayer = 0 And .Killed = 0 And NPC(B).JustActivated = 0 And NPC(B).Inert = False And NPC(B).Killed = 0 Then
                                                        If Not (NPC(B).Type = 133) And Not (NPCIsVeggie(NPC(B).Type) And NPCIsVeggie(.Type)) And NPC(B).HoldingPlayer = 0 And .Killed = 0 And NPC(B).JustActivated = 0 And NPC(B).Inert = False And NPC(B).Killed = 0 Then
                                                            
                                                            
                                                            
                                                            If NPC(B).Type <> 22 And NPC(B).Type <> 266 And NPC(B).Type <> 49 And NPC(B).Type <> 26 And NPC(B).Type <> 30 And NPC(B).Type <> 31 And NPC(B).Type <> 32 And NPC(B).Type <> 35 And NPC(B).Type <> 56 And Not NPC(B).Type = 50 And Not NPC(B).Type = 57 And Not NPC(B).Type = 58 And NPC(B).Type <> 191 And NPC(B).Type <> 193 And Not NPC(B).Generator = True And Not ((.Type = 13 Or .Type = 265) And NPC(B).Type = 195) And NPC(B).Type <> 240 And NPC(B).Type <> 278 And NPC(B).Type <> 279 And NPC(B).Type <> 288 And NPC(B).Type <> 289 And NPC(B).Type <> 291 And NPC(B).Type <> 171 And NPC(B).Type <> 292 Then
                                                            If Not (NPC(B).Type = 67 Or NPC(B).Type = 60 Or NPC(B).Type = 62 Or NPC(B).Type = 64 Or NPC(B).Type = 66 Or NPC(B).Type = 68 Or NPC(B).Type = 69 Or NPC(B).Type = 70) And Not (.Projectile = False And NPC(B).Type = 48) And NPCIsYoshi(NPC(B).Type) = False And NPC(B).Type <> 46 And NPC(B).Type <> 212 And Not (NPC(B).Type = 45 And NPC(B).Special = 0) And Not NPC(B).Type = 57 And Not (NPC(B).Type >= 78 And NPC(B).Type <= 83) And Not NPC(B).Type = 84 And Not NPC(B).Type = 85 And Not (NPC(B).Type = 17 And NPC(B).CantHurt > 0) And Not NPC(B).Type = 91 And Not (.CantHurtPlayer = NPC(B).CantHurtPlayer And .CantHurtPlayer > 0) And Not (NPC(B).Type = 96 And NPC(B).Projectile = False) And Not NPC(B).Type = 108 And Not NPC(B).Type = 246 And NPC(B).Type <> 276 And NPC(B).Type <> 282 And NPC(B).Type <> 225 And NPC(B).Type <> 226 And NPC(B).Type <> 227 Then
                                                                
                                                                If .Type = 269 Or NPC(B).Type = 269 Or .Type = 282 Or NPC(B).Type = 282 Then
                                                                    HitSpot = 0
                                                                End If
                                                                
                                                                If .Type = 283 Then
                                                                    NPCHit A, 3, B
                                                                    HitSpot = 0
                                                                ElseIf NPC(B).Type = 283 Then
                                                                    NPCHit B, 3, A
                                                                End If
                                                                
                                                                
                                                                If .Type = 266 Then
                                                                    If NPCIsABonus(NPC(B).Type) = False Then
                                                                        NPCHit B, 10, .CantHurtPlayer
                                                                    End If
                                                                    HitSpot = 0
                                                                End If
                                                                
                                                                'toad code
                                                                If NPCIsToad(NPC(A).Type) = True Then
                                                                    If Not (NPCWontHurt(NPC(B).Type) And NPC(B).Projectile = False) And Not NPCIsABonus(NPC(B).Type) And Not NPC(B).Type = 13 And Not NPC(B).Type = 265 And Not (NPC(B).Type = 17 And NPC(B).CantHurt > 0) And Not NPC(B).Type = 50 And Not NPC(B).Type = 171 And Not NPC(B).Type = 292 And Not NPC(B).Type = 195 Then
                                                                        NPCHit A, 3, B
                                                                        HitSpot = 0
                                                                    End If
                                                                End If
                                                                'Koopa Code
                                                                If (.Type = 117 Or .Type = 118 Or .Type = 120) And .Projectile = False And (NPC(B).Projectile = False And NPC(B).Type >= 113 And NPC(B).Type <= 116) Then
                                                                    tempLocation = .Location
                                                                    tempLocation2 = NPC(B).Location
                                                                    tempLocation.Width = 8
                                                                    tempLocation.X = tempLocation.X + 12
                                                                    tempLocation2.Width = 8
                                                                    tempLocation2.X = tempLocation2.X + 12
                                                                    If CheckCollision(tempLocation, tempLocation2) Then
                                                                        NPC(B).Type = NPC(B).Type - 4
                                                                        If NPC(B).Type = 112 Then NPC(B).Type = 194
                                                                        .Killed = 9
                                                                        NPC(B).Direction = .Direction
                                                                        NPC(B).Frame = EditorNPCFrame(NPC(B).Type, NPC(B).Direction)
                                                                    End If
                                                                'NPC is a projectile
                                                                ElseIf .Projectile = True And Not (NPC(B).Type = 45 And NPC(B).Special = 0) And Not .Type = 266 Then
                                                                    If Not (.Projectile = True And NPC(B).Projectile = True And .Type = 17 And NPC(B).Type = 17 And .CantHurtPlayer <> NPC(B).CantHurtPlayer) Then
                                                                        If Not ((.Type = 13 And NPCIsABonus(NPC(B).Type)) Or NPC(B).Type = 13 Or NPC(B).Type = 87) Then
                                                                            If NPCIsAShell(.Type) And (NPC(B).Type = 55 Or NPC(B).Type = 119) And (.Direction <> NPC(B).Direction Or .Special > 0) And NPC(B).Projectile = False Then
                                                                                If .Direction = -1 Then
                                                                                    NPC(B).Frame = 3
                                                                                    If NPC(B).Type = 119 Then NPC(B).Frame = 5
                                                                                    NPC(B).FrameCount = 0
                                                                                Else
                                                                                    NPC(B).Frame = 0
                                                                                    NPC(B).FrameCount = 0
                                                                                End If
                                                                                If .CantHurt < 25 Then .Special = 1
                                                                                If .Location.X + .Location.Width / 2 > NPC(B).Location.X + NPC(B).Location.Width / 2 Then
                                                                                    NPC(B).Location.X = .Location.X - NPC(B).Location.Width - 1
                                                                                    NPC(B).Direction = 1
                                                                                Else
                                                                                    NPC(B).Location.X = .Location.X + .Location.Width + 1
                                                                                    NPC(B).Direction = -1
                                                                                End If
                                                                                If .Location.SpeedY < NPC(B).Location.SpeedY Then .Location.SpeedY = NPC(B).Location.SpeedY
                                                                                .Frame = 0
                                                                                .FrameCount = 0
                                                                                If .CantHurt < 25 Then .Special = 2
                                                                                NPC(B).Special = 0
                                                                                tempLocation = NPC(B).Location
                                                                                tempLocation.Y = tempLocation.Y + 1
                                                                                tempLocation.Height = tempLocation.Height - 2
                                                                                For bCheck2 = 1 To 2
                                                                                    If bCheck2 = 1 Then
                                                                                        fBlock2 = FirstBlock((NPC(B).Location.X / 32) - 1)
                                                                                        lBlock2 = LastBlock(((NPC(B).Location.X + NPC(B).Location.Width) / 32) + 1)
                                                                                    Else
                                                                                        fBlock2 = numBlock - numTempBlock
                                                                                        lBlock2 = numBlock
                                                                                    End If
                                                                                    For C = fBlock2 To lBlock2
                                                                                            If Not BlockIsSizable(Block(C).Type) And Not BlockOnlyHitspot1(Block(C).Type) And Block(C).Hidden = False And BlockSlope(Block(C).Type) = 0 Then
                                                                                                If CheckCollision(tempLocation, Block(C).Location) = True Then
                                                                                                    If .Direction = -1 Then
                                                                                                        NPC(B).Location.X = Block(C).Location.X + Block(C).Location.Width + 0.1
                                                                                                        .Location.X = NPC(B).Location.X + NPC(B).Location.Width + 0.1
                                                                                                    Else
                                                                                                        NPC(B).Location.X = Block(C).Location.X - NPC(B).Location.Width - 0.1
                                                                                                        .Location.X = NPC(B).Location.X - .Location.Width - 0.1
                                                                                                    End If
                                                                                                End If
                                                                                            End If
                                                                                        Next C
                                                                                Next bCheck2
                                                                            ElseIf .Type = 78 Then
                                                                                NPCHit B, 8, A
                                                                            Else
                                                                                If Not NPCIsABonus(NPC(B).Type) Then
                                                                                    If .Type = 21 And NPC(B).Type = 17 Then
                                                                                        NPC(B).Projectile = True
                                                                                    Else
                                                                                        tempBool = False ' This whole cluster stops friendly projectiles form killing riddin shells
                                                                                        If NPCIsAShell(NPC(A).Type) = True Then
                                                                                            For C = 1 To numPlayers
                                                                                                If Player(C).StandingOnNPC = A And NPC(B).CantHurtPlayer = C Then
                                                                                                    tempBool = True
                                                                                                    Exit For
                                                                                                End If
                                                                                            Next C
                                                                                        End If
                                                                                        If NPCIsAShell(NPC(B).Type) = True Then
                                                                                            For C = 1 To numPlayers
                                                                                                If Player(C).StandingOnNPC = B And NPC(A).CantHurtPlayer = C Then
                                                                                                    tempBool = True
                                                                                                    Exit For
                                                                                                End If
                                                                                            Next C
                                                                                        End If
                                                                                        If Not (.Type = 17 And .Projectile = True) Then
                                                                                            If NPCIsAShell(NPC(B).Type) And NPC(B).Projectile = True Then
                                                                                                If tempBool = False Then NPCHit A, 3, B
                                                                                            Else
                                                                                                If tempBool = False Then NPCHit A, 4, B
                                                                                            End If
                                                                                        End If
                                                                                        If tempBool = False Then NPCHit B, 3, A ' end cluster
                                                                                        If .Type = 17 Then
                                                                                            If NPC(B).Type = 15 Then
                                                                                                .Location.SpeedX = -.Location.SpeedX
                                                                                                NPCHit A, 4, B
                                                                                            ElseIf NPC(B).Type = 21 Then
                                                                                                .Location.SpeedX = -.Location.SpeedX
                                                                                                PlaySound 3
                                                                                                NPCHit A, 4, A
                                                                                            End If
                                                                                        End If
                                                                                    End If
                                                                                End If
                                                                            End If
                                                                        End If
                                                                    End If
                                                               ElseIf Not (NPC(B).Type = 40 And NPC(B).Projectile = False) Then
                                                                    HitSpot = FindCollision(.Location, NPC(B).Location)
                                                                    If NPCIsToad(.Type) And .Killed > 0 Then HitSpot = 0
                                                                    If NPCIsAParaTroopa(.Type) And NPCIsAParaTroopa(NPC(B).Type) Then
                                                                        If .Location.X + .Location.Width / 2 > NPC(B).Location.X + NPC(B).Location.Width / 2 Then
                                                                            .Location.SpeedX = .Location.SpeedX + 0.05
                                                                        Else
                                                                            .Location.SpeedX = .Location.SpeedX - 0.05
                                                                        End If
                                                                        If .Location.Y + .Location.Height / 2 > NPC(B).Location.Y + NPC(B).Location.Height / 2 Then
                                                                            .Location.SpeedY = .Location.SpeedY + 0.05
                                                                        Else
                                                                            .Location.SpeedY = .Location.SpeedY - 0.05
                                                                        End If
                                                                        HitSpot = 0
                                                                    End If

                                                                    If NPC(B).Projectile = False And NPCNoClipping(.Type) = False And NPCNoClipping(NPC(B).Type) = False Then
                                                                        If ((.Type = 55 Or .Type = 119) And NPCIsAShell(NPC(B).Type)) Or ((NPC(B).Type = 55 Or NPC(B).Type = 119) And NPCIsAShell(.Type)) Then  ' Nekkid koopa kicking a shell
                                                                            If .Type = 55 Or .Type = 119 Then
                                                                                If .Location.SpeedY = Physics.NPCGravity Or .Slope > 0 Then
                                                                                    'If .Direction = 1 And .Location.X + .Location.Width < NPC(B).Location.X + 3 Or (.Direction = -1 And .Location.X > NPC(B).Location.X + NPC(B).Location.Width - 3) Then
                                                                                    If .Direction = 1 And .Location.X + .Location.Width < NPC(B).Location.X + 4 Or (.Direction = -1 And .Location.X > NPC(B).Location.X + NPC(B).Location.Width - 4) Then
                                                                                        If NPC(B).Location.SpeedX = 0 And NPC(B).Effect = 0 Then
                                                                                            .Special = 10
                                                                                            Player(numPlayers + 1).Direction = .Direction
                                                                                            .Location.X = .Location.X - .Direction
                                                                                            NPCHit B, 1, numPlayers + 1
                                                                                        End If
                                                                                    End If
                                                                                End If
                                                                            End If
                                                                        ElseIf (HitSpot = 2 Or HitSpot = 4) And .Type <> 179 And NPC(B).Type <> 179 Then
                                                                            .onWall = True
                                                                            If .Direction = NPC(B).Direction Then
                                                                                If .Location.SpeedX * .Direction > NPC(B).Location.SpeedX * NPC(B).Direction Then
                                                                                    If .Type <> 17 And .Type <> 13 And .Type <> 265 Then .TurnAround = True
                                                                                ElseIf .Location.SpeedX * .Direction < NPC(B).Location.SpeedX * NPC(B).Direction Then
                                                                                    NPC(B).TurnAround = True
                                                                                Else
                                                                                    .TurnAround = True
                                                                                    NPC(B).TurnAround = True
                                                                                End If
                                                                            Else
                                                                                If .Type <> 17 And .Type <> 13 And .Type <> 265 Then .TurnAround = True
                                                                                NPC(B).TurnAround = True
                                                                            End If
                                                                        End If
                                                                    End If
                                                                End If
                                                            End If
                                                            End If
                                                        End If
                                                    End If
                                                End If
                                            End If
                                        End If
                                    End If
                                Next B
                                End If
                            End If
                            If .WallDeath > 0 Then
                                If NPCIsCheep(.Type) = True Then
                                    .WallDeath = .WallDeath - 1
                                Else
                                    .WallDeath = 0
                                End If
                            End If
                            If tempHit <> 0 Then  'Walking
                                If .Type = 3 Then 'Walking code for Flying Goomba
                                    If .Special <= 30 Then
                                        .Special = .Special + 1
                                        .Location.SpeedY = 0
                                        If .Slope > 0 Then
                                            .Location.SpeedY = .Location.SpeedX * (Block(.Slope).Location.Height / Block(.Slope).Location.Width) * BlockSlope(Block(.Slope).Type)
                                            If .Location.SpeedY < 0 Then .Location.SpeedY = 0
                                        End If
                                        If tempSpeedA <> 0 Then
                                            .Location.SpeedY = tempSpeedA
                                        End If
                                    ElseIf .Special = 31 Then
                                        .Special = .Special + 1
                                        .Location.SpeedY = -4
                                    ElseIf .Special = 32 Then
                                        .Special = .Special + 1
                                        .Location.SpeedY = -4
                                    ElseIf .Special = 33 Then
                                        .Special = .Special + 1
                                        .Location.SpeedY = -4
                                    ElseIf .Special = 34 Then
                                        .Special = 0
                                        .Location.SpeedY = -7
                                    End If
                                ElseIf .Type = 167 Then 'Walking code for SMW Flying Goomba
                                    If .Special <= 60 Then
                                        .Special = .Special + 1
                                        .Location.SpeedY = 0
                                        If .Slope > 0 Then
                                            .Location.SpeedY = .Location.SpeedX * (Block(.Slope).Location.Height / Block(.Slope).Location.Width) * BlockSlope(Block(.Slope).Type)
                                            If .Location.SpeedY < 0 Then .Location.SpeedY = 0
                                        End If
                                        If tempSpeedA <> 0 Then
                                            .Location.SpeedY = tempSpeedA
                                        End If
                                    ElseIf .Special = 61 Then
                                        .Special = .Special + 1
                                        .Location.SpeedY = -3
                                    ElseIf .Special = 62 Then
                                        .Special = .Special + 1
                                        .Location.SpeedY = -3
                                    ElseIf .Special = 63 Then
                                        .Special = .Special + 1
                                        .Location.SpeedY = -3
                                    ElseIf .Special = 64 Then
                                        .Special = .Special + 1
                                        .Location.SpeedY = -3
                                    ElseIf .Special = 65 Then
                                        .Special = 0
                                        .Location.SpeedY = -7
                                    End If
                                ElseIf NPCTurnsAtCliffs(.Type) = True And .Projectile = False Then  'Walking code NPCs that turn
                                    tempTurn = True
                                    tempLocation = .Location
                                    tempLocation.SpeedX = 0
                                    tempLocation.SpeedY = 0
                                    tempLocation.Y = .Location.Y + .Location.Height - 8
                                    tempLocation.Height = 16
                                    If .Slope > 0 Then tempLocation.Height = 32
                                    tempLocation.Width = 16
                                    'If .Location.SpeedX > 0 Then
                                    If .Direction > 0 Then
                                        tempLocation.X = tempLocation.X + .Location.Width - 20
                                        If .Type = 247 And .Special2 = 0 Then tempLocation.X = tempLocation.X + 16
                                        
                                        'If .Type = 189 Then tempLocation.X = tempLocation.X - 10
                                    Else
                                        tempLocation.X = tempLocation.X - tempLocation.Width + 20
                                        If .Type = 247 And .Special2 = 0 Then tempLocation.X = tempLocation.X - 16
                                        
                                        'If .Type = 189 Then tempLocation.X = tempLocation.X + 10
                                    End If
                                    For bCheck2 = 1 To 2
                                        If bCheck2 = 1 Then
                                            fBlock2 = FirstBlock((tempLocation.X / 32) - 1)
                                            lBlock2 = LastBlock(((tempLocation.X + tempLocation.Width) / 32) + 1)
                                        Else
                                            fBlock2 = numBlock - numTempBlock
                                            lBlock2 = numBlock
                                        End If
                                        For B = fBlock2 To lBlock2
'                                            If BlockNoClipping(Block(B).Type) = False And Block(B).Invis = False And Block(B).Hidden = False And Not (BlockIsSizable(Block(B).Type) And Block(B).Location.Y < .Location.Y + .Location.Height - 3) Then
                                                
                                                
If tempLocation.X + tempLocation.Width >= Block(B).Location.X Then
If tempLocation.X <= Block(B).Location.X + Block(B).Location.Width Then
If tempLocation.Y + tempLocation.Height >= Block(B).Location.Y Then
If tempLocation.Y <= Block(B).Location.Y + Block(B).Location.Height Then
If BlockNoClipping(Block(B).Type) = False And Block(B).Invis = False And Block(B).Hidden = False And Not (BlockIsSizable(Block(B).Type) And Block(B).Location.Y < .Location.Y + .Location.Height - 3) Then
                                                'If CheckCollision(tempLocation, Block(B).Location) = True Then
                                                    tempTurn = False
                                                    Exit For
                                                'End If
End If
End If
End If
End If
Else
'not working
End If

                                                
                                                
                                                
                                            'End If
                                        Next B
                                    Next bCheck2
                                    If tempTurn = True Then
                                        .TurnAround = True
                                    End If
                                    .Location.SpeedY = 0
                                    If .Slope > 0 Then
                                        .Location.SpeedY = .Location.SpeedX * (Block(.Slope).Location.Height / Block(.Slope).Location.Width) * BlockSlope(Block(.Slope).Type)
                                        If .Location.SpeedY < 0 Then .Location.SpeedY = 0
                                    End If
                                    If tempSpeedA <> 0 Then
                                        .Location.SpeedY = tempSpeedA
                                    End If
                                ElseIf .Type = 77 Then 'ninja code
                                    tempTurn = True
                                    tempLocation = .Location
                                    tempLocation.SpeedX = 0
                                    tempLocation.SpeedY = 0
                                    tempLocation.Y = .Location.Y + .Location.Height - 8
                                    tempLocation.Height = 16
                                    If .Slope > 0 Then tempLocation.Height = 32
                                    tempLocation.Width = 16
                                    If .Location.SpeedX > 0 Then
                                        tempLocation.X = .Location.X + .Location.Width - 16
                                    Else
                                        tempLocation.X = .Location.X - tempLocation.Width + 16
                                    End If
                                    For bCheck2 = 1 To 2
                                        If bCheck2 = 1 Then
                                            fBlock2 = FirstBlock((tempLocation.X / 32) - 1)
                                            lBlock2 = LastBlock(((tempLocation.X + tempLocation.Width) / 32) + 1)
                                        Else
                                            fBlock2 = numBlock - numTempBlock
                                            lBlock2 = numBlock
                                        End If
                                        For B = fBlock2 To lBlock2
                                            If BlockNoClipping(Block(B).Type) = False And Block(B).Invis = False And Block(B).Hidden = False And Not (BlockIsSizable(Block(B).Type) And Block(B).Location.Y < .Location.Y + .Location.Height - 3) Then
                                                If CheckCollision(tempLocation, Block(B).Location) = True Then
                                                    tempTurn = False
                                                    Exit For
                                                End If
                                            End If
                                        Next B
                                    Next bCheck2
                                    tempLocation = .Location
                                    tempLocation.SpeedX = 0
                                    tempLocation.SpeedY = 0
                                    tempLocation.Y = .Location.Y + 8
                                    tempLocation.Height = tempLocation.Height - 16
                                    tempLocation.Width = 32
                                    If .Location.SpeedX > 0 Then
                                        tempLocation.X = .Location.X + .Location.Width
                                    Else
                                        tempLocation.X = .Location.X - tempLocation.Width
                                    End If
                                    For bCheck2 = 1 To 2
                                        If bCheck2 = 1 Then
                                            fBlock2 = FirstBlock((tempLocation.X / 32) - 1)
                                            lBlock2 = LastBlock(((tempLocation.X + tempLocation.Width) / 32) + 1)
                                        Else
                                            fBlock2 = numBlock - numTempBlock
                                            lBlock2 = numBlock
                                        End If
                                        For B = fBlock2 To lBlock2
                                            If BlockNoClipping(Block(B).Type) = False And Block(B).Invis = False And Block(B).Hidden = False And Not (BlockIsSizable(Block(B).Type) And Block(B).Location.Y < .Location.Y + .Location.Height - 1) Then
                                                If CheckCollision(tempLocation, Block(B).Location) = True Then
                                                    If .Slope > 0 Then

                                                    ElseIf BlockSlope(Block(B).Type) = 0 Then
                                                        tempTurn = True
                                                    End If
                                                    Exit For
                                                End If
                                            End If
                                        Next B
                                    Next bCheck2
                                    If tempTurn = True Then
                                        .Location.Y = .Location.Y - 0.1
                                        .Location.SpeedY = -6.55
                                    Else
                                        .Location.SpeedY = 0
                                        If .Slope > 0 Then
                                            .Location.SpeedY = .Location.SpeedX * (Block(.Slope).Location.Height / Block(.Slope).Location.Width) * BlockSlope(Block(.Slope).Type)
                                            If .Location.SpeedY < 0 Then .Location.SpeedY = 0
                                        End If
                                    End If
                                    If tempSpeedA <> 0 Then
                                        .Location.SpeedY = .Location.SpeedY + tempSpeedA
                                    End If
                                Else 'Walking code for everything else
                                    If NPCIsAParaTroopa(.Type) Then
                                        If .Special = 1 Then
                                            .Location.SpeedY = -9
                                        Else
                                            If .Location.SpeedY > 0 Then .Location.SpeedY = -.Location.SpeedY
                                        End If
                                    Else
                                        .Location.SpeedY = 0
                                        If .Slope > 0 And NPCIsAShell(.Type) = False And .Type <> 45 Then
                                            .Location.SpeedY = .Location.SpeedX * (Block(.Slope).Location.Height / Block(.Slope).Location.Width) * BlockSlope(Block(.Slope).Type)
                                            If .Location.SpeedY < 0 Then .Location.SpeedY = 0
                                        End If
                                    End If
                                    If .Type = 129 Then
                                        .Special = .Special + 1
                                        If .Special <= 3 Then
                                            .Location.SpeedY = -3.5
                                        Else
                                            .Location.SpeedY = -5.5
                                            .Special = 0
                                        End If
                                    End If
                                    If .Type = 125 Then
                                        .FrameCount = .FrameCount + 1
                                        If .FrameCount > 1 Then .FrameCount = 0
                                        .Location.SpeedY = -3
                                    End If
                                    If tempSpeedA <> 0 Then
                                        .Location.SpeedY = tempSpeedA
                                    End If
                                    If .Type = 179 Then
                                        .Special = .Location.SpeedY
                                    End If
                                    
                                End If
                                If .Slope = 0 Then .Location.Y = tempHit
                                tempHit = 0
                                If Block(tempHitBlock).IsNPC > 0 And NPC(Block(tempHitBlock).IsReally).Slope > 0 Then
                                    '.Location.SpeedY = 0
                                    .Slope = NPC(Block(tempHitBlock).IsReally).Slope
                                    'Stop
                                End If
                            End If
                         End If
                    End If
                    If .tempBlock > 0 And (.Type < 60 Or .Type > 66) And .Type <> 57 Then
                        If (.Type < 78 Or .Type > 83) And .Type <> 26 Then
                            Block(.tempBlock).Location = .Location
                            If .Type = 26 Then
                                Block(.tempBlock).Location.Y = Block(.tempBlock).Location.Y - 16
                                Block(.tempBlock).Location.Height = Block(.tempBlock).Location.Height + 16
                            End If
                            Do While Block(.tempBlock).Location.X < Block(.tempBlock - 1).Location.X And .tempBlock > numBlock + 1 - numTempBlock
                                
                                tmpBlock = Block(.tempBlock - 1)
                                Block(.tempBlock - 1) = Block(.tempBlock)
                                Block(.tempBlock) = tmpBlock
                                
                                NPC(Block(.tempBlock).IsReally).tempBlock = .tempBlock
                                .tempBlock = .tempBlock - 1
                                
                            Loop
                            Do While Block(.tempBlock).Location.X > Block(.tempBlock + 1).Location.X And .tempBlock < numBlock
                                
                                
                                tmpBlock = Block(.tempBlock + 1)
                                Block(.tempBlock + 1) = Block(.tempBlock)
                                Block(.tempBlock) = tmpBlock
                                
                                NPC(Block(.tempBlock).IsReally).tempBlock = .tempBlock
                                .tempBlock = .tempBlock + 1
                                
                                
                                
                                
                                'NPC(Block(.tempBlock).IsReally).tempBlock = .tempBlock
                                'NPC(Block(.tempBlock + 1).IsReally).tempBlock = .tempBlock + 1
                                
                                
                            Loop
                        End If
                        Block(.tempBlock).Location.SpeedX = .Location.SpeedX + .BeltSpeed
                    End If
                    If .Projectile = True Then
                        If .Type = 179 Or .Type = 58 Or .Type = 21 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70 Or (.Type >= 78 And .Type <= 83) Then .Projectile = False
                    End If
'Pinched code
                    'If .Direction <> oldDirection Then
                        '.PinchCount = .PinchCount + 10
                    'Else
                        'If .PinchCount > 0 Then
                            '.PinchCount = .PinchCount - 1
                        'If .Pinched = False Then .PinchCount = .PinchCount - 1
                        'End If
                    'End If
                    'If .PinchCount >= 14 And .Pinched = False Then
                        '.Pinched = True
                        '.PinchedDirection = .Direction
                    'ElseIf .PinchCount >= 15 Then
                        '.PinchCount = 15
                    'ElseIf .PinchCount = 0 Then
                        '.Pinched = False
                    'End If
                    .Pinched = False
'Special Code for things that work while held
                    If .Type = 134 Then 'SMB2 Bomb
                        'If .Location.SpeedX < -2 Or .Location.SpeedX > 2 Or .Location.SpeedY < -2 Or .Location.SpeedY > 5 Then .Projectile = True
                        .Special = .Special + 1
                        If .Special > 250 Then .Special2 = 1
                        If .Special >= 350 Or .Special < 0 Then
                            Bomb .Location, 2
                            .Killed = 9
                        End If
                    ElseIf .Type = 135 Then 'SMB2 Bob-om
                        .Special = .Special + 1
                        If .Special > 450 Then .Special2 = 1
                        If .Special >= 550 Or .Special < 0 Then
                            Bomb .Location, 2
                            .Killed = 9
                        End If
                    ElseIf .Type = 137 Then 'SMB3 Bomb
                        If .Inert = False Then .Special = .Special + 1
                        If .Special > 250 Then .Special2 = 1
                        If .Special >= 350 Or .Special < 0 Then
                            Bomb .Location, 3
                        End If
                    ElseIf .Type = 189 Then
                        If .Special > 0 Then
                            .Special2 = .Special2 + 1
                            If .Special2 >= 400 And .Special3 = 0 Then
                                .Special = 0
                                .Special2 = 0
                                .Inert = False
                                .Stuck = False
                            ElseIf .Special2 >= 300 Then
                                If .Special3 = 0 Then
                                    .Location.X = .Location.X + 2
                                    .Special3 = 1
                                Else
                                    .Location.X = .Location.X - 2
                                    .Special3 = 0
                                End If
                            End If
                        End If
                    ElseIf .Type = 86 Then 'smb3 bowser
                        'special5 - the player
                        'special4 - what bowser is doing
                        'special3 - counter for what bowser is doing
                        'special2 - counter for what bowser needs to do
                        If .Legacy = True Then
                            If .TimeLeft > 1 Then
                                .TimeLeft = 100
                                If bgMusic(.Section) <> 21 Then
                                    StopMusic
                                    bgMusic(.Section) = 21
                                    StartMusic .Section
                                End If
                            End If
                        End If
                        If .Special4 = 0 Then
                            .Special3 = 0 'reset counter when done
                            If .Direction < 0 Then
                                .Frame = 0
                            Else
                                .Frame = 5
                            End If
                        End If
                        If .Special5 = 0 Then 'find player
                            tempBool = False
                            For B = 1 To numPlayers
                                If Player(B).Dead = False And Player(B).TimeToLive = 0 Then tempBool = True
                            Next B
                            If tempBool = False Then
                                .Special5 = 0
                                .Special4 = 2
                            Else
                                Do
                                    B = Int(Rnd * numPlayers) + 1
                                Loop While Player(B).Dead = True Or Player(B).TimeToLive > 0
                                .Special5 = B
                            End If
                        End If
                        'see if facing the player
                        tempBool = False
                        If .Special5 > 0 Then
                            If Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 < .Location.X + .Location.Width / 2 Then
                                If .Direction < 0 Then tempBool = True
                            Else
                                If .Direction > 0 Then tempBool = True
                            End If
                        End If
                        .Special2 = .Special2 + Rnd
                        If .Special4 = 0 And tempBool = True Then
                            If .Special2 >= 200 + Rnd * 400 - Rnd * 200 Then 'hop on player
                                If .Special2 >= 200 + Rnd * 600 Then .Special2 = 0
                                .Special4 = 3
                            ElseIf (.Special2 >= 80 And .Special2 <= 130) Or (.Special2 >= 160 + Rnd * 300 And .Special2 <= 180 + Rnd * 800) Then ' shoot fireball
                                .Special4 = 4
                            End If
                        End If
                        If .Inert = True Then
                            If .Special4 = 4 Or .Special4 = 3 Then .Special4 = 0
                        End If
                        If .Special4 = 0 Then 'when not doing anything turn to player
                            If tempBool = False Then
                                If .Direction > 0 Then .Special4 = -1
                                If .Direction < 0 Then .Special4 = 1
                            End If
                        End If
                        If .Special4 = 0 Then 'hop
                            .Special4 = 2
                        End If
                        If .HoldingPlayer > 0 Then
                            If .Direction = -1 Then
                                .Frame = 0
                            Else
                                .Frame = 5
                            End If
                            .Special4 = 9000
                        ElseIf .Special4 = 9000 Then
                            .Special5 = .CantHurtPlayer
                            .Special4 = 0
                            .Location.SpeedX = 0
                            .Location.SpeedY = 0
                        End If
                        If .Special4 = -1 Then 'turn left
                            .Special3 = .Special3 - 1
                            If .Special3 > -5 Then
                                .Frame = 9
                            ElseIf .Special3 > -10 Then
                                .Frame = 8
                            ElseIf .Special3 > -15 Then
                                .Frame = 12
                            ElseIf .Special3 > -20 Then
                                .Frame = 3
                            ElseIf .Special3 > -25 Then
                                .Frame = 4
                            Else
                                .Special4 = 0
                                .Direction = -1
                            End If
                        ElseIf .Special4 = 1 Then 'turn right
                            .Special3 = .Special3 + 1
                            If .Special3 < 5 Then
                                .Frame = 4
                            ElseIf .Special3 < 10 Then
                                .Frame = 3
                            ElseIf .Special3 < 15 Then
                                .Frame = 12
                            ElseIf .Special3 < 20 Then
                                .Frame = 8
                            ElseIf .Special3 < 25 Then
                                .Frame = 9
                            Else
                                .Special4 = 0
                                .Direction = 1
                            End If
                        ElseIf .Special4 = -10 Then 'look left
                            .Special3 = .Special3 - 1
                            If .Special3 > -5 Then
                                .Frame = 3
                            ElseIf .Special3 > -10 Then
                                .Frame = 4
                            Else
                                .Special4 = 0
                                .Direction = -1
                            End If
                        ElseIf .Special4 = 10 Then 'look right
                            .Special3 = .Special3 + 1
                            If .Special3 < 5 Then
                                .Frame = 8
                            ElseIf .Special3 < 10 Then
                                .Frame = 9
                            Else
                                .Special4 = 0
                                .Direction = 1
                            End If
                        ElseIf .Special4 = 2 Then 'hops
                            If .Location.SpeedY = 0 Or .Slope > 0 Then
                                If .Special3 < 5 Then
                                    .Special3 = .Special3 + 1
                                    If .Direction = -1 Then
                                        .Frame = 1
                                    Else
                                        .Frame = 6
                                    End If
                                ElseIf .Special3 = 5 Then
                                    .Special3 = .Special3 + 1
                                    .Location.SpeedY = -3
                                    .Location.Y = .Location.Y - 0.1
                                    If .Direction = -1 Then
                                        .Frame = 0
                                    Else
                                        .Frame = 5
                                    End If
                                ElseIf .Special3 < 10 Then
                                    .Special3 = .Special3 + 1
                                    If .Direction = -1 Then
                                        .Frame = 1
                                    Else
                                        .Frame = 6
                                    End If
                                Else
                                    .Special4 = 0
                                End If
                            End If
                        ElseIf .Special4 = 3 Then 'jump on player
                            If .Special3 < -1 Then
                                If .Special > 1 Then .Special = .Special - 1
                                .Special3 = .Special3 + 1
                                If .Special3 = -1 Then .Special3 = 6
                            ElseIf .Special3 < 5 Then
                                .Special3 = .Special3 + 1
                                If .Direction = -1 Then
                                    .Frame = 1
                                Else
                                    .Frame = 6
                                End If
                            ElseIf .Special3 = 5 Then
                                .Special3 = .Special3 + 1
                                .Location.SpeedY = -12
                                .BeltSpeed = 0
                                .Location.Y = .Location.Y - 0.1
                                .Location.SpeedX = (Int(((Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 - 16) + 1) / 32) * 32 + 1 - .Location.X) / 50
                                If .Location.SpeedX > 15 Then
                                    .Location.SpeedX = 15
                                ElseIf .Location.SpeedX < -15 Then
                                    .Location.SpeedX = -15
                                End If
                                .Special3 = -50
                                .Special = 10
                                If .Direction = -1 Then
                                    .Frame = 0
                                Else
                                    .Frame = 5
                                End If
                            ElseIf .Special3 = 6 Then
                                 If .Location.SpeedY > 0 Then
                                    .Frame = 10
                                    .Location.SpeedX = 0
                                    .Location.SpeedY = 0
                                    .Special3 = 10
                                    .Projectile = True
                                End If
                            ElseIf .Special3 < 13 Then
                                .Location.SpeedY = -2
                                .Special3 = .Special3 + 1
                            ElseIf .Special3 < 16 Then
                                .Location.SpeedY = 2
                                .Special3 = .Special3 + 1
                            ElseIf .Special3 < 19 Then
                                .Location.SpeedY = -2
                                .Special3 = .Special3 + 1
                            ElseIf .Special3 < 21 Then
                                .Location.SpeedY = 2
                                .Special3 = .Special3 + 1
                            ElseIf .Special3 = 21 Then
                                If .Location.SpeedY <> 0 Then
                                    .Location.SpeedY = 10
                                Else
                                    PlaySound 37
                                    .Special3 = 30
                                    .Frame = 11
                                    .Projectile = False
                                    tempLocation = .Location
                                    tempLocation.X = tempLocation.X '+ 16
                                    tempLocation.Width = tempLocation.Width '- 32
                                    tempLocation.Y = tempLocation.Y + tempLocation.Height - 8
                                    tempLocation.Height = 16
                                    fBlock = FirstBlock((.Location.X / 32) - 1)
                                    lBlock = LastBlock(((.Location.X + .Location.Width) / 32) + 1)
                                    For B = fBlock To lBlock
                                        If Block(B).Type = 186 And CheckCollision(tempLocation, Block(B).Location) = True And Block(B).Hidden = False Then
                                            KillBlock B
                                        End If
                                    Next B
                                    If .Legacy = True And 1 = 2 Then
                                        fBlock = FirstBlock((level(.Section).X / 32) - 1)
                                        lBlock = LastBlock(((level(.Section).Width) / 32) + 2)
                                        For B = fBlock To lBlock
                                            BlockShakeUp B
                                        Next B
                                        For B = 0 To maxSections
                                            If .Location.X >= level(B).X Then
                                                If .Location.X + .Location.Width <= level(B).Width Then
                                                    If .Location.Y + .Location.Height + 48 >= level(B).Y Then
                                                        If .Location.Y + .Location.Height + 48 <= level(B).Height Then
                                                            If B <> .Section Then
                                                                .Special2 = 0
                                                                .Special3 = 0
                                                                .Special4 = 2
                                                                If level(B).X < level(.Section).X Then level(.Section).X = level(B).X
                                                                If level(B).Y < level(.Section).Y Then level(.Section).Y = level(B).Y
                                                                If level(B).Width > level(.Section).Width Then level(.Section).Width = level(B).Width
                                                                If level(B).Height > level(.Section).Height Then level(.Section).Height = level(B).Height
                                                                level(B).X = 0
                                                                level(B).Y = 0
                                                                level(B).Width = 0
                                                                level(B).Height = 0
                                                                For C = 1 To numNPCs
                                                                    If NPC(C).Section = B Then NPC(C).Section = .Section
                                                                Next C
                                                            End If
                                                        End If
                                                    End If
                                                End If
                                            End If
                                        Next B
                                        SoundPause(2) = 12
                                    End If
                                  End If
                            ElseIf .Special3 < 35 Then
                                .Frame = 11
                                .Special3 = .Special3 + 1
                            ElseIf .Special3 < 40 Then
                                .Frame = 12
                                .Special3 = .Special3 + 1
                                .Special5 = 0
                            Else
                                If .Location.SpeedY = 0 Or .Slope > 0 Then
                                
                                
                                
                                    .Special3 = 0
                                    If Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 < .Location.X + .Location.Width / 2 Then
                                        .Special4 = -10
                                    Else
                                        .Special4 = 10
                                    End If
                                End If
                            End If
                        ElseIf .Special4 = 4 Then 'shoot a fireball
                            .Special3 = .Special3 + 1
                            If .Special3 < 15 Then
                                If .Direction = -1 Then
                                    .Frame = 13
                                Else
                                    .Frame = 14
                                End If
                            ElseIf .Special3 < 30 Then
                                If .Direction = -1 Then
                                    .Frame = 2
                                Else
                                    .Frame = 7
                                End If
                                If .Special3 = 29 Then
                                    numNPCs = numNPCs + 1
                                    With NPC(numNPCs)
                                        .Active = True
                                        .TimeLeft = 100
                                        .Direction = NPC(A).Direction
                                        .Section = NPC(A).Section
                                        .Type = 87
                                        If .Direction = 1 Then .Frame = 4
                                        .Location.Height = NPCHeight(.Type)
                                        .Location.Width = NPCWidth(.Type)
                                        If .Direction = -1 Then
                                            .Location.X = NPC(A).Location.X - 40
                                        Else
                                            .Location.X = NPC(A).Location.X + 54
                                        End If
                                        .Location.Y = NPC(A).Location.Y + 19
                                        .Location.SpeedX = 4 * .Direction
                                        C = (.Location.X + .Location.Width / 2) - (Player(NPC(A).Special5).Location.X + Player(NPC(A).Special5).Location.Width / 2)
                                        D = (.Location.Y + .Location.Height / 2) - (Player(NPC(A).Special5).Location.Y + Player(NPC(A).Special5).Location.Height / 2)
                                        .Location.SpeedY = D / C * .Location.SpeedX
                                        If .Location.SpeedY > 1 Then
                                            .Location.SpeedY = 1
                                        ElseIf .Location.SpeedY < -1 Then
                                            .Location.SpeedY = -1
                                        End If
                                        PlaySound 42
                                    End With
                                End If
                            ElseIf .Special3 < 45 Then
                                If .Direction = -1 Then
                                    .Frame = 0
                                Else
                                    .Frame = 5
                                End If
                            Else
                                .Special4 = 0
                            End If
                        End If
                        
                    ElseIf .Type = 29 And .HoldingPlayer > 0 Then
                            If Player(.HoldingPlayer).Effect = 0 Then .Special3 = .Special3 + 1
                            If .Special3 >= 20 Then
                                PlaySound 25
                                .Special3 = 0 ' -15
                                numNPCs = numNPCs + 1
                                NPC(numNPCs).Location.Height = 32
                                NPC(numNPCs).Location.Width = 32
                                NPC(numNPCs).Location.X = .Location.X
                                NPC(numNPCs).Location.Y = .Location.Y
                                NPC(numNPCs).Direction = .Direction
                                NPC(numNPCs).Type = 30
                                NPC(numNPCs).Shadow = .Shadow
                                NPC(numNPCs).CantHurt = 200
                                NPC(numNPCs).CantHurtPlayer = .HoldingPlayer
                                NPC(numNPCs).Active = True
                                NPC(numNPCs).Projectile = True
                                NPC(numNPCs).TimeLeft = 50
                                NPC(numNPCs).Location.SpeedY = -8
                                NPC(numNPCs).Location.SpeedX = 3 * Player(.HoldingPlayer).Direction + Player(.HoldingPlayer).Location.SpeedX * 0.8
                            End If
                    ElseIf .Type = 21 Or .Type = 22 Then 'Bullet Bill Shooter
                        If .Type = 21 Then
                            .Special = .Special + 1
                            If .HoldingPlayer > 0 Then
                                If Player(.HoldingPlayer).Effect = 0 Then .Special = .Special + 6
                            End If
                        Else
                            If .HoldingPlayer > 0 Then
                                If Player(.HoldingPlayer).SpinJump = True Then
                                    If .Direction <> Player(.HoldingPlayer).SpinFireDir Then
                                        If Player(.HoldingPlayer).Effect = 0 Then .Special = .Special + 20
                                    End If
                                Else
                                    If Player(.HoldingPlayer).Effect = 0 Then .Special = .Special + 10
                                End If
                            ElseIf .standingOnPlayer > 0 Then
                                .Special = .Special + 5
                            ElseIf .Projectile = True Then
                                '.Special = .Special + 10
                            End If
                        End If
                        If .Special >= 200 Then
                            If .HoldingPlayer > 0 Then
                                If Player(.HoldingPlayer).SpinJump = True Then Player(.HoldingPlayer).SpinFireDir = .Direction
                            End If
                            If .HoldingPlayer = 0 And .standingOnPlayer = 0 And .Type = 21 Then
                                C = 0
                                For B = 1 To numPlayers
                                    If Player(B).Dead = False And Player(B).Section = .Section Then
                                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                            If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                                                .Direction = -1
                                            Else
                                                .Direction = 1
                                            End If
                                            If CanComeOut(.Location, Player(B).Location) = False Then C = -1
                                        End If
                                    End If
                                Next B
                            End If
                            If numNPCs < maxNPCs Then
                                If C = -1 And .HoldingPlayer = 0 And .standingOnPlayer = 0 Then
                                    .Special = 0
                                ElseIf Player(.standingOnPlayer).Controls.Run = True Or .standingOnPlayer = 0 Then
                                    .Special = 0
                                    numNPCs = numNPCs + 1
                                    With NPC(numNPCs)
                                        .Inert = NPC(A).Inert
                                        tempBool = False
                                        .Direction = NPC(A).Direction
                                        If NPC(A).HoldingPlayer > 0 Or NPC(A).standingOnPlayer > 0 Or (NPC(A).Type = 22 And NPC(A).Projectile = True) Then
                                            .Projectile = True
                                            .CantHurt = 10000
                                            .CantHurtPlayer = NPC(A).HoldingPlayer
                                            .Location.SpeedX = 8 * .Direction
                                        ElseIf NPC(A).CantHurtPlayer > 0 Then
                                            .Projectile = True
                                            .CantHurt = 1000
                                            .CantHurtPlayer = NPC(A).CantHurtPlayer
                                        ElseIf NPC(A).Type = 22 Then
                                            tempBool = True
                                            numNPCs = numNPCs - 1
                                        End If
                                        If tempBool = False Then
                                            .Shadow = NPC(A).Shadow
                                            .Active = True
                                            .TimeLeft = 100
                                            .JustActivated = 0
                                            .Section = NPC(A).Section
                                            .Type = 17
                                            .Location.Width = NPCWidth(.Type)
                                            .Location.Height = NPCHeight(.Type)
                                            
                                            If .Direction = 1 Then
                                                .Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2
                                            Else
                                                .Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2 - .Location.Width
                                            End If
                                            
                                            If .Direction = 1 Then
                                                .Frame = 1
                                            Else
                                                .Frame = 0
                                            End If
                                            .Location.Y = NPC(A).Location.Y + NPC(A).Location.Height / 2 - .Location.Height / 2
                                            
                                            tempLocation = .Location
                                            tempLocation.X = .Location.X + (.Location.Width / 2) * .Direction
                                            tempLocation.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                                            NewEffect 10, tempLocation
                                            
                                            PlaySound 22
                                        End If
                                    End With
                                End If
                            End If
                        End If
                    ElseIf .Type = 50 Then
                        B = 0
                        If .Special > 0 Then
                            If Player(.Special).HoldingNPC > 0 Then
                                If NPC(Player(.Special).HoldingNPC).Type = 49 Then
                                    B = 1
                                End If
                            End If
                        ElseIf NPC(.Special2).Projectile = True And NPC(.Special2).Active = True Then
                            B = 1
                            .Projectile = True
                            .Direction = NPC(.Special2).Direction
                            If .Direction > 0 Then
                                .Location.X = NPC(.Special2).Location.X + 32
                            Else
                                .Location.X = NPC(.Special2).Location.X - .Location.Width
                            End If
                            .Location.Y = NPC(.Special2).Location.Y
                        End If
                        If Player(.standingOnPlayer).Controls.Run = True Then
                            B = 1
                        End If
                        If .Special2 > 0 And NPC(.Special2).Special2 <> A Then B = 0
                        If .Special > 0 Then
                            If Player(.Special).Effect <> 0 Then B = 0
                        End If
                        If B = 0 Then .Killed = 9
                    ElseIf .Type = 49 Then
                        If .HoldingPlayer = 0 And .standingOnPlayer = 0 Then
                            .Special = 0
                        End If
                        If .HoldingPlayer > 0 And .Special2 > 0 Then
                            NPC(.Special2).Direction = .Direction
                        End If
                        If Player(.HoldingPlayer).Effect <> 0 Then .Special = 0
                        If .Projectile = True And .Special2 = 0 And .Special = 0 And 0 Then
                            numNPCs = numNPCs + 1
                            .Special2 = numNPCs
                            With NPC(numNPCs)
                                .Active = True
                                .Section = NPC(A).Section
                                .TimeLeft = 100
                                .Type = 50
                                .Location.Height = 32
                                .Location.Width = 48
                                .Special = 0
                                .Special2 = A
                                .Projectile = True
                                .Direction = NPC(A).Direction
                                If .Direction > 0 Then
                                    .Location.X = NPC(A).Location.X + 32
                                    .Frame = 2
                                Else
                                    .Location.X = NPC(A).Location.X - .Location.Width
                                End If
                                .Location.Y = NPC(A).Location.Y
                            End With
                        End If
                        If NPC(.Special2).Type = 50 And NPC(.Special2).Special2 = A Then
                            NPC(.Special2).Projectile = True
                            NPC(.Special2).Direction = .Direction
                            If .Direction > 0 Then
                                NPC(.Special2).Location.X = .Location.X + 32
                            Else
                                NPC(.Special2).Location.X = .Location.X - NPC(.Special2).Location.Width
                            End If
                            NPC(.Special2).Location.Y = .Location.Y
                        End If
                        If .standingOnPlayer > 0 And Player(.standingOnPlayer).Controls.Run = False Then .Special = 0
                    ElseIf .Type = 31 Then
                        If .HoldingPlayer > 0 Then
                            For B = 1 To numBackground
                                If Background(B).Type = 35 Then
                                    tempLocation = Background(B).Location
                                    tempLocation.Width = 16
                                    tempLocation.X = tempLocation.X + 8
                                    tempLocation.Height = 26
                                    tempLocation.Y = tempLocation.Y + 2
                                    If CheckCollision(.Location, tempLocation) = True Then
                                        PlaySound 31
                                        StopMusic
                                        LevelMacro = 3
                                        Exit For
                                    End If
                                End If
                            Next B
                        End If
                    ElseIf NPCIsABot(.Type) Then
                        If .Projectile = True Or .HoldingPlayer > 0 Then
                            .Special = -1
                            .Special2 = 0
                            .Location.SpeedX = .Location.SpeedX * 0.98
                        Else
                            If .Special = 0 Then
                                C = 0
                                D = 1
                                For B = 1 To numPlayers
                                    If Player(B).Dead = False And Player(B).Section = .Section Then
                                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                            D = B
                                        End If
                                    End If
                                Next B
                                If Player(D).Location.X + Player(D).Location.Width / 2 > .Location.X + 16 Then
                                    .Direction = 1
                                Else
                                    .Direction = -1
                                End If
                            End If
                            If .Location.SpeedY = 0 Or .Slope > 0 Then
                                .Location.SpeedX = 0
                                If .Special = 0 Then .Special = Int(Rnd * 3) + 1
                                If .Special = 1 Then
                                    .FrameCount = .FrameCount + 1
                                    .Special2 = .Special2 + 1
                                    .Location.SpeedX = 0
                                    If .Special2 >= 90 Then
                                        .Special2 = 0
                                        .Special = -1
                                        .Location.SpeedY = -7
                                        .Location.SpeedX = 2 * .Direction
                                    End If
                                ElseIf .Special = 3 Then
                                    .FrameCount = .FrameCount + 1
                                    .Special2 = .Special2 + 30
                                    .Location.SpeedX = 0
                                    If .Special2 >= 30 Then
                                        .Special2 = 0
                                        .Special = -1
                                        .Location.SpeedY = -3
                                        .Location.SpeedX = 2.5 * .Direction
                                    End If
                                ElseIf .Special = 2 Then
                                    .Location.SpeedX = 0.5 * .Direction
                                    .Special2 = .Special2 + 1
                                    If .Special2 = 120 Then
                                        .Special2 = 0
                                        .Special = -2
                                    End If
                                Else
                                    .Special2 = .Special2 + 1
                                    If .Special2 = 30 Then
                                        .Special2 = 0
                                        .Special = 0
                                    End If
                                End If
                            End If
                        End If
                    End If
                    
                    'If FreezeNPCs = True Then
                        '.Direction = .DefaultDirection
                        '.Special = .DefaultSpecial
                        '.Special2 = 0
                        '.Special3 = 0
                        '.Special4 = 0
                        '.Special5 = 0
                    'End If


                    NPCFrames A
                    
                    
                    
                    
'Effects
                ElseIf .Effect = 1 Then 'Bonus coming out of a block effect
                    
                    If .Direction = 0 Then 'Move toward the closest player
                        C = 0
                        For B = 1 To numPlayers
                            If Player(B).Dead = False And Player(B).Section = .Section Then
                                If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                    C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                    .Direction = -Player(B).Direction
                                End If
                            End If
                        Next B
                    End If
                    .Frame = EditorNPCFrame(.Type, .Direction, A)
                    .Effect2 = .Effect2 + 1
                    .Location.Y = .Location.Y - 1 '.01
                    .Location.Height = .Location.Height + 1
                    If NPCHeightGFX(.Type) > 0 Then
                        If .Effect2 >= NPCHeightGFX(.Type) Then
                            .Effect = 0
                            .Effect2 = 0
                            .Location.Y = .Location.Y + .Location.Height
                            .Location.Height = NPCHeight(.Type)
                            .Location.Y = .Location.Y - .Location.Height
                        End If
                    Else
                        If .Effect2 >= NPCHeight(.Type) Then
                            .Effect = 0
                            .Effect2 = 0
                            .Location.Height = NPCHeight(.Type)
                        End If
                    End If
                ElseIf .Effect = 208 Then
                    tempBool = False
                    For B = 1 To numNPCs
                        If NPC(B).Type = 208 Then
                            If CheckCollision(.Location, NPC(B).Location) = True Then
                                tempBool = True
                                Exit For
                            End If
                        End If
                    Next B
                    If tempBool = False Then .Effect = 0
                ElseIf .Effect = 2 Then 'Bonus item is falling from the players container effect
                    .Location.Y = .Location.Y + 2.2
                    .Effect2 = .Effect2 + 1
                    If .Effect2 = 5 Then .Effect2 = 1
                ElseIf .Effect = 3 Then 'Bonus falling out of a block
                    If .Type = 34 Then
                        .Direction = 1
                    ElseIf .Direction = 0 Then 'Move toward the closest player
                        C = 0
                        For B = 1 To numPlayers
                            If Player(B).Dead = False And Player(B).Section = .Section Then
                                If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                    C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                    .Direction = -Player(B).Direction
                                End If
                            End If
                        Next B
                    End If
                    .Effect2 = .Effect2 + 1
                    .Location.Y = .Location.Y + 1
                    If .Effect2 = 32 Then
                        .Effect = 0
                        .Effect2 = 0
                        .Location.Height = 32
                        For bCheck = 1 To 2
                            If bCheck = 1 Then
                                fBlock = FirstBlock((.Location.X / 32) - 1)
                                lBlock = LastBlock(((.Location.X + .Location.Width) / 32) + 1)
                            Else
                                fBlock = numBlock - numTempBlock
                                lBlock = numBlock
                            End If
                            For B = fBlock To lBlock
                                If Block(B).Invis = False And Not (BlockIsSizable(Block(B).Type) = True And .Location.Y > Block(B).Location.Y) And Block(B).Hidden = False Then
                                    If CheckCollision(.Location, Block(B).Location) = True Then
                                        .Location.Y = Block(B).Location.Y - .Location.Height - 0.1
                                        Exit For
                                    End If
                                End If
                            Next B
                        Next bCheck
                    End If
                ElseIf .Effect = 4 Then 'Warp Generator
                    If .Effect3 = 1 Then
                        .Location.Y = .Location.Y - 1
                        If .Type = 106 Then .Location.Y = .Location.Y - 1
                        If .Location.Y + .Location.Height <= .Effect2 Then
                            .Effect = 0
                            .Effect2 = 0
                            .Effect3 = 0
                        End If
                    ElseIf .Effect3 = 3 Then
                        .Location.Y = .Location.Y + 1
                        If .Type = 106 Then .Location.Y = .Location.Y + 1
                        If .Location.Y >= .Effect2 Then
                            .Effect = 0
                            .Effect2 = 0
                            .Effect3 = 0
                        End If
                    ElseIf .Effect3 = 2 Then
                        If .Type = 9 Or .Type = 90 Or .Type = 153 Or .Type = 184 Or .Type = 185 Or .Type = 186 Or .Type = 187 Or .Type = 163 Or .Type = 164 Then
                            .Location.X = .Location.X - Physics.NPCMushroomSpeed
                        ElseIf NPCCanWalkOn(.Type) = True Then
                            .Location.X = .Location.X - 1
                        Else
                            .Location.X = .Location.X - Physics.NPCWalkingSpeed
                        End If
                        If .Location.X + .Location.Width <= .Effect2 Then
                            .Effect = 0
                            .Effect2 = 0
                            .Effect3 = 0
                        End If
                    ElseIf .Effect3 = 4 Then
                        If .Type = 9 Or .Type = 90 Or .Type = 153 Or .Type = 184 Or .Type = 185 Or .Type = 186 Or .Type = 187 Or .Type = 163 Or .Type = 164 Then
                            .Location.X = .Location.X + Physics.NPCMushroomSpeed
                        ElseIf NPCCanWalkOn(.Type) = True Then
                            .Location.X = .Location.X + 1
                        Else
                            .Location.X = .Location.X + Physics.NPCWalkingSpeed
                        End If
                        If .Location.X >= .Effect2 Then
                            .Effect = 0
                            .Effect2 = 0
                            .Effect3 = 0
                        End If
                    End If
                    NPCFrames A
                    If .Effect = 0 And .Type <> 91 Then .Layer = "Spawned NPCs"
                ElseIf .Effect = 5 Then 'Grabbed by Yoshi
                    .TimeLeft = 100
                    .Effect3 = .Effect3 - 1
                    If .Effect3 <= 0 Then
                        .Effect = 0
                        .Effect2 = 0
                        .Effect3 = 0
                    End If
                ElseIf .Effect = 6 Then 'Held by Yoshi
                    .TimeLeft = 100
                    If Player(.Effect2).YoshiNPC <> A Then
                        .Effect = 0
                        .Effect2 = 0
                        .Effect3 = 0
                    End If
                ElseIf .Effect = 8 Then 'Holding Pattern
                    .Effect2 = .Effect2 - 1
                    If .Effect2 <= 0 Then
                        .Effect = 0
                        .Effect2 = 0
                        .Effect3 = 0
                    End If
                End If
            End If
            
            If speedVar <> 1 And speedVar <> 0 Then
                .RealSpeedX = .Location.SpeedX
                .Location.SpeedX = .Location.SpeedX * speedVar
            End If

            If .AttLayer <> "" And .HoldingPlayer = 0 Then
                For B = 1 To 100
                    If Layer(B).Name <> "" Then
                        If Layer(B).Name = .AttLayer Then
                            If .Location.X - lyrX = 0 And .Location.Y - lyrY = 0 Then
                                If Layer(B).SpeedX <> 0 Or Layer(B).SpeedY <> 0 Then
                                    Layer(B).EffectStop = True
                                    Layer(B).SpeedX = 0
                                    Layer(B).SpeedY = 0
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
                            Else
                                Layer(B).EffectStop = False
                                Layer(B).SpeedX = .Location.X - lyrX
                                Layer(B).SpeedY = .Location.Y - lyrY
                            End If
                        End If
                    Else
                        Exit For
                    End If
                Next B
            End If
            
        End With
    Next A
    numBlock = numBlock - numTempBlock 'clean up the temp npc blocks
    For A = numNPCs To 1 Step -1 'KILL THE NPCS <><><><><><><><><><><><><><><><><><><><><><><><><><><><><><
        With NPC(A)
            If .Killed > 0 Then
                If .Location.SpeedX = 0 Then
                    .Location.SpeedX = Rnd * 2 - 1
                    If .Location.SpeedX < 0 Then
                        .Location.SpeedX = .Location.SpeedX - 0.5
                    Else
                        .Location.SpeedX = .Location.SpeedX + 0.5
                    End If
                End If
                KillNPC A, .Killed
            End If
        End With
    Next A
    If nPlay.Online = True Then
        If nPlay.Mode = 1 Then
            nPlay.NPCWaitCount = nPlay.NPCWaitCount + 10
            If nPlay.NPCWaitCount >= 5 Then
                tempStr = "L" & LB
                For A = 1 To numNPCs
                    If NPC(A).Active = True And NPC(A).TimeLeft > 1 Then
                        If NPC(A).HoldingPlayer <= 1 Then
                            tempStr = tempStr & "K" & A & "|" & NPC(A).Type & "|" & NPC(A).Location.X & "|" & NPC(A).Location.Y & "|" & NPC(A).Location.Width & "|" & NPC(A).Location.Height & "|" & NPC(A).Location.SpeedX & "|" & NPC(A).Location.SpeedY & "|" & NPC(A).Section & "|" & NPC(A).TimeLeft & "|" & NPC(A).Direction & "|" & Int(NPC(A).Projectile) & "|" & NPC(A).Special & "|" & NPC(A).Special2 & "|" & NPC(A).Special3 & "|" & NPC(A).Special4 & "|" & NPC(A).Special5 & "|" & NPC(A).Effect & LB
                            If NPC(A).Effect <> 0 Then tempStr = tempStr & "2c" & A & "|" & NPC(A).Effect2 & "|" & NPC(A).Effect3 & LB
                        End If
                    End If
                Next A
                Netplay.sendData tempStr & "O" & numPlayers & LB
                nPlay.NPCWaitCount = 0
            End If
        End If
    End If
    CharStuff
End Sub

Public Sub DropBonus(A As Integer) 'Drops a bonus item that was held by the player
    Dim B As Integer
    If nPlay.Online = True And nPlay.MySlot + 1 <> A Then Exit Sub
    If A = 1 Or numPlayers = 2 Or nPlay.Online = True Then
        With Player(A)
            If .Character = 3 Or .Character = 4 Then
                .HeldBonus = 0
                Exit Sub
            End If
            If .HeldBonus > 0 Then
                PlaySound 11
                numNPCs = numNPCs + 1
                NPC(numNPCs).Type = .HeldBonus
                NPC(numNPCs).Location.Width = NPCWidth(.HeldBonus)
                NPC(numNPCs).Location.Height = 32
                If ScreenType = 5 And vScreen(2).Visible = False And nPlay.Online = False Then
                    If A = 1 Then B = -40
                    If A = 2 Then B = 40
                    GetvScreenAverage
                    NPC(numNPCs).Location.X = -vScreenX(1) + vScreen(1).Width / 2 - NPC(numNPCs).Location.Width / 2 + B
                    NPC(numNPCs).Location.Y = -vScreenY(1) + 16 + 12
                ElseIf nPlay.Online = True Then
                    GetvScreen 1
                    NPC(numNPCs).Location.X = -vScreenX(1) + vScreen(1).Width / 2 - NPC(numNPCs).Location.Width / 2
                    NPC(numNPCs).Location.Y = -vScreenY(1) + 16 + 12
                Else
                    GetvScreen A
                    NPC(numNPCs).Location.X = -vScreenX(A) + vScreen(A).Width / 2 - NPC(numNPCs).Location.Width / 2
                    NPC(numNPCs).Location.Y = -vScreenY(A) + 16 + 12
                End If
                NPC(numNPCs).Location.SpeedX = 0
                NPC(numNPCs).Location.SpeedY = 0
                NPC(numNPCs).Effect = 2
                NPC(numNPCs).Effect2 = 1
                NPC(numNPCs).Active = True
                NPC(numNPCs).TimeLeft = 200
                CheckSectionNPC numNPCs
                .HeldBonus = 0
                If nPlay.Online = True Then
                    Netplay.sendData "M" & NPC(numNPCs).Type & "|" & NPC(numNPCs).Location.X & "|" & NPC(numNPCs).Location.Y & LB
                End If
            End If
        End With
    Else
        Player(A).HeldBonus = 0
    End If
End Sub

Public Sub TouchBonus(A As Integer, B As Integer) 'Code for dealing with bonus and player
    Dim C As Integer
    Dim D As Integer
    Dim toadBool As Integer
    Dim tempBool As Boolean
    Dim tempLocation As Location
    With Player(A)
        If NPC(B).CantHurtPlayer <> A Or (NPCIsACoin(NPC(B).Type) And Player(A).HoldingNPC <> B And NPC(B).Killed = 0) Then
            If nPlay.Online = True And nPlay.MySlot + 1 = A Then Netplay.sendData "1k" & A & "|" & B & "|" & NPC(B).Type & LB
            
            If .Character = 3 Or .Character = 4 Or .Character = 5 Then 'for link give hearts
                If NPC(B).Type = 34 Or NPC(B).Type = 169 Or NPC(B).Type = 170 Then
                    .Hearts = .Hearts + 1
                    If .Hearts > 3 Then .Hearts = 3
                End If
            End If
            
            'If .Character = 3 Or .Character = 4 Then  'for peach and toad turn leaf and suits into a mushroom
                'If NPC(B).Type = 34 Or NPC(B).Type = 169 Or NPC(B).Type = 170 Then NPC(B).Type = 9
            'End If
            
            If NPC(B).Type = 273 And numPlayers > 1 Then '? mushroom
                If Player(1).Dead = False And Player(1).TimeToLive = 0 And Player(2).Dead = False And Player(2).TimeToLive = 0 And Player(1).Immune = 0 And Player(2).Immune = 0 Then
                    tempLocation = Player(1).Location
                    Player(1).Location.X = Player(2).Location.X + Player(2).Location.Width / 2 - Player(1).Location.Width / 2
                    Player(1).Location.Y = Player(2).Location.Y + Player(2).Location.Height - Player(1).Location.Height
                    Player(2).Location.X = tempLocation.X + Player(1).Location.Width / 2 - Player(2).Location.Width / 2
                    Player(2).Location.Y = tempLocation.Y + Player(1).Location.Height - Player(2).Location.Height
                    C = Player(1).Direction
                    Player(1).Direction = Player(2).Direction
                    Player(2).Direction = C
                    C = Player(1).Slope
                    Player(1).Slope = Player(2).Slope
                    Player(2).Slope = C
                    C = Player(1).StandingOnNPC
                    Player(1).StandingOnNPC = Player(2).StandingOnNPC
                    Player(2).StandingOnNPC = C
                    If Player(1).Immune < 10 Then Player(1).Immune = 10
                    If Player(2).Immune < 10 Then Player(2).Immune = 10
                    NPC(B).Killed = 9
                    PlaySound 20
                    Exit Sub
                End If
            End If
            
            If NPC(B).Type = 254 Then 'Player is a fairy
                If .Mount = 2 Then
                    Exit Sub
                Else
                    If .Fairy = False Then
                        .Immune = 30
                        .Effect = 8
                        .Effect2 = 4
                        .Fairy = True
                        SizeCheck A
                        NewEffect 63, .Location
                    End If
                    PlaySound 87
                    .FairyTime = -1
                    NPC(B).Killed = 9
                End If
            End If
            If NPC(B).Type = 90 Or NPC(B).Type = 187 Or NPC(B).Type = 186 Then   'player touched a 1up mushroom
                NPC(B).Killed = 9
                MoreScore 10, NPC(B).Location
                Exit Sub
            End If
            If NPC(B).Type = 248 And NPC(B).Effect <> 2 And (.Character = 1 Or .Character = 2) Then 'send the clock to the item container
                .HeldBonus = 248
                NPC(B).Killed = 9
                PlaySound 12
                Exit Sub
            End If
            If NPC(B).Type = 240 Or NPC(B).Type = 248 Then 'player touched the clock
                PSwitchStop = Physics.NPCPSwitch
                FreezeNPCs = True
                PSwitchPlayer = A
                NPC(B).Killed = 9
                Exit Sub
            End If
            If NPC(B).Type = 192 Then 'player touched the chekpoint
                If .State = 1 Then .State = 2
                If .Hearts = 1 Then .Hearts = 2
                SizeCheck A
                NPC(B).Killed = 9
                PlaySound 58
                Checkpoint = FullFileName
                Exit Sub
            End If
            If NPC(B).Type = 188 Then 'player touched the 3up moon
                NPC(B).Killed = 9
                MoreScore 12, NPC(B).Location
                Exit Sub
            End If
            If NPC(B).Type = 178 Then
                NPC(B).Killed = 9
                Exit Sub
            End If
            If NPCIsToad(NPC(B).Type) = True Then
                toadBool = NPC(B).Type
                NPC(B).Type = 9
            End If
            If NPC(B).Type = 153 Then 'Bonus is a POISON mushroom
                PlayerHurt A
            ElseIf NPC(B).Type = 9 Or NPC(B).Type = 184 Or NPC(B).Type = 185 Or NPC(B).Type = 249 Or NPC(B).Type = 250 Then     'Bonus is a mushroom
                If .Character = 5 And .State = 1 Then .State = 2
                If .Character = 3 Or .Character = 4 Or .Character = 5 Then
                    .Hearts = .Hearts + 1
                    If .Hearts > 3 Then .Hearts = 3
                End If
                UpdatePlayerBonus A, NPC(B).Type
                If .State = 1 And .Character <> 5 Then
                    If .Duck = True Then UnDuck A
                    .StateNPC = NPC(B).Type
                    .Frame = 1
                    .Effect = 1
                    If .Mount > 0 Then UnDuck A
                    PlaySound 6
                ElseIf NPC(B).Type = 250 Then
                    PlaySound 79
                Else
                    PlaySound 12
                End If
                If NPC(B).Effect <> 2 Then MoreScore 6, NPC(B).Location
            ElseIf NPC(B).Type = 14 Or NPC(B).Type = 182 Or NPC(B).Type = 183 Then   'Bonus is a fire flower
                If .Character = 3 Or .Character = 4 Or .Character = 5 Then
                    .Hearts = .Hearts + 1
                    If .Hearts > 3 Then .Hearts = 3
                End If
                UpdatePlayerBonus A, NPC(B).Type
                .StateNPC = NPC(B).Type
                If .State <> 3 Then
                    .Frame = 1
                    .Effect = 4
                    If .Mount > 0 Then UnDuck A
                    If .Character = 5 Then
                        PlaySound 83
                    Else
                        PlaySound 6
                    End If
                Else
                    If .Character = 5 Then
                        PlaySound 79
                    Else
                        PlaySound 12
                    End If
                End If
                If NPC(B).Effect <> 2 Then MoreScore 6, NPC(B).Location
            ElseIf NPC(B).Type = 264 Or NPC(B).Type = 277 Then   'Bonus is an ice flower
                If .Character = 3 Or .Character = 4 Or .Character = 5 Then
                    .Hearts = .Hearts + 1
                    If .Hearts > 3 Then .Hearts = 3
                End If
                UpdatePlayerBonus A, NPC(B).Type
                .StateNPC = NPC(B).Type
                If .State <> 7 Then
                    .Frame = 1
                    .Effect = 41
                    If .Mount > 0 Then UnDuck A
                    If .Character = 5 Then
                        PlaySound 83
                    Else
                        PlaySound 6
                    End If
                Else
                    If .Character = 5 Then
                        PlaySound 79
                    Else
                        PlaySound 12
                    End If
                End If
                If NPC(B).Effect <> 2 Then MoreScore 6, NPC(B).Location
            ElseIf NPC(B).Type = 34 Then 'Bonus is a leaf
                UpdatePlayerBonus A, NPC(B).Type
                .StateNPC = NPC(B).Type
                If .State <> 4 Then
                    .Frame = 1
                    .Effect = 5
                    .Effect2 = 0
                    If .Mount > 0 Then UnDuck A
                    If .Character = 5 Then
                        PlaySound 83
                    Else
                        PlaySound 34
                    End If
                Else
                    If .Character = 5 Then
                        PlaySound 79
                    Else
                        PlaySound 12
                    End If
                End If
                If NPC(B).Effect <> 2 Then MoreScore 6, NPC(B).Location
            ElseIf NPC(B).Type = 169 Then 'Bonus is a Tanooki Suit
                UpdatePlayerBonus A, NPC(B).Type
                .StateNPC = NPC(B).Type
                If .State <> 5 Then
                    .Frame = 1
                    .Effect = 11
                    .Effect2 = 0
                    If .Mount > 0 Then UnDuck A
                    If .Character = 5 Then
                        PlaySound 83
                    Else
                        PlaySound 34
                    End If
                Else
                    If .Character = 5 Then
                        PlaySound 79
                    Else
                        PlaySound 12
                    End If
                End If
                If NPC(B).Effect <> 2 Then MoreScore 6, NPC(B).Location
            ElseIf NPC(B).Type = 170 Then 'Bonus is a Hammer Suit
                UpdatePlayerBonus A, NPC(B).Type
                .StateNPC = NPC(B).Type
                If .State <> 6 Then
                    .Frame = 1
                    .Effect = 12
                    .Effect2 = 0
                    If .Mount > 0 Then UnDuck A
                    If .Character = 5 Then
                        PlaySound 83
                    Else
                        PlaySound 34
                    End If
                Else
                    If .Character = 5 Then
                        PlaySound 79
                    Else
                        PlaySound 12
                    End If
                End If
                If NPC(B).Effect <> 2 Then MoreScore 6, NPC(B).Location
            ElseIf NPCIsACoin(NPC(B).Type) Then 'Bonus is a coin
                If NPC(B).Type = 152 Then
                    PlaySound 56
                ElseIf NPC(B).Type = 251 Or NPC(B).Type = 252 Or NPC(B).Type = 253 Then
                    PlaySound 81
                ElseIf NPC(B).Type <> 274 Then
                    PlaySound 14
                End If
                If NPC(B).Type = 252 Or NPC(B).Type = 258 Then
                    Coins = Coins + 5
                ElseIf NPC(B).Type = 253 Then
                    Coins = Coins + 20
                Else
                    Coins = Coins + 1
                End If
                If Coins >= 100 Then
                    If Lives < 99 Then
                        Lives = Lives + 1
                        PlaySound 15
                        Coins = Coins - 100
                    Else
                        Coins = 99
                    End If
                End If
                If NPC(B).Type = 274 Then
                    PlaySound 59
                    MoreScore NPCScore(NPC(B).Type), NPC(B).Location
                    NPCScore(274) = NPCScore(274) + 1
                    If NPCScore(274) > 14 Then NPCScore(274) = 14
                Else
                    MoreScore 1, NPC(B).Location
                End If
                NewEffect 78, NPC(B).Location
            ElseIf NPCIsAnExit(NPC(B).Type) And LevelMacro = 0 Then 'Level exit
                If NPC(B).Type <> 196 Then
                    TurnNPCsIntoCoins
                    FreezeNPCs = False
                    If numPlayers > 2 And nPlay.Online = False Then Player(1) = Player(A)
                End If
                If NPC(B).Type = 11 Then
                    If NPC(B).Frame = 0 Then MoreScore 10, .Location
                    If NPC(B).Frame = 1 Then MoreScore 6, .Location
                    If NPC(B).Frame = 2 Then MoreScore 8, .Location
                    LevelMacro = 1
                    For C = 1 To numPlayers
                        If A <> C Then 'And DScreenType <> 5 Then
                            Player(C).Section = Player(A).Section
                            Player(C).Location.Y = Player(A).Location.Y + Player(A).Location.Height - Player(C).Location.Height
                            Player(C).Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - Player(C).Location.Width / 2
                            Player(C).Location.SpeedX = 0
                            Player(C).Location.SpeedY = 0
                            Player(C).Effect = 8
                            Player(C).Effect2 = -A
                        End If
                    Next C
                    StopMusic
                    DoEvents
                    PlaySound 19
                ElseIf NPC(B).Type = 16 Then
                    LevelMacro = 2
                    For C = 1 To numPlayers
                        If A <> C Then 'And DScreenType <> 5 Then
                            Player(C).Section = Player(A).Section
                            Player(C).Location.Y = Player(A).Location.Y + Player(A).Location.Height - Player(C).Location.Height
                            Player(C).Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - Player(C).Location.Width / 2
                            Player(C).Location.SpeedX = 0
                            Player(C).Location.SpeedY = 0
                            Player(C).Effect = 8
                            Player(C).Effect2 = -A
                        End If
                    Next C
                    StopMusic
                    PlaySound 21
                ElseIf NPC(B).Type = 41 Then
                    LevelMacro = 4
                    For C = 1 To numPlayers
                        If A <> C Then 'And DScreenType <> 5 Then
                            Player(C).Section = Player(A).Section
                            Player(C).Location.Y = Player(A).Location.Y + Player(A).Location.Height - Player(C).Location.Height
                            Player(C).Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - Player(C).Location.Width / 2
                            Player(C).Location.SpeedX = 0
                            Player(C).Location.SpeedY = 0
                            Player(C).Effect = 8
                            Player(C).Effect2 = -A
                        End If
                    Next C
                    StopMusic
                    PlaySound 40
                ElseIf NPC(B).Type = 97 Or NPC(B).Type = 196 Then
                    For C = 1 To numStars
                        If Star(C).level = FileName And (Star(C).Section = NPC(B).Section Or Star(C).Section = -1) Then tempBool = True
                    Next C
                    If tempBool = False Then
                        numStars = numStars + 1
                        Star(numStars).level = FileName
                        Star(numStars).Section = NPC(B).Section
                        For C = 1 To numWarps
                            If Warp(C).Stars = numStars Then
                                For D = numBackground To numBackground + numLocked
                                    If Background(D).Type = 160 Then
                                        If CheckCollision(Warp(C).Entrance, Background(D).Location) = True Then
                                            Background(D).Layer = ""
                                            Background(D).Hidden = True
                                        End If
                                    End If
                                Next D
                            End If
                        Next C
                    End If
                    If NPC(B).Type = 97 Then
                        LevelMacro = 6
                        For C = 1 To numPlayers
                            If A <> C Then 'And DScreenType <> 5 Then
                                Player(C).Section = Player(A).Section
                                Player(C).Location.Y = Player(A).Location.Y + Player(A).Location.Height - Player(C).Location.Height
                                Player(C).Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - Player(C).Location.Width / 2
                                Player(C).Location.SpeedX = 0
                                Player(C).Location.SpeedY = 0
                                Player(C).Effect = 8
                                Player(C).Effect2 = -A
                            End If
                        Next C
                        StopMusic
                        PlaySound 52
                    Else
                        PlaySound 59
                    End If
                End If
            End If
            If toadBool > 0 Then NPC(B).Type = toadBool
            NPC(B).Killed = 9
            If nPlay.Online = True And A = nPlay.MySlot + 1 Then Netplay.sendData Netplay.PutPlayerControls(nPlay.MySlot) & "1c" & A & "|" & Player(A).Effect & "|" & Player(A).Effect2 & "1h" & A & "|" & Player(A).State & LB
        End If
    End With
End Sub

Public Sub NPCHit(A As Integer, B As Integer, Optional C As Integer = 0) 'For NPCs that were hit
    Dim tempNPC As NPC
    Dim tempLocation As Location
    Dim oldNPC As NPC
    oldNPC = NPC(A)
    '------+  HIT CODES  +-------
    'B = 1      Jumped on by a player (or kicked)
    'B = 2      Hit by a shaking block
    'B = 3      Hit by projectile
    'B = 4      Hit something as a projectile
    'B = 5      Hit something while being held
    'B = 6      Touched a lava block
    'B = 7      Hit by a tail
    'B = 8      Stomped by Boot
    'B = 9      Fell of a cliff
    'B = 10     Link stab
    'Frost Bolt check
    If B = 3 And NPC(A).Type <> 263 And NPC(A).Type <> 265 Then
        If NPC(C).Type = 265 And NPC(A).Location.Width > 8 And NPC(A).Location.Height > 8 Then
            If NPC(A).Type = 283 Then NPCHit A, 3, B
            If NPCNoIceBall(NPC(A).Type) = True Or NPC(A).Location.Width > 128 Or NPC(A).Location.Height > 128 Then Exit Sub
            With NPC(A)
                If .Type = 3 Then
                    .Type = 2
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 4 Then
                    .Type = 5
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 6 Or .Type = 161 Then
                    .Type = 7
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 72 Then
                    .Type = 73
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 76 Then
                    .Type = 5
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 109 Or .Type = 121 Then
                    .Type = 113
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 110 Or .Type = 122 Then
                    .Type = 114
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 111 Or .Type = 123 Then
                    .Type = 115
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 112 Or .Type = 124 Then
                    .Type = 116
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 175 Or .Type = 177 Then
                    .Type = 174
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 173 Or .Type = 176 Then
                    .Type = 172
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 243 Then
                    .Type = 242
                    .Frame = EditorNPCFrame(.Type, .Direction)
                ElseIf .Type = 244 Then
                    .Type = 1
                    .Frame = EditorNPCFrame(.Type, .Direction)
                End If
                .Special = NPC(A).Type
                .Special2 = NPC(A).Frame
                'If .Type = 52 Or .Type = 51 Then
                .Special3 = 1
                .Location.SpeedY = 0
                'End If
                .Location.SpeedX = 0
                If .Type = 52 Then
                    If .Direction = -1 Then
                        .Location.Width = Int(.Location.Width) - 0.01
                    Else
                        .Location.X = Int(.Location.X) + 0.01
                    End If
                End If
                .Location.Height = Int(.Location.Height)
                .Type = 263
                .BeltSpeed = 0
                .Projectile = False
                .RealSpeedX = 0
                
                NewEffect 10, .Location
                For C = 1 To 20
                    tempLocation.Height = EffectHeight(80)
                    tempLocation.Width = EffectWidth(80)
                    tempLocation.SpeedX = 0
                    tempLocation.SpeedY = 0
                    tempLocation.X = .Location.X - tempLocation.Width / 2 + Rnd * .Location.Width - 4
                    tempLocation.Y = .Location.Y - tempLocation.Height / 2 + Rnd * .Location.Height - 4
                    NewEffect 80, tempLocation
                    Effect(numEffects).Location.SpeedX = Rnd * 2 - 1
                    Effect(numEffects).Location.SpeedY = Rnd * 2 - 1
                    Effect(numEffects).Frame = Int(Rnd * 3)
                Next C
                
                PlaySound 9
            End With
            'NPCHit C, 3, C
            Exit Sub
        End If
    End If
    
'Online code
    If nPlay.Online = True Then
        If B = 1 Or B = 7 Or B = 8 Then
            If C = nPlay.MySlot + 1 Or nPlay.Allow = True Or C <= 0 Then
                If C = nPlay.MySlot + 1 Then
                    Netplay.sendData "2d" & A & "|" & B & "|" & C & "|" & NPC(A).Type & LB
                End If
            Else
                Exit Sub
            End If
        End If
    End If

    If NPC(A).Active = False Then Exit Sub

    With NPC(A)
    
'Safety
        StopHit = StopHit + 1
        If .Killed > 0 Then Exit Sub
        If B = 3 Or B = 4 Then
            If NPC(C).Generator = True Then Exit Sub
        End If
        If (.Type = 235 Or .Type = 231 Or NPCIsCheep(.Type) = True) And B = 1 Then
            If Player(C).Wet > 0 Then Exit Sub
        End If
        If .Inert = True Or StopHit > 2 Or .Immune > 0 Or .Killed > 0 Or .Effect = 208 Or .Generator = True Then Exit Sub
        If B = 6 And .Killed = 6 Then Exit Sub
        If B = 3 Or B = 4 Or B = 5 Then 'Things immune to fire
            If NPC(C).Type = 13 Then
                If NPCNoFireBall(.Type) Then
                    Exit Sub
                End If
            End If
        End If
        
        
        If B = 1 And NPCJumpHurt(.Type) = True And .Type <> 283 Then Exit Sub 'Things that don't die from jumping
        
        If B = 10 And .Type = 31 Then
            If Player(C).Character = 5 And Player(C).HasKey = False Then
                .Killed = 9
                Player(C).HasKey = True
                PlaySound 84
                Exit Sub
            End If
        End If

'Yoshi Ice
        If .Type = 237 Then
            If B <> 1 And B <> 7 And B <> 8 And B <> 4 Then
                .Killed = B
            End If
'Frozen NPC
        ElseIf .Type = 263 Then
            If B = 3 And NPC(C).Type = 13 Then
            
                .Type = .Special
                If .Location.SpeedX > 0 Then
                    .Direction = 1
                ElseIf .Location.SpeedX < 0 Then
                    .Direction = -1
                Else
                    .Direction = .DefaultDirection
                End If
                .Frame = EditorNPCFrame(.Type, .Direction)
                .Special = .DefaultSpecial
                .Special2 = 0
                .Special3 = 0
                .Special4 = 0
                .Special5 = 0
                .Special6 = 0
                
            
            ElseIf B = 3 Or B = 5 Then
                If A = C Or B = 6 Or B = 5 Then .Killed = B
                If B = 3 And NPC(C).Type = .Type Then .Killed = B
            ElseIf B = 10 Or B = 2 Then .Killed = B
            End If
        
    
'Things that link can move with his sword
        ElseIf B = 10 And .Type = 134 And .CantHurt = 0 And .Projectile = False Then  'link picks up bombs
            If Player(C).Bombs < 9 Then Player(C).Bombs = Player(C).Bombs + 1
            '.Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
            '.Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
            'NewEffect 10, .Location
            .Killed = 9
            PlaySound 79
        ElseIf B = 10 And ((.Type >= 154 And .Type <= 157) Or .Type = 26 Or .Type = 32 Or .Type = 238 Or .Type = 241 Or .Type = 96 Or .Type = 22 Or .Type = 134) Then
            PlaySound 9
            .Bouce = True
            If (.Type >= 154 And .Type <= 157) Or .Type = 22 Then
                .Location.SpeedX = 3 * Player(C).Direction
                .Location.SpeedY = -5
            Else
                .Location.SpeedX = 4 * Player(C).Direction
                .Location.SpeedY = -4
            End If
            .Projectile = True
            .CantHurt = 30
            .CantHurtPlayer = C
            .BattleOwner = C
            If .Type = 22 Then .Direction = Player(C).Direction
'SMB2 Grass
        ElseIf B = 10 And (.Type = 91 Or NPCIsVeggie(.Type)) Then
            If .Type = 91 Then
                .Location.Y = .Location.Y - .Location.Height
                .Type = .Special
            End If
            PlaySound 88
            NewEffect 63, .Location
            If .Type = 17 Then
                PlaySound 22
                .Location.SpeedX = 5 * Player(C).Direction
                .Location.Y = .Location.Y + .Location.Height
            End If
            .Direction = Player(C).Direction
            .Generator = False
            .Frame = 0
            .Frame = EditorNPCFrame(.Type, .Direction)
            CharStuff A
            .Special = 0
            If NPCIsYoshi(.Type) Then
                .Special = .Type
                .Type = 96
            End If
            If Not (.Type = 21 Or .Type = 22 Or .Type = 26 Or .Type = 31 Or .Type = 32 Or .Type = 35 Or .Type = 191 Or .Type = 193 Or .Type = 49 Or NPCIsAnExit(.Type)) Then
                If BattleMode = False Then .DefaultType = 0
            End If
            .Location.Height = NPCHeight(.Type)
            .Location.Width = NPCWidth(.Type)
            .Location.Y = .Location.Y - .Location.Height
            .Location.SpeedX = (3 + Rnd * 1) * Player(C).Direction
            If .Type = 17 Then .Location.SpeedX = 5 * Player(C).Direction
            .Location.SpeedY = -4
            .CantHurtPlayer = C
            .CantHurt = 30
            If NPCIsVeggie(.Type) Or .Type = 29 Or .Type = 251 Or .Type = 252 Then
                If .Type <> 252 Then
                    .Type = 251
                End If
                .Location.SpeedX = (1 + Rnd * 0.5) * Player(C).Direction
                .Location.SpeedY = -5
                If Rnd * 20 < 3 Then .Type = 252
                If Rnd * 40 < 3 Then .Type = 253
                .Location.X = .Location.X + .Location.Width / 2
                .Location.Y = .Location.Y + .Location.Height
                .Location.Width = NPCWidth(.Type)
                .Location.Height = NPCHeight(.Type)
                .Location.X = .Location.X - .Location.Width / 2
                .Location.Y = .Location.Y - .Location.Height
            End If
            If NPCIsAShell(.Type) Then .Location.SpeedX = Physics.NPCShellSpeed * Player(C).Direction
            NPCFrames A
            If NPCIsACoin(.Type) = False Then
                .Projectile = True
            Else
                .Special = 1
            End If
            .Immune = 10
            If .Type = 134 Then
                '.Location.SpeedX = 5 * Player(C).Direction + Player(C).Location.SpeedX
                '.Location.SpeedY = -5
                .Projectile = False
            End If
            If Player(C).StandingOnNPC = A Then Player(C).StandingOnNPC = 0
'bubble
        ElseIf .Type = 283 Then
            .Special3 = 1

'Larry Koopa
        ElseIf .Type = 267 Or .Type = 280 Then
            If B <> 7 Then .Immune = 10
            If B = 1 Or B = 2 Or B = 8 Then
                .Damage = .Damage + 5
                PlaySound 2
                .Special = 5
            ElseIf B = 3 Or B = 4 Or B = 5 Then
                If NPC(C).Type = 13 Or NPC(C).Type = 108 Then
                    .Damage = .Damage + 1
                    PlaySound 9
                Else
                    NPCHit C, 3, B
                    .Special = 5
                    .Damage = .Damage + 5
                    PlaySound 39
                End If
            ElseIf B = 10 Then
                .Damage = .Damage + 2
                PlaySound 89
            ElseIf B = 6 Then
                .Killed = B
            End If
            If .Damage >= 15 Then
                .Killed = B
            ElseIf .Special = 5 And Not (.Type = 268 Or .Type = 281) Then
                .Special = 0
                .Special2 = 0
                .Special3 = 0
                .Special4 = 0
                .Special5 = 0
                .Special6 = 0
                .Location.X = .Location.X + .Location.Width / 2
                .Location.Y = .Location.Y + .Location.Height
                If .Type = 267 Then
                    .Type = 268
                Else
                    .Type = 281
                End If
                .Location.Width = NPCWidth(.Type)
                .Location.Height = NPCHeight(.Type)
                .Location.X = .Location.X - .Location.Width / 2
                .Location.Y = .Location.Y - .Location.Height
                .Location.SpeedX = 0
                .Location.SpeedY = 0
                oldNPC = NPC(A)
            End If
            
'Larry Koop Shell
        ElseIf .Type = 268 Or .Type = 281 Then
            If B <> 7 And B <> 1 And B <> 2 And B <> 8 Then .Immune = 10
            If B = 1 Or B = 2 Or B = 8 Then
                If B = 1 Or B = 8 Then
                    
                    If Player(C).Location.X + Player(C).Location.Width / 2 < .Location.X + .Location.Width / 2 Then
                        Player(C).Location.SpeedX = Player(C).Location.SpeedX - 3
                    Else
                        Player(C).Location.SpeedX = Player(C).Location.SpeedX + 3
                    End If
                    
                End If
                PlaySound 2
            ElseIf B = 3 Or B = 4 Or B = 5 Then
                If NPC(C).Type = 13 Or NPC(C).Type = 108 Then
                    .Damage = .Damage + 1
                    PlaySound 9
                Else
                    NPCHit C, 3, B
                    .Special = 5
                    .Damage = .Damage + 5
                    PlaySound 39
                End If
            ElseIf B = 10 Then
                .Damage = .Damage + 2
                PlaySound 89
            ElseIf B = 6 Then
                .Killed = B
            End If
            If .Damage >= 15 Then
                .Killed = B
            End If
'Zelda 2 Locked Door
        ElseIf .Type = 255 Then
            If B = 10 Then
                If Player(C).HasKey = True Then
                    Player(C).HasKey = False
                    .Killed = 3
                End If
            End If
'Goomba / Nekkid Koopa
        ElseIf .Type = 1 Or .Type = 2 Or .Type = 242 Or .Type = 27 Or .Type = 55 Or .Type = 59 Or .Type = 61 Or .Type = 63 Or .Type = 65 Or .Type = 71 Or .Type = 77 Or .Type = 271 Or .Type = 89 Or (.Type >= 117 And .Type <= 120) Or .Type = 162 Or .Type = 163 Or .Type = 229 Or .Type = 236 Or .Type = 230 Or .Type = 232 Or .Type = 233 Or .Type = 234 Then
            If B = 1 Then
                If .Type = 162 Then
                    .Location.Y = .Location.Y + .Location.Height
                    .Location.Height = 32
                    .Type = 163
                    .Location.Y = .Location.Y - .Location.Height
                    PlaySound 2
                ElseIf .Type <> 234 Then
                    .Killed = B
                End If
            ElseIf .Type >= 117 And .Type <= 120 Then
                If B = 3 And .CantHurt > 0 Then
                Else
                    .Killed = B
                End If
            Else
                If .Type = 234 And B = 3 Then
                    If NPC(C).Type <> 13 And NPC(C).Type <> 108 Then .Killed = B
                Else
                    .Killed = B
                End If
            End If
'Mother Brain
        ElseIf .Type = 209 Then
            Dim D As Integer
            Dim tempBool As Boolean
            tempBool = False
            For D = 1 To numNPCs
                If NPC(D).Type = 208 Then
                    If NPC(D).Active = True Then
                        If NPC(D).Section = .Section Then
                            If CheckCollision(.Location, NPC(D).Location) Then
                                tempBool = True
                                .Immune = 65
                                Exit For
                            End If
                        End If
                    End If
                End If
            Next D
            If tempBool = False Then
                If B = 3 Or B = 10 Then
                    If NPC(C).Type = 13 Then
                    Else
                        If NPC(C).Type = 171 Then
                            .Immune = 60
                        Else
                            .Immune = 20
                        End If
                        .Special = 1
                        PlaySound 68
                        .Damage = .Damage + 1
                        If .Damage >= 10 Then .Killed = 3
                    End If
                End If
            End If
'Metroid Cherrio
        ElseIf .Type = 210 Then
            If B = 3 Or B = 4 Or B = 5 Or B = 7 Or B = 9 Or B = 10 Then .Killed = B
'Metroid Glass
        ElseIf .Type = 208 Then
            If B = 3 Then
                PlaySound 64
                If NPC(C).Type = 13 Then
                Else
                    If NPC(C).Type = 171 Then
                        .Immune = 60
                    Else
                        .Immune = 20
                    End If
                    .Damage = .Damage + 3
                End If
            ElseIf B = 10 Then
                .Damage = .Damage + 3
                .Immune = 10
            End If
            If .Damage >= 15 Then .Killed = B
'Metroid Floating Things
        ElseIf .Type = 203 Or .Type = 204 Then
            If B = 3 Then
                If NPC(C).Type <> 13 And NPC(C).Type <> 108 Then .Killed = B
            ElseIf B = 2 Or B = 4 Or B = 5 Or B = 6 Or B = 9 Or B = 10 Then .Killed = B
            End If
'Spike Top
        ElseIf .Type = 207 Then
            If B = 3 Then
                If NPC(C).Type <> 13 And NPC(C).Type <> 108 Then .Killed = B
            ElseIf Not B = 1 Then .Killed = B
            End If
'Metroid Crawler
        ElseIf .Type = 205 Then
            If B = 3 Then
                If NPC(C).Type = 13 Then
                    .Damage = .Damage + 1
                Else
                    .Damage = .Damage + 3
                End If
                If .Damage >= 3 Then
                    .Killed = B
                Else
                    PlaySound 66
                End If
            ElseIf B = 8 Then
                .Damage = .Damage + 1
                If .Damage >= 3 Then
                    .Killed = B
                Else
                    PlaySound 66
                End If
            ElseIf B = 10 Then
                .Killed = B
            ElseIf B = 4 Or B = 2 Or B = 9 Or B = 6 Then
                .Killed = B
            End If
'mouser
        ElseIf .Type = 262 Then
            If B = 1 Then
            ElseIf B = 3 Then
                If NPC(C).Type <> 13 Then
                    .Damage = .Damage + 5
                    .Immune = 60
                Else
                    .Damage = .Damage + 1
                End If
            ElseIf B = 6 Then
                .Killed = B
                PlaySound 63
            ElseIf B = 10 Then
                .Damage = .Damage + 2
                .Immune = 20
            End If
            If .Damage >= 20 Then
                .Killed = 3
                PlaySound 41
            ElseIf B = 3 Then
                If NPC(C).Type = 13 Then
                    PlaySound 9
                Else
                    PlaySound 39
                End If
            ElseIf B = 10 Then PlaySound 39
            End If
'Wart
        ElseIf .Type = 201 Then
            If B = 1 Then
            ElseIf B = 3 Then
                If NPCIsVeggie(NPC(C).Type) Then
                    If .Special = 1 Then
                        PlaySound 39
                        .Damage = .Damage + 5
                        .Immune = 20
                        NPC(C).Killed = 9
                    End If
                Else
                    If NPC(C).Type <> 13 Then
                        PlaySound 39
                        .Damage = .Damage + 5
                        .Immune = 20
                    Else
                        PlaySound 9
                        .Damage = .Damage + 1
                    End If
                End If
            ElseIf B = 6 Then
                .Killed = B
                PlaySound 63
            ElseIf B = 10 Then
                PlaySound 39
                .Damage = .Damage + 5
                .Immune = 20
            End If
'King Koopa
        ElseIf .Type = 200 Then
            If B = 1 Then
            ElseIf B = 3 Then
                .Immune = 20
                If NPC(C).Type <> 13 Then
                    PlaySound 39
                    .Damage = .Damage + 3
                Else
                    PlaySound 9
                    .Damage = .Damage + 1
                End If
            ElseIf B = 10 Then
                PlaySound 39
                .Immune = 20
                .Damage = .Damage + 1
            ElseIf B = 6 Then
                .Killed = B
            End If
            If .Damage >= 12 Then .Killed = B
'SMW Dry Bones
        ElseIf .Type = 189 Then
            If B = 1 Or B = 8 Or B = 10 Then
                PlaySound 57
                PlaySound 2
                .Special = 1
                .Special2 = 0
                .Inert = True
                .Stuck = True
            ElseIf B = 3 Then
                If NPC(C).Type = 13 Or NPC(C).Type = 108 Then
                Else
                    .Killed = B
                End If
            Else
                .Killed = B
            End If
            
'Big Boo
        ElseIf .Type = 44 Then
            If (B = 3 And NPC(C).Type <> 13) Or B = 4 Then
                If B = 3 And NPC(C).Type = 45 Then NPCHit C, 3, C
                .Damage = .Damage + 1
                .Immune = 30
                If .Damage >= 3 Then
                    .Killed = B
                Else
                    PlaySound 39
                End If
            ElseIf B = 6 Then .Killed = B
            End If
            
'Projectile Only Death (Ghosts, Thwomps, Etc.)
        ElseIf .Type = 37 Or .Type = 38 Or .Type = 42 Or .Type = 43 Or .Type = 180 Or .Type = 179 Or .Type = 206 Or .Type = 259 Then
            If (B = 3 And NPC(C).Type <> 13) Or B = 4 Then
                If Not .Type = 259 And NPC(C).Type <> 58 Then 'roto disks don't die form falling blocks
                    If .Type <> 179 Then .Killed = B
                    If B = 3 And (.Type = 37 Or .Type = 180 Or .Type = 259) Then
                        If NPC(C).Location.SpeedX > 0 Then
                            .Direction = 1
                            .Location.SpeedX = 2
                        Else
                            .Direction = -1
                            .Location.SpeedX = -2
                        End If
                    End If
                End If
            ElseIf B = 6 Then .Killed = B
            ElseIf .Type = 206 And B = 10 Then .Killed = B
            End If
'Mega Mole
        ElseIf .Type = 164 Then
            If B = 6 Or B = 7 Or B = 9 Or B = 2 Or B = 10 Then
                .Killed = B
            ElseIf B = 3 Then
                If NPC(C).Type <> 13 Then .Killed = B
            End If
'SMW Goombas
        ElseIf .Type = 165 Or .Type = 166 Or .Type = 167 Or .Type = 168 Then
            If B = 1 Then
                If .Type = 167 Then
                    .Type = 165
                    If .Projectile = False Then
                        PlaySound 9
                        .Projectile = True
                    End If
                ElseIf .Type = 168 Then
                    PlaySound 2
                    If .Special2 = 0 Then
                        .Special2 = 1
                        .Location.SpeedX = 4 * Player(C).Direction
                        .Location.SpeedY = -2
                    End If
                ElseIf .Type = 165 Then
                    PlaySound 9
                    .Projectile = True
                    .Type = 166
                ElseIf .Type = 166 Then
                    If .CantHurt = 0 Then
                        .CantHurtPlayer = C
                        .CantHurt = 10
                        PlaySound 9
                        .Projectile = True
                        If Player(C).Location.X + Player(C).Location.Width / 2 > .Location.X + .Location.Width / 2 Then
                            .Direction = -1
                        Else
                            .Direction = 1
                        End If
                        .Location.SpeedX = 5 * .Direction
                        .Location.SpeedY = -2.5
                    End If
                End If
                .Special = 0
            ElseIf B = 2 Then
                If .Type <> 168 Then .Type = 166
                .Special = 0
                If .Location.SpeedY > -4 Then
                    PlaySound 2
                    If .Type = 168 Then
                        .Special2 = 1
                    Else
                        .Projectile = True
                    End If
                    .Location.SpeedY = -5
                    .Location.Y = Block(C).Location.Y - .Location.Height - 0.01
                End If
            ElseIf B = 7 Then
                If .Type <> 168 Then .Type = 166
                .Special = 0
                PlaySound 2
                .Location.SpeedY = -5
                .Location.SpeedX = 3 * Player(C).Direction
                If .Type = 168 Then
                    .Special2 = 1
                Else
                    .Projectile = True
                End If
            Else
                If .Type = 168 And (B = 3 Or B = 4 Or B = 8) Then
                    If B = 3 And NPC(C).Type <> 13 And NPC(C).Type <> 108 Then
                        .Location.SpeedY = -7
                        .Killed = B
                    End If
                Else
                    .Killed = B
                End If
            End If
'SMB2 Bomb
        ElseIf .Type = 134 Then
            If B = 9 Then
                .Killed = B
            ElseIf B <> 8 And B <> 7 Then
                .Special = 10000
            End If
'Heart bomb
        ElseIf .Type = 291 Then
            If B = 9 Then
                .Killed = B
            ElseIf B <> 1 And B <> 8 And B <> 7 And B <> 10 Then
                If .HoldingPlayer > 0 Then
                    Player(.HoldingPlayer).HoldingNPC = 0
                    .HoldingPlayer = 0
                End If
                .Special4 = 1
            End If
'SMB2 Bob-omb
        ElseIf .Type = 135 Then
            If B = 9 Then
                .Killed = B
            ElseIf B = 7 Then
                .Projectile = True
                .Location.SpeedX = 3 * Player(C).Direction
                .Location.SpeedY = -5
                PlaySound 2
                If .Special < 520 Then .Special = 520
            ElseIf B <> 8 Then
                .Special = 10000
            End If
'Thwomps
        ElseIf .Type = 84 Or .Type = 181 Or .Type = 180 Then
            If B = 6 Then .Killed = B
'Zelda NPCs
        ElseIf .Type = 125 Then
            .Killed = B
'Zelda Bots
        ElseIf NPCIsABot(.Type) Then
            .Killed = B
'Switch Platforms
        ElseIf .Type = 60 Or .Type = 62 Or .Type = 64 Or .Type = 66 Then
            If B = 9 Then .Killed = B
'Veggies
        ElseIf NPCIsVeggie(.Type) Then
            If B = 5 Then
                Player(.HoldingPlayer).HoldingNPC = 0
                .CantHurtPlayer = .HoldingPlayer
                .HoldingPlayer = 0
                .CantHurt = 1000
                .Location.SpeedX = 3 * -.Direction
                .Location.SpeedY = -3
                .Projectile = True
            ElseIf B = 4 And (NPC(C).Type <> .Type Or A = C) Then
                If Not NPC(C).Type = 202 And Not NPC(C).Type = 201 Then
                    If .Location.SpeedY > -4 Then .Location.SpeedY = -4
                    If .Location.SpeedX = 0 Then
                        If Rnd * 2 > 1 Then
                            .Location.SpeedX = 2
                        Else
                            .Location.SpeedX = -2
                        End If
                    End If
                End If
            ElseIf B = 6 Then
                .Killed = B
            End If
'SMB3 Bomb
        ElseIf .Type = 137 Then
            If B = 1 Then
                If .CantHurt = 0 Then
                    .CantHurt = 10
                    .CantHurtPlayer = C
                    PlaySound 2
                    .Projectile = True
                    If Player(C).Location.X + Player(C).Location.Width / 2 > .Location.X + .Location.Width / 2 Then
                        .Direction = -1
                    Else
                        .Direction = 1
                    End If
                    .Location.SpeedX = 5 * .Direction
                    .Location.SpeedY = -2
                End If
            ElseIf B = 2 Then
                If .Location.SpeedY > -4 Then
                    PlaySound 2
                    .Projectile = True
                    .Location.SpeedY = -5
                    .Location.Y = Block(C).Location.Y - .Location.Height - 0.01
                End If
            ElseIf B = 7 Or B = 10 Then
                .Type = 137
                .Special = 0
                PlaySound 2
                .Location.SpeedY = -5
                .Location.SpeedX = 3 * Player(C).Direction
                .Projectile = True
            Else
                If B = 3 Then
                    If NPC(C).Type <> 13 And NPC(C).Type <> 108 Then .Killed = B
                ElseIf B <> 8 Then
                    .Killed = B
                End If
            End If
 'SMB3 Bob-om
        ElseIf .Type = 136 Then
            If B = 1 Then
                .CantHurt = 11
                .Type = 137
                .Special = 0
                PlaySound 2
                .Projectile = True
            ElseIf B = 2 Then
                If .Location.SpeedY > -4 Then
                    PlaySound 2
                    .Location.SpeedY = -5
                    .Projectile = True
                    .Location.Y = Block(C).Location.Y - .Location.Height - 0.01
                End If
                .Type = 137
                .Special = 0
            ElseIf B = 7 Or B = 10 Then
                .Type = 137
                .Special = 0
                PlaySound 2
                .Location.SpeedY = -5
                .Location.SpeedX = 3 * Player(C).Direction
                .Projectile = True
            Else
                If B = 3 Or B = 5 Then
                    If NPC(C).Type <> 13 And NPC(C).Type <> 108 Then .Killed = B
                ElseIf B <> 8 Then
                    .Killed = B
                End If
            End If
            If .Type = 137 Then .Location.Height = 28
'Friendly NPCs (Toad, Peach, Link, Luigi, Etc.)
        ElseIf NPCIsToad(NPC(A).Type) = True Then
            If B = 2 And .Location.SpeedY > -4 Then
                PlaySound 2
                .Location.SpeedY = -5
                .Location.Y = Block(C).Location.Y - .Location.Height - 0.01
            ElseIf B = 3 Or B = 4 Or B = 5 Or B = 6 Or B = 9 Then
                .Killed = B
                If B = 3 Then
                    .Location.SpeedX = 2 * NPC(B).Direction
                End If
            End If
'SMB3 Red Paragoomba
        ElseIf .Type = 3 Then
            If B = 1 Then
                PlaySound 2
                If .Location.SpeedY < 0 Then .Location.SpeedY = 0
                .Type = 2
                .Frame = 0
            Else
                .Killed = B
            End If
'SML2 Paragoomba
        ElseIf .Type = 243 Then
            If B = 1 Then
                PlaySound 2
                If .Location.SpeedY < 0 Then .Location.SpeedY = 0
                .Type = 242
                .Frame = 0
            Else
                .Killed = B
            End If
'SMB3 Brown Paragoomba
        ElseIf .Type = 244 Then
            If B = 1 Then
                PlaySound 2
                If .Location.SpeedY < 0 Then .Location.SpeedY = 0
                .Type = 1
                .Frame = 0
            Else
                .Killed = B
            End If
'SMB3 Ice Block
        ElseIf .Type = 45 Then
            If B = 1 Or (B = 10 And .Projectile = False) Then
                .Special = 1
                 PlaySound 9
                .Location.SpeedX = Physics.NPCShellSpeed * Player(C).Direction
                .CantHurt = Physics.NPCCanHurtWait
                .CantHurtPlayer = C
            ElseIf B = 6 Or B = 2 Or B = 5 Or B = 4 Or (B = 3 And .Special = 1) Or B = 9 Or (B = 10 And .Projectile = True) Then
                If B = 10 Then B = 3
                If B = 4 Then
                    If C = A Then
                        .Killed = B
                        NewEffect 75, .Location
                        Effect(numEffects).Location.X = Effect(numEffects).Location.X + .Location.SpeedX
                        Effect(numEffects).Location.Y = Effect(numEffects).Location.Y + .Location.SpeedY
                    End If
                ElseIf B = 3 Then
                    If Not NPC(C).Type = 13 Then .Killed = B
                    If NPC(C).Killed = 0 Then
                        NPCHit C, 3, A
                    End If
                Else
                    .Killed = B
                End If
            End If
'Bower Statues
        ElseIf .Type = 84 Or .Type = 181 Then
            If B = 2 Then
                .Location.Y = .Location.Y - 1
                .Location.SpeedY = -1
            End If
'Things With Shells (Koopa Troopa, Buzzy Beetle, Etc.)
        ElseIf .Type = 4 Or .Type = 6 Or .Type = 23 Or .Type = 72 Or NPCIsAParaTroopa(.Type) Or (.Type >= 109 And .Type <= 112) Or .Type = 173 Or .Type = 175 Or .Type = 176 Or .Type = 177 Then
            If B = 1 Then
                PlaySound 2
                .Location.Y = .Location.Y + .Location.Height
                .Location.X = .Location.X + .Location.Width / 2
                If .Type = 4 Then
                    .Type = 5
                ElseIf .Type = 6 Then
                    .Type = 7
                ElseIf .Type = 72 Then
                    .Type = 73
                ElseIf .Type = 76 Then ' winged green koopa
                    .Type = 4
                ElseIf .Type = 161 Then ' winged red koopa
                    .Type = 6
                ElseIf .Type = 176 Then ' smb1 winged green koopa
                    .Type = 173
                ElseIf .Type = 177 Then ' smb winged red koopa
                    .Type = 175
                ElseIf .Type = 173 Then ' smb1 green koopa
                    .Type = 172
                    .Location.Height = 28
                ElseIf .Type = 175 Then ' smb red koopa
                    .Type = 174
                    .Location.Height = 28
                ElseIf .Type = 23 Then
                    .Type = 24
                ElseIf .Type >= 121 And .Type <= 124 Then
                    .Type = .Type - 12
                    .Special = 0
                Else
                    numNPCs = numNPCs + 1
                    With NPC(numNPCs)
                        .Location = NPC(A).Location
                        .Location.Y = .Location.Y - 32
                        .Type = NPC(A).Type + 8
                        .Projectile = True
                        .Direction = Player(C).Direction
                        .Location.SpeedY = 0
                        .Location.SpeedX = Physics.NPCShellSpeed * .Direction
                        .Location.X = .Location.X - 16 + .Location.SpeedX
                        CheckSectionNPC numNPCs
                        .CantHurtPlayer = C
                        .CantHurt = 6
                        .Active = True
                        .TimeLeft = 100
                    End With
                    .Type = .Type + 4
                End If
                .Location.Height = NPCHeight(.Type)
                .Location.Width = NPCWidth(.Type)
                .Location.Y = .Location.Y - .Location.Height
                .Location.X = .Location.X - (.Location.Width / 2) - (.Direction * 2)
                .Location.SpeedX = 0
                .Location.SpeedY = 0
                .RealSpeedX = 0
                .Special = 0
                .Frame = 0
                If .Type >= 109 And .Type <= 120 Then NewEffect 10, .Location
            ElseIf B = 2 Or B = 7 Then
                PlaySound 9
                .Projectile = True
                .Location.Y = .Location.Y + .Location.Height
                .Location.X = .Location.X + .Location.Width / 2
                If .Type = 4 Or .Type = 76 Then
                    .Type = 5
                ElseIf .Type = 6 Or .Type = 161 Then
                    .Type = 7
                ElseIf .Type = 72 Then
                    .Type = 73
                ElseIf .Type = 161 Then ' winged red koopa
                    .Type = 6
                ElseIf .Type = 176 Then ' smb1 winged green koopa
                    .Type = 172
                    .Location.Height = 28
                ElseIf .Type = 177 Then ' smb winged red koopa
                    .Type = 174
                    .Location.Height = 28
                ElseIf .Type = 173 Then ' smb1 green koopa
                    .Type = 172
                    .Location.Height = 28
                ElseIf .Type = 175 Then ' smb red koopa
                    .Type = 174
                    .Location.Height = 28
                ElseIf .Type = 23 Then
                    .Type = 24
                ElseIf .Type >= 121 And .Type <= 124 Then
                    .Type = .Type - 12
                    .Special = 0
                Else
                    .Type = .Type + 4
                End If
                If B = 7 And .Type >= 113 And .Type <= 117 Then
                    numNPCs = numNPCs + 1
                    With NPC(numNPCs)
                        .Location = NPC(A).Location
                        .Location.Y = .Location.Y - 32
                        .Type = NPC(A).Type + 4
                        .Projectile = True
                        .Direction = Player(C).Direction
                        .Location.SpeedY = 0
                        .Location.SpeedX = Physics.NPCShellSpeed * .Direction
                        .Location.X = .Location.X - 16 + 32 * .Direction
                        CheckSectionNPC numNPCs
                        .CantHurtPlayer = C
                        .CantHurt = 6
                        .Active = True
                        .TimeLeft = 100
                    End With
                End If
                .Location.Height = NPCHeight(.Type)
                .Location.Width = NPCWidth(.Type)
                .Location.Y = .Location.Y - .Location.Height
                .Location.X = .Location.X - (.Location.Width / 2) - (.Direction * 2)
                .Location.SpeedX = 0
                .Special = 0
                .Frame = 0
                .Location.SpeedY = -5
                If B = 2 Then .Location.Y = Block(C).Location.Y - .Location.Height - 0.01
            Else
                If B = 3 Then
                    If Not (.Type = 23 And (NPC(C).Type = 13 Or NPC(C).Type = 108)) Then .Killed = B
                Else
                    .Killed = B
                End If
            End If
            If NPCIsAShell(.Type) Then .Stuck = False
'SMB3 Bowser
        ElseIf .Type = 86 Then
            If B = 9 Then
                .Killed = 6
                If .Legacy = True Then
                    bgMusic(.Section) = 0
                    StopMusic
                End If
            End If
            If B = 1 Then
                'PlaySound 2
            ElseIf B = 3 Then
                If NPC(C).Type <> 86 Then
                    .Immune = 10
                    If NPC(C).Type = 17 Then
                        NPC(C).Location.SpeedX = -NPC(C).Location.SpeedX
                        NPCHit C, 4, C
                    Else
                        NPCHit C, 3, A
                    End If
                    If NPC(C).Type <> 13 Then
                        PlaySound 39
                        .Damage = .Damage + 10
                    Else
                        PlaySound 9
                        .Damage = .Damage + 1
                    End If
                End If
            ElseIf B = 6 Then .Killed = B
            ElseIf B = 10 Then
                .Immune = 10
                PlaySound 39
                .Damage = .Damage + 10
            End If
            If .Damage >= 200 Then
                .Location.SpeedY = -13
                .Location.SpeedX = 4 * NPC(C).Direction
                .Killed = B
                If .Legacy = True Then
                    bgMusic(.Section) = 0
                    StopMusic
                End If
            End If
'SMW Rainbow Shell
        ElseIf .Type = 194 Then
            If B = 1 Then
                PlaySound 2
            ElseIf B = 2 Or B = 7 Then
                PlaySound 9
                .Location.SpeedY = -5
                If B = 7 Then
                    .Type = 195
                    .Location.SpeedX = 0
                    MoreScore 6, .Location, Player(C).Multiplier
                End If
            ElseIf B = 6 Then
                tempLocation.Y = .Location.Y + .Location.Height - 2
                tempLocation.X = .Location.X - 4 + Rnd * (.Location.Width + 8) - 4
                NewEffect 74, tempLocation
            ElseIf B = 8 Then
                .Killed = 8
                PlaySound 36
            End If
'Shells
        ElseIf .Type = 5 Or .Type = 7 Or .Type = 24 Or .Type = 73 Or (.Type >= 113 And .Type <= 116) Or .Type = 174 Or .Type = 172 Or .Type = 195 Then
            If B = 1 Then
                If .Effect = 2 Then .Effect = 0
                If Player(C).Dismount <= 0 And Player(C).Mount <> 2 Then
                    If .Location.SpeedX = 0 And .CantHurtPlayer <> C Then
                        PlaySound 9
                        .Location.SpeedX = Physics.NPCShellSpeed * Player(C).Direction
                        .CantHurt = Physics.NPCCanHurtWait
                        .CantHurtPlayer = C
                        .Projectile = True
                        .Location.SpeedY = 0
                    ElseIf .CantHurtPlayer <> C Or (.Slope = 0 And Player(C).Vine = 0) Then
                        PlaySound 2
                        .Location.SpeedX = 0
                        .Location.SpeedY = 0
                        If .Wet > 0 Then
                            .RealSpeedX = 0
                            .Projectile = False
                        End If
                    End If
                End If
            ElseIf B = 2 Or B = 7 Then
                PlaySound 9
                .Projectile = True
                .Location.SpeedY = -5
                .Location.SpeedX = 0
            ElseIf B = 6 Then
                If .Type = 195 Then
                    tempLocation.Y = .Location.Y + .Location.Height - 2
                    tempLocation.X = .Location.X - 4 + Rnd * (.Location.Width + 8) - 4
                    NewEffect 74, tempLocation
                Else
                    .Killed = B
                End If
            ElseIf Not B = 4 Then
                If B = 3 Then
                    If Not (.Type = 24 And (NPC(C).Type = 13 Or NPC(C).Type = 108)) Then
                        .Killed = B
                    End If
                Else
                    .Killed = B
                End If
            ElseIf B = 4 Then
                If NPC(C).Projectile = True And Not (NPC(C).Type >= 117 And NPC(C).Type <= 120) Then
                    If Not (.Type = 24 And NPC(C).Type = 13) Then
                        .Killed = B
                    Else
                        .Killed = B
                    End If
                End If
            End If
            If .Type = 195 Then
                .Killed = 0
                If B = 5 Then
                    PlaySound 9
                    .Location.SpeedX = Physics.NPCShellSpeed * -.Direction
                    .Location.X = .Location.X + .Location.SpeedX
                    .CantHurt = Physics.NPCCanHurtWait
                    .CantHurtPlayer = C
                    .Projectile = True
                    .Location.SpeedY = 0
                    Player(.HoldingPlayer).HoldingNPC = 0
                    .HoldingPlayer = 0
                End If
            End If
'Big Piranha Plant
        ElseIf .Type = 256 Or .Type = 257 Then
            If Not (B = 1 Or B = 2 Or B = 6) Then
                If .Special3 = 0 Then
                    If B = 3 Then
                        If NPC(C).Type = 13 Then
                            PlaySound 39
                            .Damage = .Damage + 1
                            .Special3 = 10
                            If .Special2 = 2 Then .Special = 50
                        Else
                            .Damage = .Damage + 3
                            PlaySound 39
                            .Special3 = 30
                            If .Special2 = 2 Then .Special = 50
                        End If
                    ElseIf B = 10 Then
                        .Damage = .Damage + 2
                        PlaySound 39
                        .Special3 = 10
                        If .Special2 = 2 Then .Special = 50
                    End If
                End If
                If .Damage >= 6 Then .Killed = B
            End If
            
'Piranha Plants
        ElseIf .Type = 8 Or .Type = 275 Or .Type = 93 Or .Type = 51 Or .Type = 52 Or .Type = 74 Or .Type = 245 Or .Type = 270 Then
            If Not (B = 1 Or B = 2 Or B = 6) Then
                If B <> 8 And B <> 10 Then PlaySound 9
                .Killed = B
            End If
'Podoboo
        ElseIf .Type = 12 Then
            If B = 9 Then
            ElseIf B = 8 Then .Killed = B
            ElseIf B = 3 Or B = 5 Or B = 7 Then
                PlaySound 9
                .Killed = B
            ElseIf B = 4 And C > 0 Then
                If NPC(C).Projectile = True Then
                    PlaySound 9
                    .Killed = 3
                End If
            End If
'Player Fireball
        ElseIf .Type = 13 Or .Type = 265 Then
            If Not B = 7 And Not B = 9 And Not B = 2 Then
                If B = 3 Or B = 4 Then
                    If NPC(C).Type <> 171 Then
                        If B <> 6 Then PlaySound 3
                        .Killed = B
                    End If
                Else
                    If B <> 6 Then PlaySound 3
                    .Killed = B
                End If
            End If
'Yoshi Fireball
        ElseIf .Type = 108 Then
            If B = 3 Or B = 5 Then
                PlaySound 3
                .Killed = B
            End If
'Hammer Bros.
        ElseIf .Type = 29 Then
            .Killed = B
'Hammer Bros. Hammer
        ElseIf .Type = 30 Then
            If B = 3 Then .Killed = B
'Boom Boom
        ElseIf .Type = 15 Then
            If Not .Special = 4 Then
                If (B = 1 Or B = 10) And .Special = 0 Then
                    .Damage = .Damage + 3
                    If B = 1 Then
                        PlaySound 2
                    Else
                        PlaySound 39
                    End If
                    .Special = 4
                    .Special2 = 0
                    .Location.SpeedX = 0
                    .Location.SpeedY = 0
                ElseIf B = 3 Then
                    .Immune = 20
                    If C > 0 Then
                        NPCHit C, 3, A
                    End If
                    .Damage = .Damage + 1
                    PlaySound 9
                ElseIf B = 6 Then
                    .Killed = B
                    PlaySound 9
                ElseIf B = 10 Then
                    UpdateGraphics
                    .Immune = 10
                    .Damage = .Damage + 1
                    PlaySound 39
                End If
            End If
            If .Damage >= 9 Then .Killed = B
'Bullet Bills
        ElseIf .Type = 17 Or .Type = 18 Then
            If B = 1 Or B = 3 Or B = 4 Or B = 5 Or B = 7 Or B = 8 Or B = 10 Then
                If Not ((B = 3 Or B = 4) And (NPC(C).Type = 13 Or NPC(C).Type = 12)) Then
                    If Not (B = 7 And .Projectile = True) Then
                        If Not (B = 3 And .CantHurt > 0) And Not (B = 3 And NPC(C).Type = 108) Then
                            If Not (.Type = 18 And B = 4) Then
                                If Not (B = 10 And .Projectile = True) Then 'Link can't stab friendly bullets
                                    .Killed = B
                                    If A <> C And B <> 8 And B <> 10 Then PlaySound 9
                                End If
                            End If
                        End If
                    End If
                End If
            End If
'Birdo
        ElseIf .Type = 39 Then
            If .Special >= 0 Then
                If B = 3 Then
                    If NPC(C).Type <> 13 Then
                        .Special = -30
                        .Damage = .Damage + 1
                        .Direction = -.Direction
                        PlaySound 39
                    End If
                ElseIf B = 4 Then
                    .Damage = 3
                ElseIf B = 10 Then
                    .Special = -30
                    .Damage = .Damage + 1
                    .Direction = -.Direction
                    PlaySound 39
                End If
                If .Damage >= 3 Then .Killed = B
            End If
            If B = 6 Then
                .Killed = B
                PlaySound 39
            End If
'Eggs
        ElseIf .Type = 40 Then
            If B = 3 Then
                If NPC(C).Type = 13 Then B = 0
            End If
            If B = 3 Or B = 4 Or B = 5 Or B = 7 Or B = 10 Then
                If C = A Then
                    .Special = 1
                Else
                    NPC(A).Location.SpeedX = NPC(A).Location.SpeedX * 0.6
                    PlaySound 9
                End If
                .Killed = B
            End If
'Indestructable Objects
        ElseIf .Type = 21 Or .Type = 22 Or .Type = 26 Or .Type = 31 Or .Type = 32 Or .Type = 238 Or .Type = 239 Or .Type = 35 Or .Type = 191 Or .Type = 193 Or .Type = 49 Or NPCIsYoshi(.Type) Or .Type = 96 Or (.Type >= 154 And .Type <= 157) Or .Type = 240 Or .Type = 241 Or .Type = 278 Or .Type = 279 Then
            If .Type = 241 And (B = 4 Or B = 5 Or B = 10) Then
                .Killed = 4
                PowBlock
            End If
            If .Type = 96 And (B = 4 Or B = 5) Then
                If NPC(C).Type <> .Type Then .Killed = B
            ElseIf .Type = 96 And B = 10 Then
                PlaySound 53
                .Special2 = 1
            Else
                If B = 1 And .Type = 26 Then PlaySound 24
                If B = 1 And (.Type = 32 Or .Type = 238 Or .Type = 239) Then
                    .Killed = 1
                    If .Type = 32 Then
                        PSwitchTime = Physics.NPCPSwitch
                        PSwitchPlayer = C
                    ElseIf .Type = 238 Then
                        PSwitchStop = Physics.NPCPSwitch
                        FreezeNPCs = True
                        PSwitchPlayer = C
                    End If
                End If
                If B = 2 And .Location.SpeedY > -4 And .CantHurt = 0 Then
                    .CantHurt = 10
                    PlaySound 2
                    .Location.SpeedY = -5
                    'If .Type = 96 Then .Location.SpeedY = -4
                    .Location.Y = Block(C).Location.Y - .Location.Height - 0.01
                ElseIf B = 6 Then
                    If .Type = 191 Then
                        tempLocation.Y = .Location.Y + .Location.Height - 2
                        'tempLocation.X = .Location.X + .Location.Width / 2 - 4 '+ 4 * .Direction
                        tempLocation.X = .Location.X - 4 + Rnd * (.Location.Width + 8) - 4
                        NewEffect 74, tempLocation
                    Else
                        If .Type = 26 Then .Location.Y = .Location.Y - 16
                        NewEffect 10, .Location
                        If .NoLavaSplash = False Then NewEffect 13, .Location
                        PlaySound 16
                        .Location = .DefaultLocation
                        .Active = False
                        .TimeLeft = 0
                        .Projectile = False
                        .Direction = .DefaultDirection
                        .CantHurt = 0
                        .CantHurtPlayer = 0
                        .Reset(1) = False
                        .Reset(2) = False
                    End If
                End If
            End If
'Misc. Things With No Jump Death (SMB2 Shy Guys, SMB2 Ninji, SMB2 Pokey)
        ElseIf .Type = 19 Or .Type = 20 Or .Type = 247 Or .Type = 25 Or .Type = 28 Or .Type = 36 Or .Type = 285 Or .Type = 286 Or .Type = 47 Or .Type = 284 Or .Type = 48 Or .Type = 53 Or .Type = 54 Or (.Type >= 129 And .Type <= 132) Or .Type = 158 Or .Type = 231 Or .Type = 235 Or .Type = 261 Or .Type = 272 Then
            If B = 10 And .Type <> 158 Then
                .Killed = B
            ElseIf B <> 1 Then
                If B = 6 Then
                    .Killed = B
                ElseIf B = 2 And .Type = 158 Then
                    If .CantHurt = 0 Then
                        .CantHurt = 10
                        PlaySound 2
                        .Location.SpeedY = -5
                        .Location.Y = Block(C).Location.Y - .Location.Height - 0.01
                        .Projectile = True
                        .Location.SpeedX = .Location.SpeedX * 0.5
                    End If
                ElseIf .Type = 158 And B = 5 Then
                    Player(.HoldingPlayer).HoldingNPC = 0
                    .Projectile = True
                    .Location.SpeedX = 3 * -Player(.HoldingPlayer).Direction
                    .Location.SpeedY = -4
                    .WallDeath = 0
                    .HoldingPlayer = 0
                ElseIf .Type = 158 And B = 3 Then
                    If NPC(C).HoldingPlayer = 0 And NPC(C).Type <> .Type Then
                        .Immune = 30
                        .Projectile = True
                        .Location.SpeedY = -5
                        .Location.SpeedX = (NPC(C).Location.SpeedX + .Location.SpeedX) * 0.5
                        If .Location.SpeedX < 1.2 And .Location.SpeedX > -1.2 Then
                            If NPC(C).Direction = -1 Then
                                .Location.SpeedX = 3
                            Else
                                .Location.SpeedX = -3
                            End If
                        End If
                        PlaySound 9
                    End If
                ElseIf .Type = 158 And B = 10 Then
                    .Immune = 30
                    .Projectile = True
                    .Location.SpeedY = -5
                    .Location.SpeedX = Player(C).Location.SpeedX + 4 * Player(C).Direction
                    PlaySound 9
                ElseIf Not (.Type = 158 And (B = 4 Or B = 8 Or (B = 3 And NPC(C).Type = 13))) Then
                    If .Type = 158 And B = 7 Then
                        .Direction = Player(C).Direction
                        .Location.SpeedX = Abs(.Location.SpeedX) * .Direction
                        .TurnAround = False
                        .Location.SpeedY = -6
                        .Projectile = True
                        PlaySound 2
                    Else
                        .Killed = B
                    End If
                End If
            ElseIf B = 1 And .Type = 28 Then
                .Killed = B
                .Location.SpeedY = 0
                .Location.SpeedX = 0
            ElseIf B = 1 And NPCCanWalkOn(.Type) = False And NPCJumpHurt(.Type) = False Then
                .Killed = B
                .Location.SpeedY = 0.123
                .Location.SpeedX = 0
            End If
            If B = 1 And .Type = 158 Then PlaySound 2
            If (B = 1 Or B = 8) And (.Type = 47 Or .Type = 284) Then .Killed = B
'Exits
        ElseIf NPCIsAnExit(.Type) Then
            If B = 6 Then
                NewEffect 10, .Location
                NewEffect 13, NPC(A).Location
                PlaySound 16
                .Location = .DefaultLocation
            End If
'Coins
        ElseIf NPCIsACoin(.Type) Then
            If LevelEditor = True Then PlaySound 9
            If B = 2 Then
                If .Type = 251 Or .Type = 252 Or .Type = 253 Then
                    PlaySound 81
                    NewEffect 78, .Location
                    MoreScore 1, .Location
                ElseIf .Type = 258 Or .Type = 103 Then
                    PlaySound 14
                    NewEffect 78, .Location
                    MoreScore 1, .Location
                Else
                    .Location.Y = .Location.Y + .Location.Height
                    .Location.X = .Location.X '- (32 - .Location.Width) / 2
                    .Location.Height = 0
                    PlaySound 14
                    NewEffect 11, .Location
                End If
                .Killed = 9
                If .Type = 252 Or .Type = 258 Then
                    Coins = Coins + 5
                ElseIf .Type = 253 Then
                    Coins = Coins + 20
                Else
                    Coins = Coins + 1
                End If
                If Coins >= 100 Then
                    If Lives < 99 Then
                        Lives = Lives + 1
                        PlaySound 15
                        Coins = Coins - 100
                    Else
                        Coins = 99
                    End If
                End If
            ElseIf B = 5 Or B = 3 Or B = 4 Or B = 6 Then
                .Killed = B
            ElseIf B = 10 Then
                If C > 0 Then TouchBonus C, A
            End If
'Bonus Items
        ElseIf NPCIsABonus(.Type) Then
            If B = 2 And .Location.SpeedY > -4 Then
                PlaySound 2
                .Location.SpeedY = -5
                .Location.Y = Block(C).Location.Y - .Location.Height - 0.01
            ElseIf B = 6 Or B = 5 Or B = 4 Then
                If Not (NPC(C).Type = 13 Or NPC(C).Type = 108 Or NPC(C).Type = 171 Or NPCIsVeggie(NPC(C).Type)) Then
                    .Killed = B
                End If
            ElseIf B = 7 Then
                If .Type = 9 Or .Type = 273 Or .Type = 14 Or .Type = 90 Or .Type = 153 Or .Type = 169 Or .Type >= 182 And .Type <= 188 Or .Type = 170 Then
                    .Direction = Player(C).Direction
                    .Location.SpeedX = Abs(.Location.SpeedX) * .Direction
                    .TurnAround = False
                    .Location.SpeedY = -6
                    PlaySound 2
                End If
            ElseIf B = 10 And .Type <> 153 Then
                If C > 0 And .Effect = 0 Then TouchBonus C, A
            End If
        End If
      
        If .Killed = 10 Then .Direction = Player(C).Direction
        tempBool = False
        If .Killed = 3 Then
            If NPC(C).Type = 13 And NPC(C).Special = 5 And .Type <> 13 Then
                .Direction = NPC(C).Direction
                .Killed = 10
                tempBool = True
            End If
        End If
        If .Killed = 10 Then
            If tempBool = True Then
                MoreScore NPCScore(.Type), .Location, NPC(C).Multiplier
            Else
                MoreScore NPCScore(.Type), .Location, Player(C).Multiplier
            End If
        End If
'Calculate Score
        Player(0).Multiplier = 0
        If (B = 1 Or B = 8) And C <= numPlayers And NPCIsABonus(.Type) = False Then
            If .Type = 13 Or .Type = 32 Or .Type = 238 Or .Type = 239 Then
            ElseIf oldNPC.Type = 137 Or .Type = 45 Or oldNPC.Type = 166 Or .Type = 168 Or (NPCIsAShell(oldNPC.Type) And Not B = 8) Then
                If Not B = 8 Then '(.Type = 45 And B = 8) Then
                    If .Type <> 195 Then
                        'MoreScore 1, .Location
                        If Player(C).Multiplier > .Multiplier Then .Multiplier = Player(C).Multiplier
                    End If
                End If
            ElseIf .Location.SpeedX <> oldNPC.Location.SpeedX Or .Location.SpeedY <> oldNPC.Location.SpeedY Or .Projectile <> .Projectile Or .Killed <> oldNPC.Killed Or .Type <> oldNPC.Type Or .Inert <> oldNPC.Inert Then
                If .Type = 15 And .Killed = 0 Then
                    MoreScore 2, .Location, Player(C).Multiplier
                    If Player(C).Multiplier > .Multiplier Then .Multiplier = Player(C).Multiplier
                Else
                    MoreScore NPCScore(.Type), .Location, Player(C).Multiplier
                    If Player(C).Multiplier > .Multiplier Then .Multiplier = Player(C).Multiplier
                End If
            End If
        End If
        If (B = 2 Or B = 7) And NPCIsABonus(.Type) = False And oldNPC.Type <> 194 And .Type <> 241 Then
            If (.Killed <> 0 Or .Type <> oldNPC.Type) Then
                MoreScore NPCScore(.Type), .Location
                If B = 2 Then NewEffect 75, newLoc(.Location.X, .Location.Y + .Location.Height - 16)
            ElseIf .Location.SpeedX <> oldNPC.Location.SpeedX Or .Location.SpeedY <> oldNPC.Location.SpeedY Or .Projectile <> .Projectile Then
                'MoreScore 1, .Location
                If B = 2 Then NewEffect 75, newLoc(.Location.X, .Location.Y + .Location.Height - 16)
            End If
        End If
        If B = 4 And .Killed = 4 And NPCIsACoin(.Type) = False And C <> A And .Type <> 13 And .Type <> 265 And .Type <> 108 And .Type <> 241 Then
            If NPC(C).Type <> 208 Then
                If Not (.Type = 17 And .CantHurt > 0) Then
                    If NPC(C).Multiplier < .Multiplier Then NPC(C).Multiplier = .Multiplier
                    MoreScore NPCScore(.Type), .Location, NPC(C).Multiplier
                End If
            End If
        End If
        If B = 5 And .Killed = 5 Then
            If .Multiplier < NPC(C).Multiplier Then .Multiplier = NPC(C).Multiplier
            MoreScore NPCScore(.Type), .Location, .Multiplier
        End If
        If B = 6 And .Killed = 6 And (.Type = 209 Or .Type = 200 Or .Type = 201 Or .Type = 15 Or .Type = 39 Or .Type = 86) Then
            If NPCWontHurt(.Type) = False And NPCIsABonus(.Type) = False And .Type <> 13 Then
                MoreScore NPCScore(.Type), .Location
            End If
        End If
        If NPCIsACoin(.Type) = False And B = 3 And C <> A And (.Killed = B Or .Damage <> oldNPC.Damage) And .Type <> 13 And .Type <> 108 And .Type <> 45 And .Type <> 210 And .Type <> 241 Then
            If .Killed = B Then
                If NPC(C).Multiplier < .Multiplier Then NPC(C).Multiplier = .Multiplier
                MoreScore NPCScore(.Type), .Location, NPC(C).Multiplier
            End If
            If .Type <> 208 And .Type <> 209 Then
                If .Location.Width >= 64 Or .Location.Height >= 64 Then
                    With NPC(C)
                        tempLocation = .Location
                        tempLocation.X = .Location.X + .Location.Width / 2 - 16 + .Location.SpeedX
                        tempLocation.Y = .Location.Y + .Location.Height / 2 - 16 + .Location.SpeedY
                    End With
                Else
                    tempLocation = .Location
                    tempLocation.Y = (NPC(C).Location.Y + tempLocation.Y + NPC(C).Location.Height / 2 + tempLocation.Height / 2) / 2 - 16
                    tempLocation.X = (NPC(C).Location.X + tempLocation.X + NPC(C).Location.Width / 2 + tempLocation.Width / 2) / 2 - 16
                End If
                NewEffect 75, tempLocation
            End If
        End If
        If .Killed = 6 Then
            If BlockKills2(Block(C).Type) = True Then .NoLavaSplash = True
        End If
        If .Killed = 0 And .Location.SpeedX = 0 And oldNPC.Location.SpeedX <> 0 Then .RealSpeedX = 0
        
        If .Type <> oldNPC.Type Then
            .Location.Y = .Location.Y + .Location.Height
            .Location.Height = NPCHeight(.Type)
            .Location.Y = .Location.Y - .Location.Height
            .Location.X = .Location.X + .Location.Width / 2
            .Location.Width = NPCWidth(.Type)
            .Location.X = .Location.X - .Location.Width / 2
        End If
    
    End With
    

    
    StopHit = 0
End Sub

Public Sub KillNPC(A As Integer, B As Integer) 'Handles NPC deaths and death effects
    '------+  KILL CODES  +-------
    'B = 1      Jumped on by a player (or kicked)
    'B = 2      Hit by a shaking block
    'B = 3      Hit by projectile
    'B = 4      Hit something as a projectile
    'B = 5      Hit something while being held
    'B = 6      Touched a lava block
    'B = 8      Stomped by boot
    'B = 9      Time to DIE
    'B = 10     Zelda Stab
    Dim DontSpawnExit As Boolean
    Dim DontResetMusic As Boolean
    Dim tempBool As Boolean
    Dim blankNPC As NPC
    Dim C As Integer
    Dim tempLocation As Location
    With NPC(A)
        If .Type = 263 And .Special > 0 And .Killed <> 9 Then
            NewEffect 10, .Location
            For C = 1 To 50
                tempLocation.Height = EffectHeight(80)
                tempLocation.Width = EffectWidth(80)
                tempLocation.SpeedX = 0
                tempLocation.SpeedY = 0
                tempLocation.X = .Location.X - tempLocation.Width / 2 + Rnd * .Location.Width
                tempLocation.Y = .Location.Y - tempLocation.Height / 2 + Rnd * .Location.Height
                NewEffect 80, tempLocation
                Effect(numEffects).Location.SpeedX = Rnd * 4 - 2 - .Location.SpeedX * 0.2
                Effect(numEffects).Location.SpeedY = Rnd * 4 - 2 + .Location.SpeedY * 0.2
                Effect(numEffects).Frame = Int(Rnd * 3)
            Next C
            PlaySound 9
            .Type = .Special
            If B <> 10 Then
                MoreScore NPCScore(.Type), .Location, .Multiplier
            End If
            .Location.SpeedX = .Location.SpeedX * 0.4
            If .Location.SpeedX < 2 And .Location.SpeedX > -2 Then .Location.SpeedX = 2 * .Direction
        End If
        If .Killed = 8 And .Type <> 13 And .Type <> 125 And NPCIsABot(.Type) = False And .Type <> 203 And .Type <> 204 And .Type <> 205 And .Type <> 210 Then
            NewEffect 76, .Location
        End If
        If .Type = 59 Or .Type = 61 Or .Type = 63 Or .Type = 65 Or .DefaultType = 59 Or .DefaultType = 61 Or .DefaultType = 63 Or .DefaultType = 65 Then
            tempBool = False
            For C = 1 To numNPCs
                If NPC(C).Type = .Type And NPC(C).Section = .Section And C <> A Then tempBool = True
            Next C
            If LevelEditor = True Then tempBool = True
            If tempBool = False Then
                If .Type = 59 Or .DefaultType = 59 Then
                    PlaySound 32
                    For C = 1 To numBlock
                        If Block(C).Type = 171 Then
                            Block(C).Type = 172
                        ElseIf Block(C).Type = 172 Then
                            Block(C).Type = 171
                        End If
                    Next C
                    For C = 1 To numNPCs
                        If NPC(C).Type = 60 Then
                            NPC(C).Direction = -NPC(C).Direction
                        End If
                    Next C
                ElseIf .Type = 61 Or .DefaultType = 61 Then
                    PlaySound 32
                    For C = 1 To numBlock
                        If Block(C).Type = 174 Then
                            Block(C).Type = 175
                        ElseIf Block(C).Type = 175 Then
                            Block(C).Type = 174
                        End If
                    Next C
                    For C = 1 To numNPCs
                        If NPC(C).Type = 62 Then
                            NPC(C).Direction = -NPC(C).Direction
                        End If
                    Next C
                ElseIf .Type = 63 Or .DefaultType = 63 Then
                    PlaySound 32
                    For C = 1 To numBlock
                        If Block(C).Type = 177 Then
                            Block(C).Type = 178
                        ElseIf Block(C).Type = 178 Then
                            Block(C).Type = 177
                        End If
                    Next C
                    For C = 1 To numNPCs
                        If NPC(C).Type = 64 Then
                            NPC(C).Direction = -NPC(C).Direction
                        End If
                    Next C
                ElseIf .Type = 65 Or .DefaultType = 65 Then
                    PlaySound 32
                    For C = 1 To numBlock
                        If Block(C).Type = 180 Then
                            Block(C).Type = 181
                        ElseIf Block(C).Type = 181 Then
                            Block(C).Type = 180
                        End If
                    Next C
                    For C = 1 To numNPCs
                        If NPC(C).Type = 66 Then
                            NPC(C).Direction = -NPC(C).Direction
                        End If
                    Next C
                End If
            End If
        End If
        If .TriggerDeath <> "" And LevelEditor = False Then ProcEvent .TriggerDeath
        If .TriggerLast <> "" Then
            tempBool = False
            For C = 1 To numNPCs
                If C <> A Then
                    If NPC(C).Layer = NPC(A).Layer And NPC(C).Generator = False Then tempBool = True
                End If
            Next C
            For C = 1 To numBlock
                If NPC(A).Layer = Block(C).Layer Then tempBool = True
            Next C
            If tempBool = False Then ProcEvent .TriggerLast
        End If
        If .HoldingPlayer > 0 Then
            If Not NPCIsAnExit(.Type) Then Player(.HoldingPlayer).HoldingNPC = 0   'Tell the player the NPC he was holding is dead
        End If
        If .Killed = 10 Then 'Things that die by Link's sword
            If Not (.Type = 15 Or .Type = 39 Or .Type = 86 Or .Type = 209 Or .Type = 200 Or .Type = 201 Or .Type = 203 Or .Type = 204 Or .Type = 205 Or .Type = 210 Or .Type = 208) Then
                PlaySound 53
                NewEffect 63, .Location
                B = 9
                If Rnd * 10 <= 3 Then
                    numNPCs = numNPCs + 1
                    NPC(numNPCs).Type = 251
                    If Rnd * 15 <= 3 Then NPC(numNPCs).Type = 252
                    If Rnd * 40 <= 3 Then NPC(numNPCs).Type = 253
                    NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                    NPC(numNPCs).Location.X = .Location.X + .Location.Width / 2 - NPC(numNPCs).Location.Width / 2
                    NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                    If .Location.Height >= 32 Then
                        NPC(numNPCs).Location.Y = .Location.Y + .Location.Height / 2 - NPC(numNPCs).Location.Height / 2
                    ElseIf .Type = 51 Or .Type = 257 Then 'Stops the rupees from spawning in blocks
                        NPC(numNPCs).Location.Y = .Location.Y + 1
                    Else 'Stops the rupees from spawning in blocks
                        NPC(numNPCs).Location.Y = .Location.Y + .Location.Height - NPC(numNPCs).Location.Height - 1
                    End If
                    NPC(numNPCs).Section = .Section
                    NPC(numNPCs).TimeLeft = Physics.NPCTimeOffScreen
                    NPC(numNPCs).Active = True
                    NPC(numNPCs).TailCD = 10
                    NPC(numNPCs).Special = 1
                    NPC(numNPCs).Location.SpeedY = -5
                    NPC(numNPCs).Location.SpeedX = (1 + Rnd * 0.5) * .Direction
                End If
            End If
        End If
        If Not B = 9 Then
            .Location.SpeedX = -.Location.SpeedX
            If .Type = 235 Or .Type = 231 Or .Type = 1 Or .Type = 242 Or .Type = 243 Or .Type = 244 Or .Type = 162 Or .Type = 163 Or .Type = 164 Or .Type = 165 Or .Type = 166 Or .Type = 167 Or .Type = 229 Or .Type = 236 Or .Type = 230 Or .Type = 232 Or .Type = 233 Or .Type = 234 Or .Type = 237 Or .Type = 263 Then    'Goomba / Rex
                If B = 1 And .Type <> 229 And .Type <> 236 And .Type <> 230 And .Type <> 232 And .Type <> 233 And .Type <> 234 Then
                    If .Type = 1 Then
                        NewEffect 2, .Location
                    ElseIf .Type = 242 Then
                        NewEffect 126, .Location
                    Else
                        NewEffect 84, .Location, .Direction
                    End If
                ElseIf B = 6 Then
                    PlaySound 16
                    .Location.X = .Location.X + .Location.Width / 2 - 16
                    .Location.Width = 32
                    .Location.Y = .Location.Y + .Location.Height - 32
                    .Location.Height = 32
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                    .Location.X = .Location.X + .Location.Width / 2 - 16
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    If .Type = 1 Or .Type = 244 Then
                        NewEffect 4, .Location
                    ElseIf .Type = 242 Or .Type = 243 Then
                        NewEffect 127, .Location
                    ElseIf .Type = 231 Then
                        NewEffect 117, .Location
                    ElseIf .Type = 235 Then
                        NewEffect 121, .Location
                    ElseIf .Type = 162 Then
                        NewEffect 86, .Location, .Direction
                    ElseIf .Type = 164 Then
                        NewEffect 87, .Location, .Direction
                    ElseIf .Type = 163 Then
                        NewEffect 85, .Location, .Direction
                    ElseIf .Type = 229 Then
                        .Location.SpeedY = -11
                        If B = 1 Then .Location.SpeedY = -2
                        NewEffect 115, .Location, .Direction
                    ElseIf .Type = 236 Then
                        .Location.SpeedY = -11
                        If B = 1 Then .Location.SpeedY = -2
                        NewEffect 122, .Location, .Direction
                    ElseIf .Type = 230 Then
                        .Location.SpeedY = -11
                        If B = 1 Then .Location.SpeedY = -2
                        NewEffect 116, .Location, .Direction
                    ElseIf .Type = 232 Then
                        .Location.SpeedY = -11
                        If B = 1 Then .Location.SpeedY = -2
                        NewEffect 118, .Location, .Direction
                    ElseIf .Type = 233 Then
                        .Location.SpeedY = -11
                        If B = 1 Then .Location.SpeedY = -2
                        NewEffect 119, .Location, .Direction
                    ElseIf .Type = 234 Then
                        .Location.SpeedY = -11
                        If B = 1 Then .Location.SpeedY = -2
                        NewEffect 120, .Location, .Direction
                    ElseIf .Type = 237 Or .Type = 263 Then
                        NewEffect 10, .Location
                        For C = 1 To 50
                            tempLocation.Height = EffectHeight(80)
                            tempLocation.Width = EffectWidth(80)
                            tempLocation.SpeedX = 0
                            tempLocation.SpeedY = 0
                            tempLocation.X = .Location.X - tempLocation.Width / 2 + Rnd * .Location.Width
                            tempLocation.Y = .Location.Y - tempLocation.Height / 2 + Rnd * .Location.Height
                            NewEffect 80, tempLocation
                            Effect(numEffects).Location.SpeedX = Rnd * 2 - 1 - .Location.SpeedX * 0.3
                            Effect(numEffects).Location.SpeedY = Rnd * 2 - 1 + .Location.SpeedY * 0.3
                            Effect(numEffects).Frame = Int(Rnd * 3)
                        Next C
                    Else
                        NewEffect 88, .Location, .Direction
                    End If
                End If
            ElseIf .Type = 203 Or .Type = 204 Or .Type = 205 Or .Type = 210 Then
                PlaySound 65
                NewEffect 108, .Location
            ElseIf .Type = 208 Then
                PlaySound 67
                For C = 1 To 100
                    NewEffect 111, newLoc(.Location.X + Rnd * .Location.Width - 16, .Location.Y + Rnd * .Location.Height - 16)
                Next C
            ElseIf .Type = 209 Then
                PlaySound 69
                PlaySound 70
                NewEffect 112, .Location, .Direction
            ElseIf .Type = 38 Or .Type = 42 Or .Type = 43 Or .Type = 44 Or .Type = 206 Or .Type = 259 Then
                PlaySound 9 'Shell hit sound
                .Location.SpeedY = -10
                If .Type = 38 Then
                    NewEffect 94, .Location, .Direction
                ElseIf .Type = 42 Then
                    NewEffect 93, .Location, .Direction
                ElseIf .Type = 43 Then
                    NewEffect 92, .Location, .Direction
                ElseIf .Type = 206 Then
                    NewEffect 110, .Location
                ElseIf .Type = 259 Then
                    NewEffect 136, .Location
                    Effect(numEffects).Frame = .Frame
                    Effect(numEffects).Life = 100
                Else
                    NewEffect 91, .Location, .Direction
                End If
            ElseIf .Type = 168 Then 'bully
                .Location.SpeedY = -8
                If B = 6 Then
                    PlaySound 16
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height - EffectHeight(10)
                     .Location.Width = 32
                     .Location.Height = 32
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9
                    NewEffect 89, .Location, .Direction
                End If
            
            
            
            
            'turnips
            ElseIf NPCIsVeggie(.Type) Then
                .Location.Y = .Location.Y - (32 - .Location.Height)
                .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                .Location.Height = 32
                .Location.Width = 32
                If .Killed = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                End If
            ElseIf .Type = 32 Then 'P Switch
                If B = 1 Then
                    .Location.Y = .Location.Y + 2
                    NewEffect 81, .Location
                ElseIf B = 2 Then
                    PlaySound 9
                    NewEffect 10, .Location
                End If
            ElseIf .Type = 238 Then 'P Switch Time
                If B = 1 Then
                    .Location.Y = .Location.Y + 2
                    NewEffect 123, .Location
                ElseIf B = 2 Then
                    PlaySound 9
                    NewEffect 10, .Location
                End If
            ElseIf .Type = 239 Then 'Red Switch
                If B = 1 Then
                    .Location.Y = .Location.Y + 2
                    NewEffect 124, .Location
                ElseIf B = 2 Then
                    PlaySound 9
                    NewEffect 10, .Location
                End If
            ElseIf (.Type = 84 Or .Type = 181) And B = 6 Then   'lava only
                .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                .Location.Y = .Location.Y + .Location.Height - 32
                .Location.Height = 32
                .Location.Width = 32
                PlaySound 16
                NewEffect 10, .Location
                If .NoLavaSplash = False Then NewEffect 13, .Location
            ElseIf .Type = 37 Or .Type = 179 Or .Type = 180 Then  'thwomp
                If B = 3 Or B = 4 Or B = 2 Then
                    PlaySound 9 'Shell hit sound
                    .Location.SpeedY = -10
                    If .Type = 37 Then
                        NewEffect 90, .Location
                    ElseIf .Type = 179 Then
                        .Location.Width = 64
                        .Location.Height = 64
                        .Location.X = .Location.X - 8
                        .Location.Y = .Location.Y - 8
                        NewEffect 99, .Location
                    ElseIf .Type = 180 Then
                        NewEffect 98, .Location
                    End If
                ElseIf B = 6 Then
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height - 32
                    .Location.Height = 32
                    .Location.Width = 32
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf .Type = 179 Then
                    PlaySound 9 'Shell hit sound
                    .Location.SpeedY = -10
                    .Location.Width = 64
                    .Location.Height = 64
                    .Location.X = .Location.X - 8
                    .Location.Y = .Location.Y - 8
                    NewEffect 99, .Location
                End If
            ElseIf .Type = 136 Or .Type = 137 Then
                If B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9
                    .Location.SpeedY = -11
                    NewEffect 72, .Location, .Direction
                End If
            ElseIf .Type = 89 Then  'SMB1 Goomba
                If B = 1 Then
                    NewEffect 52, .Location
                ElseIf B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    NewEffect 53, .Location
                End If
            'Zelda NPCs
            ElseIf .Type = 125 Or NPCIsABot(.Type) Or .Type = 255 Then
                PlaySound 53
                NewEffect 63, .Location
            ElseIf .Type = 133 Then
                .Location.SpeedX = -.Location.SpeedX * 0.3
                NewEffect 68, .Location
            ElseIf .Type = 59 Or .Type = 61 Or .Type = 63 Or .Type = 65 Then    'switch goombas
                If B = 1 Then
                    NewEffect .Type - 22, .Location
                ElseIf B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    NewEffect .Type - 21, .Location
                End If
                
            ElseIf .Type = 267 Or .Type = 268 Or .Type = 280 Or .Type = 281 Then   'larry koopa
                If B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf .Type = 280 Or .Type = 281 Then
                    NewEffect 143, .Location
                Else
                    NewEffect 140, .Location
                End If
                
            ElseIf .Type = 201 Or .Type = 262 Then 'wart, smb2 bosses
                If .Type = 262 And .Killed <> 3 And .Killed <> 6 And .Killed <> 10 Then PlaySound 41
                'If B <> 6 Then MoreScore NPCScore(.Type), .Location
                If B = 6 Then
                    PlaySound 16
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    .Location.Y = .Location.Y + 24
                    .Location.Width = 32
                    .Location.Height = 32
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                Else
                    .Location.SpeedY = -7
                    If .Type = 262 Then
                        NewEffect 138, .Location, .Direction
                        Effect(numEffects).Location.SpeedX = 0
                        Effect(numEffects).Location.SpeedY = -8
                    Else
                        NewEffect 106, .Location, .Direction
                    End If
                End If
            ElseIf .Type = 200 Then 'king koopa
                If B = 6 Then
                    PlaySound 16
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    .Location.Y = .Location.Y + 24
                    .Location.Width = 32
                    .Location.Height = 32
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                Else
                    '.Location.Width = .Location.Width + 2
                    '.Location.X = .Location.X - 1
                    NewEffect 105, .Location, .Direction
                End If
                PlaySound 44
            ElseIf .Type = 86 Then 'bowser
                If B = 6 Then
                    PlaySound 16
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    .Location.Y = .Location.Y + 24
                    .Location.Width = 32
                    .Location.Height = 32
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                Else
                    .Location.Width = .Location.Width + 2
                    .Location.X = .Location.X - 1
                    NewEffect 50, .Location, .Direction
                End If
                PlaySound 44
                If .Legacy = True Then
                    tempBool = False
                    For B = 1 To numNPCs
                        If B <> A And NPC(B).Type = 86 Then tempBool = True
                    Next B
                    If tempBool = False Then
                        LevelMacroCounter = 0
                        LevelMacro = 5
                    End If
                End If
            ElseIf .Type = 2 Or .Type = 3 Then   'Red goomba
                If B = 1 Then
                    NewEffect 6, .Location
                ElseIf B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    NewEffect 7, .Location
                End If
            ElseIf NPCIsToad(.Type) = True Then   'toad
                If B <> 2 Then
                    If B = 6 Then
                        .Location.Y = .Location.Y + (.Location.Height - 32)
                        PlaySound 16
                        NewEffect 10, .Location
                        If .NoLavaSplash = False Then NewEffect 13, .Location
                    Else
                        PlaySound 9 'Shell hit sound
                        NewEffect 48, .Location, .Direction
                    End If
                End If
            ElseIf .Type = 96 Then 'yoshi egg
                C = NPC(A).Special
                CharStuff A, True
                If .Special = 287 Then .Special = RandomBonus
                NewEffect 56, .Location, 1, Int(.Special)
                With Effect(numEffects)
                    If C = 98 Then
                        .Frame = .Frame + 3
                    ElseIf C = 99 Then
                        .Frame = .Frame + 5
                    ElseIf C = 100 Then
                        .Frame = .Frame + 7
                    ElseIf C = 148 Then
                        .Frame = .Frame + 9
                    ElseIf C = 149 Then
                        .Frame = .Frame + 11
                    ElseIf C = 150 Then
                        .Frame = .Frame + 13
                    ElseIf C = 228 Then
                        .Frame = .Frame + 15
                    End If
                End With
            ElseIf .Type = 71 Then   'giagnormous goomba
                If B = 1 Then
                    NewEffect 45, .Location
                ElseIf B = 6 Then
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height - 32
                    .Location.Height = 32
                    .Location.Width = 32
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    NewEffect 46, .Location
                End If
            ElseIf .Type = 27 Then  'Grey goomba
                If B = 1 Then
                    NewEffect 23, .Location
                ElseIf B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    If Not (B = 5) Then .Location.SpeedX = -.Location.SpeedX
                    NewEffect 22, .Location
                End If
            ElseIf .Type = 55 Then  'nekkid koopa
                If B = 1 Then
                    NewEffect 35, .Location
                ElseIf B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    If Not (B = 5) Then .Location.SpeedX = -.Location.SpeedX
                    NewEffect 36, .Location, .Direction
                End If
            ElseIf .Type = 189 Then  'Dry Bones
                .Location.Width = 48
                .Location.X = .Location.X - 8
                If B = 6 Then
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height - 32
                    .Location.Height = 32
                    .Location.Width = 32
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                Else
                    PlaySound 9
                    NewEffect 97, .Location, .Direction
                End If
            ElseIf .Type >= 117 And .Type <= 120 Then  'SMW Beach Koopas
                If B = 1 Then
                    NewEffect 62, .Location
                    Effect(numEffects).Frame = .Type - 117
                ElseIf B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9
                    If Not (B = 5) Then .Location.SpeedX = -.Location.SpeedX
                    NewEffect 61, .Location, .Direction
                    Effect(numEffects).Frame = (.Type - 117) * 4
                    If .Direction = 1 Then Effect(numEffects).Frame = Effect(numEffects).Frame + 2
                End If
            ElseIf .Type = 4 Or .Type = 5 Or .Type = 76 Then   'Green Koopa
                 .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(8) / 2
                 .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(8) / 2
                If B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    NewEffect 8, .Location
                End If
            ElseIf .Type = 207 Then   'spike top
                If B = 6 Then
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(8) / 2
                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(8) / 2
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    NewEffect 109, .Location, CDbl(.Frame)
                End If
            ElseIf .Type = 172 Or .Type = 173 Or .Type = 176 Then   'smb1 Green Koopa
                 .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(8) / 2
                 .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(8) / 2
                If B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    NewEffect 95, .Location
                End If
            ElseIf .Type = 174 Or .Type = 175 Or .Type = 177 Then   'smb1 red Koopa
                 .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(8) / 2
                 .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(8) / 2
                If B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    NewEffect 96, .Location
                End If
            ElseIf .Type = 241 Then
                If B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                Else
                    NewEffect 125, .Location
                End If
            ElseIf .Type = 72 Or .Type = 73 Then   'giant Green Koopa
                 .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(8) / 2
                 .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(8) / 2
                If B = 6 Then
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height - 32
                    .Location.Height = 32
                    .Location.Width = 32
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    NewEffect 47, .Location
                End If
            ElseIf .Type = 39 Then 'Birdo
                PlaySound 39
                If .Legacy = True And LevelEditor = False Then
                    For C = 1 To numNPCs
                        If NPC(C).Type = 39 And C <> A Then DontSpawnExit = True
                    Next C
                    If DontSpawnExit = False Then
                        numNPCs = numNPCs + 1
                        With NPC(numNPCs)
                            .Type = 41
                            .Location.Height = NPCHeight(.Type)
                            .Location.Width = NPCWidth(.Type)
                            .Location.X = NPC(A).Location.X
                            .Location.Y = NPC(A).Location.Y
                            .Location.SpeedY = -6
                            .Active = True
                            .TimeLeft = 100
                            .Frame = 0
                            CheckSectionNPC numNPCs
                            PlaySound 41
                        End With
                    Else
                        For C = 1 To numNPCs
                            If NPC(C).Type = 39 And NPC(C).Active = True And C <> A Then DontResetMusic = True
                        Next C
                        If DontResetMusic = False Then
                            bgMusic(.Section) = bgMusicREAL(.Section)
                            StopMusic
                            StartMusic .Section
                        End If
                    End If
                End If
                 .Location.Y = .Location.Y - .Location.Height / 2 + 32
                 .Location.X = .Location.X - .Location.Width / 2 + 20
                 NewEffect 29, .Location, .Direction
            ElseIf .Type = 40 Then  'Egg
                If .Special = 1 Then .Location.SpeedY = -5.1
                NewEffect 28, .Location
            ElseIf .Type = 6 Or .Type = 7 Or .Type = 161 Then   'Red Koopa
                 .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(9) / 2
                 .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(9) / 2
                If B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    NewEffect 9, .Location
                End If
                
            ElseIf (.Type >= 109 And .Type <= 116) Or (.Type >= 121 And .Type <= 124) Then  'SMW Koopas
                If B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9
                    NewEffect 60, .Location
                    If .Type <= 112 Then
                        Effect(numEffects).Frame = .Type - 109
                    ElseIf .Type <= 116 Then
                        Effect(numEffects).Frame = .Type - 113
                    Else
                        Effect(numEffects).Frame = .Type - 121
                    End If
                End If
            ElseIf .Type = 23 Or .Type = 24 Or .Type = 36 Or .Type = 53 Or .Type = 54 Or .Type = 285 Or .Type = 286 Then      'Hard thing / Spiney
                 .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(9) / 2
                 .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(9) / 2
                If B = 6 Then
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                    If .Type = 36 Then
                        NewEffect 27, .Location, .Direction
                    ElseIf .Type = 285 Or .Type = 286 Then
                        NewEffect 146, .Location, .Direction
                    ElseIf .Type = 53 Then
                        NewEffect 33, .Location
                    ElseIf .Type = 54 Then
                        NewEffect 34, .Location
                    Else
                        NewEffect 19, .Location
                    End If
                End If
            ElseIf .Type = 30 Then  ' Hammer
                If B = 3 Then
                    PlaySound 9
                    NewEffect 10, .Location
                End If
            ElseIf .Type = 256 Or .Type = 257 Then
                .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                tempLocation = .Location
                If .Type = 257 Then
                    For C = 0 To .Location.Height Step 32
                        If .Location.Height - C > 16 Then
                            tempLocation.Y = .Location.Y + .Location.Height - 32 - C
                            NewEffect 10, tempLocation
                        End If
                    Next C
                Else
                    For C = 0 To .Location.Height Step 32
                        If .Location.Height - C > 16 Then
                            tempLocation.Y = .Location.Y + C
                            NewEffect 10, tempLocation
                        End If
                    Next C
                End If
                PlaySound 9 'Shell hit sound
            ElseIf .Type = 8 Or .Type = 275 Or .Type = 93 Or .Type = 12 Or .Type = 51 Or .Type = 52 Or .Type = 74 Or .Type = 37 Or .Type = 38 Or .Type = 42 Or .Type = 43 Or .Type = 44 Or .Type = 245 Or .Type = 270 Then   'Piranha Plant / Fireball
                .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                NewEffect 10, .Location
                If B = 8 Then
                    PlaySound 36
                Else
                    PlaySound 9 'Shell hit sound
                End If
            ElseIf .Type = 13 Or .Type = 108 Or .Type = 265 Then  'Small Fireball / Yoshi Fireball
                If B = 6 Then
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(9) / 2
                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(9) / 2
                    .Location.Width = 32
                    PlaySound 16
                    NewEffect 10, .Location, , , .Shadow
                    .Location.X = .Location.X + 2
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                Else
                    For C = 1 To 10
                        If .Type = 265 Then
                            NewEffect 139, .Location, CSng(.Special), , .Shadow
                        Else
                            NewEffect 77, .Location, CSng(.Special), , .Shadow
                        End If
                        Effect(numEffects).Location.SpeedX = Rnd * 3 - 1.5 + .Location.SpeedX * 0.1
                        Effect(numEffects).Location.SpeedY = Rnd * 3 - 1.5 - .Location.SpeedY * 0.1
                    Next C
                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    If (.Type = 13 And .Special = 5) Or .Type = 108 Then
                        NewEffect 10, .Location, , , .Shadow
                    Else
                        NewEffect 131, .Location, , , .Shadow
                    End If
                End If
            ElseIf .Type = 15 Then  'Big Koopa
                .Location.Y = .Location.Y - (NPCHeight(.Type) - .Location.Height)
                .Location.Height = NPCHeight(.Type)
                If .Legacy = True Then
                    For B = 1 To numNPCs
                        If NPC(B).Type = 15 And NPC(B).Killed = 0 And B <> A Then DontSpawnExit = True
                    Next B
                    If LevelEditor = True Then DontSpawnExit = True
                    If DontSpawnExit = False Then
                        NewEffect 14, .Location, 1, 16
                    Else
                        NewEffect 14, .Location
                        For B = 1 To numNPCs
                            If NPC(B).Type = 15 And NPC(B).Active = True And B <> A And NPC(B).Killed = 0 Then DontResetMusic = True
                        Next B
                        If DontResetMusic = False Then
                        bgMusic(.Section) = bgMusicREAL(.Section)
                            StopMusic
                            StartMusic Player(1).Section
                        End If
                    End If
                Else
                    NewEffect 14, .Location
                End If
             ElseIf .Type = 17 Or .Type = 18 Then    'Bullet Bills
                 .Location.SpeedX = .Location.SpeedX / 2
                If B = 1 Then
                     .Location.SpeedX = 0.0001 * .Direction
                ElseIf B = 5 Then
                     .Location.SpeedX = 3 * .Direction
                Else
                     .Location.SpeedX = .Location.SpeedX / 2
                End If
                If Not B = 1 Then .Location.SpeedY = -9
                If B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    If B = 3 Or B = 2 Then PlaySound 9
                    If .Type = 17 Then
                        NewEffect 15, .Location, .Direction
                    Else
                        NewEffect 16, .Location, .Direction
                    End If
                End If
            ElseIf .Type = 247 Or .Type = 19 Or .Type = 20 Or .Type = 25 Or .Type = 28 Or .Type = 29 Or .Type = 47 Or .Type = 284 Or .Type = 48 Or .Type = 77 Or .Type = 271 Or (.Type >= 129 And .Type <= 132) Or .Type = 158 Or .Type = 261 Or .Type = 272 Then     'Misc Things
                If B = 6 Then
                    .Location.Y = .Location.Y + (.Location.Height - 32)
                    PlaySound 16
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                ElseIf B = 8 Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                Else
                    If .Type >= 129 And .Type <= 132 Then
                        NewEffect 64 + .Type - 129, .Location, .Direction
                    ElseIf .Type = 19 Then
                        NewEffect 17, .Location, .Direction
                    ElseIf .Type = 20 Then
                        NewEffect 18, .Location, .Direction
                    ElseIf .Type = 261 Then
                        NewEffect 137, .Location, .Direction
                    ElseIf .Type = 25 Then
                        NewEffect 20, .Location, .Direction
                    ElseIf .Type = 28 Then
                        .Location.SpeedY = -11
                        If .Killed = 1 Then .Location.SpeedY = 0
                        NewEffect 24, .Location, .Direction
                    ElseIf .Type = 158 Then
                        NewEffect 83, .Location, .Direction
                    ElseIf .Type = 247 Then
                        NewEffect 128, .Location
                    ElseIf .Type = 272 Then
                        NewEffect 142, .Location
                    ElseIf .Type = 77 Then
                        If B = 1 Then
                             .Location.SpeedY = 0
                             .Location.SpeedX = 0
                            PlaySound 2
                        Else
                             .Location.SpeedY = -11
                            PlaySound 9
                        End If
                        NewEffect 49, .Location, .Direction
                    ElseIf .Type = 271 Then
                        If B = 1 Then
                             .Location.SpeedY = 0
                             .Location.SpeedX = 0
                        Else
                             .Location.SpeedY = -11
                            PlaySound 9
                        End If
                        NewEffect 141, .Location, .Direction
                    ElseIf .Type = 29 Then
                        If B = 1 Then
                             .Location.SpeedY = 0
                             .Location.SpeedX = 0
                            PlaySound 2
                        Else
                             .Location.SpeedY = -11
                            PlaySound 9
                        End If
                        NewEffect 25, .Location, .Direction
                    ElseIf .Type = 48 Then
                        NewEffect 31, .Location
                    ElseIf .Type = 47 Or .Type = 284 Then
                        If .Location.SpeedX > 4 Then .Location.SpeedX = 4
                        If .Location.SpeedX < -4 Then .Location.SpeedX = -4
                        If B = 1 Then
                             .Location.SpeedY = 0
                             .Location.SpeedX = 0
                            PlaySound 2
                        Else
                             .Location.SpeedY = -11
                            PlaySound 9
                        End If
                        If .Type = 284 Then
                            NewEffect 145, .Location
                        Else
                            .Location.Y = .Location.Y - 14
                            NewEffect 32, .Location
                        End If
                    End If
                    If Not .Type = 29 And Not .Type = 47 And Not .Type = 77 Then
                        PlaySound 9
                    End If
                End If
            ElseIf .Type = 45 Then 'ice block
                If B = 6 Then
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                    PlaySound 16
                Else
                    NewEffect 30, NPC(A).Location
                    PlaySound 4
                End If
            ElseIf NPCIsABonus(.Type) Then  'NPC is a bonus
                If B = 3 Or B = 4 Or B = 5 Then
                    If NPCIsACoin(.Type) = False Or LevelEditor = True Or TestLevel = True Then PlaySound 9   'Shell hit sound
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                ElseIf B = 6 Then
                    PlaySound 16
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    If .NoLavaSplash = False Then NewEffect 13, .Location
                End If
            ElseIf LevelEditor = True Or MagicHand = True Then
                If Not (.Type = 32 And B = 1) Then
                     .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                     .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                    NewEffect 10, .Location
                    PlaySound 36
                End If
            End If
        End If
        If BattleMode = True Then
            .RespawnDelay = 65 * 30
        End If
        
        If .AttLayer <> "" Then
            For C = 1 To 100
                If .AttLayer = Layer(C).Name Then
                    Layer(C).SpeedX = 0
                    Layer(C).SpeedY = 0
                End If
            Next C
        End If
        
        If (GameMenu = False And BattleMode = False) Or .DefaultType = 0 Then
            For B = 1 To numPlayers 'Tell the player to stop standing on me because im dead kthnx
                If Player(B).StandingOnNPC = A Then
                    Player(B).StandingOnNPC = 0
                    If .Type <> 56 Then Player(B).Location.SpeedY = .Location.SpeedY
                ElseIf Player(B).StandingOnNPC = numNPCs Then
                    Player(B).StandingOnNPC = A
                End If
                If Player(B).YoshiNPC = numNPCs Then Player(B).YoshiNPC = A
                If Player(B).VineNPC = numNPCs Then Player(B).VineNPC = A
            Next B
            NPC(A) = NPC(numNPCs)
            NPC(numNPCs) = blankNPC
            numNPCs = numNPCs - 1
            If .HoldingPlayer > 0 Then
                Player(.HoldingPlayer).HoldingNPC = A
                If nPlay.Online = True And nPlay.Mode = 1 Then
                    Netplay.sendData "K" & C & "|" & NPC(A).Type & "|" & NPC(A).Location.X & "|" & NPC(A).Location.Y & "|" & NPC(A).Location.Width & "|" & NPC(A).Location.Height & "|" & NPC(A).Location.SpeedX & "|" & NPC(A).Location.SpeedY & "|" & NPC(A).Section & "|" & NPC(A).TimeLeft & "|" & NPC(A).Direction & "|" & Int(NPC(A).Projectile) & "|" & NPC(A).Special & "|" & NPC(A).Special2 & "|" & NPC(A).Special3 & "|" & NPC(A).Special4 & "|" & NPC(A).Special5 & "|" & NPC(A).Effect & LB & "1n" & .HoldingPlayer & "|" & A & "|" & NPC(A).Type & LB
                End If
            End If
            
            If .Effect = 5 Or .Effect = 6 Then
                Player(.Effect2).YoshiNPC = A
            End If
            If .Type = 49 And .Special = 1 Then
                For C = 1 To numNPCs
                    If NPC(C).Type = 50 And NPC(C).Special2 = numNPCs + 1 Then
                        NPC(C).Special2 = A
                    End If
                Next C
            ElseIf .Type = 49 And .Special2 > 0 Then
                NPC(.Special2).Special2 = A
            ElseIf .Type = 50 And .Special2 > 0 Then
                NPC(.Special2).Special2 = A
            End If
        Else
            Deactivate A
        End If
    End With
End Sub

Public Sub CheckSectionNPC(A As Integer) 'find out what section the NPC is in
    Dim B As Integer
    If GameMenu = True Then Exit Sub
    With NPC(A)
        If .HoldingPlayer > 0 Then
            If .TimeLeft < 10 Then .TimeLeft = 10
            .Section = Player(.HoldingPlayer).Section
        End If
        If .Location.X >= level(B).X Then
            If .Location.X + .Location.Width <= level(B).Width Then
                If .Location.Y >= level(B).Y Then
                    If .Location.Y + .Location.Height <= level(B).Height Then
                        .Section = B
                        Exit Sub
                    End If
                End If
            End If
        End If
        For B = 0 To maxSections
            If .Location.X >= level(B).X Then
                If .Location.X + .Location.Width <= level(B).Width Then
                    If .Location.Y >= level(B).Y Then
                        If .Location.Y + .Location.Height <= level(B).Height Then
                            .Section = B
                            Exit Sub
                        End If
                    End If
                End If
            End If
        Next B
    End With
End Sub

Public Sub Deactivate(A As Integer) 'deactive and reset the NPC when it goes offscreen
    With NPC(A)
        If .DefaultType > 0 Then
            If .TurnBackWipe = True And NoTurnBack(.Section) = True Then
                .Killed = 9
            Else
                If .Type = 189 And .Special > 0 Then
                    .Inert = False
                    .Stuck = False
                End If
            'reset variables back to default
                .Quicksand = 0
                .NoLavaSplash = False
                .Active = False
                .Location = .DefaultLocation
                .Direction = .DefaultDirection
                .Stuck = .DefaultStuck
                .TimeLeft = 0
                .Projectile = False
                .Effect = 0
                .Effect2 = 0
                .Effect3 = 0
                .Type = .DefaultType
                .BeltSpeed = 0
                .standingOnPlayer = 0
                .standingOnPlayerY = 0
                .Frame = 0
                .Killed = 0
                .Shadow = False
                .oldAddBelt = 0
                .Reset(1) = False
                .Reset(2) = False
                .Special = .DefaultSpecial
                .Special2 = .DefaultSpecial2
                .Special3 = 0
                .Special4 = 0
                .Special5 = 0
                .Special6 = 0
                .Damage = 0
                .HoldingPlayer = 0
                .Pinched1 = 0
                .Pinched2 = 0
                .Pinched3 = 0
                .Pinched4 = 0
                .Pinched = 0
                .MovingPinched = 0
            End If
        ElseIf NPCIsAnExit(.Type) Then
            .TimeLeft = 100
        Else
            .Killed = 9
        End If
    End With
End Sub

Public Sub Bomb(Location As Location, Game As Integer, Optional ImmunePlayer As Integer = 0) 'for bomb explosions
    Dim Radius As Single
    Dim i As Integer
    Dim X As Double
    Dim Y As Double
    Dim A As Double
    Dim B As Double
    Dim C As Double
    NPC(0).Multiplier = 0
    If Game = 0 Then
        NewEffect 148, Location
        PlaySound 22
        Radius = 32
    End If
    If Game = 2 Then
        NewEffect 69, Location
        PlaySound 43
        Radius = 52
    End If
    If Game = 3 Then
        NewEffect 70, Location
        PlaySound 43
        Radius = 64
    End If
    X = Location.X + Location.Width / 2
    Y = Location.Y + Location.Height / 2
    For i = 1 To numNPCs
        With NPC(i)
            If .Hidden = False And .Active = True And .Inert = False And .Generator = False And NPCIsABonus(.Type) = False Then
                If .Type <> 13 And .Type <> 291 Then
                    A = Abs(.Location.X + .Location.Width / 2 - X)
                    B = Abs(.Location.Y + .Location.Height / 2 - Y)
                    C = Sqr(A ^ 2 + B ^ 2)
                    If C <= Radius + (.Location.Width / 4 + .Location.Height / 4) Then
                        NPC(0).Location = NPC(i).Location
                        NPCHit i, 3, 0
                        If NPCIsVeggie(NPC(i).Type) Then
                            NPC(i).Projectile = True
                            .Location.SpeedY = -5
                            .Location.SpeedX = Rnd * 4 - 2
                        End If
                    End If
                End If
            End If
        End With
    Next i
    For i = 1 To numBlock
        With Block(i)
            If .Hidden = False And BlockNoClipping(.Type) = False Then
                A = Abs(Block(i).Location.X + Block(i).Location.Width / 2 - X)
                B = Abs(Block(i).Location.Y + Block(i).Location.Height / 2 - Y)
                C = Sqr(A ^ 2 + B ^ 2)
                If C <= Radius + (Block(i).Location.Width / 4 + Block(i).Location.Height / 4) Then
                    BlockHit i
                    BlockHitHard i
                    If Game = 0 And .Type = 457 Then KillBlock i
                End If
            End If
        End With
    Next i
    If Game <> 0 Then
        For i = 1 To numPlayers
            With Player(i)
                A = Abs(.Location.X + .Location.Width / 2 - X)
                B = Abs(.Location.Y + .Location.Height / 2 - Y)
                C = Sqr(A ^ 2 + B ^ 2)
                If C <= Radius + (.Location.Width / 4 + .Location.Height / 4) Then PlayerHurt i
            End With
        Next i
    ElseIf BattleMode = True Then
        For i = 1 To numPlayers
            If i <> ImmunePlayer Then
                With Player(i)
                    A = Abs(.Location.X + .Location.Width / 2 - X)
                    B = Abs(.Location.Y + .Location.Height / 2 - Y)
                    C = Sqr(A ^ 2 + B ^ 2)
                    If C <= Radius + (.Location.Width / 4 + .Location.Height / 4) Then PlayerHurt i
                End With
            End If
        Next i
    End If
End Sub

Public Sub DropNPC(A As Integer, NPCType As Integer)  'Drops an NPC from the screen
    Dim B As Integer
    If A = 1 Or numPlayers = 2 Then
        With Player(A)
            PlaySound 11
            numNPCs = numNPCs + 1
            NPC(numNPCs).Type = NPCType
            NPC(numNPCs).Location.Width = NPCWidth(NPCType)
            NPC(numNPCs).Location.Height = NPCHeight(NPCType)
            If ScreenType = 5 And vScreen(2).Visible = False Then
                If A = 1 Then B = -40
                If A = 2 Then B = 40
                NPC(numNPCs).Location.X = -vScreenX(1) + vScreen(1).Width / 2 - NPC(numNPCs).Location.Width / 2 + B
                NPC(numNPCs).Location.Y = -vScreenY(1) + 16 + 12
            Else
                NPC(numNPCs).Location.X = -vScreenX(A) + vScreen(A).Width / 2 - NPC(numNPCs).Location.Width / 2
                NPC(numNPCs).Location.Y = -vScreenY(A) + 16 + 12
            End If
            NPC(numNPCs).Location.SpeedX = 0
            NPC(numNPCs).Location.SpeedY = 0
            NPC(numNPCs).Effect = 2
            NPC(numNPCs).Active = True
            NPC(numNPCs).TimeLeft = 200
        End With
    End If
End Sub

Public Sub TurnNPCsIntoCoins() 'turns some NPCs into coins when the player reaches the level exit
    Dim A As Integer
    For A = 1 To numNPCs
        With NPC(A)
            If .Active = True And .Generator = False Then
                If .Hidden = False And .Killed = 0 And NPCIsAnExit(.Type) = False And .Inert = False Then
                    If NPCIsYoshi(.Type) = False And NPCIsBoot(.Type) = False And NPCIsABonus(.Type) = False And .Type <> 265 And .Type <> 13 And .Type <> 108 And .Type <> 26 And NPCIsVeggie(.Type) = False And .Type <> 91 And .Type <> 171 And NPCIsAVine(.Type) = False And .Type <> 56 And .Type <> 60 And .Type <> 62 And .Type <> 64 And .Type <> 66 And .Type <> 104 And Not (.Projectile = True And .Type = 30) And Not (.Projectile = True And .Type = 17) And .Type <> 291 And .Type <> 292 And .Type <> 266 And .Type <> 57 And .Type <> 58 And Not (.Type >= 78 And .Type <= 83) And .Type <> 91 And .Type <> 260 And .Type <> 259 Then
                        .Location.Y = .Location.Y + 32
                        NewEffect 11, .Location
                        PlaySound 14
                        Coins = Coins + 1
                        If Coins >= 100 Then
                            If Lives < 99 Then
                                Lives = Lives + 1
                                PlaySound 15
                                Coins = Coins - 100
                            Else
                                Coins = 99
                            End If
                        End If
                        .Killed = 9
                        .Location.Height = 0
                        .Active = False
                    ElseIf .Type = 197 Or .Type = 260 Or .Type = 259 Then
                        .Active = False
                    End If
                End If
            ElseIf .Generator = True Then
                .Killed = 9
                .Hidden = True
            End If
        End With
    Next A
End Sub

Public Sub NPCFrames(A As Integer) 'updates the NPCs graphics
    Dim B As Double
    Dim C As Double
    Dim D As Double
    Dim tempLocation As Location
    With NPC(A)
        If NPCFrame(.Type) > 0 Then 'custom frames
            .FrameCount = .FrameCount + 1
            If NPCFrameStyle(.Type) = 2 And (.Projectile = True Or .HoldingPlayer > 0) Then .FrameCount = .FrameCount + 1
            If .FrameCount >= NPCFrameSpeed(.Type) Then
                If NPCFrameStyle(.Type) = 0 Then
                    .Frame = .Frame + 1 * .Direction
                Else
                    .Frame = .Frame + 1
                End If
                .FrameCount = 0
            End If
            If NPCFrameStyle(.Type) = 0 Then
                If .Frame >= NPCFrame(.Type) Then .Frame = 0
                If .Frame < 0 Then .Frame = NPCFrame(.Type) - 1
            ElseIf NPCFrameStyle(.Type) = 1 Then
                If .Direction = -1 Then
                    If .Frame >= NPCFrame(.Type) Then .Frame = 0
                    If .Frame < 0 Then .Frame = NPCFrame(.Type)
                Else
                    If .Frame >= NPCFrame(.Type) * 2 Then .Frame = NPCFrame(.Type)
                    If .Frame < NPCFrame(.Type) Then .Frame = NPCFrame(.Type)
                End If
            ElseIf NPCFrameStyle(.Type) = 2 Then
                If .HoldingPlayer = 0 And .Projectile = False Then
                    If .Direction = -1 Then
                        If .Frame >= NPCFrame(.Type) Then .Frame = 0
                        If .Frame < 0 Then .Frame = NPCFrame(.Type) - 1
                    Else
                        If .Frame >= NPCFrame(.Type) * 2 Then .Frame = NPCFrame(.Type)
                        If .Frame < NPCFrame(.Type) Then .Frame = NPCFrame(.Type) * 2 - 1
                    End If
                Else
                    If .Direction = -1 Then
                        If .Frame >= NPCFrame(.Type) * 3 Then .Frame = NPCFrame(.Type) * 2
                        If .Frame < NPCFrame(.Type) * 2 Then .Frame = NPCFrame(.Type) * 3 - 1
                    Else
                        If .Frame >= NPCFrame(.Type) * 4 Then .Frame = NPCFrame(.Type) * 3
                        If .Frame < NPCFrame(.Type) * 3 Then .Frame = NPCFrame(.Type) * 4 - 1
                    End If
                End If
            End If
        ElseIf .Type = 231 Or .Type = 235 Or .Type = 86 Or .Type = 40 Or .Type = 46 Or .Type = 212 Or .Type = 47 Or .Type = 284 Or .Type = 58 Or .Type = 67 Or .Type = 68 Or .Type = 69 Or .Type = 70 Or .Type = 73 Or NPCIsVeggie(.Type) Or .Type = 79 Or .Type = 80 Or .Type = 82 Or .Type = 83 Or .Type = 104 Or .Type = 105 Or .Type = 106 Or .Type = 133 Or .Type = 151 Or (.Type >= 154 And .Type <= 157) Or .Type = 159 Or .Type = 192 Or .Type = 197 Or NPCIsAVine(.Type) Or .Type = 237 Or .Type = 239 Or .Type = 240 Or .Type = 250 Or .Type = 289 Or .Type = 290 Then       ' no frames
            If Not (.Type = 86 Or .Type = 284 Or .Type = 47) And A = 0 Then 'Reset Frame to 0 unless a specific NPC type
                .Frame = 0
            End If
            
            
        ElseIf .Type = 169 Or .Type = 170 Then
            C = 0
            For B = 1 To numPlayers
                If Player(B).Dead = False And Player(B).Section = .Section And Player(B).TimeToLive = 0 Then
                    If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) + Abs(.Location.Y + .Location.Height / 2 - (Player(B).Location.Y + Player(B).Location.Height / 2)) < C Then
                        C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) + Abs(.Location.Y + .Location.Height / 2 - (Player(B).Location.Y + Player(B).Location.Height / 2))
                        If Player(B).Character = 5 Then
                            D = 1
                        Else
                            D = 0
                        End If
                    End If
                End If
            Next B
            If D <> .Frame Then
                If .FrameCount > 0 Then NewEffect 131, .Location
                .Frame = D
            End If
            .FrameCount = 1
        ElseIf .Type = 278 Or .Type = 279 Then 'fly block
            .FrameCount = .FrameCount + 1
            If .HoldingPlayer > 0 Then .FrameCount = .FrameCount + 1
            If .Location.SpeedY <> 0 Then .FrameCount = .FrameCount + 1
            If .FrameCount <= 6 Then
                .Frame = 0
            ElseIf .FrameCount <= 12 Then
                .Frame = 1
            ElseIf .FrameCount <= 18 Then
                .Frame = 2
            ElseIf .FrameCount <= 24 Then
                .Frame = 3
            ElseIf .FrameCount <= 30 Then
                .Frame = 2
            ElseIf .FrameCount <= 36 Then
                .Frame = 1
            Else
                .Frame = 0
                .FrameCount = 0
            End If
            If .Type = 279 And .Direction = 1 Then
                .Frame = .Frame + 4
            End If
        ElseIf .Type = 275 Then 'fire plant thing
            If .Special = 0 Then
                .FrameCount = .FrameCount + 1
                If .FrameCount < 8 Then
                    .Frame = 0
                ElseIf .FrameCount < 16 Then
                    .Frame = 2
                Else
                    .Frame = 0
                    .FrameCount = 0
                End If
            ElseIf .Special = 1 Then
                .FrameCount = .FrameCount + 1
                If .FrameCount < 4 Then
                    .Frame = 0
                ElseIf .FrameCount < 8 Then
                    .Frame = 1
                Else
                    .Frame = 0
                    .FrameCount = 0
                End If
            Else
                .Frame = 3
            End If
        ElseIf .Type = 288 Then 'potion
            .FrameCount = .FrameCount + 1
            If .FrameCount >= 8 Then
                .Frame = .Frame + 1
                .FrameCount = 0
            End If
            If .Frame >= 4 Then .Frame = 0
        ElseIf .Type = 283 Then 'bubble
            .FrameCount = .FrameCount + 1
            If .FrameCount < 6 Then
                .Frame = 0
            ElseIf .FrameCount < 12 Then
                .Frame = 1
            ElseIf .FrameCount < 18 Then
                .Frame = 0
            ElseIf .FrameCount < 24 Then
                .Frame = 2
            Else
                .FrameCount = 0
                .Frame = 0
            End If
        ElseIf .Type = 272 Then 'spider
            If .Projectile = True Or .Location.SpeedY >= 0 Or .HoldingPlayer > 0 Then
                .Frame = 0
            Else
                .Frame = 2
            End If
            .FrameCount = .FrameCount + 1
            If .FrameCount > 15 Then
                .FrameCount = 0
            ElseIf .FrameCount >= 8 Then
                .Frame = .Frame + 1
            End If
        ElseIf .Type = 271 Then 'bat thing
            If .Special = 0 Then
                .Frame = 0
            Else
                .Frame = 1
                .FrameCount = .FrameCount + 1
                If .FrameCount > 15 Then
                    .FrameCount = 0
                ElseIf .FrameCount >= 8 Then
                    .Frame = 2
                End If
            End If
            If .Direction = 1 Then
                .Frame = .Frame + 3
                
            End If
            
        ElseIf .Type = 270 Then 'jumping plant
            .FrameCount = .FrameCount + 1
            If .FrameCount >= 4 Then
                .Frame = .Frame + 1
                .FrameCount = 0
            End If
            If .Frame >= 4 Then .Frame = 0
        
        ElseIf .Type = 280 Then 'ludwig koopa
            If .Location.SpeedY <> 0 Then
                .FrameCount = .FrameCount + 1
                If .FrameCount < 4 Then
                    .Frame = 10
                ElseIf .FrameCount < 8 Then
                    .Frame = 11
                Else
                    .Frame = 10
                    .FrameCount = 0
                End If
            Else
                If .Special = 0 Then
                    .FrameCount = .FrameCount + 1
                    If .Location.SpeedX = 0 Then .FrameCount = 10
                    If .FrameCount < 4 Then
                        .Frame = 0
                    ElseIf .FrameCount < 8 Then
                        .Frame = 1
                    ElseIf .FrameCount < 12 Then
                        .Frame = 2
                    Else
                        .Frame = 0
                        .FrameCount = 0
                    End If
                ElseIf .Special = 1 Then
                    .Frame = 3
                ElseIf .Special = 2 Then
                    .Frame = 4
                End If
                If .Direction = 1 Then .Frame = .Frame + 5
            End If
            
            
            
        ElseIf .Type = 281 Then 'ludwig shell
            If .Location.SpeedX = 0 Then
                If .Frame > 2 Then .Frame = 0
            Else
                .FrameCount = .FrameCount + 1
                If .FrameCount >= 4 Then
                    .Frame = .Frame + .Direction
                    .FrameCount = 0
                End If
                If .Frame < 0 Then .Frame = 2
                If .Frame > 2 Then .Frame = 0
            End If
            
        ElseIf .Type = 282 Then 'ludwig fire
            .FrameCount = .FrameCount + 1
            .Frame = 0
            If .FrameCount > 8 Then
                .FrameCount = 0
            ElseIf .FrameCount >= 4 Then
                .Frame = 1
            End If
            If .Direction = 1 Then .Frame = .Frame + 2
            
        ElseIf .Type = 269 Then 'larry magic
            If .Special = 0 Then
                .Frame = 2
            ElseIf .Special = 1 Then
                .Frame = 1
            Else
                .Frame = 0
            End If
        ElseIf .Type = 268 Then ' larry shell
            .FrameCount = .FrameCount + 1
            If .FrameCount >= 4 Then
                .Frame = .Frame + .Direction
                .FrameCount = 0
            End If
            If .Frame < 0 Then .Frame = 5
            If .Frame > 5 Then .Frame = 0
        ElseIf .Type = 267 Then 'larry koopa
        
            .Frame = 0
            If .Special = 0 Then
                If .Location.SpeedY = 0 Then
                    If .Location.SpeedX = 0 Then
                        .Frame = 0
                    Else
                        .FrameCount = .FrameCount + 1
                        If .FrameCount < 8 Then
                            .Frame = 0
                        ElseIf .FrameCount < 16 Then
                            .Frame = 1
                        Else
                            .Frame = 0
                            .FrameCount = 0
                        End If
                    End If
                Else
                    .Frame = 1
                End If
            ElseIf .Special = 1 Then
                .FrameCount = .FrameCount + 1
                If .FrameCount < 2 Then
                    .Frame = 2
                ElseIf .FrameCount < 4 Then
                    .Frame = 3
                ElseIf .FrameCount < 6 Then
                    .Frame = 4
                ElseIf .FrameCount < 8 Then
                    .Frame = 5
                Else
                    .Frame = 2
                    .FrameCount = 0
                End If
            ElseIf .Special = 2 Then
                .FrameCount = .FrameCount + 1
                If .FrameCount < 2 Then
                    .Frame = 6
                ElseIf .FrameCount < 4 Then
                    .Frame = 7
                ElseIf .FrameCount < 6 Then
                    .Frame = 8
                ElseIf .FrameCount < 8 Then
                    .Frame = 9
                Else
                    .Frame = 6
                    .FrameCount = 0
                End If
            End If
            If .Direction = 1 Then .Frame = .Frame + 10
            
            
        ElseIf .Type = 266 Then 'sword beam
            .Frame = 0
            If .Direction = 1 Then .Frame = 4
            .FrameCount = .FrameCount + 1
            If .FrameCount < 2 Then
            ElseIf .FrameCount < 4 Then
                .Frame = .Frame + 1
            ElseIf .FrameCount < 6 Then
                .Frame = .Frame + 2
            ElseIf .FrameCount < 8 Then
                .Frame = .Frame + 3
            Else
                .FrameCount = 0
            End If
            
        
        ElseIf .Type = 262 Then 'mouser
            If .Immune > 0 Then
                .FrameCount = .FrameCount + 1
                If .FrameCount < 4 Then
                    .Frame = 3
                ElseIf .FrameCount < 8 Then
                    .Frame = 4
                ElseIf .FrameCount < 12 Then
                    .Frame = 5
                ElseIf .FrameCount < 15 Then
                    .Frame = 6
                Else
                    .Frame = 6
                    .FrameCount = 0
                End If
                If .Direction = 1 Then .Frame = .Frame + 7
            ElseIf .Special <= 0 Then
                .FrameCount = .FrameCount + 1
                If .FrameCount < 8 Then
                    .Frame = 1
                ElseIf .FrameCount < 15 Then
                    .Frame = 2
                Else
                    .Frame = 2
                    .FrameCount = 0
                End If
                If .Direction = 1 Then .Frame = .Frame + 7
            Else
                .Frame = 0
                If .Direction = 1 Then .Frame = .Frame + 7
            End If
            
        ElseIf .Type = 261 Then
            .FrameCount = .FrameCount + 1
            If .FrameCount < 8 Then
                .Frame = 0
            ElseIf .FrameCount < 15 Then
                .Frame = 1
            Else
                .FrameCount = 0
                .Frame = 1
            End If
            If .Direction = 1 Then .Frame = .Frame + 4
            If .Special > 0 And .Location.SpeedY <= 0 Then .Frame = .Frame + 2
            
        ElseIf .Type = 260 Then
            If .Direction = 1 Then
                .Frame = SpecialFrame(2)
            Else
                .Frame = 3 - SpecialFrame(2)
            End If
         ElseIf .Type = 255 Then
             'NPC has no frames so do nothing
         ElseIf .Type = 259 Then
            .Frame = .Frame + 1
            If .Frame >= 5 Then .Frame = 0
         ElseIf .Type = 251 Or .Type = 252 Or .Type = 253 Then
            .Frame = SpecialFrame(8)
         ElseIf .Type = 238 Then
            .FrameCount = .FrameCount + 1
            If .FrameCount >= 4 Then
                .FrameCount = 0
                .Frame = .Frame + 1
            End If
            If .Frame >= 3 Then .Frame = 0
         ElseIf .Type = 247 Then
             If .Special < 0 And .Location.SpeedY = 0 Then .Special = .Special + 1
             If .Projectile = True Or .HoldingPlayer > 0 Then
                 .Frame = 4
             Else
                 If .Special < 0 Then
                     .Frame = 1
                 Else
                     .Frame = 0
                 End If
             End If
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 16 Then
                 .FrameCount = 0
             ElseIf .FrameCount > 8 Then
                 If .Projectile = True Or .HoldingPlayer > 0 Then
                     .Frame = .Frame + 1
                 Else
                     .Frame = .Frame + 2
                 End If
             End If
         ElseIf .Type = 245 Then
             .Frame = 0
             If Player(.Special4).Location.X + Player(.Special4).Location.Width / 2 > .Location.X + .Location.Width / 2 Then
                 .Frame = 2
             End If
             If Player(.Special4).Location.Y + Player(.Special4).Location.Height / 2 < .Location.Y + 16 Then
                 .Frame = .Frame + 1
             End If
         ElseIf .Type = 243 Then
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 4 Then
                 .FrameCount = 0
                 .Frame = .Frame + 1
                 If .Frame >= 2 Then .Frame = 0
             End If
         ElseIf .Type = 241 Then 'POW block
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 8 Then
                 .FrameCount = 0
                 .Frame = .Frame + 1
                 If .Frame >= 7 Then .Frame = 0
             End If
         ElseIf .Type = 81 Then '1 frame left or right
             If .Direction = 1 Then
                 .Frame = 1
             Else
                 .Frame = 0
             End If
         ElseIf .Type = 211 Then
             .FrameCount = .FrameCount + 1
             If .FrameCount <= 6 Then
                 .Frame = 0
             ElseIf .FrameCount <= 12 Then
                 .Frame = 1
             ElseIf .FrameCount <= 18 Then
                 .Frame = 2
             ElseIf .FrameCount <= 24 Then
                 .Frame = 3
             ElseIf .FrameCount <= 30 Then
                 .Frame = 4
             ElseIf .FrameCount <= 36 Then
                 .Frame = 5
             ElseIf .FrameCount <= 42 Then
                 .Frame = 4
             ElseIf .FrameCount <= 48 Then
                 .Frame = 3
             ElseIf .FrameCount <= 54 Then
                 .Frame = 2
             ElseIf .FrameCount <= 60 Then
                 .Frame = 1
             Else
                 .FrameCount = 0
             End If
         ElseIf .Type = 210 Then
             .FrameCount = .FrameCount + 1
             If .FrameCount <= 8 Then
                 .Frame = 0
             ElseIf .FrameCount <= 16 Then
                 .Frame = 1
             ElseIf .FrameCount <= 24 Then
                 .Frame = 2
             ElseIf .FrameCount <= 32 Then
                 .Frame = 3
             ElseIf .FrameCount <= 38 Then
                 .Frame = 2
             ElseIf .FrameCount <= 46 Then
                 .Frame = 1
             Else
                 .FrameCount = 0
             End If
         ElseIf .Type = 209 Then
             .Frame = 0
             If .Special > 0 And .Special < 15 Then .Frame = 1
             If .Direction = 1 Then .Frame = .Frame + 2
         ElseIf .Type = 208 Then
             If .Damage < 3 Then
                 .Frame = 0
             ElseIf .Damage < 6 Then
                 .Frame = 1
             ElseIf .Damage < 9 Then
                 .Frame = 2
             ElseIf .Damage < 12 Then
                 .Frame = 3
             Else
                 .Frame = 4
             End If
             If .Direction = 1 Then .Frame = .Frame + 5
         ElseIf .Type = 207 Then
             .FrameCount = .FrameCount + 1
             .Frame = 0
             If .FrameCount >= 16 Then
                 .FrameCount = 0
             ElseIf .FrameCount > 8 Then
                 .Frame = 1
             End If
             If .Special = 4 Then
                 .Frame = .Frame + 4
             ElseIf .Special = 3 Then
                 .Frame = .Frame + 8
             ElseIf .Special = 2 Then
                 .Frame = .Frame + 12
             End If
             If .Special2 = 1 Then .Frame = .Frame + 2
             
         
         ElseIf .Type = 205 Then
             .FrameCount = .FrameCount + 1
             .Frame = 0
             If .FrameCount <= 6 Then
                 .Frame = 0
             ElseIf .FrameCount <= 12 Then
                 .Frame = 1
             ElseIf .FrameCount <= 18 Then
                 .Frame = 2
             ElseIf .FrameCount <= 24 Then
                 .Frame = 3
             ElseIf .FrameCount <= 30 Then
                 .Frame = 4
             Else
                 .FrameCount = 0
             End If
             If .Special = 4 Then
                 .Frame = .Frame + 5
             ElseIf .Special = 3 Then
                 .Frame = .Frame + 10
             ElseIf .Special = 2 Then
                 .Frame = .Frame + 15
             End If
             
             
         ElseIf .Type = 203 Or .Type = 204 Then
             .FrameCount = .FrameCount + 1
             .Frame = 0
             If .FrameCount <= 6 Then
                 .Frame = 0
             ElseIf .FrameCount <= 12 Then
                 .Frame = 1
             ElseIf .FrameCount <= 18 Then
                 .Frame = 2
             ElseIf .FrameCount <= 24 Then
                 .Frame = 1
             Else
                 .FrameCount = 0
             End If
             If .Direction = 1 Then .Frame = .Frame + 4
         ElseIf .Type = 201 Then
             .Frame = 0
             If .Special = 0 Then
                 .FrameCount = .FrameCount + 1
                 If .FrameCount < 8 Then
                     .Frame = 0
                 ElseIf .FrameCount < 16 Then
                     .Frame = 1
                 Else
                     .FrameCount = 0
                 End If
             ElseIf .Special = 1 Then
                 .FrameCount = 0
                 .Frame = 2
                 
             ElseIf .Special = 2 Then
                 .FrameCount = .FrameCount + 1
                 If .FrameCount < 8 Then
                     .Frame = 3
                 ElseIf .FrameCount < 16 Then
                     .Frame = 4
                 Else
                     .Frame = 3
                     .FrameCount = 0
                 End If
             End If
             
             If .Special = 3 Or .Special = 2 Then
                 .Frame = 0
                 .FrameCount = .FrameCount + 1
                 If .FrameCount < 4 Then
                     .Frame = 5
                 ElseIf .FrameCount < 8 Then
                     .Frame = 6
                 ElseIf .FrameCount < 12 Then
                     .Frame = 7
                 Else
                     .Frame = 7
                     .FrameCount = 0
                 End If
             End If
             If .Direction = 1 Then .Frame = .Frame + 8
         ElseIf .Type = 200 Then 'King Koopa
             .Frame = 0
             If .Special = 0 Then
                 .FrameCount = .FrameCount + 1
                 If .FrameCount <= 8 Then
                     .Frame = 1
                 ElseIf .FrameCount <= 16 Then
                     .Frame = 0
                 ElseIf .FrameCount <= 24 Then
                     .Frame = 2
                 ElseIf .FrameCount <= 32 Then
                     .Frame = 0
                 Else
                     .FrameCount = 0
                 End If
             ElseIf .Special = 1 Then
                 .FrameCount = 0
                 .Frame = 3
             ElseIf .Special = 2 Then
                 .FrameCount = 0
                 .Frame = 4
             End If
             If .Direction = 1 Then .Frame = .Frame + 5
         ElseIf .Type = 196 Then
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 4 Then
                 .FrameCount = 0
                 .Frame = .Frame + 1
                 If .Frame >= 2 Then .Frame = 0
             End If
         ElseIf .Type = 180 Then
             .Frame = 0
             C = 0
             For B = 1 To numPlayers
                 If CanComeOut(.Location, Player(B).Location) = False And Player(B).Location.Y >= .Location.Y Then C = B
             Next B
             If C > 0 Then
                 .Frame = 2
             Else
                 For B = 1 To numPlayers
                     tempLocation = .Location
                     tempLocation.Width = .Location.Width * 2
                     tempLocation.X = .Location.X - .Location.Width / 2
                     If CanComeOut(tempLocation, Player(B).Location) = False And Player(B).Location.Y >= .Location.Y Then C = B
                 Next B
                 If C > 0 Then
                     .Frame = 1
                 End If
             End If
             If .Special = 1 Then .Frame = 2
         
        ElseIf .Type = 292 Then 'toad boomerang
            .FrameCount = .FrameCount + 1
            If .FrameCount >= 6 Then
                .FrameCount = 0
                
                 If .Location.SpeedX > 0 Then
                     .Frame = .Frame + 1
                     If .Frame = 1 Then
                         .Location.X = .Location.X + 4
                     ElseIf .Frame = 3 Then
                         .Location.X = .Location.X - 4
                     ElseIf .Frame = 2 Then
                         .Location.Y = .Location.Y + 4
                     Else
                         .Location.Y = .Location.Y - 4
                     End If
                 Else
                     .Frame = .Frame - 1
                     If .Frame = 0 Then
                         .Location.X = .Location.X - 4
                     ElseIf .Frame = 1 Then
                         .Location.Y = .Location.Y - 4
                     ElseIf .Frame = 2 Then
                         .Location.X = .Location.X + 4
                     Else
                         .Location.Y = .Location.Y + 4
                     End If
                 End If
                 
                 If .Frame > 3 Then
                    .Frame = 0
                ElseIf .Frame < 0 Then
                    .Frame = 3
                End If
            End If
            If Int(Rnd * 4) = 0 Then
                NewEffect 80, newLoc(.Location.X + .Location.Width / 2 - 4, .Location.Y + .Location.Height / 2 - 4), , , .Shadow
                Effect(numEffects).Location.SpeedX = Rnd * 1 - 0.5
                Effect(numEffects).Location.SpeedY = Rnd * 1 - 0.5
            End If

             
             
         ElseIf .Type = 171 Then 'Mario Hammer
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 4 Then
                 .FrameCount = 0
                 If .Location.SpeedX > 0 Then
                     .Frame = .Frame + 1
                     If .Frame = 1 Then
                         .Location.X = .Location.X + 8
                     ElseIf .Frame = 3 Then
                         .Location.X = .Location.X - 8
                     ElseIf .Frame = 2 Then
                         .Location.Y = .Location.Y + 12
                     Else
                         .Location.Y = .Location.Y - 12
                     End If
                 Else
                     .Frame = .Frame - 1
                     If .Frame = 0 Then
                         .Location.X = .Location.X - 8
                     ElseIf .Frame = 1 Then
                         .Location.Y = .Location.Y - 12
                     ElseIf .Frame = 2 Then
                         .Location.X = .Location.X + 8
                     Else
                         .Location.Y = .Location.Y + 12
                     End If
                 End If
                 If .Frame > 3 Then
                     .Frame = 0
                 ElseIf .Frame < 0 Then
                     .Frame = 3
                 End If
                 NewEffect 80, newLoc(.Location.X + .Location.Width / 2 - 8, .Location.Y + .Location.Height / 2 - 8), , , .Shadow
                 Effect(numEffects).Location.SpeedX = Rnd * 1 - 0.5
                 Effect(numEffects).Location.SpeedY = Rnd * 1 - 0.5
                 
             End If
             
             
         ElseIf .Type = 167 Then 'smw paragoomba
             .FrameCount = .FrameCount + 1
             If .Direction = 1 Then
                 .Frame = 4
             Else
                 .Frame = 0
             End If
             If .FrameCount >= 16 Then
                 .FrameCount = 0
             ElseIf .FrameCount >= 8 Then
                 .Frame = .Frame + 1
             End If
             
             If .Effect = 0 Then
                 If .Special = 0 Then
                     .Special2 = .Special2 + 2
                 ElseIf .Special <= 60 Then
                     .Special2 = 0
                 ElseIf .Special < 65 Then
                     .Special2 = .Special2 + 1
                 Else
                     .Special2 = .Special2 + 2
                 End If
                 If .Special2 >= 16 Then
                     .Special2 = 0
                 ElseIf .Special2 >= 8 Then
                     .Frame = .Frame + 2
                 End If
             End If
         ElseIf .Type = 3 Or .Type = 244 Then 'Flying Goomba
             If .Location.SpeedY = 0 Or .Slope > 0 Then
                 .FrameCount = .FrameCount + 1
                 If .FrameCount >= 8 Then
                     .FrameCount = 0
                     .Frame = .Frame + 1
                     If .Frame >= 2 Then .Frame = 0
                 End If
             Else
                 .FrameCount = .FrameCount + 1
                 If .FrameCount >= 4 Then
                     .FrameCount = 0
                     If .Frame = 0 Then
                         .Frame = 2
                     ElseIf .Frame = 1 Then
                         .Frame = 3
                     ElseIf .Frame = 2 Then
                         .Frame = 1
                     ElseIf .Frame = 3 Then
                         .Frame = 0
                     End If
                 End If
             End If
         ElseIf .Type = 134 Then 'bomb
             .FrameCount = .FrameCount + 1
             If .FrameCount < 4 Then
                 .Frame = 0
             ElseIf .FrameCount < 8 Then
                 .Frame = 1
             ElseIf .FrameCount < 11 Then
                 .Frame = 2
             Else
                 .FrameCount = 0
             End If
             If .Special2 = 1 Then
                 .Special3 = .Special3 + 1
                 If .Special3 < 4 Then
                 ElseIf .Special3 < 8 Then
                     .Frame = .Frame + 9
                 ElseIf .Special3 < 12 Then
                     .Frame = .Frame + 3
                 ElseIf .Special3 < 15 Then
                     .Frame = .Frame + 6
                 Else
                     .Special3 = 0
                 End If
             End If
         ElseIf .Type = 291 Then 'heart bomb
             .FrameCount = .FrameCount + 1
             If .FrameCount < 4 Then
                 .Frame = 0
             ElseIf .FrameCount < 8 Then
                 .Frame = 1
             ElseIf .FrameCount < 11 Then
                 .Frame = 2
             Else
                 .FrameCount = 0
                 .Frame = 0
             End If
            .Special3 = .Special3 + 1
            If .Special3 < 4 Then
            ElseIf .Special3 < 8 Then
                .Frame = .Frame + 3
            ElseIf .Special3 < 12 Then
                .Frame = .Frame + 6
            Else 'If .Special3 >= 16 Then
                .Special3 = 0
            End If
            If Rnd * 10 > 9.2 Then
                NewEffect 80, newLoc(.Location.X + .Location.Width / 2 - 4, .Location.Y + .Location.Height / 2 - 6), , , .Shadow
                Effect(numEffects).Location.SpeedX = Rnd * 1 - 0.5
                Effect(numEffects).Location.SpeedY = Rnd * 1 - 0.5
            End If
            
         ElseIf .Type = 91 Then .Frame = SpecialFrame(5)
         ElseIf .Type = 96 Then
             .Frame = 0
             If .Special = 98 Then
                 .Frame = 1
             ElseIf .Special = 99 Then
                 .Frame = 2
             ElseIf .Special = 100 Then
                 .Frame = 3
             ElseIf .Special = 148 Then
                 .Frame = 4
             ElseIf .Special = 149 Then
                 .Frame = 5
             ElseIf .Special = 150 Then
                 .Frame = 6
             ElseIf .Special = 228 Then
                 .Frame = 7
             End If
         ElseIf .Type = 194 Or .Type = 195 Then 'Glowy Shell
             .Special5 = .Special5 + 1
             If .Special5 >= 16 Then .Special5 = 0
             If .Location.SpeedX > 0 Then
                 If .Type = 194 Then
                     .FrameCount = .FrameCount + 1
                 Else
                     .FrameCount = .FrameCount - 1
                 End If
             ElseIf .Location.SpeedX < 0 Then
                 If .Type = 194 Then
                     .FrameCount = .FrameCount - 1
                 Else
                     .FrameCount = .FrameCount + 1
                 End If
             Else
                 If .Type = 194 Then
                     .FrameCount = 0
                 Else
                     .FrameCount = 12
                 End If
             End If
             If .FrameCount < 0 Then .FrameCount = 15
             If .FrameCount >= 16 Then .FrameCount = 0
             If .FrameCount < 4 Then
                 .Frame = 0
             ElseIf .FrameCount < 8 Then
                 .Frame = 1
             ElseIf .FrameCount < 12 Then
                 .Frame = 2
             ElseIf .FrameCount < 16 Then
                 .Frame = 3
             End If
             If .Special5 < 4 Then
             ElseIf .Special5 < 8 Then
                 .Frame = .Frame + 4
             ElseIf .Special5 < 12 Then
                 .Frame = .Frame + 8
             ElseIf .Special5 < 16 Then
                 .Frame = .Frame + 12
             End If
         ElseIf NPCIsAShell(.Type) Then 'Turtle shell
             If .Location.SpeedX = 0 Then
                 .Frame = 0
             Else
                 .FrameCount = .FrameCount + 1
                 If .FrameCount >= 4 Then
                     .FrameCount = 0
                     .Frame = .Frame + 1
                     If .Frame >= 4 Then .Frame = 0
                 End If
             End If
         ElseIf .Type = 77 Then 'black ninja
             If .Location.SpeedY = 0 Or .Slope > 0 Then
                 .Frame = 0
                 .FrameCount = .FrameCount + 1
                 If .FrameCount >= 12 Then
                     .FrameCount = 0
                 ElseIf .FrameCount >= 6 Then
                     .Frame = 1
                 End If
             ElseIf .Location.SpeedY < 0 Then
                 .Frame = 0
                 .FrameCount = 6
             Else
                 .Frame = 1
                 .FrameCount = 0
             End If
             If .Direction = 1 Then .Frame = .Frame + 2
         ElseIf .Type = 57 Then 'smb3 belt
             If .Direction = -1 Then
                 .Frame = SpecialFrame(4)
             Else
                 .Frame = 3 - SpecialFrame(4)
             End If
         ElseIf .Type = 60 Or .Type = 62 Or .Type = 64 Or .Type = 66 Then
             .Frame = 1
             If .Direction = 1 Then .Frame = 0
         ElseIf .Type = 168 Then ' Bully
             .Frame = 0
             If .Direction = 1 Then .Frame = .Frame + 3
             
             If .Projectile = True Or .Special2 <> 0 Then
                 .Frame = .Frame + 2
                 .FrameCount = 0
             Else
                 .FrameCount = .FrameCount + 1
                 If .FrameCount >= 16 Then
                     .FrameCount = 0
                 ElseIf .FrameCount >= 8 Then
                     .Frame = .Frame + 1
                 End If
             End If
             
             
         ElseIf .Type = 78 Then 'tank treads
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 8 Then
                 .Frame = 2
             ElseIf .FrameCount >= 4 Then
                 .Frame = 1
             Else
                 .Frame = 0
             End If
             If .FrameCount > 12 Then .FrameCount = 0
             If .Direction = 1 Then .Frame = .Frame + 3
         ElseIf .Type = 55 Then 'nekkid koopa
             If .Special = 0 Then
                 .Frame = 0
                 If .Direction = 1 Then .Frame = 3
                 .FrameCount = .FrameCount + 1
                 If .FrameCount >= 15 Then
                     .FrameCount = 0
                 ElseIf .FrameCount >= 8 Then
                     .Frame = .Frame + 1
                 End If
             Else
                 If .Direction = -1 Then
                     .Frame = 2
                 Else
                     .Frame = 5
                 End If
             End If
         ElseIf .Type >= 117 And .Type <= 120 Then 'beach koopa
             If .Projectile = True Then
                 If .Location.SpeedX < -0.5 Or .Location.SpeedX > 0.5 Then
                     .Frame = 3
                 Else
                     .Frame = 3
                     .FrameCount = .FrameCount + 1
                     If .FrameCount >= 15 Then
                         .FrameCount = 0
                     ElseIf .FrameCount >= 8 Then
                         .Frame = 4
                     End If
                 End If
             Else
                 If .Special = 0 Then
                     .Frame = 0
                     .FrameCount = .FrameCount + 1
                     If .FrameCount >= 15 Then
                         .FrameCount = 0
                     ElseIf .FrameCount >= 8 Then
                         .Frame = 1
                     End If
                 Else
                     .Frame = 2
                 End If
             End If
             If .Direction = 1 Then .Frame = .Frame + 5
         ElseIf .Type = 54 Then ' bouncy bee
             If .Location.SpeedY = 0 Or .Slope > 0 Then
                 .FrameCount = 0
                 .Frame = 0
             Else
                 .FrameCount = .FrameCount + 1
                 If .FrameCount >= 3 Then
                     .Frame = .Frame + 1
                     If .Frame >= 2 Then .Frame = 0
                     .FrameCount = 0
                 End If
             End If
         ElseIf .Type = 56 Then
             .Frame = SpecialFrame(2)
             If .Direction = 1 Then .Frame = .Frame + 4
         ElseIf .Type = 45 Then 'ice block
             If .Special = 0 Then
                 .Frame = BlockFrame(4)
             Else
                 If .Frame < 4 Then .Frame = 4
                 .FrameCount = .FrameCount + 1
                 If .FrameCount >= 4 Then
                     .FrameCount = 0
                     .Frame = .Frame + 1
                     If .Frame >= 6 Then .Frame = 4
                 End If
             End If
         'bowser fireball
         ElseIf .Type = 87 Then
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 20 Then .FrameCount = 0
             .Frame = Int(.FrameCount / 5)
             If .Direction = 1 Then .Frame = .Frame + 4
         'statue fireball
         ElseIf .Type = 85 Then
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 8 Then .FrameCount = 0
             .Frame = Int(.FrameCount / 2)
             If .Direction = 1 Then .Frame = .Frame + 4
         'winged koopa
         ElseIf .Type = 76 Or .Type = 161 Then
             .FrameCount = .FrameCount + 1
             If .Direction = -1 And .Frame >= 4 Then
                 .Frame = 0
             ElseIf .Direction = 1 And .Frame < 4 Then
                 .Frame = 4
             End If
             If .FrameCount >= 4 Then
                 .FrameCount = 0
                 If .Direction = -1 Then
                     .Frame = .Frame + 1
                     If .Frame >= 4 Then .Frame = 0
                 Else
                     .Frame = .Frame + 1
                     If .Frame >= 8 Then .Frame = 4
                 End If
             End If
         ElseIf .Type = 137 Then 'SMB3 Bomb
             .FrameCount = .FrameCount + 1
             If .FrameCount < 8 Then
                 .Frame = 0
             ElseIf .FrameCount < 15 Then
                 .Frame = 1
             Else
                 .Frame = 1
                 .FrameCount = 0
             End If
             If .Direction = 1 Then .Frame = .Frame + 6
             If .Special2 = 1 Then
                 .Special3 = .Special3 + 1
                 If .Special3 < 4 Then
                 ElseIf .Special3 < 8 Then
                     .Frame = .Frame + 2
                 ElseIf .Special3 < 11 Then
                     .Frame = .Frame + 4
                 Else
                     .Frame = .Frame + 4
                     .Special3 = 0
                 End If
             End If
         ElseIf .Type = 160 Then    'Airship Jet
             .FrameCount = .FrameCount + 1
             If .Direction = -1 And .Frame >= 4 Then
                 .Frame = 0
             ElseIf .Direction = 1 And .Frame < 4 Then
                 .Frame = 8
             End If
             If .FrameCount >= 2 Then
                 .FrameCount = 0
                 If .Direction = -1 Then
                     .Frame = .Frame + 1
                     If .Frame >= 4 Then .Frame = 0
                 Else
                     .Frame = .Frame + 1
                     If .Frame >= 8 Then .Frame = 4
                 End If
             End If
         ElseIf .Type = 178 Then
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 8 Then
                 .FrameCount = 0
                 .Frame = .Frame + 1
                 If .Frame >= 3 Then .Frame = 0
             End If
         ElseIf .Type = 4 Or .Type = 6 Or .Type = 23 Or .Type = 36 Or .Type = 285 Or .Type = 42 Or .Type = 52 Or .Type = 72 Or (.Type >= 109 And .Type <= 112) Or (.Type >= 121 And .Type <= 124) Or .Type = 136 Or .Type = 159 Or .Type = 162 Or .Type = 163 Or .Type = 164 Or .Type = 165 Or .Type = 166 Or .Type = 173 Or .Type = 175 Or .Type = 176 Or .Type = 177 Or .Type = 199 Or .Type = 229 Or .Type = 236 Or .Type = 230 Or .Type = 232 Or .Type = 233 Then    'Walking koopa troopa / hard thing / spiney
             .FrameCount = .FrameCount + 1
             If .Type = 166 And .Special > 360 Then .FrameCount = .FrameCount + 1
             If .Direction = -1 And .Frame >= 2 Then
                 .Frame = 0
             ElseIf .Direction = 1 And .Frame < 2 Then
                 .Frame = 2
             End If
             If .FrameCount >= 8 Then
                 .FrameCount = 0
                 If .Direction = -1 Then
                     .Frame = .Frame + 1
                     If .Frame >= 2 Then .Frame = 0
                 Else
                     .Frame = .Frame + 1
                     If .Frame >= 4 Then .Frame = 2
                 End If
             End If
             
         ElseIf .Type = 234 Then
             .FrameCount = .FrameCount + 1
             .Frame = 0
             If .Direction = 1 Then .Frame = 3
             
             If .FrameCount > 8 Then .Frame = .Frame + 1
             
             If .FrameCount > 16 Then .Frame = .Frame + 1
             If .FrameCount > 24 Then .Frame = .Frame - 1
             If .FrameCount > 32 Then .FrameCount = 0
             
         ElseIf .Type = 189 Then 'dry bones
             If .Special = 0 Then
                 .FrameCount = .FrameCount + 1
                 If .Type = 166 And .Special > 360 Then .FrameCount = .FrameCount + 1
                 If .Direction = -1 And .Frame >= 2 Then
                     .Frame = 0
                 ElseIf .Direction = 1 And .Frame < 2 Then
                     .Frame = 2
                 End If
                 If .FrameCount >= 8 Then
                     .FrameCount = 0
                     If .Direction = -1 Then
                         .Frame = .Frame + 1
                         If .Frame >= 2 Then .Frame = 0
                     Else
                         .Frame = .Frame + 1
                         If .Frame >= 4 Then .Frame = 2
                     End If
                 End If
             Else
                 If .Special2 < 10 Or .Special2 > 400 - 10 Then
                     .Frame = 4
                 Else
                     .Frame = 5
                 End If
                 If .Direction = 1 Then .Frame = .Frame + 2
             End If
         ElseIf .Type = 274 Then 'dragon coin
             .FrameCount = .FrameCount + 1
             If .FrameCount < 6 Then
                .Frame = 0
             ElseIf .FrameCount < 12 Then
                .Frame = 1
             ElseIf .FrameCount < 18 Then
                .Frame = 2
             ElseIf .FrameCount < 24 Then
                .Frame = 3
             ElseIf .FrameCount < 30 Then
                .Frame = 2
             ElseIf .FrameCount < 36 Then
                .Frame = 1
             Else
                .FrameCount = 0
                .Frame = 0
             End If
         ElseIf NPCIsACoin(.Type) Then 'Coin
             .Frame = CoinFrame(3)
             If .Type = 138 Then .Frame = CoinFrame(2)
             If .Type = 152 Then .Frame = CoinFrame(3)
         ElseIf .Type = 11 Then 'Frame finder for Star/Flower/Mushroom Exit
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 8 Then
                 .FrameCount = 0
                 .Frame = .Frame + 1
                 If .Frame = 3 Then .Frame = 0
             End If
         ElseIf .Type = 50 Then 'killer plant
             '.standingOnPlayer = A
             .Frame = 0
             If .Direction = 1 Then .Frame = 2
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 8 Then
                 .Frame = .Frame + 1
             End If
             If .FrameCount >= 16 Then
                 .FrameCount = 0
             End If
         ElseIf .Type = 49 Then 'killer pipe
             If .HoldingPlayer = 0 And Player(.standingOnPlayer).Controls.Run = False And .Projectile = False Then
                 .FrameCount = .FrameCount + 1
                 If .FrameCount >= 4 Then
                     .Frame = .Frame + 1
                     .FrameCount = 0
                 End If
                 If .Frame >= 5 Then .Frame = 0
             Else
                 If .Direction = -1 Then
                     .FrameCount = .FrameCount + 1
                     If .FrameCount >= 4 Then
                         .Frame = .Frame + 1
                         .FrameCount = 0
                     End If
                     If .Frame >= 10 Or .Frame < 5 Then .Frame = 5
                 Else
                     .FrameCount = .FrameCount + 1
                     If .FrameCount >= 4 Then
                         .Frame = .Frame + 1
                         .FrameCount = 0
                     End If
                     If .Frame >= 15 Or .Frame < 10 Then .Frame = 10
                 End If
             End If
         ElseIf .Type = 12 Then 'Frame finder for big fireball
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 4 Then
                 .FrameCount = 0
                 .Frame = .Frame + 1
                 If .Location.SpeedY < 0 Then
                     If .Frame >= 2 Then .Frame = 0
                 Else
                     If .Frame >= 4 Then .Frame = 2
                 End If
             End If
         ElseIf .Type = 13 Or .Type = 30 Or .Type = 246 Or .Type = 265 Then 'Frame finder for Fireball / Hammer
            If (.Type = 13 Or .Type = 265) And .Quicksand = 0 Then
                If .Wet > 0 Then
                    If Rnd * 100 > 95 Then
                        tempLocation = newLoc(.Location.X + 4, .Location.Y + 4, 8, 8)
                        If UnderWater(.Section) = False Then
                            NewEffect 113, tempLocation, , , .Shadow
                        Else
                            NewEffect 113, tempLocation, 1, 1, .Shadow
                        End If
                    End If
                    If Rnd * 100 > 85 Then
                        If .Type = 265 Then
                            If .Special = 5 Then
                                NewEffect 139, .Location, , , .Shadow
                                If Rnd * 10 > 8 Then
                                    tempLocation.Height = EffectHeight(80)
                                    tempLocation.Width = EffectWidth(80)
                                    tempLocation.SpeedX = 0
                                    tempLocation.SpeedY = 0
                                    tempLocation.X = .Location.X + Rnd * 16 - EffectWidth(80) / 2 - 4 - .Location.SpeedX * 3
                                    tempLocation.Y = .Location.Y + Rnd * 16 - EffectHeight(80) / 2 - 4
                                    NewEffect 80, tempLocation
                                    Effect(numEffects).Location.SpeedX = .Location.SpeedX * 0.5
                                    Effect(numEffects).Location.SpeedY = .Location.SpeedY * 0.5
                                    Effect(numEffects).Frame = Int(Rnd * 3)
                                End If
                            ElseIf Rnd * 10 > 6 Then
                                tempLocation.Height = EffectHeight(80)
                                tempLocation.Width = EffectWidth(80)
                                tempLocation.SpeedX = 0
                                tempLocation.SpeedY = 0
                                tempLocation.X = .Location.X - tempLocation.Width / 2 + Rnd * .Location.Width - 4
                                tempLocation.Y = .Location.Y - tempLocation.Height / 2 + Rnd * .Location.Height - 4
                                NewEffect 80, tempLocation, , , .Shadow
                                Effect(numEffects).Location.SpeedX = .Location.SpeedX * 0.25
                                Effect(numEffects).Location.SpeedY = .Location.SpeedY * 0.25
                                Effect(numEffects).Frame = Int(Rnd * 3)
                            End If
                        Else
                            NewEffect 77, .Location, CSng(.Special), , .Shadow
                        End If
                    End If
                Else
                    If .Type = 265 Then
                        If .Special = 5 Then
                            NewEffect 139, .Location, , , .Shadow
                            If Rnd * 10 > 8 Then
                                tempLocation.Height = EffectHeight(80)
                                tempLocation.Width = EffectWidth(80)
                                tempLocation.SpeedX = 0
                                tempLocation.SpeedY = 0
                                tempLocation.X = .Location.X + Rnd * 16 - EffectWidth(80) / 2 - 4 - .Location.SpeedX * 3
                                tempLocation.Y = .Location.Y + Rnd * 16 - EffectHeight(80) / 2 - 4
                                NewEffect 80, tempLocation
                                Effect(numEffects).Location.SpeedX = .Location.SpeedX * 0.5
                                Effect(numEffects).Location.SpeedY = .Location.SpeedY * 0.5
                                Effect(numEffects).Frame = Int(Rnd * 3)
                            End If
                        ElseIf Rnd * 10 > 6 Then
                            tempLocation.Height = EffectHeight(80)
                            tempLocation.Width = EffectWidth(80)
                            tempLocation.SpeedX = 0
                            tempLocation.SpeedY = 0
                            tempLocation.X = .Location.X - tempLocation.Width / 2 + Rnd * .Location.Width - 4
                            tempLocation.Y = .Location.Y - tempLocation.Height / 2 + Rnd * .Location.Height - 4
                            NewEffect 80, tempLocation, , , .Shadow
                            Effect(numEffects).Location.SpeedX = .Location.SpeedX * 0.25
                            Effect(numEffects).Location.SpeedY = .Location.SpeedY * 0.25
                            Effect(numEffects).Frame = Int(Rnd * 3)
                        End If
                    Else
                        NewEffect 77, .Location, CSng(.Special), , .Shadow
                    End If
                End If
            End If
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 4 Then
                 .FrameCount = 0
                 .Frame = .Frame - .Direction
             End If
             If .Special < 2 Or (.Type = 265 And .Special <> 5) Then
                 If .Frame >= 4 Then .Frame = 0
                 If .Frame < 0 Then .Frame = 3
             ElseIf .Special = 2 Or (.Type = 265 And .Special = 5) Then
                 If .Frame >= 7 Then .Frame = 4
                 If .Frame < 4 Then .Frame = 6
             ElseIf .Special = 3 Then
                 If .Frame >= 11 Then .Frame = 8
                 If .Frame < 8 Then .Frame = 10
             ElseIf .Special = 4 Then
                 If .Frame >= 15 Then .Frame = 12
                 If .Frame < 12 Then .Frame = 14
             ElseIf .Special = 5 Then
                 If .Frame >= 19 Then .Frame = 16
                 If .Frame < 16 Then .Frame = 18
             End If
         ElseIf .Type = 15 Then 'Frame finder for Big Koopa
             If .Special = 0 Then
                 If .Location.SpeedY <> 0 Then
                     .Frame = 0
                 Else
                     If .FrameCount >= 0 Then
                         .FrameCount = .FrameCount + 1
                     Else
                         .FrameCount = .FrameCount - 1
                     End If
                     If .FrameCount >= 5 Or .FrameCount <= -5 Then
                         If .FrameCount >= 0 Then
                             .Frame = .Frame + 1
                             .FrameCount = 1
                         Else
                             .Frame = .Frame - 1
                             .FrameCount = -1
                         End If
                         If .Frame >= 5 Then
                             .Frame = 3
                             .FrameCount = -1
                         ElseIf .Frame <= 0 Then
                             .Frame = 2
                             .FrameCount = 1
                         End If
                     End If
                 End If
             ElseIf .Special = 1 Then
                 .Frame = 6
             ElseIf .Special = 4 Then
                 .FrameCount = .FrameCount + 1
                 If .Frame < 7 Then .Frame = 7
                 If .FrameCount >= 8 Then
                     .FrameCount = 0
                     If .Frame = 7 Then
                         .Frame = 8
                     Else
                         .Frame = 7
                     End If
                 End If
             Else
                 .Frame = 5
             End If
         ElseIf .Type = 37 Or .Type = 180 Then 'Thwomp
         'Bullet Bills / Key / ONLY DIRECTION FRAMES
         ElseIf .Type = 17 Or .Type = 18 Or .Type = 31 Or .Type = 84 Or .Type = 94 Or .Type = 198 Or NPCIsYoshi(.Type) Or .Type = 101 Or .Type = 102 Or .Type = 181 Then
             If .Direction = -1 Then
                 .Frame = 0
             Else
                 .Frame = 1
             End If
         'Leaf
        ElseIf .Type = 34 Then
             If .Direction = -1 Then
                 .Frame = 1
             Else
                 .Frame = 0
             End If
         ElseIf .Type = 135 And .Special2 = 1 Then
             .FrameCount = .FrameCount + 1
             If .FrameCount < 4 Then
                 .Frame = 8
             ElseIf .FrameCount < 8 Then
                 .Frame = 9
             ElseIf .FrameCount < 11 Then
                 .Frame = 10
             Else
                 .Frame = 10
                 .FrameCount = 0
             End If
             If .HoldingPlayer > 0 Or .Projectile = True Then .Frame = .Frame + 6
             If .Direction = 1 Then .Frame = .Frame + 3
         ElseIf .Type = 19 Or .Type = 20 Or .Type = 28 Or (.Type >= 129 And .Type <= 132) Or .Type = 135 Or .Type = 158 Then    'Shy guys / Jumping Fish
             If .HoldingPlayer = 0 And .Projectile = False Then
                 .FrameCount = .FrameCount + 1
                 If .Direction = -1 And .Frame >= 2 Then
                     .Frame = 0
                 ElseIf .Direction = 1 And .Frame < 2 Then
                     .Frame = 2
                 End If
                 If .FrameCount >= 8 Then
                     .FrameCount = 0
                     If .Direction = -1 Then
                         .Frame = .Frame + 1
                         If .Frame >= 2 Then .Frame = 0
                     Else
                         .Frame = .Frame + 1
                         If .Frame >= 4 Then .Frame = 2
                     End If
                 End If
             Else
                 If .Frame < 4 Then .Frame = 4
                 .FrameCount = .FrameCount + 1
                 If .Direction = -1 And .Frame >= 6 Then
                     .Frame = 4
                 ElseIf .Direction = 1 And .Frame < 6 Then
                     .Frame = 6
                 End If
                 If .FrameCount >= 4 Then
                     .FrameCount = 0
                     If .Direction = -1 Then
                         .Frame = .Frame + 1
                         If .Frame >= 6 Then .Frame = 4
                     Else
                         .Frame = .Frame + 1
                         If .Frame >= 8 Then .Frame = 6
                     End If
                 End If
             End If
         ElseIf .Type = 25 Then ' Bouncy Star things
             If .HoldingPlayer = 0 And .Projectile = False Then
                 If .Location.SpeedY = 0 Or .Slope > 0 Then
                     If .Direction = -1 Then
                         .Frame = 0
                     ElseIf .Direction = 1 Then
                         .Frame = 2
                     End If
                 Else
                     If .Direction = -1 Then
                         .Frame = 1
                     ElseIf .Direction = 1 Then
                         .Frame = 3
                     End If
                 End If
             Else
                 .FrameCount = .FrameCount + 1
                 If .Direction = -1 And .Frame >= 6 Then
                     .Frame = 4
                 ElseIf .Direction = 1 And .Frame < 6 Then
                     .Frame = 6
                 End If
                 If .FrameCount >= 4 Then
                     .FrameCount = 0
                     If .Direction = -1 Then
                         .Frame = .Frame + 1
                         If .Frame >= 6 Then .Frame = 4
                     Else
                         .Frame = .Frame + 1
                         If .Frame >= 8 Then .Frame = 6
                     End If
                 End If
             End If
         ElseIf .Type = 22 Then 'Bullet bill Gun
            .FrameCount = .FrameCount + 1
             If .FrameCount >= 4 Then
                 .FrameCount = 1
                 .Frame = .Frame + 1
                 If .Frame = 5 Then .Frame = 0
             End If
         ElseIf .Type = 107 Then
             If .Location.SpeedX = 0 Then
                 .FrameCount = .FrameCount + 1
                 If .FrameCount < 4 Then
                     .Frame = 0
                 ElseIf .FrameCount < 7 Then
                     .Frame = 1
                 Else
                     .Frame = 1
                     .FrameCount = 0
                 End If
             Else
                 .FrameCount = .FrameCount + 1
                 If .FrameCount < 4 Then
                     .Frame = 0
                 ElseIf .FrameCount < 8 Then
                     .Frame = 1
                 ElseIf .FrameCount < 12 Then
                     .Frame = 2
                 ElseIf .FrameCount < 15 Then
                     .Frame = 3
                 Else
                     .Frame = 3
                     .FrameCount = 0
                 End If
             End If
             If .Direction = 1 Then .Frame = .Frame + 4
         ElseIf .Type = 26 Then 'Spring thing
             If LevelEditor = False Then
                If .Location.Height = 32 Then
                    .Location.Height = 16
                    .Location.Y = .Location.Y + 16
                End If
                If .HoldingPlayer > 0 Then
                    .Frame = 0
                Else
                    C = 0
                    tempLocation = .Location
                    tempLocation.Height = 24
                    tempLocation.Y = tempLocation.Y - 8
                    For B = 1 To numPlayers
                        If CheckCollision(tempLocation, Player(B).Location) = True And Player(B).Mount <> 2 And (Player(B).Location.SpeedY > 0 Or Player(B).Location.SpeedY < Physics.PlayerJumpVelocity) Then
                            C = 2
                            Exit For
                        End If
                    Next B
                    If C = 0 Then
                        tempLocation = .Location
                        tempLocation.Height = 32
                        tempLocation.Y = tempLocation.Y - 16
                        For B = 1 To numPlayers
                            If CheckCollision(tempLocation, Player(B).Location) = True And Player(B).Mount <> 2 And (Player(B).Location.SpeedY > 0 Or Player(B).Location.SpeedY < Physics.PlayerJumpVelocity) Then
                                C = 1
                                Exit For
                            End If
                        Next B
                    End If
                    .Frame = C
                End If
             End If
         ElseIf .Type = 39 Then 'birdo
             .Frame = 0
             If .Direction = 1 Then .Frame = 5
             If .Special = 0 Then
                 If .Location.SpeedX <> 0 Then
                     .FrameCount = .FrameCount + 1
                     If .FrameCount > 12 Then
                         .FrameCount = 0
                     ElseIf .FrameCount >= 6 Then
                         .Frame = .Frame + 1
                     End If
                 End If
             ElseIf .Special < 0 Then
                 .Frame = .Frame + 3
                 .FrameCount = .FrameCount + 1
                 If .FrameCount > 8 Then
                     .FrameCount = 0
                 ElseIf .FrameCount >= 4 Then
                     .Frame = .Frame + 1
                 End If
             Else
                 .Frame = .Frame + 2
             End If
         ElseIf .Type = 125 Then 'Rat Head
             .Frame = .FrameCount
             If .Direction = 1 Then .Frame = .Frame + 2
         ElseIf .Type = 29 Then 'SMB Hammer Bro
             If .Special3 >= 0 Then
                 If (.Location.SpeedY < 1 And .Location.SpeedY >= 0) Or .Slope > 0 Or .HoldingPlayer > 0 Then
                     .FrameCount = .FrameCount + 1
                     If .Direction = -1 And .Frame >= 2 Then
                         .Frame = 0
                     ElseIf .Direction = 1 And .Frame < 3 Then
                         .Frame = 3
                     End If
                     If .FrameCount >= 8 Then
                         .FrameCount = 0
                         If .Direction = -1 Then
                             .Frame = .Frame + 1
                             If .Frame >= 2 Then .Frame = 0
                         Else
                             .Frame = .Frame + 1
                             If .Frame >= 5 Then .Frame = 3
                         End If
                     End If
                 Else
                     If .Direction = -1 Then
                         .Frame = 0
                     Else
                         .Frame = 3
                     End If
                 End If
             Else
                 If .Direction = -1 Then
                     .Frame = 2
                 Else
                     .Frame = 5
                 End If
             End If
         ElseIf .Type = 108 Then 'Yoshi Fireball
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 8 Then
                 .Frame = 1
                 .FrameCount = 0
             ElseIf .FrameCount > 4 Then
                 .Frame = 1
             Else
                 .Frame = 0
             End If
             If .Direction = 1 Then .Frame = .Frame + 2
         ElseIf .Type = 35 Or .Type = 191 Or .Type = 193 Then ' Goombas Shoe
             If .Direction = 1 Then
                 .Frame = 2 + SpecialFrame(1)
             Else
                 .Frame = 0 + SpecialFrame(1)
             End If
         ElseIf .Type = 38 Or .Type = 43 Or .Type = 44 Then 'Boo
             .Frame = 0
             If .Direction = 1 Then
                 .Frame = 2
             End If
             If .Special = 1 Or .HoldingPlayer > 0 Then .Frame = .Frame + 1
         ElseIf .Type = 41 Then 'smb2 birdo exit
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 8 Then
                 .FrameCount = 1
                 .Frame = .Frame + 1
                 If .Frame = 8 Then .Frame = 0
             End If
         ElseIf .Type = 97 Then 'SMB3 Star
             .FrameCount = .FrameCount + 1
             If .Special = 0 Then
                 If .FrameCount < 8 Then
                     .Frame = 0
                 ElseIf .FrameCount < 12 Then
                     .Frame = 1
                 ElseIf .FrameCount < 16 Then
                     .Frame = 2
                 ElseIf .FrameCount < 20 Then
                     .Frame = 1
                 Else
                     .FrameCount = 0
                 End If
             Else
                 If .FrameCount < 60 Then
                     .Frame = 2
                 'ElseIf .FrameCount < 64 Then
                     '.Frame = 1
                 Else
                     .FrameCount = 0
                 End If
             End If
         ElseIf Not (NPCIsABonus(.Type) Or .Type = 21 Or .Type = 32) Then   'Frame finder for everything else
             .FrameCount = .FrameCount + 1
             If .Type = 48 Or .Type = 206 Then .FrameCount = .FrameCount + 1
             If .FrameCount >= 8 Then
                 .FrameCount = 1
                 .Frame = .Frame + 1
                 If .Frame = 2 Then .Frame = 0
             End If
         ElseIf .Type = 183 Or .Type = 277 Then
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 12 Then
                 .FrameCount = 1
                 .Frame = .Frame + 1
                 If .Frame = 2 Then .Frame = 0
             End If
         ElseIf .Type = 182 Then
             .FrameCount = .FrameCount + 1
             If .FrameCount >= 4 Then
                 .FrameCount = 1
                 .Frame = .Frame + 1
                 If .Frame = 4 Then .Frame = 0
             End If
         Else
            If A = 0 Then .Frame = 0
         End If
    End With
End Sub

Public Sub SkullRide(A As Integer)
    Dim B As Integer
    Dim tempLocation As Location
    With NPC(A)
        tempLocation = NPC(A).Location
        tempLocation.Width = tempLocation.Width + 16
        tempLocation.X = tempLocation.X - 8
        For B = 1 To numNPCs
            If NPC(B).Type = 190 Then
                If NPC(B).Active = True Then
                    If NPC(B).Special = 0 Then
                        If CheckCollision(tempLocation, NPC(B).Location) = True Then
                            NPC(B).Special = 1
                            SkullRide B
                        End If
                    End If
                End If
            End If
        Next B
    End With
End Sub


Public Sub NPCSpecial(A As Integer)
    Dim B As Double
    Dim C As Double
    Dim D As Double
    Dim E As Double
    Dim F As Double
    Dim fBlock As Double
    Dim lBlock As Double
    Dim straightLine As Boolean
    Dim tempBool As Boolean
    Dim tempBool2 As Boolean
    Dim tempLocation As Location
    Dim tempNPC As NPC
    With NPC(A)
    'dont despawn
        If .Type = 200 Or .Type = 201 Or .Type = 209 Or .Type = 208 Or .Type = 262 Then
            If .TimeLeft > 1 Then .TimeLeft = 100
        End If
    ''''''''''''''
    
        If .Type = 225 Or .Type = 226 Or .Type = 227 Then 'Vine Maker
            .Location.SpeedY = -2
            tempLocation.Height = 28
            tempLocation.Width = 30
            tempLocation.Y = NPC(A).Location.Y + NPC(A).Location.Height / 2 - tempLocation.Height / 2
            tempLocation.X = NPC(A).Location.X + NPC(A).Location.Width / 2 - tempLocation.Width / 2
            tempBool = False
            For B = 1 To numNPCs
                If NPCIsAVine(NPC(B).Type) = True Then
                    If NPC(B).Hidden = False Then
                        If CheckCollision(tempLocation, NPC(B).Location) = True Then
                            tempBool = True
                            Exit For
                        End If
                    End If
                End If
            Next B
            If tempBool = False Then
                fBlock = FirstBlock(Int(tempLocation.X / 32) - 1)
                lBlock = LastBlock(Int((tempLocation.X + tempLocation.Width) / 32) + 1)
                For B = fBlock To lBlock
                    If Block(B).Hidden = False And BlockNoClipping(Block(B).Type) = False And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False Then
                        If CheckCollision(tempLocation, Block(B).Location) = True And BlockSlope(Block(B).Type) = 0 Then
                            'tempBool = True
                        End If
                    End If
                Next B
            End If
            If tempBool = False Or .Special = 1 Then
                numNPCs = numNPCs + 1
                With NPC(numNPCs)
                    If NPC(A).Type = 225 Then
                        .Type = 214
                    ElseIf NPC(A).Type = 226 Then
                        .Type = 213
                    ElseIf NPC(A).Type = 227 Then
                        .Type = 224
                    End If
                    .Location.Y = Int(NPC(A).Location.Y / 32) * 32
                    .Location.Height = 32
                    .Location.Width = NPCWidth(.Type)
                    .Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2 - .Location.Width / 2
                    .Active = True
                    .TimeLeft = 100
                    .Section = NPC(A).Section
                    .DefaultLocation = .Location
                    .DefaultType = .Type
                    .Layer = NPC(A).Layer
                    .Shadow = NPC(A).Shadow
                End With
            End If
            If .Special = 1 Then .Killed = 9
    'driving block
        ElseIf .Type = 290 Then
            If .Special4 > 0 Then
                .Special4 = 0
            Else
                .Special5 = 0
                .Special6 = 0
            End If
            If .Special5 > 0 Then
                If .Location.SpeedX < 0 Then .Location.SpeedX = .Location.SpeedX * 0.95
                .Location.SpeedX = .Location.SpeedX + 0.1
            ElseIf .Special5 < 0 Then
                If .Location.SpeedX > 0 Then .Location.SpeedX = .Location.SpeedX * 0.95
                .Location.SpeedX = .Location.SpeedX - 0.1
            Else
                .Location.SpeedX = .Location.SpeedX * 0.95
                If .Location.SpeedX > -0.1 And .Location.SpeedX < 0.1 Then .Location.SpeedX = 0
            End If
            If .Special6 > 0 Then
                If .Location.SpeedY < 0 Then .Location.SpeedY = .Location.SpeedY * 0.95
                .Location.SpeedY = .Location.SpeedY + 0.1
            ElseIf .Special6 < 0 Then
                If .Location.SpeedY > 0 Then .Location.SpeedY = .Location.SpeedY * 0.95
                .Location.SpeedY = .Location.SpeedY - 0.1
            Else
                .Location.SpeedY = .Location.SpeedY * 0.95
                If .Location.SpeedY > -0.1 And .Location.SpeedY < 0.1 Then .Location.SpeedY = 0
            End If
            If .Location.SpeedY > 4 Then .Location.SpeedY = 4
            If .Location.SpeedY < -4 Then .Location.SpeedY = -4
            If .Location.SpeedX > 6 Then .Location.SpeedX = 6
            If .Location.SpeedX < -6 Then .Location.SpeedX = -6
            
        ElseIf .Type = 291 Then 'heart bomb
            If .Special4 <> 0 Then
                .Killed = 9
                C = .BattleOwner
                If .CantHurtPlayer > 0 Then C = .CantHurtPlayer
                Bomb .Location, 0, Int(C)
                For B = 1 To 5
                    NewEffect 80, newLoc(.Location.X + .Location.Width / 2 - 4, .Location.Y + .Location.Height / 2 - 6), , , .Shadow
                    Effect(numEffects).Location.SpeedX = Rnd * 6 - 3
                    Effect(numEffects).Location.SpeedY = Rnd * 6 - 3
                    Effect(numEffects).Frame = Int(Rnd * 3)
                Next B
                
                
            End If
        
        
        ElseIf .Type = 272 Then
            If .Projectile = False Then
                .Location.SpeedX = 0
                If .Location.SpeedY < 0 Then
                    .Special = -1
                Else
                    .Special = 1
                End If
                tempLocation = .Location
                If .Special = -1 Then
                    tempLocation.Y = tempLocation.Y - 1
                Else
                    tempLocation.Y = tempLocation.Y + tempLocation.Height + 1
                End If
                tempLocation.Height = 1
                tempBool = False
                For B = 1 To numNPCs
                    If NPC(B).Active = True Then
                        If NPC(B).Hidden = False Then
                            If NPCIsAVine(NPC(B).Type) Then
                                If CheckCollision(tempLocation, NPC(B).Location) Then
                                    tempBool = True
                                    Exit For
                                End If
                            End If
                        End If
                    End If
                Next B
                If tempBool = False Then
                For B = 1 To numBackground
                    If Background(B).Hidden = False Then
                        If (Background(B).Type >= 174 And Background(B).Type <= 186) Or Background(B).Type = 63 Then
                            If CheckCollision(tempLocation, Background(B).Location) Then
                                tempBool = True
                                Exit For
                            End If
                        End If
                    End If
                Next B
                End If
                If tempBool = True Then
                    If .Special = 1 Then
                        .Location.SpeedY = 2
                    Else
                        .Location.SpeedY = -1
                    End If
                Else
                    If .Special = -1 Then
                        .Location.SpeedY = 2
                        .Special = 2
                    Else
                        .Location.SpeedY = -1
                        .Special = -1
                    End If
                End If
            Else
                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity
                .Location.SpeedX = .Location.SpeedX * 0.987
                If .Location.SpeedX > -0.1 And .Location.SpeedX < 0.1 Then .Location.SpeedX = 0
                
            End If
        ElseIf .Type = 287 Then
            .Type = RandomBonus
        ElseIf .Type = 286 Then 'falling spiney
            If .Special <> 0 Then
                .Type = 285
                .Special = 0
                C = 0
                For B = 1 To numPlayers
                    If Player(B).Dead = False And Player(B).Section = .Section And Player(B).TimeToLive = 0 Then
                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                            If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                                .Direction = -1
                            Else
                                .Direction = 1
                            End If
                        End If
                    End If
                Next B
                .Location.SpeedX = Physics.NPCWalkingOnSpeed * .Direction
            End If
        ElseIf .Type = 283 Then ' bubble
            If .Special = 287 Then
                .Special = RandomBonus
                .DefaultSpecial = .Special
            End If
            .Location.SpeedX = 0.75 * .DefaultDirection
            If .Special2 = 0 Then .Special2 = -1
            .Location.SpeedY = .Location.SpeedY + 0.05 * .Special2
            If .Location.SpeedY > 1 Then
                .Location.SpeedY = 1
                .Special2 = -1
            ElseIf .Location.SpeedY < -1 Then
                .Location.SpeedY = -1
                .Special2 = 1
            End If
            If .Special3 > 0 Then
                NewEffect 144, .Location
                PlaySound 91
                .Type = .Special
                .Special3 = 0
                .Special2 = 0
                .Special = 0
                .Frame = EditorNPCFrame(.Type, .Direction)
                .FrameCount = 0
                .Location.X = .Location.X + .Location.Width / 2
                .Location.Y = .Location.Y + .Location.Height / 2
                .Location.Width = NPCWidth(.Type)
                .Location.Height = NPCHeight(.Type)
                .Location.X = .Location.X - .Location.Width / 2
                .Location.Y = .Location.Y - .Location.Height / 2
                .Location.SpeedX = 0
                .Location.SpeedY = 0
                .Direction = .DefaultDirection
                If NPCIsACoin(.Type) Then
                    .Special = 1
                    .Location.SpeedX = Rnd * 1 - 0.5
                End If
                If .Direction = 0 Then
                    If Rnd * 2 > 1 Then
                        .Direction = 1
                    Else
                        .Direction = -1
                    End If
                End If
                .TurnAround = False
                If .Type = 134 Then
                    .Projectile = True
                End If
            End If
            
        ElseIf .Type = 275 Then 'fire plant thing
            If .Special = 0 Then
                .Special2 = .Special2 + 1
                If .Special2 >= 170 Then
                    .Special2 = 0
                    .Special = 1
                End If
            ElseIf .Special = 1 Then
                .Special2 = .Special2 + 1
                If .Special2 >= 70 Then
                    .Special2 = 0
                    .Special = 2
                End If
            ElseIf .Special = 2 Then
                If .Special2 = 0 Then 'spit fireballs
                    For B = 1 To 4
                        numNPCs = numNPCs + 1
                        With NPC(numNPCs)
                            .Type = 276
                            .Location.Height = NPCHeight(.Type)
                            .Location.Width = NPCWidth(.Type)
                            .Section = NPC(A).Section
                            .TimeLeft = NPC(A).TimeLeft
                            .Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2 - .Location.Width / 2
                            .Location.Y = NPC(A).Location.Y - .Location.Height
                            .Active = True
                            .Layer = NPC(A).Layer
                            If B = 1 Or B = 4 Then
                                .Location.SpeedX = -2.5
                                .Location.SpeedY = -1.5
                            Else
                                .Location.SpeedX = -1
                                .Location.SpeedY = -2
                            End If
                            If B = 3 Or B = 4 Then
                                .Location.SpeedX = -.Location.SpeedX
                            End If
                            .Location.SpeedX = .Location.SpeedX * 1.6
                            .Location.SpeedY = .Location.SpeedY * 1.6
                        End With
                    Next B
                End If
                .Special2 = .Special2 + 1
                If .Special2 >= 50 Then
                    .Special2 = 0
                    .Special = 0
                End If
            End If
        ElseIf .Type = 276 Then 'plant fireballs
            If .Special = 0 Then
                .Location.SpeedY = .Location.SpeedY * 0.98
                .Location.SpeedX = .Location.SpeedX * 0.98
                If .Location.SpeedY > -0.5 Then
                    .Location.SpeedX = 0
                    .Location.SpeedY = 0
                    .Special2 = 0
                    .Special = 1
                End If
            Else
                .Location.SpeedY = .Location.SpeedY + 0.02
                If .Location.SpeedY > 2 Then .Location.SpeedY = 2
                
                If .Location.SpeedY > 0.25 Then
                    .Special2 = .Special2 + 1
                    If .Special2 < 7 Then
                        .Location.SpeedX = -0.8
                    ElseIf .Special2 < 13 Then
                        .Location.SpeedX = 0.8
                    Else
                        .Special2 = 0
                        .Location.SpeedX = 0
                    End If
                End If
                
            End If
        ElseIf .Type = 271 Then 'bat thing
            If .Special = 0 Then
                For B = 1 To numPlayers
                    If Player(B).Section = .Section And Player(B).Dead = False And Player(B).TimeToLive = 0 Then
                        tempLocation = .Location
                        tempLocation.Width = 400
                        tempLocation.Height = 800
                        tempLocation.X = tempLocation.X - tempLocation.Width / 2
                        tempLocation.Y = tempLocation.Y - tempLocation.Height / 2
                        If CheckCollision(tempLocation, Player(B).Location) Then
                            .Special = 1
                            If Player(B).Location.X < .Location.X Then
                                .Direction = -1
                            Else
                                .Direction = 1
                            End If
                            .Location.SpeedX = 0.01 * .Direction
                            
                            If Player(B).Location.Y > .Location.Y Then
                                .Location.SpeedY = 2.5
                                .Special2 = Player(B).Location.Y - 130
                            Else
                                .Location.SpeedY = -2.5
                                .Special2 = Player(B).Location.Y + 130
                            End If
                            
                        End If
                    End If
                Next B
            Else
                .Location.SpeedX = (3 - Abs(.Location.SpeedY)) * .Direction
                If (.Location.SpeedY > 0 And .Location.Y > .Special2) Or (.Location.SpeedY < 0 And .Location.Y < .Special2) Then
                    .Location.SpeedY = .Location.SpeedY * 0.98
                    If .Location.SpeedY > -0.1 And .Location.SpeedY < 0.1 Then .Location.SpeedY = 0
                End If
            End If
        ElseIf .Type = 269 Then ' larry magic
            If .Special < 2 Then
                .Special2 = .Special2 + 1
                If .Special2 >= 30 And .Special <> 2 Then
                    .Location.X = .Location.X + .Location.Width
                    .Location.Y = .Location.Y + .Location.Height
                    .Location.Width = 16
                    .Location.Height = 32
                    .Special = 2
                    .Location.X = .Location.X - .Location.Width
                    .Location.Y = .Location.Y - .Location.Height
                    .Special2 = 21
                ElseIf .Special2 >= 15 And .Special <> 1 Then
                    .Location.X = .Location.X + .Location.Width
                    .Location.Y = .Location.Y + .Location.Height
                    .Location.Width = 10
                    .Location.Height = 20
                    .Special = 1
                    .Location.X = .Location.X - .Location.Width
                    .Location.Y = .Location.Y - .Location.Height
                End If
            End If
        ElseIf .Type = 268 Or .Type = 281 Then 'larry/ludwig shell
            If .Special5 = 0 Then 'Target a Random Player
                C = 0
                Do
                    B = Int(Rnd) * numPlayers + 1
                    If Player(B).Dead = False And Player(B).Section = .Section And Player(B).TimeToLive = 0 Then
                        .Special5 = B
                    End If
                    C = C + 1
                    If C >= 20 Then .Special5 = 1
                Loop Until .Special5 > 0
            End If

            If Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 < .Location.X + .Location.Width / 2 Then
                .Direction = -1
            Else
                .Direction = 1
            End If
            If .Special = 0 Then
                .Special2 = .Special2 + 1
                If .Special2 >= 60 Then
                    .Special = 1
                    .Special2 = 0
                End If
            ElseIf .Special = 1 Then
                If .Type = 281 And .Location.SpeedY = Physics.NPCGravity Then
                    .Location.SpeedX = .Location.SpeedX + 0.1 * .Direction
                Else
                    .Location.SpeedX = .Location.SpeedX + 0.2 * .Direction
                End If
                If .Type = 281 And .Damage >= 5 Then
                    If .Location.SpeedX > 5.5 Then
                        .Location.SpeedX = 5.5
                    ElseIf .Location.SpeedX < -5.5 Then
                        .Location.SpeedX = -5.5
                    End If
                ElseIf .Type = 281 And .Damage >= 10 Then
                    If .Location.SpeedX > 6 Then
                        .Location.SpeedX = 6
                    ElseIf .Location.SpeedX < -6 Then
                        .Location.SpeedX = -6
                    End If
                Else
                    If .Location.SpeedX > 5 Then
                        .Location.SpeedX = 5
                    ElseIf .Location.SpeedX < -5 Then
                        .Location.SpeedX = -5
                    End If
                End If
                
                If .Type = 281 And .Location.SpeedY = Physics.NPCGravity Then
                    .Special3 = .Special3 + 1
                    If (.Location.SpeedX < -2 And .Direction < 0) Or (.Location.SpeedX > 2 And .Direction > 0) Then
                        If .Special3 >= 20 - .Damage * 2 Then
                            .Special3 = 0
                            .Location.SpeedY = -3 - Rnd * 2
                        End If
                    End If
                End If
                
                .Special2 = .Special2 + 1
                
                If .Special2 >= 300 And .Location.SpeedY = Physics.NPCGravity Then
                    .Special = 2
                    .Special2 = 0
                End If
            ElseIf .Special = 2 Then
                .Location.SpeedY = -5 - Rnd * 3
                If .Type = 281 Then .Location.SpeedY = .Location.SpeedY - 2
                .Special = 3
            ElseIf .Special = 3 Then
                If .Location.SpeedX > 2.5 Then
                    .Location.SpeedX = .Location.SpeedX - 0.2
                ElseIf .Location.SpeedX < -2.5 Then
                    .Location.SpeedX = .Location.SpeedX + 0.2
                End If
                .Special2 = .Special2 + 1
                
                If .Type = 281 Then
                    .Special2 = 20
                    PlaySound 24
                End If
                
                If .Special2 = 20 Then
                    .Special = 0
                    .Special2 = .Direction
                    .Special3 = 0
                    .Special4 = 0
                    .Special5 = 0
                    .Special6 = 0
                    .Location.X = .Location.X + .Location.Width / 2
                    .Location.Y = .Location.Y + .Location.Height
                    .Type = .Type - 1
                    .Location.Width = NPCWidth(.Type)
                    .Location.Height = NPCHeight(.Type)
                    .Location.X = .Location.X - .Location.Width / 2
                    .Location.Y = .Location.Y - .Location.Height
                End If
            Else
                .Special = 0
            End If
            
        ElseIf .Type = 267 Then 'larry koopa
            'special is phase
            'special5 is targetted player
            'special3 is jump counter
            'special2 is direction
            
            'special4 is attack timer
            'special3 is attack count
            If .Inert = True Then
                .Special4 = 0
                .Special3 = 0
            End If
            If .Special5 = 0 Then 'Target a Random Player
                C = 0
                Do
                    B = Int(Rnd) * numPlayers + 1
                    If Player(B).Dead = False And Player(B).Section = .Section And Player(B).TimeToLive = 0 Then
                        .Special5 = B
                    End If
                    C = C + 1
                    If C >= 20 Then .Special5 = 1
                Loop Until .Special5 > 0
            End If
            
                If Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 < .Location.X + .Location.Width / 2 Then
                    .Direction = -1
                Else
                    .Direction = 1
                End If
                If .Special2 = 0 Then .Special2 = .Direction
            
            If .Special = 0 Then
                If .Special2 = -1 Then
                    .Location.SpeedX = -2.5
                Else
                    .Location.SpeedX = 2.5
                End If
                'movement
                If .Location.X < Player(.Special5).Location.X - 400 Then
                    .Special2 = 1
                ElseIf .Location.X > Player(.Special5).Location.X + 400 Then
                    .Special2 = -1
                End If
                'jumping
                If .Location.SpeedY = Physics.NPCGravity Then
                    .Special3 = .Special3 + 1
                    If .Special3 >= 30 + Rnd * 100 Then
                        .Special3 = 0
                        .Location.SpeedY = -5 - Rnd * 4
                    End If
                Else
                    .Special3 = 0
                End If
                'attack timer
                .Special4 = .Special4 + 1
                If .Special4 >= 100 + Rnd * 100 And .Location.SpeedY = Physics.NPCGravity Then
                    .Special = 1
                    .Special5 = 0
                    .Special3 = 0
                    .Special4 = 0
                End If
            ElseIf .Special = 1 Then
                If Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 < .Location.X + .Location.Width / 2 Then
                    .Direction = -1
                Else
                    .Direction = 1
                End If
                .Special2 = .Direction
                .Location.SpeedX = 0
                .Special3 = .Special3 + 1
                If .Special3 >= 10 Then
                    .Special3 = 0
                    .Special = 2
                End If
            ElseIf .Special = 2 Then
                .Location.SpeedX = 0
                If .Special3 = 0 Or .Special3 = 6 Or .Special3 = 12 Then 'shoot
                    
                    If .Special3 = 0 Then
                        .Special6 = Player(NPC(A).Special5).Location.X + Player(NPC(A).Special5).Location.Width / 2
                        .Special4 = Player(NPC(A).Special5).Location.Y + Player(NPC(A).Special5).Location.Height / 2 + 16
                    End If
                    
                    If .Special3 = 0 Then PlaySound 34
                    numNPCs = numNPCs + 1
                    With NPC(numNPCs)
                        .Active = True
                        .TimeLeft = 100
                        .Direction = NPC(A).Direction
                        .Section = NPC(A).Section
                        .Type = 269
                        .Location.Width = 10
                        .Location.Height = 8
                        .Frame = 3
                        .Special2 = NPC(A).Special3
                        If .Direction = -1 Then
                            .Location.X = NPC(A).Location.X - 20
                        Else
                            .Location.X = NPC(A).Location.X + NPC(A).Location.Width - .Location.Width + 20
                        End If
                        .Location.Y = NPC(A).Location.Y + 47
                        .Location.SpeedX = 3 * .Direction
                        C = (.Location.X + .Location.Width / 2) - NPC(A).Special6
                        D = (.Location.Y + .Location.Height / 2) - NPC(A).Special4
                        .Location.SpeedY = D / C * .Location.SpeedX
                        If .Location.SpeedY > 3 Then
                            .Location.SpeedY = 3
                        ElseIf .Location.SpeedY < -3 Then
                            .Location.SpeedY = -3
                        End If
                    End With
                End If
                .Special3 = .Special3 + 1
                If .Special3 >= 30 Then
                    .Special = 0
                    .Special4 = 0
                    .Special5 = 0
                    .Special6 = 0
                End If
            End If
            
'ludwig koopa
        ElseIf .Type = 280 Then
            'special is phase
            'special5 is targetted player
            'special3 is jump counter
            'special2 is direction
            
            'special4 is attack timer
            'special3 is attack count
            
            If .Inert = True Then
                .Special4 = 0
                .Special3 = 0
                .Special6 = 0
            End If
            If .Special5 = 0 Then 'Target a Random Player
                C = 0
                Do
                    B = Int(Rnd) * numPlayers + 1
                    If Player(B).Dead = False And Player(B).Section = .Section And Player(B).TimeToLive = 0 Then
                        .Special5 = B
                    End If
                    C = C + 1
                    If C >= 20 Then .Special5 = 1
                Loop Until .Special5 > 0
            End If
            
                If Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 < .Location.X + .Location.Width / 2 Then
                    .Direction = -1
                Else
                    .Direction = 1
                End If
                If .Special2 = 0 Then .Special2 = .Direction
            
            If .Special = 0 Then
                If (.Damage < 5 And .Special6 > 60) Or (.Damage < 10 And .Special6 > 80) Or .Inert = True Then
                    If .Special2 = -1 Then
                        .Location.SpeedX = -1.5
                    Else
                        .Location.SpeedX = 1.5
                    End If
                    'movement
                    If .Location.X < Player(.Special5).Location.X - 400 Then
                        .Special2 = 1
                    ElseIf .Location.X > Player(.Special5).Location.X + 400 Then
                        .Special2 = -1
                    End If
                Else
                    .Location.SpeedX = .Location.SpeedX * 0.98
                    If .Location.SpeedY = Physics.NPCGravity Then .Location.SpeedX = 0
                
                End If
                'attack timer
                If .Location.SpeedY = Physics.NPCGravity Then .Special6 = .Special6 + 1
                If .Special6 = 20 Or .Special6 = 40 Or .Special6 = 60 Or (.Damage >= 5 And .Special6 = 80) Or (.Damage >= 10 And .Special6 = 100) Then
                    .Special = 1
                    .Special5 = 0
                    .Special3 = 0
                    .Special4 = 0
                End If
                If .Damage >= 10 And .Special = 0 And .Special6 >= 100 Then .Special6 = 200
                If .Special6 >= 160 And .Location.SpeedY = Physics.NPCGravity Then
                    .Special6 = 0
                    .Special = 3
                    PlaySound 24
                    .Location.SpeedY = -7 - Rnd * 2
                End If
            ElseIf .Special = 3 Then
                    If .Location.SpeedY > 0 Then 'turn into shell
                        .Special = 1
                        .Special2 = 0
                        .Special3 = 0
                        .Special4 = 0
                        .Special5 = 0
                        .Special6 = 0
                        .Location.X = .Location.X + .Location.Width / 2
                        .Location.Y = .Location.Y + .Location.Height
                        .Type = 281
                        .Location.Width = NPCWidth(.Type)
                        .Location.Height = NPCHeight(.Type)
                        .Location.X = .Location.X - .Location.Width / 2
                        .Location.Y = .Location.Y - .Location.Height
                    Else
                        .Location.SpeedX = .Location.SpeedX + 0.2 * .Special2
                        If .Location.SpeedX > 5 Then
                            .Location.SpeedX = 5
                        ElseIf .Location.SpeedX < -5 Then
                            .Location.SpeedX = -5
                        End If
                    End If
            ElseIf .Special = 1 Or .Special = 2 Then
                If Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 < .Location.X + .Location.Width / 2 Then
                    .Direction = -1
                Else
                    .Direction = 1
                End If
                .Special2 = .Direction
                .Location.SpeedX = 0
                If .Special3 = 20 Then 'shoot
                    PlaySound 42
                    numNPCs = numNPCs + 1
                    With NPC(numNPCs)
                        .Active = True
                        .TimeLeft = 100
                        .Direction = NPC(A).Direction
                        .Section = NPC(A).Section
                        .Type = 282
                        .Location.Width = NPCWidth(.Type)
                        .Location.Height = NPCHeight(.Type)
                        .Frame = 0
                        If .Direction = -1 Then
                            .Location.X = NPC(A).Location.X - 24
                        Else
                            .Location.X = NPC(A).Location.X + NPC(A).Location.Width - .Location.Width + 24
                        End If
                        .Location.Y = NPC(A).Location.Y + 4
                        .Location.SpeedX = 4 * .Direction
                        C = (.Location.X + .Location.Width / 2) - (Player(NPC(A).Special5).Location.X + Player(NPC(A).Special5).Location.Width / 2)
                        D = (.Location.Y + .Location.Height / 2) - (Player(NPC(A).Special5).Location.Y + Player(NPC(A).Special5).Location.Height / 2)
                        .Location.SpeedY = D / C * .Location.SpeedX
                        If .Location.SpeedY > 2 Then
                            .Location.SpeedY = 2
                        ElseIf .Location.SpeedY < -2 Then
                            .Location.SpeedY = -2
                        End If
                    End With
                End If
                .Special3 = .Special3 + 1
                If .Special3 < 20 Then
                    .Special = 1
                Else
                    .Special = 2
                End If
                
                If .Special3 >= 40 Then
                    .Special = 0
                    .Special5 = 0
                    .Special3 = 0
                    .Special4 = 0
                End If
            End If
            
            
            
        ElseIf .Type = 266 Then 'link sword beam
            .Special = .Special + 1
            If .Special = 40 Then
                .Killed = 9
                For B = 1 To 4
                    tempLocation.Height = EffectHeight(80)
                    tempLocation.Width = EffectWidth(80)
                    tempLocation.SpeedX = 0
                    tempLocation.SpeedY = 0
                    tempLocation.X = .Location.X + Rnd * 16 - EffectWidth(80) / 2 - 4 '+ .Location.SpeedX
                    tempLocation.Y = .Location.Y + Rnd * 4 - EffectHeight(80) / 2 - 2
                    NewEffect 80, tempLocation
                    Effect(numEffects).Location.SpeedX = .Location.SpeedX * 0.3 + Rnd * 2 - 1
                    Effect(numEffects).Location.SpeedY = Rnd * 1 - 0.5
                    Effect(numEffects).Frame = Int(Rnd * 3)
                Next B
                
            End If
            If Rnd * 10 > 5 Then
                tempLocation.Height = EffectHeight(80)
                tempLocation.Width = EffectWidth(80)
                tempLocation.SpeedX = 0
                tempLocation.SpeedY = 0
                tempLocation.X = .Location.X + Rnd * 16 - EffectWidth(80) / 2 - 4 '+ .Location.SpeedX
                tempLocation.Y = .Location.Y + Rnd * 4 - EffectHeight(80) / 2 - 2
                NewEffect 80, tempLocation
                Effect(numEffects).Location.SpeedX = .Location.SpeedX * 0.15
                Effect(numEffects).Location.SpeedY = .Location.SpeedY '+ Rnd * 2 - 1
                Effect(numEffects).Frame = Int(Rnd * 2) + 1
            End If
            
            
        ElseIf .Type = 262 Then 'mouser
            If .Immune = 0 Then
                C = 0
                For B = 1 To numPlayers
                    If Player(B).Dead = False And Player(B).Section = .Section Then
                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                            If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                                .Direction = -1
                            Else
                                .Direction = 1
                            End If
                        End If
                    End If
                Next B
            Else
                If Rnd * 100 > 90 Then .Direction = -.Direction
                .Special3 = 0
                .Special4 = 0
            End If
            If .Immune <> 0 Then
                .Location.SpeedX = 0
            ElseIf .Special = 0 Then
                If .Location.SpeedY = Physics.NPCGravity Then
                    If .Special2 = 0 Then .Special2 = .Direction
                    .Location.SpeedX = 2 * .Special2
                    If .Location.X < .DefaultLocation.X - 64 Then
                        .Special2 = 1
                    ElseIf .Location.X > .DefaultLocation.X + 64 Then
                        .Special2 = -1
                    End If
                    .Special3 = .Special3 + 1
                    .Special4 = .Special4 + 1
                    If .Special3 >= 100 + Rnd * 200 Then
                        .Special3 = 0
                        .Location.SpeedX = 0
                        .Location.SpeedY = -5
                    ElseIf .Special4 >= 20 + Rnd * 200 Then
                        .Special4 = 0
                        .Special = -10
                    End If
                Else
                    .Location.SpeedX = 0
                End If
            Else
                If .Special = -1 Then
                    .Special = 20
                    numNPCs = numNPCs + 1
                    With NPC(numNPCs)
                        .Layer = "Spawned NPCs"
                        .Active = True
                        .Direction = NPC(A).Direction
                        .Type = 134
                        .Location.Height = NPCHeight(.Type)
                        .Location.Width = NPCWidth(.Type)
                        .Location.Y = NPC(A).Location.Y + NPC(A).Location.Height - 48
                        .Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2 - .Location.Width / 2 - 12 * .Direction
                        .TimeLeft = 100
                        .Section = NPC(A).Section
                        .Location.SpeedX = (5 + Rnd * 3) * .Direction
                        .Location.SpeedY = -5 - (Rnd * 3)
                    End With
                End If
                .Location.SpeedX = 0
                If .Special < 0 Then
                    .Special = .Special + 1
                Else
                    .Special = .Special - 1
                End If
            End If
        
        ElseIf .Type = 261 Then 'muncher thing
            If .Special = 0 Then
                For B = 1 To numPlayers
                    If Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Section = .Section Then
                        tempLocation = .Location
                        tempLocation.Height = 256
                        tempLocation.Y = .Location.Y - tempLocation.Height
                        If CheckCollision(tempLocation, Player(B).Location) Then
                            .Special = 1
                            .Location.SpeedY = -7
                            .Location.SpeedX = 0
                        End If
                    End If
                Next B
            ElseIf .Location.SpeedY = Physics.NPCGravity Then
                .Special = 0
            End If
            
            If .Stuck = False And .Special = 0 Then
                If .Special2 = 0 Then
                    If .Location.X < .DefaultLocation.X - 128 And .Direction = -1 Then
                        .Special2 = 60
                    ElseIf .Location.X > .DefaultLocation.X + 128 And .Direction = 1 Then
                        .Special2 = 60
                    End If
                    .Location.SpeedX = 1.4 * .Direction
                    If .Location.SpeedY = Physics.NPCGravity Then .Location.SpeedY = -1.5
                Else
                    .Special2 = .Special2 - 1
                    If .Location.SpeedY = Physics.NPCGravity Then .Location.SpeedX = 0
                    If .Special2 = 0 Then
                        If .Location.X < .DefaultLocation.X Then
                            .Direction = 1
                        Else
                            .Direction = -1
                        End If
                    End If
                End If
            End If
            

            
            
        ElseIf .Type = 260 Then 'Firebar
            C = 0.03 * .DefaultSpecial
            B = 0.98 * .DefaultSpecial
            If .Special2 = 0 Then
                .Location.SpeedX = .Location.SpeedX + C
                .Location.SpeedY = .Location.SpeedY + C * .DefaultDirection
                If .Special5 = 0 Then
                    .Special5 = 1
                    .Location.SpeedX = -B
                    .Location.SpeedY = 0
                End If
                If .Location.SpeedX >= -0.001 Then
                    .Special2 = .Special2 + 1 * .DefaultDirection
                    If .Special2 <= 0 Then .Special2 = 3
                    .Special5 = 0
                End If
            ElseIf .Special2 = 1 Then
                .Location.SpeedX = .Location.SpeedX + C * .DefaultDirection
                .Location.SpeedY = .Location.SpeedY - C
                If .Special5 = 0 Then
                    .Special5 = 1
                    .Location.SpeedY = B
                    .Location.SpeedX = 0
                End If
                If .Location.SpeedY <= 0.001 Then
                    .Special2 = .Special2 + 1 * .DefaultDirection
                    .Special5 = 0
                End If
            ElseIf .Special2 = 2 Then
                .Location.SpeedX = .Location.SpeedX - C
                .Location.SpeedY = .Location.SpeedY - C * .DefaultDirection
                If .Special5 = 0 Then
                    .Special5 = 1
                    .Location.SpeedX = B
                    .Location.SpeedY = 0
                End If
                If .Location.SpeedX <= 0.001 Then
                    .Special2 = .Special2 + 1 * .DefaultDirection
                    .Special5 = 0
                End If
            ElseIf .Special2 = 3 Then
                .Location.SpeedX = .Location.SpeedX - C * .DefaultDirection
                .Location.SpeedY = .Location.SpeedY + C
                If .Special5 = 0 Then
                    .Special5 = 1
                    .Location.SpeedY = -B
                    .Location.SpeedX = 0
                End If
                If .Location.SpeedY >= -0.001 Then
                    .Special2 = .Special2 + 1 * .DefaultDirection
                    If .Special2 > 3 Then .Special2 = 0
                    .Special5 = 0
                End If
            End If
            
        ElseIf .Type = 259 Then 'Roto-Disk
            C = 0.2 '* .DefaultDirection
            B = 6.05 '* .DefaultDirection
            .Special4 = .Special4 + 1
            If .Special4 = 4 Then
                NewEffect 136, .Location
                Effect(numEffects).Frame = .Frame
                Effect(numEffects).Location.SpeedX = 0
                Effect(numEffects).Location.SpeedY = 0
                .Special4 = 0
            End If
            If .Special = 0 Then
                .Location.SpeedX = .Location.SpeedX + C
                .Location.SpeedY = .Location.SpeedY + C * .DefaultDirection
                If .Special5 = 0 Then
                    .Special5 = 1
                    .Location.SpeedX = -B
                    .Location.SpeedY = 0
                End If
                If .Location.SpeedX >= 0 Then
                    .Special = .Special + 1 * .DefaultDirection
                    If .Special < 0 Then .Special = 3
                    .Special5 = 0
                End If
            ElseIf .Special = 1 Then
                .Location.SpeedX = .Location.SpeedX + C * .DefaultDirection
                .Location.SpeedY = .Location.SpeedY - C
                If .Special5 = 0 Then
                    .Special5 = 1
                    .Location.SpeedY = B
                    .Location.SpeedX = 0
                End If
                If .Location.SpeedY <= 0 Then
                    .Special = .Special + 1 * .DefaultDirection
                    .Special5 = 0
                End If
            ElseIf .Special = 2 Then
                .Location.SpeedX = .Location.SpeedX - C
                .Location.SpeedY = .Location.SpeedY - C * .DefaultDirection
                If .Special5 = 0 Then
                    .Special5 = 1
                    .Location.SpeedX = B
                    .Location.SpeedY = 0
                End If
                If .Location.SpeedX <= 0 Then
                    .Special = .Special + 1 * .DefaultDirection
                    .Special5 = 0
                End If
            ElseIf .Special = 3 Then
                .Location.SpeedX = .Location.SpeedX - C * .DefaultDirection
                .Location.SpeedY = .Location.SpeedY + C
                
                If .Special5 = 0 Then
                    .Special5 = 1
                    .Location.SpeedY = -B
                    .Location.SpeedX = 0
                End If
                If .Location.SpeedY >= 0 Then
                    .Special = .Special + 1 * .DefaultDirection
                    If .Special > 3 Then .Special = 0
                    .Special5 = 0
                End If
            End If
            
            
        ElseIf .Type = 255 Then
            For B = 1 To numNPCs
                If NPC(B).Type = 31 Then
                    If NPC(B).Active = True Then
                        If NPC(B).HoldingPlayer <> 0 Then
                            If CheckCollision(.Location, NPC(B).Location) Then
                                NPC(B).Killed = 9
                                NewEffect 10, NPC(B).Location
                                .Killed = 3
                            End If
                        End If
                    End If
                End If
            Next B
        ElseIf .Type = 209 Then 'Mother Brain
            If .Special >= 1 Then
                B = 1 - (.Special / 45)
                C = B * 0.5
                B = B * 15
                C = C * 15
                .Location.X = .DefaultLocation.X + Rnd * B - Rnd * C
                .Location.Y = .DefaultLocation.Y + Rnd * B - Rnd * C
                .Special = .Special + 1
                If .Special >= 45 Then .Special = 0
            Else
                .Location = .DefaultLocation
            End If
        ElseIf .Type = 210 Then 'O thing
            If .Special = 0 Then
                .Special2 = .Special2 + 1
                If .Special2 >= 80 + Rnd * 20 Then
                    .Special = 1
                    C = 0
                    For B = 1 To numPlayers
                        If Player(B).Dead = False And Player(B).Section = .Section Then
                            If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                D = B
                            End If
                        End If
                    Next B
                    B = D
                    C = (.Location.X + .Location.Width / 2) - (Player(B).Location.X + Player(B).Location.Width / 2)
                    D = (.Location.Y + .Location.Height / 2) - (Player(B).Location.Y + Player(B).Location.Height / 2)
                    E = Sqr(C ^ 2 + D ^ 2)
                    C = -C / E
                    D = -D / E
                    .Location.SpeedX = C * 3
                    .Location.SpeedY = D * 3
                End If
            End If
        
        ElseIf .Type = 211 Then 'Metroid O shooter thing
            .Special = .Special + 1 + Rnd
            If .Special >= 200 + Rnd * 200 Then
                .Special = 0
                numNPCs = numNPCs + 1
                NPC(numNPCs).Inert = .Inert
                NPC(numNPCs).Location.Height = 32
                NPC(numNPCs).Location.Width = 28
                NPC(numNPCs).Location.X = .Location.X + 2
                NPC(numNPCs).Location.Y = .Location.Y
                NPC(numNPCs).Section = .Section
                NPC(numNPCs).Layer = "Spawned NPCs"
                NPC(numNPCs).Type = 210
                NPC(numNPCs).Active = True
                NPC(numNPCs).TimeLeft = 50
            End If
        ElseIf .Type = 206 Or .Type = 205 Or .Type = 207 Then 'sparky
            If .Type = 206 Then
                F = 2
            Else
                F = 1
            End If
            tempBool = False
            tempBool2 = False
            If .Special = 0 Then
                If .Direction = 0 Then
                    If Rnd * 2 > 1 Then
                        .Direction = 1
                    Else
                        .Direction = -1
                    End If
                End If
                
                .Special = 1
                .Special2 = .Direction
            End If
            If .Slope > 0 Then
                If .Special = 2 Then
                    .Special2 = 1
                    .Special = 1
                ElseIf .Special = 4 Then
                    .Special2 = -1
                    .Special = 1
                End If
            End If
            
            .Special5 = .Special5 + 1
            If .Special5 >= 8 And .Special = 1 Then
                .Special5 = 8
                .Special = 0
                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity
                If .Location.SpeedY > 8 Then .Location.SpeedY = 8
            End If
            If .Special = 1 Then
                .Location.SpeedY = F * Abs(.Special2)
                .Location.SpeedX = F * .Special2
                tempBool = False
                tempLocation.Width = 2
                tempLocation.Height = 2
                tempLocation.X = .Location.X + .Location.Width / 2 - 1 + 18 * .Special2
                tempLocation.Y = .Location.Y + .Location.Height / 2 - 1
                fBlock = FirstBlock(Int(tempLocation.X / 32) - 1)
                lBlock = LastBlock(Int((tempLocation.X + tempLocation.Width) / 32) + 1)
                For B = fBlock To lBlock
                    If Block(B).Hidden = False And BlockNoClipping(Block(B).Type) = False And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False Then
                        If CheckCollision(tempLocation, Block(B).Location) = True And BlockSlope(Block(B).Type) = 0 Then
                            If .Special2 = 1 Then
                                .Location.SpeedY = 0
                                .Special = 2
                                .Special2 = -1
                            Else
                                .Location.SpeedY = 0
                                .Special = 4
                                .Special2 = -1
                            End If
                            tempBool = True
                            Exit For
                        End If
                    End If
                Next B
                If tempBool = False Then
                    tempLocation.Width = .Location.Width + 2
                    tempLocation.Height = 8
                    tempLocation.X = .Location.X
                    tempLocation.Y = .Location.Y + .Location.Height
                    fBlock = FirstBlock(Int(tempLocation.X / 32) - 1)
                    lBlock = LastBlock(Int((tempLocation.X + tempLocation.Width) / 32) + 1)
                    For B = fBlock To lBlock
                        If Block(B).Hidden = False And BlockNoClipping(Block(B).Type) = False And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False Then
                            If CheckCollision(tempLocation, Block(B).Location) = True Then
                                .Special3 = B
                                tempBool2 = True
                                Exit For
                            End If
                        End If
                    Next B
                    If tempBool2 = False Then
                        If .Special2 = 1 Then
                            If .Special3 > 0 Then
                                .Location.X = Block(.Special3).Location.X + Block(.Special3).Location.Width + 2
                                .Location.Y = .Location.Y + 2
                            End If
                            .Special = 4
                            .Special2 = 1
                        Else
                            .Special = 2
                            .Special2 = 1
                        End If
                    End If
                End If
            ElseIf .Special = 2 Then
                .Location.SpeedY = F * .Special2
                .Location.SpeedX = Abs(.Special2)
                tempBool = False
                tempLocation.Width = 2
                tempLocation.Height = 2
                tempLocation.X = .Location.X + .Location.Width / 2 - 1
                tempLocation.Y = .Location.Y + .Location.Height / 2 - 1 + 18 * .Special2
                fBlock = FirstBlock(Int(tempLocation.X / 32) - 1)
                lBlock = LastBlock(Int((tempLocation.X + tempLocation.Width) / 32) + 1)
                For B = fBlock To lBlock
                    If Block(B).Hidden = False And BlockNoClipping(Block(B).Type) = False And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False Then
                        If CheckCollision(tempLocation, Block(B).Location) = True Then
                            If .Special2 = 1 Then
                                .Special = 1
                                .Special2 = -1
                            Else
                                .Special = 3
                                .Special2 = -1
                            End If
                            tempBool = True
                            Exit For
                        End If
                    End If
                Next B
                If tempBool = False Then
                    tempLocation.Width = 8
                    tempLocation.Height = .Location.Height
                    tempLocation.Y = .Location.Y
                    tempLocation.X = .Location.X + .Location.Width
                    fBlock = FirstBlock(Int(tempLocation.X / 32) - 1)
                    lBlock = LastBlock(Int((tempLocation.X + tempLocation.Width) / 32) + 1)
                    For B = fBlock To lBlock
                        If Block(B).Hidden = False And BlockNoClipping(Block(B).Type) = False And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False Then
                            If CheckCollision(tempLocation, Block(B).Location) = True Then
                                tempBool2 = True
                                Exit For
                            End If
                        End If
                    Next B
                    If tempBool2 = False Then
                        If .Special2 = 1 Then
                            .Special = 3
                            .Special2 = 1
                        Else
                            .Special = 1
                            .Special2 = 1
                        End If
                    End If
                End If
            ElseIf .Special = 3 Then
                .Location.SpeedY = -Abs(.Special2)
                .Location.SpeedX = F * .Special2
                tempBool = False
                tempLocation.Width = 2
                tempLocation.Height = 2
                tempLocation.X = .Location.X + .Location.Width / 2 - 1 + 18 * .Special2
                tempLocation.Y = .Location.Y + .Location.Height / 2 - 1
                fBlock = FirstBlock(Int(tempLocation.X / 32) - 1)
                lBlock = LastBlock(Int((tempLocation.X + tempLocation.Width) / 32) + 1)
                For B = fBlock To lBlock
                    If Block(B).Hidden = False And BlockNoClipping(Block(B).Type) = False And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False Then
                        If CheckCollision(tempLocation, Block(B).Location) = True And BlockSlope2(Block(B).Type) = 0 Then
                            If .Special2 = 1 Then
                                .Special = 2
                                .Special2 = 1
                            Else
                                .Special = 4
                                .Special2 = 1
                            End If
                            tempBool = True
                            Exit For
                        End If
                    End If
                Next B
                If tempBool = False Then
                    tempLocation.Width = .Location.Width
                    tempLocation.Height = 8
                    tempLocation.X = .Location.X
                    tempLocation.Y = .Location.Y - 8
                    fBlock = FirstBlock(Int(tempLocation.X / 32) - 1)
                    lBlock = LastBlock(Int((tempLocation.X + tempLocation.Width) / 32) + 1)
                    For B = fBlock To lBlock
                        If Block(B).Hidden = False And BlockNoClipping(Block(B).Type) = False And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False Then
                            If CheckCollision(tempLocation, Block(B).Location) = True Then
                                tempBool2 = True
                                If BlockSlope2(Block(B).Type) <> 0 Then .Location.SpeedY = .Location.SpeedY * F
                            End If
                        End If
                    Next B
                    If tempBool2 = False Then
                        If .Special2 = 1 Then
                            .Special = 4
                            .Special2 = -1
                        Else
                            .Special = 2
                            .Special2 = -1
                        End If
                    End If
                End If
            ElseIf .Special = 4 Then
                .Location.SpeedY = F * .Special2
                .Location.SpeedX = -Abs(.Special2)
                tempBool = False
                tempLocation.Width = 2
                tempLocation.Height = 2
                tempLocation.X = .Location.X + .Location.Width / 2 - 1
                tempLocation.Y = .Location.Y + .Location.Height / 2 - 1 + 18 * .Special2
                fBlock = FirstBlock(Int(tempLocation.X / 32) - 1)
                lBlock = LastBlock(Int((tempLocation.X + tempLocation.Width) / 32) + 1)
                For B = fBlock To lBlock
                    If Block(B).Hidden = False And BlockNoClipping(Block(B).Type) = False And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False Then
                        If CheckCollision(tempLocation, Block(B).Location) = True And BlockSlope2(Block(B).Type) = 0 Then
                            If .Special2 = 1 Then
                                .Special = 1
                                .Special2 = 1
                            Else
                                .Special = 3
                                .Special2 = 1
                            End If
                            tempBool = True
                            Exit For
                        End If
                    End If
                Next B
                If tempBool = False Then
                    tempLocation.Width = 8
                    tempLocation.Height = .Location.Height
                    tempLocation.Y = .Location.Y
                    tempLocation.X = .Location.X - 8
                    fBlock = FirstBlock(Int(tempLocation.X / 32) - 1)
                    lBlock = LastBlock(Int((tempLocation.X + tempLocation.Width) / 32) + 1)
                    For B = fBlock To lBlock
                        If Block(B).Hidden = False And BlockNoClipping(Block(B).Type) = False And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False Then
                            If CheckCollision(tempLocation, Block(B).Location) = True Then
                                tempBool2 = True
                                Exit For
                            End If
                        End If
                    Next B
                    If tempBool2 = False Then
                        If .Special2 = 1 Then
                            .Special = 3
                            .Special2 = -1
                        Else
                            .Special = 1
                            .Special2 = -1
                        End If
                    End If
                End If
            End If
                
        
        
                        ElseIf .Type = 201 Then ' Wart
                            .Direction = .DefaultDirection
                            If .Immune > 0 Then .Special = 2
                            If .Damage >= 30 Then
                                If .Special <> 3 Then
                                    PlaySound 63
                                End If
                                .Special = 3
                            End If
                            If .Special = 0 Then
                                .Special3 = .Special3 + 1
                                If .Special3 >= 160 + Rnd * 140 Then
                                    .Special = 1
                                    .Special3 = 0
                                End If
                                
                                If .Special2 = 1 Then
                                    .Location.SpeedX = 1
                                    If .Location.X > .DefaultLocation.X + .Location.Width * 1 Then .Special2 = -1
                                ElseIf .Special2 = -1 Then
                                    .Location.SpeedX = -1
                                    If .Location.X < .DefaultLocation.X - .Location.Width * 1 Then .Special2 = 1
                                Else
                                    .Special2 = .Direction
                                End If
                            ElseIf .Special = 1 Then
                                .Location.SpeedX = 0
                                If .Special3 = 0 Then PlaySound 62
                                .Special3 = .Special3 + 1
                                If .Special3 Mod 10 = 0 Then
                                    numNPCs = numNPCs + 1
                                    NPC(numNPCs).Inert = .Inert
                                    NPC(numNPCs).Location.Height = 32
                                    NPC(numNPCs).Location.Width = 32
                                    NPC(numNPCs).Location.X = .Location.X + .Location.Width / 2 - 16 + (32 * .Direction)
                                    NPC(numNPCs).Location.Y = .Location.Y + 18
                                    NPC(numNPCs).Direction = .Direction
                                    NPC(numNPCs).Type = 202
                                    NPC(numNPCs).Active = True
                                    NPC(numNPCs).TimeLeft = 50
                                    NPC(numNPCs).Location.SpeedY = -7
                                    NPC(numNPCs).Location.SpeedX = 7 * NPC(numNPCs).Direction
                                    NPC(numNPCs).Location.SpeedY = NPC(numNPCs).Location.SpeedY + Rnd * 6 - 3
                                    NPC(numNPCs).Location.SpeedX = NPC(numNPCs).Location.SpeedX * (1 - (.Special3 / 140))
                                End If
                                If .Special3 >= 120 + Rnd * 40 Then
                                    .Special = 0
                                    .Special3 = 0
                                End If
                            ElseIf .Special = 2 Then
                                .Location.SpeedX = 0
                                .Special4 = .Special4 + 1
                                If .Special4 >= 120 Then
                                    .Special4 = 0
                                    .Special = 0
                                End If
                            ElseIf .Special = 3 Then
                                .Location.SpeedX = 0
                                .Special4 = .Special4 + 1
                                If .Special4 >= 120 Then .Killed = 3
                            End If
                            
'Platform movement
                        ElseIf .Type = 60 Or .Type = 62 Or .Type = 64 Or .Type = 66 Or .Type = 104 Or .Type = 179 Then
                        straightLine = False
                            tempBool = False
                            For B = 1 To numPlayers
                                If Player(B).Section = .Section Then tempBool = True
                            Next B
                            If .Type = 179 Then
                                .Location.X = .Location.X - 24
                                .Location.Width = 96
                                .Location.Y = .Location.Y + 8
                                .Location.Height = 32
                            End If
                            If .Direction = 1 And tempBool = True Or .Type = 179 Then
                                .Location.SpeedY = .Special
                                .Location.SpeedX = .Special2
                                tempBool = False
                                tempBool2 = False
                                tempLocation = .Location
                                tempLocation.Y = .Location.Y + 15
                                tempLocation.Height = 2
                                tempLocation.X = .Location.X + 47
                                tempLocation.Width = 2
                                C = 2 'The Speed
                                D = 0
                                E = 0
                                F = 0
                                tempNPC = NPC(A)
                                For B = 1 To numBackground
                                    If (Background(B).Type >= 70 And Background(B).Type <= 74) Or Background(B).Type = 100 Then
                                        If Background(B).Hidden = False Then
                                            If CheckCollision(tempLocation, Background(B).Location) Then
                                                If F > 0 Then
                                                    If Background(B).Type = .Special5 Or Background(B).Type = 70 Or Background(B).Type = 100 Then
                                                        F = 0
                                                        E = 0
                                                        D = 0
                                                        NPC(A) = tempNPC
                                                    End If
                                                End If
                                                If F = 0 Then
                                                    If Background(B).Type = 72 Then
                                                        If .Location.SpeedY <= 0 Then
                                                            .Location.SpeedY = -C
                                                        Else
                                                            .Location.SpeedY = C
                                                        End If
                                                        .Location.SpeedX = 0
                                                        E = -.Location.X + Background(B).Location.X - 32
                                                    ElseIf Background(B).Type = 71 Then
                                                        If .Location.SpeedX >= 0 Then
                                                            .Location.SpeedX = C
                                                        Else
                                                            .Location.SpeedX = -C
                                                        End If
                                                        .Location.SpeedY = 0
                                                        D = -.Location.Y + Background(B).Location.Y
                                                    ElseIf Background(B).Type = 73 Then
                                                        If .Location.SpeedY < 0 Then
                                                            .Location.SpeedX = C
                                                        ElseIf .Location.SpeedY > 0 Then .Location.SpeedX = -C
                                                        End If
                                                        If .Location.SpeedX > 0 Then
                                                            .Location.SpeedY = -C
                                                        ElseIf .Location.SpeedX < 0 Then .Location.SpeedY = C
                                                        End If
                                                    ElseIf Background(B).Type = 74 Then
                                                        If .Location.SpeedY < 0 Then
                                                            .Location.SpeedX = -C
                                                        ElseIf .Location.SpeedY > 0 Then .Location.SpeedX = C
                                                        End If
                                                        If .Location.SpeedX > 0 Then
                                                            .Location.SpeedY = C
                                                        ElseIf .Location.SpeedX < 0 Then .Location.SpeedY = -C
                                                        End If
                                                    ElseIf Background(B).Type = 70 Or Background(B).Type = 100 Then
                                                        .Location.SpeedX = -.Location.SpeedX
                                                        .Location.SpeedY = -.Location.SpeedY
                                                        tempBool = True
                                                        Exit For
                                                    End If
                                                    tempBool = True
                                                    F = Background(B).Type
                                                End If
                                            End If
                                        End If
                                    End If
                                Next B
                                .Special5 = F
                                If tempBool = False Then
                                
                                    If .Type = 104 And .Wet = 2 Then
                                        .Location.SpeedY = .Location.SpeedY - Physics.NPCGravity * 0.25
                                    Else
                                        .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity
                                    End If
                                Else
                                    .Location.SpeedX = .Location.SpeedX + E
                                    .Location.SpeedY = .Location.SpeedY + D
                                End If
                                .Special = .Location.SpeedY
                                .Special2 = .Location.SpeedX
                                For B = 1 To numPlayers
                                    If Not (Player(B).Effect = 0 Or Player(B).Effect = 3 Or Player(B).Effect = 9 Or Player(B).Effect = 10) Then
                                        .Location.SpeedX = 0
                                        .Location.SpeedY = 0
                                    End If
                                Next B
                            Else
                                .Location.SpeedX = 0
                                .Location.SpeedY = 0
                            End If
                            Block(.tempBlock).Location = .Location
                            Block(.tempBlock).Location.X = Block(.tempBlock).Location.X + .Location.SpeedX
                            If .Location.SpeedY < 0 Then Block(.tempBlock).Location.Y = Block(.tempBlock).Location.Y + .Location.SpeedY
                            If .Type = 179 Then
                                .Location.X = .Location.X + 24
                                .Location.Width = 48
                                .Location.Y = .Location.Y - 8
                                .Location.Height = 48
                                
                                If .Location.SpeedX = 0 And .Location.SpeedY = Physics.NPCGravity Then
                                    .Location.SpeedX = C * .Direction
                                    .Special2 = .Location.SpeedX
                                End If
                                
                            End If
                        ElseIf .Type = 200 Then 'King Koopa
                            C = 0
                            For B = 1 To numPlayers
                                If Player(B).Dead = False And Player(B).Section = .Section Then
                                    If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                        C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                        D = B
                                    End If
                                End If
                            Next B
                            If Player(D).Location.X + Player(D).Location.Width / 2 > .Location.X + 16 Then
                                .Direction = 1
                            Else
                                .Direction = -1
                            End If
                            .Special5 = D

                            If Rnd * 300 > 297 And .Special = 0 Then
                                .Special = 1
                            End If
                            .Special4 = .Special4 + 1
                            If .Inert = True Then .Special4 = 150
                            
                            If .Special4 <= 80 + Rnd * 40 Then
                                If Rnd * 100 > 40 And .Special4 Mod 16 = 0 Then
                                    PlaySound 25
                                    numNPCs = numNPCs + 1
                                    NPC(numNPCs).Inert = .Inert
                                    NPC(numNPCs).Location.Height = 32
                                    NPC(numNPCs).Location.Width = 32
                                    NPC(numNPCs).Location.X = .Location.X + .Location.Width / 2 - 16
                                    NPC(numNPCs).Location.Y = .Location.Y - 32
                                    NPC(numNPCs).Direction = .Direction
                                    NPC(numNPCs).Type = 30
                                    NPC(numNPCs).Active = True
                                    NPC(numNPCs).TimeLeft = 50
                                    NPC(numNPCs).Layer = "Spawned NPCs"
                                    NPC(numNPCs).Location.SpeedY = -8
                                    NPC(numNPCs).Location.SpeedX = 3 * NPC(numNPCs).Direction
                                End If
                            ElseIf .Special4 > 300 + Rnd * 50 Then
                                .Special4 = 0
                            End If
                            If .Inert = True Then .Special = 0
                            If .Special > 0 Then
                                .Special3 = .Special3 + 1
                                If .Special3 < 40 Then
                                    .Special = 1
                                ElseIf .Special3 < 70 Then
                                    If .Special3 = 40 Then
                                        numNPCs = numNPCs + 1
                                        With NPC(numNPCs)
                                            .Active = True
                                            .TimeLeft = 100
                                            .Direction = NPC(A).Direction
                                            .Section = NPC(A).Section
                                            .Layer = "Spawned NPCs"
                                            .Type = 87
                                            If .Direction = 1 Then .Frame = 4
                                            .Location.Height = 32
                                            .Location.Width = 48
                                            If .Direction = -1 Then
                                                .Location.X = NPC(A).Location.X - 40
                                            Else
                                                .Location.X = NPC(A).Location.X + 54
                                            End If
                                            .Location.Y = NPC(A).Location.Y + 19
                                            .Location.SpeedX = 4 * .Direction
                                            C = (.Location.X + .Location.Width / 2) - (Player(NPC(A).Special5).Location.X + Player(NPC(A).Special5).Location.Width / 2)
                                            D = (.Location.Y + .Location.Height / 2) - (Player(NPC(A).Special5).Location.Y + Player(NPC(A).Special5).Location.Height / 2)
                                            .Location.SpeedY = D / C * .Location.SpeedX
                                            If .Location.SpeedY > 1 Then
                                                .Location.SpeedY = 1
                                            ElseIf .Location.SpeedY < -1 Then
                                                .Location.SpeedY = -1
                                            End If
                                            PlaySound 42
                                        End With
                                    End If
                                    .Special = 2
                                Else
                                    .Special = 0
                                    .Special3 = 0
                                End If
                            ElseIf .Special = 0 Then
                                If .Special2 = 0 Then
                                    .Location.SpeedX = -0.5
                                    If .Location.X < .DefaultLocation.X - .Location.Width * 1.5 Then .Special2 = 1
                                Else
                                    .Location.SpeedX = 0.5
                                    If .Location.X > .DefaultLocation.X + .Location.Width * 1.5 Then .Special2 = 0
                                End If
                                If .Location.SpeedY = Physics.NPCGravity Or .Slope > 0 Then
                                    If Rnd * 200 >= 198 Then
                                        .Location.SpeedY = -8
                                    End If
                                End If
                            End If
                            
                        
                        ElseIf .Type = 197 Then 'SMW Exit
                            If .Special = 0 Then
                                .Location.SpeedY = 2
                            Else
                                .Location.SpeedY = -2
                            End If
                            If .Location.Y <= .DefaultLocation.Y Then .Special = 0
                            If .Special2 = 0 Then
                                tempLocation = NPC(A).Location
                                tempLocation.Height = 8000
                                C = 0
                                For B = 1 To numBlock
                                    If CheckCollision(tempLocation, Block(B).Location) = True Then
                                        If C = 0 Then
                                            C = B
                                        Else
                                            If Block(B).Location.Y < Block(C).Location.Y Then C = B
                                        End If
                                    End If
                                Next B
                                If C > 0 Then
                                    .Special2 = Block(C).Location.Y + 4
                                End If
                            End If
                            For B = 1 To numPlayers
                                If Player(B).Section = .Section Then
                                    If Player(B).Location.Y + .Location.Height <= .Special2 Then
                                        If Player(B).Location.X + Player(B).Location.Width >= .Location.X + .Location.Width - 8 Then
                                            If Player(B).Location.X <= .Location.X + 80 Then
                                                If CheckCollision(Player(B).Location, .Location) = True Then
                                                    MoreScore Int((1 - (.Location.Y - .DefaultLocation.Y) / (.Special2 - .DefaultLocation.Y)) * 10) + 1, .Location
                                                    .Killed = 9
                                                    PlaySound 37
                                                End If
                                                FreezeNPCs = False
                                                TurnNPCsIntoCoins
                                                If numPlayers > 2 And nPlay.Online = False Then Player(1) = Player(A)
                                                LevelMacro = 7
                                                For C = 1 To numPlayers
                                                    If B <> C Then 'And DScreenType <> 5 Then
                                                        Player(C).Section = Player(B).Section
                                                        Player(C).Location.Y = Player(B).Location.Y + Player(B).Location.Height - Player(B).Location.Height
                                                        Player(C).Location.X = Player(B).Location.X + Player(B).Location.Width / 2 - Player(B).Location.Width / 2
                                                        Player(C).Location.SpeedX = 0
                                                        Player(C).Location.SpeedY = 0
                                                        Player(C).Effect = 8
                                                        Player(C).Effect2 = -B
                                                    End If
                                                Next C
                                                StopMusic
                                                DoEvents
                                                PlaySound 60
                                                Exit For
                                            End If
                                        End If
                                    End If
                                End If
                            Next B
                            
                        ElseIf .Type = 105 Then
                            If .Special = 1 Then
                                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity / 4
                                .Special = 0
                            Else
                                .Location.SpeedY = 0
                            End If
                        ElseIf .Type = 106 Then
                            .Location.SpeedY = .Direction * 2
    
                        ElseIf .Type = 199 Then
                            If .Special = 0 Then
                                tempLocation = .Location
                                tempLocation.Height = 400
                                tempLocation.Y = tempLocation.Y - tempLocation.Height
                                tempLocation.X = tempLocation.X + tempLocation.Width / 2
                                tempLocation.Width = 600
                                tempLocation.X = tempLocation.X - tempLocation.Width / 2
                                For B = 1 To numPlayers
                                    If CheckCollision(tempLocation, Player(B).Location) = True Then
                                        If Player(B).Location.X + Player(B).Location.Width / 2 < .Location.X + .Location.Width / 2 Then
                                            .Direction = -1
                                        Else
                                            .Direction = 1
                                        End If
                                        .Special = 1
                                        NewEffect 104, .Location, .Direction
                                        Exit For
                                    End If
                                Next B
                            ElseIf .Special = 1 Then
                                .Special2 = .Special2 + 1
                                If .Special2 = 90 Then
                                    .Location.SpeedX = 1 * .Direction
                                    .Location.SpeedY = -4.2
                                    .Special = 2
                                    PlaySound 61
                                End If
                            ElseIf .Special = 2 Then
                                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity * 0.4
                                If .Location.Y > .DefaultLocation.Y + .Location.Height + 48 Then
                                    Deactivate A
                                End If
                            End If
                            
                            
                        'End If
 'Sniffits
                        ElseIf .Type >= 130 And .Type <= 132 Then
                            If .Projectile = True Then
                                .Special = 0
                                .Special2 = 0
                            End If
                            tempBool = False
                            If .Type < 132 Then
                                .Special = .Special + 1
                                If .Special > 120 Then
                                    .FrameCount = .FrameCount - 1
                                    If .Special2 = 0 Then
                                        .Special2 = 1
                                        .Location.X = .Location.X - 2
                                    Else
                                        .Special2 = 0
                                        .Location.X = .Location.X + 2
                                    End If
                                    .Location.SpeedX = 0
                                    If .Special >= 150 Then
                                        tempBool = True
                                        .Special = 0
                                    End If
                                End If
                            Else
                                .Special = .Special + 1
                                If .Special > 160 Then
                                    tempBool = True
                                    If .Special3 <> 2 Then
                                        .Special3 = .Special3 - 1
                                        .Special = 0
                                    Else
                                        .Special = 140
                                        .Special3 = .Special3 - 1
                                        If .Location.SpeedY = Physics.NPCGravity Or .Slope > 0 Then .Special2 = 90
                                    End If
                                    If .Special3 < 0 Then .Special3 = 2
                                End If
                                If .Location.SpeedY = Physics.NPCGravity Or .Slope > 0 Then
                                    .Special2 = .Special2 + 1
                                    If .Special2 >= 100 Then
                                        .Special2 = 0
                                        .Location.SpeedY = -3.9
                                        .Location.Y = .Location.Y - Physics.NPCGravity
                                    End If
                                Else
                                    .FrameCount = .FrameCount - 1
                                End If
                            End If
                            If tempBool = True Then
                                numNPCs = numNPCs + 1
                                With NPC(numNPCs)
                                    .Active = True
                                    .Section = NPC(A).Section
                                    .TimeLeft = 100
                                    .Type = 133
                                    .Layer = NPC(A).Layer
                                    .Inert = NPC(A).Inert
                                    .Direction = NPC(A).Direction
                                    .Location.SpeedX = 4 * .Direction
                                    .Location.Width = 16
                                    .Location.Height = 16
                                    .Location.X = NPC(A).Location.X + 8 + 16 * .Direction
                                    .Location.Y = NPC(A).Location.Y + 13
                                End With
                            End If
                        End If
    
    End With
End Sub


Public Sub SpecialNPC(A As Integer)
    Dim B As Integer
    Dim C As Single
    Dim D As Single
    Dim E As Single
    Dim F As Single
    Dim tempTurn As Boolean
    Dim tempLocation As Location
    Dim tempLocation2 As Location
    Dim tempNPC As NPC
    With NPC(A)
        If .Type = 87 Or .Type = 276 Or .Type = 85 Or .Type = 133 Or .Type = 246 Or .Type = 30 Or .Type = 202 Or .Type = 210 Or (BattleMode = True And (.Type = 13 Or .Type = 171 Or .Type = 265)) Then  'Link shield block
            For B = 1 To numPlayers
                If Player(B).Character = 5 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Effect = 0 And Player(B).SwordPoke = 0 And Player(B).Fairy = False And Not (.Type = 13 And .CantHurtPlayer = B) And Not (.Type = 171 And .CantHurtPlayer = B) Then
                    If Player(B).Duck = False Then
                        tempLocation.Y = Player(B).Location.Y + Player(B).Location.Height - 52
                    Else
                        tempLocation.Y = Player(B).Location.Y + Player(B).Location.Height - 28
                    End If
                    tempLocation.Height = 24
                    tempLocation.Width = 6
                    If Player(B).Direction = 1 Then
                        tempLocation.X = Player(B).Location.X + Player(B).Location.Width - 2
                    Else
                        tempLocation.X = Player(B).Location.X - tempLocation.Width + 4
                    End If
                    If CheckCollision(.Location, tempLocation) = True Then
                        UpdateGraphics
                        PlaySound 85
                        If .Type = 133 Then
                            .Killed = 3
                        Else
                            .Killed = 9
                            If .Type = 13 Or .Type = 265 Then .Killed = 3
                            If .Type <> 30 And .Type <> 202 And .Type <> 210 And .Type <> 171 And .Type <> 13 And .Type <> 265 Then
                                For C = 1 To 10
                                    NewEffect 77, .Location, CSng(.Special)
                                    Effect(numEffects).Location.SpeedX = Rnd * 3 - 1.5 + .Location.SpeedX * 0.1
                                    Effect(numEffects).Location.SpeedY = Rnd * 3 - 1.5 - .Location.SpeedY * 0.1
                                    If Effect(numEffects).Frame = 0 Then
                                        Effect(numEffects).Frame = -Int(Rnd * 3)
                                    Else
                                        Effect(numEffects).Frame = 5 + Int(Rnd * 3)
                                    End If
                                Next C
                            End If
                            If .Type <> 13 And .Type <> 265 Then
                                .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                                .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                                NewEffect 10, .Location
                            End If
                        End If
                    End If
                End If
            Next B
        End If

        If .Type = 196 Or .Type = 97 Then
            If .Projectile = True Then
                .Location.SpeedX = .Location.SpeedX * 0.95
                .Location.SpeedY = .Location.SpeedY * 0.95
                If .Location.SpeedY < 1 And .Location.SpeedY > -1 Then
                    If .Location.SpeedX < 1 And .Location.SpeedX > -1 Then
                        .Projectile = False
                    End If
                End If
            End If
        End If
        If .Type = 292 Then ' Toad Boomerang
            If .CantHurt > 0 Then .CantHurt = 100
            If .Location.SpeedY > 8 Then .Location.SpeedY = 8
            If .Location.SpeedY < -8 Then .Location.SpeedY = -8
            If .Location.SpeedX > 12 + Player(.Special5).Location.SpeedX Then .Location.SpeedX = 12 + Player(.Special5).Location.SpeedX
            If .Location.SpeedX < -12 + Player(.Special5).Location.SpeedX Then .Location.SpeedX = -12 + Player(.Special5).Location.SpeedX
            If .Location.X + .Location.Width / 2 > Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 Then
                .Location.SpeedX = .Location.SpeedX - 0.2
                If .Location.SpeedX > -4 And .Location.SpeedX < 4 Then .Location.SpeedX = .Location.SpeedX - 0.5
                
            ElseIf .Location.X + .Location.Width / 2 < Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 Then
                .Location.SpeedX = .Location.SpeedX + 0.2
                If .Location.SpeedX > -4 And .Location.SpeedX < 4 Then .Location.SpeedX = .Location.SpeedX + 0.5
            End If
            .Location.SpeedX = .Location.SpeedX + (Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 - .Location.X + .Location.Width / 2) * 0.0005
            If .Location.Y + .Location.Height / 2 > Player(.Special5).Location.Y + Player(.Special5).Location.Height / 2 Then
                .Location.SpeedY = .Location.SpeedY - 0.2
                If .Location.SpeedY > 0 And .Direction <> .Special6 Then .Location.SpeedY = .Location.SpeedY - Abs(.Location.SpeedY) * 0.04
            ElseIf .Location.Y + .Location.Height / 2 < Player(.Special5).Location.Y + Player(.Special5).Location.Height / 2 Then
                .Location.SpeedY = .Location.SpeedY + 0.2
                If .Location.SpeedY < 0 And .Direction <> .Special6 Then .Location.SpeedY = .Location.SpeedY + Abs(.Location.SpeedY) * 0.04
            End If
            .Location.SpeedY = .Location.SpeedY + (Player(.Special5).Location.Y + Player(.Special5).Location.Height / 2 - .Location.Y + .Location.Height / 2) * 0.004
                
                
            For B = 1 To numNPCs
                If NPC(B).Active = True Then
                    If NPCIsACoin(NPC(B).Type) Then
                        If CheckCollision(.Location, NPC(B).Location) Then
                            NPC(B).Location.X = .Location.X + .Location.Width / 2 - NPC(B).Location.Width / 2
                            NPC(B).Location.Y = .Location.Y + .Location.Height / 2 - NPC(B).Location.Height / 2
                            NPC(B).Special = 0
                            NPC(B).Projectile = False
                        End If
                    End If
                End If
            Next B
                
            If (.Location.X + .Location.Width / 2 > Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 And .Special6 = 1) Or (.Location.X + .Location.Width / 2 < Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 And .Special6 = -1) Then
            Else
                .Special2 = 1
                If CheckCollision(.Location, Player(.Special5).Location) Then
                    .Killed = 9
                    Player(.Special5).FrameCount = 115
                    PlaySound 73
                    For B = 1 To numNPCs
                        If NPC(B).Active = True Then
                            If NPCIsACoin(NPC(B).Type) Then
                                If CheckCollision(.Location, NPC(B).Location) Then
                                    NPC(B).Location.X = Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 - NPC(B).Location.Width / 2
                                    NPC(B).Location.Y = Player(.Special5).Location.Y + Player(.Special5).Location.Height / 2 - NPC(B).Location.Height / 2
                                    TouchBonus Int(.Special5), B
                                End If
                            End If
                        End If
                    Next B
                End If
            End If
            If .Special2 = 1 Then
                If .Location.X + .Location.Width / 2 > Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 Then
                    If .Location.SpeedX > 0 Then .Location.SpeedX = .Location.SpeedX - 0.1
                ElseIf .Location.X + .Location.Width / 2 < Player(.Special5).Location.X + Player(.Special5).Location.Width / 2 Then
                    If .Location.SpeedX < 0 Then .Location.SpeedX = .Location.SpeedX + 0.1
                End If
                If .Location.Y + .Location.Height / 2 > Player(.Special5).Location.Y + Player(.Special5).Location.Height / 2 Then
                    If .Location.SpeedY > 0 Then .Location.SpeedY = .Location.SpeedY - 0.3
                ElseIf .Location.Y + .Location.Height / 2 < Player(.Special5).Location.Y + Player(.Special5).Location.Height / 2 Then
                    If .Location.SpeedY < 0 Then .Location.SpeedY = .Location.SpeedY + 0.1
                End If
            End If
            
        ElseIf .Type = 96 Then 'yoshi egg
            If .Location.SpeedY > 2 Then .Projectile = True
            If .Special2 = 1 Then
                .Killed = 1
            End If
        ElseIf .Type = 251 Or .Type = 252 Or .Type = 253 Then 'Rupee
            If .Location.SpeedX < -0.02 Then
                .Location.SpeedX = .Location.SpeedX + 0.02
            ElseIf .Location.SpeedX > 0.02 Then
                .Location.SpeedX = .Location.SpeedX - 0.02
            Else
                .Location.SpeedX = 0
            End If
        ElseIf .Type = 237 Or .Type = 263 Then   'Yoshi Ice
            If Rnd * 100 > 93 Then
                tempLocation.Height = EffectHeight(80)
                tempLocation.Width = EffectWidth(80)
                tempLocation.SpeedX = 0
                tempLocation.SpeedY = 0
                tempLocation.X = .Location.X - tempLocation.Width / 2 + Rnd * .Location.Width - 4
                tempLocation.Y = .Location.Y - tempLocation.Height / 2 + Rnd * .Location.Height - 4
                NewEffect 80, tempLocation
            End If
            If .Projectile = True Then
                If Rnd * 100 > 80 Then
                    tempLocation.Height = EffectHeight(80)
                    tempLocation.Width = EffectWidth(80)
                    tempLocation.SpeedX = 0
                    tempLocation.SpeedY = 0
                    tempLocation.X = .Location.X - tempLocation.Width / 2 + Rnd * .Location.Width - 4
                    tempLocation.Y = .Location.Y - tempLocation.Height / 2 + Rnd * .Location.Height - 4
                    NewEffect 80, tempLocation
                End If
            End If
        ElseIf .Type = 231 Or .Type = 235 Then   'Blooper
            If .Wet = 2 And .Quicksand = 0 Then
                If .Special = 0 Then
                    C = 0
                    D = 1
                    For B = 1 To numPlayers
                        If Player(B).Dead = False And Player(B).Section = .Section Then
                            If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                                C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                                D = B
                            End If
                        End If
                    Next B
                    .Special = D
                End If
                If .Special2 = 0 Or .Special4 = 1 Then
                    If .Location.Y + .Location.Height >= Player(.Special).Location.Y - 24 Or .Special4 = 1 Then
                        .Special2 = 60
                        If .Location.X + .Location.Width / 2 < Player(.Special).Location.X + Player(.Special).Location.Width / 2 Then
                            .Location.SpeedX = 4
                        Else
                            .Location.SpeedX = -4
                        End If
                        If .Special4 = 1 Then
                            .Special4 = 0
                            .Location.Y = .Location.Y - 0.1
                        End If
                    End If
                End If
                If .Special2 > 0 Then
                    .Special2 = .Special2 - 1
                    .Location.SpeedY = -1.75
                    .Frame = 0
                Else
                    .Location.SpeedY = 1
                    .Frame = 1
                End If
                If .Special2 = 0 Then .Special2 = -20
                If .Special2 < 0 Then .Special2 = .Special2 + 1
                If .Location.SpeedY >= 0 Then .Location.SpeedX = 0
            Else
                .Location.SpeedX = .Location.SpeedX * 0.7
                If .Location.SpeedY < -1 Then .Location.SpeedY = -1
                .Special2 = -60
            End If
            
            If Player(.Special).Dead = True Or Player(.Special).Section <> .Section Then .Special = 0
        ElseIf NPCIsCheep(.Type) And .Special = 1 Then 'Red SMB3 Cheep
            If .Projectile = False Then
                If .Wet = 2 Then .Special5 = 0
                C = 0
                D = 1
                For B = 1 To numPlayers
                    If Player(B).Dead = False And Player(B).Section = .Section Then
                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                            D = B
                        End If
                    End If
                Next B
                B = D
                If Player(B).WetFrame = False And Player(B).Location.Y + Player(B).Location.Height < .Location.Y Then
                    If .Direction = 1 And Player(D).Location.X > .Location.X Or .Direction = -1 And Player(B).Location.X < .Location.X Then
                        If .Location.X > Player(B).Location.X - 200 And .Location.X + .Location.Width < Player(B).Location.X + Player(B).Location.Width + 200 Then
                            If .Wet = 2 Then
                                If .Location.SpeedY > -3 Then .Location.SpeedY = .Location.SpeedY - 0.1
                                .Special3 = 1
                            End If
                        Else
                            .Special3 = 0
                        End If
                    Else
                        .Special3 = 0
                    End If
                    If .Special3 = 1 And .Wet = 0 Then
                        .Location.SpeedY = -(.Location.Y - Player(B).Location.Y + Player(B).Location.Height / 2) * 0.05 + Rnd * 4 - 2
                        If .Location.SpeedY < -9 Then .Location.SpeedY = -9
                        .Special3 = 0
                        .Special5 = 1
                        .WallDeath = 10
                    End If
                End If
            End If
        ElseIf .Type = 288 Then
            If .Special3 = 1 Then
                tempLocation = .Location
                tempLocation.Y = tempLocation.Y - 32
                NewEffect 147, .Location
                NewEffect 147, tempLocation
                .Frame = 0
                .Location.SpeedX = 0
                .Location.SpeedY = 0
                .Special3 = 0
                .Effect = 8
                .Projectile = False
                .Type = 289
                .Effect2 = 16
                PlaySound 41
            End If
        'firespitting plant
        ElseIf .Type = 245 Then
            C = 0
            For B = 1 To numPlayers
                If Player(B).Dead = False And Player(B).Section = .Section Then
                    If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                        C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                        If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                            .Direction = -1
                        Else
                            .Direction = 1
                        End If
                        .Special4 = B
                    End If
                End If
            Next B
            
            If .Location.X <> .DefaultLocation.X Then
                .Killed = 2
                .Location.Y = .Location.Y - .Location.SpeedY
            Else
                If .Special2 = 0 And .Inert = False Then
                    .Location.Y = .Location.Y + NPCHeight(.Type) + 1.5
                    .Special2 = 4
                    .Special = 70
                End If
                If .Special2 = 1 Then
                    .Special = .Special + 1
                    .Location.Y = .Location.Y - 1.5
                    If .Special >= NPCHeight(.Type) * 0.65 + 1 Then
                        .Special2 = 2
                        .Special = 0
                    End If
                ElseIf .Special2 = 2 Then
                    .Special = .Special + 1
                    If .Special >= 100 Then
                        .Special2 = 3
                        .Special = 0
                    ElseIf .Special = 50 Then
                        numNPCs = numNPCs + 1
                        With NPC(numNPCs)
                            .Active = True
                            .TimeLeft = 100
                            .Direction = NPC(A).Direction
                            .Section = NPC(A).Section
                            .Type = 246
                            .Frame = 1
                            .Location.Height = NPCHeight(.Type)
                            .Location.Width = NPCWidth(.Type)
                            If .Location.Width = 16 Then
                                .Location.X = NPC(A).Location.X + 8
                                .Location.Y = NPC(A).Location.Y + 8
                            Else 'modified fireball
                                .Location.X = NPC(A).Location.X
                                .Location.Y = NPC(A).Location.Y
                            End If
                            .Location.SpeedX = 3 * .Direction
                            C = (.Location.X + .Location.Width / 2) - (Player(NPC(A).Special4).Location.X + Player(NPC(A).Special4).Location.Width / 2)
                            D = (.Location.Y + .Location.Height / 2) - (Player(NPC(A).Special4).Location.Y + Player(NPC(A).Special4).Location.Height / 2)
                            .Location.SpeedY = D / C * .Location.SpeedX
                            If .Location.SpeedY > 2 Then
                                .Location.SpeedY = 2
                            ElseIf .Location.SpeedY < -2 Then
                                .Location.SpeedY = -2
                            End If
                            .Location.X = .Location.X + .Location.SpeedX * 4
                            .Location.Y = .Location.Y + .Location.SpeedY * 4
                        End With
                    End If
                ElseIf .Special2 = 3 Then
                    .Special = .Special + 1
                    .Location.Y = .Location.Y + 1.5
                    If .Special >= NPCHeight(.Type) * 0.65 + 1 Then
                        .Special2 = 4
                    End If
                ElseIf .Special2 = 4 Then
                    .Special = .Special + 1
                    If .Special >= 150 Then
                        tempTurn = True
                            If .Inert = False Then
                                For B = 1 To numPlayers
                                    If Player(B).Dead = False And Player(B).TimeToLive = 0 Then
                                        If CanComeOut(.Location, Player(B).Location) = False Then
                                            tempTurn = False
                                            Exit For
                                        End If
                                    End If
                                Next B
                            End If
                        If tempTurn = True Then
                            .Special2 = 1
                            .Special = 0
                        Else
                            .Special = 140
                        End If
                    End If
                End If
                .Location.Height = NPCHeight(.Type) - (.Location.Y - .DefaultLocation.Y)
                If .Location.Height < 0 Then .Location.Height = 0
                If .Location.Height = 0 Then
                    .Immune = 100
                Else
                    .Immune = 0
                End If
            End If
            
        'jumping plant
        ElseIf .Type = 270 Then
            If .Projectile = True Then
                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity
                .Location.SpeedX = .Location.SpeedX * 0.98
            Else
                If .Special = 0 Then 'hiding
                    .Location.Y = .DefaultLocation.Y + NPCHeight(.Type) + 1.5
                    .Location.Height = 0
                    .Special2 = .Special2 - 1
                    If .Special2 <= -30 Then
                        tempTurn = True
                        If .Inert = False Then
                            For B = 1 To numPlayers
                                If Player(B).Dead = False And Player(B).TimeToLive = 0 Then
                                    If CanComeOut(.Location, Player(B).Location) = False Then
                                        tempTurn = False
                                        Exit For
                                    End If
                                End If
                            Next B
                        End If
                        If tempTurn = True Then
                            .Special = 1
                            .Special2 = 0
                        Else
                            .Special2 = 1000
                        End If
                    End If
                ElseIf .Special = 1 Then 'jumping
                    .Location.Height = NPCHeight(.Type)
                    If .Special2 = 0 Then
                        .Location.SpeedY = -6
                    ElseIf .Location.SpeedY < -4 Then
                        .Location.SpeedY = .Location.SpeedY + 0.2
                    ElseIf .Location.SpeedY < -3 Then
                        .Location.SpeedY = .Location.SpeedY + 0.15
                    ElseIf .Location.SpeedY < -2 Then
                        .Location.SpeedY = .Location.SpeedY + 0.1
                    ElseIf .Location.SpeedY < -1 Then
                        .Location.SpeedY = .Location.SpeedY + 0.05
                    Else
                        .Location.SpeedY = .Location.SpeedY + 0.02
                    End If
                    .Special2 = .Special2 + 1
                    If .Location.SpeedY >= 0 Then
                        .Special = 2
                        .Special2 = 0
                    End If
                    
                ElseIf .Special = 2 Then 'falling
                    .Location.Height = NPCHeight(.Type)
                    
                    .Location.SpeedY = .Location.SpeedY + 0.01
                    If .Location.SpeedY >= 0.75 Then .Location.SpeedY = 0.75
                    
                    If .Location.Y + NPCHeight(.Type) >= .DefaultLocation.Y + NPCHeight(.Type) Then
                        .Location.Height = (.DefaultLocation.Y + NPCHeight(.Type)) - (.Location.Y)
                        If .Location.Y >= .DefaultLocation.Y + NPCHeight(.Type) Then
                            .Location.Height = 0
                            .Location.Y = .DefaultLocation.Y + NPCHeight(.Type)
                            .Special = 0
                            .Special2 = 60
                        End If
                    End If
                End If
                If .Location.Height < 0 Then .Location.Height = 0
                If .Location.Height = 0 Then
                    .Immune = 100
                Else
                    .Immune = 0
                End If
            End If
            
        'Piranha Plant code
        ElseIf .Type = 8 Or .Type = 74 Or .Type = 93 Or .Type = 256 Then
            If .Special3 > 0 Then .Special3 = .Special3 - 1
            If .Location.X <> .DefaultLocation.X Then
                .Killed = 2
                .Location.Y = .Location.Y - .Location.SpeedY
            Else
                If .Special2 = 0 And .Inert = False Then
                    .Location.Y = .Location.Y + NPCHeight(.Type) + 1.5
                    .Special2 = 4
                    .Special = 70
                End If
                If .Special2 = 1 Then
                    .Special = .Special + 1
                    .Location.Y = .Location.Y - 1.5
                    If .Special >= NPCHeight(.Type) * 0.65 + 1 Then
                        .Special2 = 2
                        .Special = 0
                    End If
                ElseIf .Special2 = 2 Then
                    If .Type <> 256 Then .Special = .Special + 1
                    If .Special >= 50 Then
                        .Special2 = 3
                        .Special = 0
                    End If
                ElseIf .Special2 = 3 Then
                    .Special = .Special + 1
                    .Location.Y = .Location.Y + 1.5
                    If .Special >= NPCHeight(.Type) * 0.65 + 1 Then
                        .Special2 = 4
                        If .Type = 256 Then .Special = 0
                    End If
                ElseIf .Special2 = 4 Then
                    .Special = .Special + 1
                    If .Special >= 75 Then
                        tempTurn = True
                        If .Inert = False Then
                            For B = 1 To numPlayers
                                If Player(B).Dead = False And Player(B).TimeToLive = 0 Then
                                    If CanComeOut(.Location, Player(B).Location) = False Then
                                        tempTurn = False
                                        Exit For
                                    End If
                                End If
                            Next B
                        End If
                        If .Type = 256 Then tempTurn = True
                        If tempTurn = True Then
                            .Special2 = 1
                            .Special = 0
                        Else
                            .Special = 140
                        End If
                    End If
                End If
                .Location.Height = NPCHeight(.Type) - (.Location.Y - .DefaultLocation.Y)
                If .Location.Height < 0 Then .Location.Height = 0
                If .Location.Height = 0 Then
                    .Immune = 100
                Else
                    .Immune = 0
                End If
            End If
        'down piranha plant
        ElseIf .Type = 51 Or .Type = 257 Then
            If .Special3 > 0 Then .Special3 = .Special3 - 1
            If .Location.X <> .DefaultLocation.X Then
                .Killed = 2
                .Location.Y = .Location.Y - .Location.SpeedY
            Else
                If .Special2 = 0 And .Inert = False Then
                    '.Location.Y = .Location.Y - NPCHeight(.Type) - 1.5
                    .Location.Height = 0
                    .Special2 = 1
                    .Special = 0
                ElseIf .Special2 = 1 Then
                    .Special = .Special + 1
                    '.Location.Y = .Location.Y + 1.5
                    .Location.Height = .Location.Height + 1.5
                    If .Special >= NPCHeight(.Type) * 0.65 + 1 Then
                        .Special2 = 2
                        .Special = 0
                    End If
                ElseIf .Special2 = 2 Then
                    If .Type <> 257 Then .Special = .Special + 1
                    If .Special >= 50 Then
                        .Special2 = 3
                        .Special = 0
                    End If
                ElseIf .Special2 = 3 Then
                    .Special = .Special + 1
                    '.Location.Y = .Location.Y - 1.5
                    .Location.Height = .Location.Height - 1.5
                    If .Special >= NPCHeight(.Type) * 0.65 + 1 Then
                        .Special2 = 4
                    End If
                ElseIf .Special2 = 4 Then
                    .Special = .Special + 1
                    If .Special >= 110 Then
                        .Special2 = 1
                        .Special = 0
                    End If
                End If
                If .Location.Height = 0 Then
                    .Immune = 100
                Else
                    .Immune = 0
                End If
            End If
        'left/right piranha plant
        ElseIf .Type = 52 Then
            .Direction = .DefaultDirection
            If .Location.Y <> .DefaultLocation.Y Then
                .Location.Y = .Location.Y - .Location.SpeedY
                NPCHit A, 4
            Else
                If .Special2 = 0 And .Inert = False Then
                    If .Direction = 1 Then
                        '.Location.x = .Location.X - NPCWidth(.Type) - 1.5
                        .Location.Width = .Location.Width - NPCWidth(.Type) - 1.5
                    Else
                        .Location.X = .Location.X + NPCWidth(.Type) + 1.5
                    End If
                    .Special2 = 1
                    .Special = 0
                ElseIf .Special2 = 1 Then
                    .Special = .Special + 1
                    If .Direction = -1 Then
                        .Location.X = .Location.X + 1.5 * .Direction
                    Else
                        .Location.Width = .Location.Width + 1.5 * .Direction
                    End If
                    If .Special >= NPCWidth(.Type) * 0.65 + 1 Then
                        .Special2 = 2
                        .Special = 0
                    End If
                ElseIf .Special2 = 2 Then
                    .Special = .Special + 1
                    If .Special >= 50 Then
                        .Special2 = 3
                        .Special = 0
                    End If
                ElseIf .Special2 = 3 Then
                    .Special = .Special + 1
                    If .Direction = -1 Then
                        .Location.X = .Location.X - 1.5 * .Direction
                    Else
                        .Location.Width = .Location.Width - 1.5 * .Direction
                    End If
                    If .Special >= NPCWidth(.Type) * 0.65 + 1 Then
                        .Special2 = 4
                    End If
                ElseIf .Special2 = 4 Then
                    .Special = .Special + 1
                    If .Special >= 110 Then
                        .Special2 = 1
                        .Special = 0
                    End If
                End If
                If .Direction = -1 Then
                    .Location.Width = NPCWidth(.Type) - (.Location.X - .DefaultLocation.X)
                    If .Location.Width < 0 Then .Location.Width = 0
                End If
                If .Location.Width = 0 Then
                    .Immune = 100
                Else
                    .Immune = 0
                End If
                
            End If
        'smb3 belt code
        ElseIf .Type = 57 Then
            .Location.SpeedX = 0.8 * .DefaultDirection * BeltDirection
            .Location.X = .DefaultLocation.X
            .Location.Y = .DefaultLocation.Y
            .Direction = .DefaultDirection * BeltDirection
        ElseIf .Type = 75 Then
            If .Location.SpeedY = Physics.NPCGravity Then
                .Special = .Special + 1
                .Frame = 0
                If .Special >= 100 Then
                    .Special = 1
                ElseIf .Special >= 10 Then
                    .Special = 0
                    .Frame = 1
                    .Location.Y = .Location.Y - 1
                    .Location.SpeedY = -4.6
                End If
            Else
                If .Special <= 8 Then
                    .Special = .Special + 1
                    .Frame = 1
                Else
                    .Frame = 2
                    .Special = 100
                End If
                
            End If
            If .Direction = 1 Then .Frame = .Frame + 3
        'Fireball code
        ElseIf .Type = 12 Then
            If .Location.Y > .DefaultLocation.Y + .Location.Height + 16 Then .Location.Y = .DefaultLocation.Y + .DefaultLocation.Height + 16
            .Projectile = True
            'If .Location.X <> .DefaultLocation.X Then .Killed = 2
            If .Special2 = 0 Then
                .Location.Y = .DefaultLocation.Y + .Location.Height + 1.5
                .Special2 = 1
                .Special = 0
                PlaySound 16
                tempLocation = .Location
                tempLocation.Y = tempLocation.Y - 32
                NewEffect 13, tempLocation
            ElseIf .Special2 = 1 Then
                .Special = .Special + 1
                .Location.SpeedY = -6
                If .Location.Y < .DefaultLocation.Y - 10 Then
                    If .Special Mod 5 = 0 Then NewEffect 12, .Location
                End If
                If .Special >= 30 Then
                    .Special2 = 2
                    .Special = 0
                End If
            ElseIf .Special2 = 2 Then
                .Special = .Special + 1
                If .Special = 61 Then
                    tempLocation = .Location
                    tempLocation.Y = tempLocation.Y + 2
                    NewEffect 13, tempLocation
                    PlaySound 16
                End If
                If .Special >= 150 Then
                    .Special2 = 0
                    .Special = 0
                End If
            End If
            If .Location.Y > level(.Section).Height + 1 Then .Location.Y = level(.Section).Height
        ElseIf (.Type = 46 Or .Type = 212) And LevelMacro = 0 Then
            If .Special = 0 Then
                If .Special2 = 1 Then
                    .Special3 = .Special3 + 1
                    .Special2 = 0
                    .Location.X = .Location.X + .Direction * 2
                    If .Location.X >= .DefaultLocation.X + 2 Then .Direction = -1
                    If .Location.X <= .DefaultLocation.X - 2 Then .Direction = 1
                Else
                    If .Special3 > 0 Then .Special3 = .Special3 - 1
                    .Location.X = .DefaultLocation.X
                End If
                If (.Special3 >= 5 And .Type = 46) Or (.Special3 >= 30 And .Type = 212) Then
                    .Special = 1
                    .Location.X = .DefaultLocation.X
                End If
            End If
        'Big Koopa Code
        ElseIf .Type = 15 Then
            If .Legacy = True Then
                If .TimeLeft > 1 Then .TimeLeft = 100
                If bgMusic(.Section) <> 6 And bgMusic(.Section) <> 15 And bgMusic(.Section) <> 21 And .TimeLeft > 1 Then
                    bgMusic(.Section) = 6
                    StopMusic
                    StartMusic .Section
                End If
            End If
            If .Special = 0 Then
                If .Location.Height <> 54 Then
                    .Location.Y = .Location.Y + .Location.Height - 54
                    .Location.Height = 54
                End If
                .Special2 = .Special2 + Rnd * 2
                If .Special2 >= 250 + Int(Rnd * 250) Then
                    .Special = 2
                    .Special2 = 0
                End If
            ElseIf .Special = 2 Then
                .Special2 = .Special2 + 1
                If .Special2 >= 10 Then
                    .Special = 1
                    .Special2 = 0
                End If
            ElseIf .Special = 1 Then
                If .Location.Height <> 40 Then
                    .Location.Y = .Location.Y + .Location.Height - 40
                    .Location.Height = 40
                End If
                .Special2 = .Special2 + Rnd * 2
                If .Special2 >= 100 + Int(Rnd * 100) Then
                    .Special = 3
                    .Special2 = 0
                End If
            ElseIf .Special = 3 Then
                .Special2 = .Special2 + 1
                If .Special2 >= 10 Then
                    .Special = 0
                    .Special2 = 0
                End If
            ElseIf .Special = 4 Then
                If .Location.Height <> 34 Then
                    .Location.Y = .Location.Y + .Location.Height - 34
                    .Location.Height = 34
                End If
                .Special2 = .Special2 + 1
                If .Special2 >= 100 Then
                    .Special = 1
                    .Special2 = 0
                End If
            End If
        ElseIf NPCIsAParaTroopa(.Type) Then  'para-troopas
            If .Special = 0 Then 'chase
                If .CantHurt > 0 Then .CantHurt = 100
                .Projectile = False
                C = 0
                For B = 1 To numPlayers
                    If Player(B).Dead = False And Player(B).Section = .Section And Player(B).TimeToLive = 0 And .CantHurtPlayer <> B Then
                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                            D = B
                        End If
                    End If
                Next B
                C = D
                If C > 0 Then
                    If .Location.X + .Location.Width / 2 > Player(C).Location.X + Player(C).Location.Width / 2 Then
                        D = -1
                    Else
                        D = 1
                    End If
                    .Direction = D
                    E = 0 'X
                    F = -1 'Y
                    If .Location.Y > Player(C).Location.Y Then
                        F = -1
                    ElseIf .Location.Y < Player(C).Location.Y - 128 Then
                        F = 1
                    End If
                    If .Location.X > Player(C).Location.X + Player(C).Location.Width + 64 Then
                        E = -1
                    ElseIf .Location.X + .Location.Width + 64 < Player(C).Location.X Then
                        E = 1
                    End If
                    If .Location.X + .Location.Width + 150 > Player(C).Location.X And .Location.X - 150 < Player(C).Location.X + Player(C).Location.Width Then
                        If .Location.Y > Player(C).Location.Y + Player(C).Location.Height Then
                            
                            'If Player(C).Location.SpeedX + NPC(Player(C).StandingOnNPC).Location.SpeedX > 0 And .Location.X + .Location.Width / 2 > Player(C).Location.X + Player(C).Location.Width / 2 Then
                                'E = -D
                            'ElseIf Player(C).Location.SpeedX + NPC(Player(C).StandingOnNPC).Location.SpeedX <= 0 And .Location.X + .Location.Width / 2 < Player(C).Location.X + Player(C).Location.Width / 2 Then
                                E = -D
                            'End If
                            If .Location.Y < Player(C).Location.Y + Player(C).Location.Height + 160 Then
                                If .Location.X + .Location.Width + 100 > Player(C).Location.X And .Location.X - 100 < Player(C).Location.X + Player(C).Location.Width Then
                                    F = 0.2
                                End If
                            End If
                        Else
                            If .Direction <> D Then E = D
                            E = D
                            F = 1
                        End If
                    End If
                    If .Wet = 2 Then
                        .Location.SpeedX = .Location.SpeedX + 0.025 * E
                        .Location.SpeedY = .Location.SpeedY + 0.025 * F
                    Else
                        .Location.SpeedX = .Location.SpeedX + 0.05 * E
                        .Location.SpeedY = .Location.SpeedY + 0.05 * F
                    End If
                    If .Location.SpeedX > 4 Then
                        .Location.SpeedX = 4
                    ElseIf .Location.SpeedX < -4 Then .Location.SpeedX = -4
                    End If
                    If .Location.SpeedY > 3 Then
                        .Location.SpeedY = 3
                    ElseIf .Location.SpeedY < -3 Then .Location.SpeedY = -3
                    End If
                End If
            ElseIf .Special = 1 Then
                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity
                .Location.SpeedX = Physics.NPCWalkingSpeed * .Direction
            ElseIf .Special = 2 Then
                
                If .Special3 = 0 Then
                    .Location.SpeedY = .Location.SpeedY + 0.05
                    If .Location.SpeedY > 1 Then .Special3 = 1
                Else
                    .Location.SpeedY = .Location.SpeedY - 0.05
                    If .Location.SpeedY < -1 Then .Special3 = 0
                End If
                
                If .Location.X = .DefaultLocation.X And .Location.SpeedX = 0 Then
                    .Location.SpeedX = 2 * .Direction
                End If
                If .Location.X < .DefaultLocation.X - 64 Then
                    .Location.SpeedX = .Location.SpeedX + 0.02
                ElseIf .Location.X > .DefaultLocation.X + 64 Then
                    .Location.SpeedX = .Location.SpeedX - 0.02
                ElseIf .Direction = -1 Then
                    .Location.SpeedX = .Location.SpeedX - 0.02
                ElseIf .Direction = 1 Then
                    .Location.SpeedX = .Location.SpeedX + 0.02
                End If
                If .Location.SpeedX > 2 Then .Location.SpeedX = 2
                If .Location.SpeedX < -2 Then .Location.SpeedX = -2
            ElseIf .Special = 3 Then
                .Location.SpeedX = 0
                If .Location.Y = .DefaultLocation.Y And .Location.SpeedY = 0 Then
                    .Location.SpeedY = 2 * .Direction
                End If
                If .Location.Y < .DefaultLocation.Y - 64 Then
                    .Location.SpeedY = .Location.SpeedY + 0.02
                ElseIf .Location.Y > .DefaultLocation.Y + 64 Then
                    .Location.SpeedY = .Location.SpeedY - 0.02
                ElseIf .Location.SpeedY < 0 Then
                    .Location.SpeedY = .Location.SpeedY - 0.02
                Else
                    .Location.SpeedY = .Location.SpeedY + 0.02
                End If
                If .Location.SpeedY > 2 Then .Location.SpeedY = 2
                If .Location.SpeedY < -2 Then .Location.SpeedY = -2
                C = 0
                For B = 1 To numPlayers
                    If Player(B).Dead = False And Player(B).Section = .Section Then
                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                            D = B
                        End If
                    End If
                Next B
                If Player(D).Location.X + Player(D).Location.Width / 2 > .Location.X + 16 Then
                    .Direction = 1
                Else
                    .Direction = -1
                End If
            End If
            If .Stuck = True And .Projectile = False Then .Location.SpeedX = 0
            .Location.X = .Location.X + .Location.SpeedX
            .Location.Y = .Location.Y + .Location.SpeedY
        'Jumpy bee thing
        ElseIf .Type = 54 Then
            If .Location.SpeedY = Physics.NPCGravity Or .Slope > 0 Then
                .Location.SpeedX = 0
                .Special = .Special + 1
                If .Special = 30 Then
                    .Special = 0
                    .Location.Y = .Location.Y - 1
                    .Location.SpeedY = -6
                    .Location.SpeedX = 1.4 * .Direction
                End If
            End If
        'Bouncy Star thing code
        ElseIf .Type = 25 Then
            C = 0
            For B = 1 To numPlayers
                If Player(B).Dead = False And Player(B).Section = .Section Then
                    If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                        C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                        If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                            .Direction = -1
                        Else
                            .Direction = 1
                        End If
                    End If
                End If
            Next B
            If .Location.SpeedY = Physics.NPCGravity Or .Slope > 0 Then
                .Special = .Special + 1
                If .Special = 8 Then
                    .Location.SpeedY = -7
                    .Location.Y = .Location.Y - 1
                    .Special = 0
                End If
            Else
                .Special = 0
            End If
        'bowser statue
        ElseIf .Type = 84 Or .Type = 181 Then
            .Special = .Special + 1
            If .Special >= 200 + Rnd * 200 Then
                .Special = 0
                numNPCs = numNPCs + 1
                With NPC(numNPCs)
                    .Inert = NPC(A).Inert
                    .Type = 85
                    .Direction = NPC(A).Direction
                    .Location.Height = NPCHeight(.Type)
                    .Location.Width = NPCWidth(.Type)
                    .TimeLeft = 100
                    .Active = True
                    .Section = NPC(A).Section
                    .Location.Y = NPC(A).Location.Y + 16
                    .Location.X = NPC(A).Location.X + 24 * .Direction
                    If NPC(A).Type = 181 Then
                        .Location.Y = .Location.Y - 5
                        .Location.X = NPC(A).Location.X + 6 + 30 * .Direction
                    End If
                    .Location.SpeedX = 4 * .Direction
                    If .Direction = 1 Then .Frame = 4
                    .FrameCount = Int(Rnd * 8)
                    PlaySound 42
                End With
            End If
        'Hammer Bro
        ElseIf .Type = 29 And .Projectile = False Then
            C = 0
            For B = 1 To numPlayers
                If Player(B).Dead = False And Player(B).Section = .Section Then
                    If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                        C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                        If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                            .Direction = -1
                        Else
                            .Direction = 1
                        End If
                    End If
                End If
            Next B
            If .Special > 0 Then
                .Special = .Special + 1
                .Location.SpeedX = 0.6
                If .Special >= 100 And .Location.SpeedY = Physics.NPCGravity Then
                    .Special = -1
                End If
            Else
                .Special = .Special - 1
                .Location.SpeedX = -0.6
                If .Special <= -100 And .Location.SpeedY = Physics.NPCGravity Then
                    .Special = 1
                End If
            End If
            If .Location.SpeedY = Physics.NPCGravity Then
                .Special2 = .Special2 + 1
                If .Special2 >= 250 Then
                    .Location.SpeedY = -7
                    .Location.Y = .Location.Y - 1
                    .Special2 = 0
                End If
            End If
            .Special3 = .Special3 + Rnd * 2
            If .Special3 >= 50 + Rnd * 1000 Then
                If .Location.SpeedY = Physics.NPCGravity Then
                    .Location.SpeedY = -3
                    .Location.Y = .Location.Y - 1
                End If
                PlaySound 25
                .Special3 = -15
                numNPCs = numNPCs + 1
                NPC(numNPCs).Inert = .Inert
                NPC(numNPCs).Location.Height = 32
                NPC(numNPCs).Location.Width = 32
                NPC(numNPCs).Location.X = .Location.X
                NPC(numNPCs).Location.Y = .Location.Y
                NPC(numNPCs).Direction = .Direction
                NPC(numNPCs).Type = 30
                NPC(numNPCs).Section = .Section
                NPC(numNPCs).Active = True
                NPC(numNPCs).TimeLeft = 50
                NPC(numNPCs).Location.SpeedY = -8
                NPC(numNPCs).Location.SpeedX = 3 * NPC(numNPCs).Direction
            End If
        'leaf
        ElseIf .Type = 34 Then 'Leaf
            If .Stuck = True And .Projectile = False Then
                .Location.SpeedX = 0
            ElseIf .Stuck = True Then
                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity
                If .Location.SpeedY >= 8 Then .Location.SpeedY = 8
            ElseIf .Special = 0 Then
                .Location.SpeedY = .Location.SpeedY + Physics.NPCGravity
                If .Projectile = True Then
                    If .Location.SpeedY >= 2 Then
                        .Location.SpeedX = 1.2
                        .Special = 1
                        .Projectile = False
                    End If
                    
                ElseIf .Location.SpeedY >= 0 Then
                    .Special = 6
                End If
            Else
                If .Special = 1 Then
                    .Location.SpeedY = .Location.SpeedY - 0.25
                    .Location.SpeedX = .Location.SpeedX + 0.3
                    If .Location.SpeedY <= 0 Then .Special = 2
                ElseIf .Special = 2 Then
                    .Location.SpeedX = .Location.SpeedX - 0.3
                    .Location.SpeedY = .Location.SpeedY - 0.02
                    If .Location.SpeedX <= 0 Then
                        .Special = 3
                        .Location.SpeedX = 0
                    End If
                ElseIf .Special = 3 Then
                    .Location.SpeedY = .Location.SpeedY + 0.4
                    .Location.SpeedX = .Location.SpeedX - 0.1
                    If .Location.SpeedY >= 3 Then .Special = 4
                ElseIf .Special = 4 Then
                    .Location.SpeedY = .Location.SpeedY - 0.25
                    .Location.SpeedX = .Location.SpeedX - 0.3
                    If .Location.SpeedY <= 0 Then .Special = 5
                ElseIf .Special = 5 Then
                    .Location.SpeedX = .Location.SpeedX + 0.3
                    .Location.SpeedY = .Location.SpeedY - 0.02
                    If .Location.SpeedX >= 0 Then
                        .Special = 6
                        .Location.SpeedX = 0
                    End If
                ElseIf .Special = 6 Then
                    .Location.SpeedY = .Location.SpeedY + 0.4
                    .Location.SpeedX = .Location.SpeedX + 0.1
                    If .Location.SpeedY >= 3 Then .Special = 1
                End If
            End If
        ElseIf .Type = 47 Then 'lakitu
            .Projectile = False
            If .TimeLeft > 1 Then .TimeLeft = 100
            If .CantHurt > 0 Then .CantHurt = 100
            C = 0
            For B = 1 To numPlayers
                If Player(B).Dead = False And Player(B).Section = .Section And B <> .CantHurtPlayer Then
                    If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                        C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                        D = B
                    End If
                End If
            Next B
            C = D
            If C > 0 Then
                If .Special = 0 Then
                    .Location.SpeedX = .Location.SpeedX - 0.2
                    D = Abs(.Location.X + .Location.Width / 2 - Player(C).Location.X + Player(C).Location.Width / 2) / 100
                    D = D + Abs(Player(C).Location.SpeedX) / 2
                    If .Location.SpeedX < -5 - D Then .Location.SpeedX = .Location.SpeedX + 0.2
                    If .Location.X + .Location.Width / 2 < Player(C).Location.X + Player(C).Location.Width / 2 - 50 + (Player(C).Location.SpeedX * 15) Then
                        .Special = 1
                    End If
                Else
                    .Location.SpeedX = .Location.SpeedX + 0.2
                    D = Abs(.Location.X + .Location.Width / 2 - Player(C).Location.X + Player(C).Location.Width / 2) / 100
                    D = D + Abs(Player(C).Location.SpeedX) / 2
                    If .Location.SpeedX > 5 + D Then .Location.SpeedX = .Location.SpeedX - 0.2
                    If .Location.X + .Location.Width / 2 > Player(C).Location.X + Player(C).Location.Width / 2 + 50 + (Player(C).Location.SpeedX * 15) Then
                        .Special = 0
                    End If
                End If
                D = 1
                If numPlayers = 2 Then
                    If ScreenType = 5 Then
                        If DScreenType <> 5 Then D = 2
                    End If
                End If
                If .Location.Y + .Location.Height > Player(C).Location.Y - 248 Then
                    .Special2 = 1
                End If
                If .Location.Y + .Location.Height < Player(C).Location.Y - 256 Or .Location.Y < -vScreenY(D) Then
                    .Special2 = 0
                End If
                If .Location.Y > -vScreenY(D) + 64 Then
                    .Special2 = 1
                End If
                If .Location.Y < -vScreenY(D) + 72 Then
                    .Special2 = 0
                End If
                If .Special2 = 0 Then
                    .Location.SpeedY = .Location.SpeedY + 0.05
                    If .Location.SpeedY > 2 Then .Location.SpeedY = 2
                Else
                    .Location.SpeedY = .Location.SpeedY - 0.05
                    If .Location.SpeedY < -2 Then .Location.SpeedY = -2
                End If
                If .Inert = True Then
                    If .Special3 > 1 Then .Special3 = 0
                End If
                If .Special3 = 0 Then
                    .FrameCount = .FrameCount + 1
                    If .FrameCount >= 10 Then
                        .FrameCount = 0
                        .Frame = .Frame + 1
                        If .Frame >= 2 Then .Special3 = 1
                    End If
                ElseIf .Special3 = 1 Then
                    .FrameCount = .FrameCount + 1
                    If .FrameCount >= 10 Then
                        .FrameCount = 0
                        .Frame = .Frame - 1
                        If .Frame <= 0 Then .Special3 = 0
                    End If
                ElseIf .Special3 = 2 Then
                    .FrameCount = .FrameCount + 1
                    If .FrameCount >= 16 Then
                        .FrameCount = 10
                        If .Frame < 5 Then .Frame = .Frame + 1
                        If .Frame <= 5 Then
                            .Special5 = .Special5 + 1
                        End If
                    End If
                ElseIf .Special3 = 3 Then
                    .FrameCount = .FrameCount + 1
                    If .FrameCount >= 2 Then
                        .FrameCount = 0
                        .Frame = .Frame - 1
                        If .Frame <= 0 Then
                            .Special3 = 0
                            .Frame = 0
                        End If
                    End If
                End If
                If Abs(.Location.X + .Location.Width / 2 - Player(C).Location.X + Player(C).Location.Width / 2) < 100 Then
                    If .Special4 = 0 Then
                        .Special3 = 2
                        .Special4 = 100
                    End If
                End If
            End If
            If .Special4 > 0 Then .Special4 = .Special4 - 1
            If .Special5 >= 20 Then
                .Special5 = 20
                tempLocation = .Location
                With tempLocation
                    .X = .X - 16
                    .Y = .Y - 16
                    .Width = .Width + 32
                    .Height = .Height + 32
                End With
                D = 0
                If .Location.Y + .Location.Height > Player(C).Location.Y Then
                    D = 1
                Else
                    For E = 1 To numBlock
                        If BlockNoClipping(Block(E).Type) = False And BlockIsSizable(Block(E).Type) = False And BlockOnlyHitspot1(Block(E).Type) = False Then
                            If CheckCollision(tempLocation, Block(E).Location) = True Then D = 1
                        End If
                    Next E
                End If
                If D = 0 Then
                    .Special3 = 3
                    .FrameCount = 0
                    .Special5 = 0
                    numNPCs = numNPCs + 1
                    If .Location.X + .Location.Width / 2 > Player(C).Location.X + Player(C).Location.Width / 2 Then
                        NPC(numNPCs).Direction = -1
                    Else
                        NPC(numNPCs).Direction = 1
                    End If
                    With NPC(numNPCs)
                        .Location = NPC(A).Location
                        .Location.Height = 32
                        .Location.Width = 32
                        If NPC(A).CantHurt > 0 Then
                            .CantHurt = 100
                            .CantHurtPlayer = NPC(A).CantHurtPlayer
                        End If
                        .Location.Y = .Location.Y + 8
                        .Location.SpeedX = (1.5 + Abs(Player(C).Location.SpeedX) * 0.75) * .Direction
                        .Location.SpeedY = -8
                        .Active = True
                        .Section = NPC(A).Section
                        .TimeLeft = 100
                        .Type = 48
                    End With
                    tempNPC = NPC(A)
                    NPC(A) = NPC(numNPCs)
                    NPC(numNPCs) = tempNPC
                    PlaySound 25
                End If
            End If
        ElseIf .Type = 166 Then 'smw goomba
            .Special = .Special + 1
            If .Special >= 400 Then
                If .Slope > 0 Or .Location.SpeedY = Physics.NPCGravity Or .Location.SpeedY = 0 Then
                    .Location.SpeedY = -5
                    .Type = 165
                    .Special = 0
                    .Location.Y = .Location.Y - 1
                End If
            End If
        ElseIf .Type = 37 Or .Type = 180 Then 'thwomp
                If .Special = 0 Then
                    .Location.SpeedY = 0
                    .Location.Y = .DefaultLocation.Y
                    C = 0
                    For B = 1 To numPlayers
                        If CanComeOut(.Location, Player(B).Location) = False And Player(B).Location.Y >= .Location.Y Then C = B
                    Next B
                    If C > 0 Then
                        .Special = 1
                    End If
                ElseIf .Special = 1 Then
                    .Location.SpeedY = 6
                ElseIf .Special = 2 Then
                    If .Special2 = 0 Then
                        PlaySound 37
                        tempLocation.Width = 32
                        tempLocation.Height = 32
                        tempLocation.Y = .Location.Y + .Location.Height - 16
                        
                        
                        tempLocation.X = .Location.X
                        NewEffect 10, tempLocation
                        Effect(numEffects).Location.SpeedX = -1.5
                        
                        tempLocation.X = tempLocation.X + tempLocation.Width - EffectWidth(10)
                        NewEffect 10, tempLocation
                        Effect(numEffects).Location.SpeedX = 1.5
                        
                    End If
                    .Location.SpeedY = 0
                    If .Slope > 0 Then .Location.Y = .Location.Y - 0.1
                    .Special2 = .Special2 + 1
                    If .Special2 >= 100 Then
                        .Location.Y = .Location.Y - 1
                        .Special = 3
                        .Special2 = 0
                    End If
                ElseIf .Special = 3 Then
                    .Location.SpeedY = -2
                    If .Location.Y <= .DefaultLocation.Y + 1 Then
                        .Location.Y = .DefaultLocation.Y
                        .Location.SpeedY = 0
                        .Special = 0
                        .Special2 = 0
                    End If
                End If
            'End If
        ElseIf .Type = 38 Or .Type = 43 Or .Type = 44 Then 'boo
                If BattleMode = True And .CantHurt > 0 Then .CantHurt = 100
                If .Projectile = True Then
                    If .CantHurtPlayer > 0 Then .BattleOwner = .CantHurtPlayer
                    .Location.SpeedX = .Location.SpeedX * 0.95
                    .Location.SpeedY = .Location.SpeedY * 0.95
                    If .Location.SpeedX > -2 And .Location.SpeedX < 2 Then
                        If .Location.SpeedY > -2 And .Location.SpeedY < 2 Then
                            .Projectile = False
                        End If
                    End If
                End If
                C = 0
                D = 0
                For B = 1 To numPlayers
                    If Player(B).Dead = False And Player(B).Section = .Section And B <> .CantHurtPlayer Then
                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                            D = B
                        End If
                    End If
                Next B
                C = D
                If C > 0 Then
                    D = .Location.X + .Location.Width / 2
                    E = Player(C).Location.X + Player(C).Location.Width / 2
                    If D <= E And Player(C).Direction = -1 Or Player(C).SpinJump = True Then
                        .Special = 0
                        If .Type = 38 Then
                            .Location.SpeedX = .Location.SpeedX * 0.9
                            .Location.SpeedY = .Location.SpeedY * 0.9
                        ElseIf .Type = 43 Then
                            .Location.SpeedX = .Location.SpeedX * 0.85
                            .Location.SpeedY = .Location.SpeedY * 0.85
                        ElseIf .Type = 44 Then
                            .Location.SpeedX = .Location.SpeedX * 0.8
                            .Location.SpeedY = .Location.SpeedY * 0.8
                        End If
                        If .Location.SpeedX < 0.1 And .Location.SpeedX > -0.1 Then .Location.SpeedX = 0
                        If .Location.SpeedY < 0.1 And .Location.SpeedY > -0.1 Then .Location.SpeedY = 0
                    ElseIf D >= E And Player(C).Direction = 1 Or Player(C).SpinJump = True Then
                        .Special = 0
                        If .Type = 38 Then
                            .Location.SpeedX = .Location.SpeedX * 0.9
                            .Location.SpeedY = .Location.SpeedY * 0.9
                        ElseIf .Type = 43 Then
                            .Location.SpeedX = .Location.SpeedX * 0.85
                            .Location.SpeedY = .Location.SpeedY * 0.85
                        ElseIf .Type = 44 Then
                            .Location.SpeedX = .Location.SpeedX * 0.8
                            .Location.SpeedY = .Location.SpeedY * 0.8
                        End If
                        If .Location.SpeedX < 0.1 And .Location.SpeedX > -0.1 Then .Location.SpeedX = 0
                        If .Location.SpeedY < 0.1 And .Location.SpeedY > -0.1 Then .Location.SpeedY = 0
                    Else
                        .Special = 1
                        .Direction = Player(C).Direction
                        If .Type = 38 Then
                            F = 0.03
                        ElseIf .Type = 43 Then F = 0.025
                        ElseIf .Type = 44 Then F = 0.02
                        End If
                        If D <= E And .Location.SpeedX < 1.5 Then
                            .Location.SpeedX = .Location.SpeedX + F
                        ElseIf .Location.SpeedX > -1.5 Then
                            .Location.SpeedX = .Location.SpeedX - F
                        End If
                        D = .Location.Y + .Location.Height / 2
                        E = Player(C).Location.Y + Player(C).Location.Height / 2
                        If D <= E And .Location.SpeedY < 1.5 Then
                            .Location.SpeedY = .Location.SpeedY + F
                        ElseIf .Location.SpeedY > -1.5 Then
                            .Location.SpeedY = .Location.SpeedY - F
                        End If
                    End If
                Else
                    .Special = 0
                    .Location.SpeedX = 0
                    .Location.SpeedY = 0
                End If
            'End If
        ElseIf .Type = 97 Or .Type = 196 Then
            If .Special = 0 Then
                .Special4 = .Special4 + 1
                If .Special4 >= 5 Then
                    .Special4 = 0
                    NewEffect 80, newLoc(.Location.X + Rnd * .Location.Width - 2, .Location.Y + Rnd * .Location.Height)
                    Effect(numEffects).Location.SpeedX = Rnd * 1 - 0.5
                    Effect(numEffects).Location.SpeedY = Rnd * 1 - 0.5
                End If
            Else
                .Special4 = .Special4 + 1
                If .Special4 >= 10 Then
                    .Special4 = 0
                    NewEffect 80, newLoc(.Location.X + Rnd * .Location.Width - 2, .Location.Y + Rnd * .Location.Height)
                    Effect(numEffects).Location.SpeedX = Rnd * 1 - 0.5
                    Effect(numEffects).Location.SpeedY = Rnd * 1 - 0.5
                    Effect(numEffects).Frame = 1
                End If
            End If
            If .Special2 = 0 Then
                .Location.SpeedY = .Location.SpeedY - 0.04
                If .Location.SpeedY <= -1.4 Then .Special2 = 1
            Else
                .Location.SpeedY = .Location.SpeedY + 0.04
                If .Location.SpeedY >= 1.4 Then .Special2 = 0
            End If
            If .Special3 = 0 Then
                .Location.SpeedX = .Location.SpeedX - 0.03
                If .Location.SpeedX <= -0.6 Then .Special3 = 1
            Else
                .Location.SpeedX = .Location.SpeedX + 0.03
                If .Location.SpeedX >= 0.6 Then .Special3 = 0
            End If
        ElseIf .Type = 39 And .Projectile = False Then  ' birdo
            If .Legacy = True Then
                If .TimeLeft > 1 Then .TimeLeft = 100
                If bgMusic(.Section) <> 6 And bgMusic(.Section) <> 15 And bgMusic(.Section) <> 21 And .TimeLeft > 1 Then
                    bgMusic(.Section) = 15
                    StopMusic
                    StartMusic .Section
                End If
            End If
            If .Special >= 0 Then
                C = 0
                For B = 1 To numPlayers
                    If Player(B).Dead = False And Player(B).Section = .Section Then
                        If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                            C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                            If .Location.X + .Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                                .Direction = -1
                            Else
                                .Direction = 1
                            End If
                        End If
                    End If
                Next B
                .Special2 = .Special2 + 1
                If .Special2 = 125 Then
                    .Location.Y = .Location.Y - 1
                    .Location.SpeedY = -5
                    If .Inert = True Then .Special2 = 0
                ElseIf .Special2 >= 240 Then
                    If .Special2 = 260 Then
                        numNPCs = numNPCs + 1
                        With NPC(numNPCs)
                            .Active = True
                            .Direction = NPC(A).Direction
                            .Type = 40
                            
                            .Location.Height = NPCHeight(.Type)
                            .Location.Width = NPCWidth(.Type)
                            .Location.Y = NPC(A).Location.Y + 14 - .Location.Height / 2
                            

                            
                            If .Direction = 1 Then
                                .Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2
                            Else
                                .Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2 - .Location.Width
                            End If
                            .TimeLeft = 100
                            .Section = NPC(A).Section
                            .Location.SpeedX = 4 * .Direction
                            PlaySound 38
                        End With
                    End If
                    .Special = 1
                    If .Special2 > 280 Then
                        .Special2 = 0
                        .Special = 0
                    End If
                End If
                If .Special = 0 And .Location.SpeedY = Physics.NPCGravity Then
                    .Special3 = .Special3 + 1
                    If .Special3 <= 200 Then
                        .Location.SpeedX = -1
                    ElseIf .Special3 > 500 Then
                        .Special3 = 0
                    ElseIf .Special3 > 250 And .Special3 <= 450 Then
                        .Location.SpeedX = 1
                    Else
                        .Location.SpeedX = 0
                    End If
                Else
                    .Location.SpeedX = 0
                End If
            Else
                .Special = .Special + 1
                .Location.SpeedX = 0
            End If
            If .Stuck = True Then .Location.SpeedX = 0
            
            
            
            
            
            
        ElseIf .Type = 284 Then 'smw lakitu
            If .Special = 0 Then .Special = .Type
            .Projectile = False
            If .TimeLeft > 1 Then .TimeLeft = 100
            If .CantHurt > 0 Then .CantHurt = 100
            C = 0
            For B = 1 To numPlayers
                If Player(B).Dead = False And Player(B).Section = .Section And B <> .CantHurtPlayer And Player(B).TimeToLive = 0 Then
                    If C = 0 Or Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2)) < C Then
                        C = Abs(.Location.X + .Location.Width / 2 - (Player(B).Location.X + Player(B).Location.Width / 2))
                        D = B
                    End If
                End If
            Next B
            C = D
            If C > 0 Then
                If .Special6 = 0 Then
                    .Location.SpeedX = .Location.SpeedX - 0.2
                    D = Abs(.Location.X + .Location.Width / 2 - Player(C).Location.X + Player(C).Location.Width / 2) / 100
                    D = D + Abs(Player(C).Location.SpeedX) / 2
                    If .Location.SpeedX < -5 - D Then .Location.SpeedX = .Location.SpeedX + 0.2
                    If .Location.X + .Location.Width / 2 < Player(C).Location.X + Player(C).Location.Width / 2 - 50 + (Player(C).Location.SpeedX * 15) Then
                        .Special6 = 1
                    End If
                Else
                    .Location.SpeedX = .Location.SpeedX + 0.2
                    D = Abs(.Location.X + .Location.Width / 2 - Player(C).Location.X + Player(C).Location.Width / 2) / 100
                    D = D + Abs(Player(C).Location.SpeedX) / 2
                    If .Location.SpeedX > 5 + D Then .Location.SpeedX = .Location.SpeedX - 0.2
                    If .Location.X + .Location.Width / 2 > Player(C).Location.X + Player(C).Location.Width / 2 + 50 + (Player(C).Location.SpeedX * 15) Then
                        .Special6 = 0
                    End If
                End If
                D = 1
                If numPlayers = 2 Then
                    If ScreenType = 5 Then
                        If DScreenType <> 5 Then D = 2
                    End If
                End If
                If .Location.Y + .Location.Height > Player(C).Location.Y - 248 Then
                    .Special2 = 1
                End If
                If .Location.Y + .Location.Height < Player(C).Location.Y - 256 Or .Location.Y < -vScreenY(D) Then
                    .Special2 = 0
                End If
                If .Location.Y > -vScreenY(D) + 64 Then
                    .Special2 = 1
                End If
                If .Location.Y < -vScreenY(D) + 72 Then
                    .Special2 = 0
                End If
                If .Special2 = 0 Then
                    .Location.SpeedY = .Location.SpeedY + 0.05
                    If .Location.SpeedY > 2 Then .Location.SpeedY = 2
                Else
                    .Location.SpeedY = .Location.SpeedY - 0.05
                    If .Location.SpeedY < -2 Then .Location.SpeedY = -2
                End If
                If .Inert = True Then
                    If .Special3 > 1 Then .Special3 = 0
                End If
                If Abs(.Location.X + .Location.Width / 2 - Player(C).Location.X + Player(C).Location.Width / 2) < 100 Then
                    If .Special4 = 0 Then
                        .Special3 = 2
                        .Special4 = 100
                    End If
                End If
            End If
            If .Special4 > 0 Then .Special4 = .Special4 - 1
            
            
            
            
            .Frame = 0
            If .FrameCount < 100 Then
                .FrameCount = .FrameCount + 1
                If .FrameCount < 8 Then
                    .Frame = 0
                ElseIf .FrameCount < 16 Then
                    .Frame = 1
                ElseIf .FrameCount < 24 Then
                    .Frame = 2
                ElseIf .FrameCount < 32 Then
                    .Frame = 1
                Else
                    .Frame = 0
                    .FrameCount = 0
                End If
            Else
                .FrameCount = .FrameCount + 1
                If .FrameCount < 108 Then
                    .Frame = 6
                ElseIf .FrameCount < 116 Then
                    .Frame = 7
                ElseIf .FrameCount < 124 Then
                    .Frame = 8
                ElseIf .FrameCount < 132 Then
                    .Frame = 7
                Else
                    .Frame = 0
                    .FrameCount = 0
                End If
            End If
            If .Direction = 1 Then .Frame = .Frame + 3
            .Special5 = .Special5 + 1
            If .Special5 >= 150 Then
                .Special5 = 150
                tempLocation = .Location
                With tempLocation
                    .X = .X - 16
                    .Y = .Y - 16
                    .Width = .Width + 32
                    .Height = .Height + 32
                End With
                D = 0
                If .Location.Y + .Location.Height > Player(C).Location.Y Then
                    D = 1
                Else
                    For E = 1 To numBlock
                        If CheckCollision(tempLocation, Block(E).Location) = True And BlockNoClipping(Block(E).Type) = False Then D = 1
                    Next E
                End If
                If D = 0 Then
                    .FrameCount = 100
                    .Special3 = 3
                    .Special5 = 0
                    numNPCs = numNPCs + 1
                    If .Location.X + .Location.Width / 2 > Player(C).Location.X + Player(C).Location.Width / 2 Then
                        NPC(numNPCs).Direction = -1
                    Else
                        NPC(numNPCs).Direction = 1
                    End If
                    With NPC(numNPCs)
                        .Type = NPC(A).Special
                        If .Type = 287 Then .Type = RandomBonus
                        .Location.Height = NPCHeight(.Type)
                        .Location.Width = NPCWidth(.Type)
                        .Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2 - .Location.Width / 2
                        .Location.Y = NPC(A).Location.Y
                        If NPC(A).CantHurt > 0 Then
                            .CantHurt = 100
                            .CantHurtPlayer = NPC(A).CantHurtPlayer
                        End If
                        .Location.Y = .Location.Y + 8
                        .Location.SpeedX = (1 + Rnd * 2) * .Direction
                        .Location.SpeedY = -7
                        .Active = True
                        .Section = NPC(A).Section
                        .TimeLeft = 100
                        If NPCIsACoin(.Type) Then
                            .Special = 1
                            .Location.SpeedX = .Location.SpeedX * 0.5
                        End If
                    End With
                    'tempNPC = NPC(A)
                    'NPC(A) = NPC(numNPCs)
                    'NPC(numNPCs) = tempNPC
                    If MagicHand = True Then
                        If .Special = .Type Then frmNPCs.ShowLak
                    End If
                    
                End If
            End If
        'nekkid koopa
        ElseIf .Type = 55 Then
            If .Special > 0 Then
                .Special = .Special - 1
                .Location.SpeedX = 0
            End If
        'beach koopa
        ElseIf .Type >= 117 And .Type <= 120 Then
            If .Type = 119 And .Special > 0 Then
                .Special = .Special - 1
                .Location.SpeedX = 0
            End If
            If .Projectile = True Then
                .Location.SpeedX = .Location.SpeedX * 0.96
                If .Location.SpeedX > -0.003 And .Location.SpeedX < 0.003 Then
                    .Projectile = False
                    .Location.Y = .Location.Y - Physics.NPCGravity
                    .Location.SpeedY = -5
                    .Direction = -.Direction
                End If
            Else
                If .Type <> 119 Then
                    If .Location.SpeedY = Physics.NPCGravity Then
                        For B = 1 To numNPCs
                            If NPC(B).Active = True And NPC(B).Section = .Section And NPC(B).Hidden = False And NPC(B).HoldingPlayer = 0 Then
                                If NPC(B).Type >= 113 And NPC(B).Type <= 116 Then
                                    tempLocation = .Location
                                    tempLocation2 = NPC(B).Location
                                    tempLocation.Width = tempLocation.Width + 32
                                    tempLocation.X = tempLocation.X - 16
                                    If CheckCollision(tempLocation, tempLocation2) = True Then
                                        .Location.Y = .Location.Y - Physics.NPCGravity
                                        .Location.SpeedY = -4
                                    End If
                                End If
                            End If
                        Next B
                    End If
                End If
            End If
        End If
        'Projectile code
        If NPCIsAShell(.Type) Or (.Type = 45 And .Special = 1) Then
            If .Location.SpeedX <> 0 Then .Projectile = True
        End If
        If .Type = 13 Then
            .Projectile = True
        ElseIf .Type = 17 And .CantHurt > 0 Then .Projectile = True
        ElseIf .Type = 12 Then .Projectile = False 'Stop the big fireballs from getting killed from tha lava
        ElseIf .Type = 50 Then ' killer plant destroys blocks
            For B = 1 To numBlock
                If CheckCollision(.Location, Block(B).Location) = True Then
                    BlockHitHard B
                End If
            Next B
        End If
    End With
End Sub

Public Sub CharStuff(Optional WhatNPC As Integer = 0, Optional CheckEggs As Boolean = False)
    Dim SMBX As Boolean
    Dim SMB2 As Boolean
    Dim TLOZ As Boolean
    Dim A As Integer
    Dim NPCStart As Integer
    Dim NPCStop As Integer
    If GameMenu = True Then Exit Sub
    For A = 1 To numPlayers
        If Player(A).Character = 1 Or Player(A).Character = 2 Then SMBX = True
        If Player(A).Character = 3 Or Player(A).Character = 4 Then SMB2 = True
        If Player(A).Character = 5 Then TLOZ = True
    Next A
    If WhatNPC = 0 Then
        NPCStart = 1
        NPCStop = numNPCs
    Else
        NPCStart = WhatNPC
        NPCStop = WhatNPC
    End If
    If SMBX = False And SMB2 = True Then  'Turn SMBX stuff into SMB2 stuff
        For A = NPCStart To NPCStop
            If NPC(A).Type = 96 And NPC(A).Special > 0 And CheckEggs = True Then  'Check Eggs
                If NPCIsYoshi(NPC(A).Special) Then 'Yoshi into mushroom (Egg)
                    'NPC(A).Special = 249
                    NPC(A).Special = 35 'Yoshi into boot
                End If
            End If
        Next A
    End If
    If SMBX = False And SMB2 = False And TLOZ = True Then  'Turn SMBX stuff into Zelda stuff
        For A = NPCStart To NPCStop
            If NPC(A).Active = True And NPC(A).Generator = False And NPC(A).Inert = False Then
                If NPC(A).Type = 9 Or NPC(A).Type = 184 Or NPC(A).Type = 185 Or NPCIsBoot(NPC(A).Type) Then    'turn mushrooms into hearts
                    NPC(A).Frame = 0
                    NPC(A).Type = 250
                    NPC(A).Location.SpeedX = 0
                    NPC(A).Location.Y = NPC(A).Location.Y + NPC(A).Location.Height - NPCHeight(NPC(A).Type) - 1
                    NPC(A).Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2 - NPCWidth(NPC(A).Type) / 2
                    NPC(A).Location.Width = 32
                    NPC(A).Location.Height = 32
                ElseIf NPC(A).Type = 10 Or NPC(A).Type = 33 Or NPC(A).Type = 88 Or NPC(A).Type = 138 Or NPC(A).Type = 258 Then 'turn coins into rupees
                    If NPC(A).Type = 258 Then
                        NPC(A).Type = 252
                    Else
                        NPC(A).Type = 251
                    End If
                    NPC(A).Location.Y = NPC(A).Location.Y + NPC(A).Location.Height - NPCHeight(NPC(A).Type)
                    NPC(A).Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2 - NPCWidth(NPC(A).Type) / 2
                    NPC(A).Location.Width = NPCWidth(NPC(A).Type)
                    NPC(A).Location.Height = NPCHeight(NPC(A).Type)
                    NPC(A).Frame = 0
                End If
            End If
            If NPC(A).Type = 96 And NPC(A).Special > 0 And CheckEggs = True Then  'Check Eggs
                If NPCIsYoshi(NPC(A).Special) Or NPCIsBoot(NPC(A).Special) Then 'Yoshi / boot into mushroom (Egg)
                    NPC(A).Special = 250
                End If
                If NPC(A).Special = 9 Or NPC(A).Special = 184 Or NPC(A).Special = 185 Then  'mushrooms into hearts (eggs)
                    NPC(A).Special = 250
                End If
                If NPC(A).Special = 10 Or NPC(A).Special = 33 Or NPC(A).Special = 88 Or (SMB2 = False And NPC(A).Special = 138) Then 'coins into rupees (eggs)
                    NPC(A).Special = 251
                End If
            End If
        Next A
    End If
End Sub

Public Function RandomBonus()
    Dim B As Integer
    B = Int(Rnd * 6)
    If B = 0 Then
        RandomBonus = 9
    ElseIf B = 1 Then
        RandomBonus = 14
    ElseIf B = 2 Then
        RandomBonus = 34
    ElseIf B = 3 Then
        RandomBonus = 169
    ElseIf B = 4 Then
        RandomBonus = 170
    ElseIf B = 5 Then
        RandomBonus = 264
    End If
End Function












