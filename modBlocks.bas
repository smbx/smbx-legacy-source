Attribute VB_Name = "modBlocks"
Option Explicit

Public Sub BlockHit(A As Integer, Optional HitDown As Boolean = False, Optional whatPlayer As Integer = 0) 'The block was hit by a player
    Dim tempPlayer As Integer
    Dim makeShroom As Boolean 'if true make amushroom
    Dim newBlock As Integer 'what the block should turn into if anything
    Dim C As Integer
    Dim B As Integer
    Dim blankBlock As Block
    Dim tempBool As Boolean
    Dim oldSpecial As Integer 'previous .Special
    Dim tempLocation As Location
    With Block(A)
        If BattleMode = True And .RespawnDelay = 0 Then
            .RespawnDelay = 1
        End If
        If (.Type >= 622 And .Type <= 625) Or .Type = 631 Then
            If whatPlayer = 0 Then
                Exit Sub
            Else
                .Special = 0
                For B = 1 To numPlayers
                    SavedChar(Player(whatPlayer).Character) = Player(whatPlayer)
                    If Player(B).Character = 1 Then BlockFrame(622) = 4
                    If Player(B).Character = 2 Then BlockFrame(623) = 4
                    If Player(B).Character = 3 Then BlockFrame(624) = 4
                    If Player(B).Character = 4 Then BlockFrame(625) = 4
                    If Player(B).Character = 5 Then BlockFrame(631) = 4
                Next B
                If BlockFrame(.Type) < 4 Then
                    PlaySound 34
                    'UnDuck whatPlayer
                    If .Type = 622 Then Player(whatPlayer).Character = 1
                    If .Type = 623 Then Player(whatPlayer).Character = 2
                    If .Type = 624 Then Player(whatPlayer).Character = 3
                    If .Type = 625 Then Player(whatPlayer).Character = 4
                    If .Type = 631 Then Player(whatPlayer).Character = 5
                    With Player(whatPlayer)
                        Player(whatPlayer).State = SavedChar(Player(whatPlayer).Character).State
                        Player(whatPlayer).HeldBonus = SavedChar(Player(whatPlayer).Character).HeldBonus
                        Player(whatPlayer).Mount = SavedChar(Player(whatPlayer).Character).Mount
                        Player(whatPlayer).MountType = SavedChar(Player(whatPlayer).Character).MountType
                        Player(whatPlayer).Hearts = SavedChar(Player(whatPlayer).Character).Hearts
                        If .State = 0 Then .State = 1
                        .FlySparks = False
                        .Immune = 50
                        .Effect = 8
                        .Effect2 = 14
                        If .Mount <= 1 Then
                            .Location.Height = Physics.PlayerHeight(.Character, .State)
                            If .Mount = 1 And .State = 1 Then .Location.Height = Physics.PlayerHeight(1, 2)
                            .StandUp = True
                        End If
                        tempLocation = .Location
                        tempLocation.Y = .Location.Y + .Location.Height / 2 - 16
                        tempLocation.X = .Location.X + .Location.Width / 2 - 16
                        NewEffect 10, tempLocation
                    End With
                Else
                    Exit Sub
                End If
            End If
        End If
    
    
        oldSpecial = .Special
        If .ShakeY <> 0 Or .ShakeY2 <> 0 Or .ShakeY3 <> 0 Then 'if the block has just been hit, ignore
            If .RapidHit > 0 And Player(whatPlayer).Character = 4 And whatPlayer > 0 Then
                .RapidHit = Int(Rnd * 3) + 1
            End If
            Exit Sub
        End If
        .Invis = False
        If HitDown = True And .Special > 0 Then
            tempBool = False
            For B = 1 To numBlock
                If B <> A Then
                    If CheckCollision(Block(A).Location, newLoc(Block(B).Location.X + 4, Block(B).Location.Y - 16, Block(B).Location.Width - 8, Block(B).Location.Height)) Then
                        HitDown = False
                        Exit For
                    End If
                End If
            Next B
        End If
        
If nPlay.Online = True And nPlay.Mode = 1 Then 'online code
    If HitDown = False Then
        Netplay.sendData "3a" & B & LB
    Else
        Netplay.sendData "3b" & B & LB
    End If
End If
    
    If .Special = 1225 Or .Special = 1226 Or .Special = 1227 Then
        HitDown = False
    End If
        
        'Shake the block
        If .Type = 4 Or .Type = 615 Or .Type = 55 Or .Type = 60 Or .Type = 90 Or .Type = 159 Or .Type = 169 Or .Type = 170 Or .Type = 173 Or .Type = 176 Or .Type = 179 Or .Type = 188 Or .Type = 226 Or .Type = 281 Or .Type = 282 Or .Type = 283 Or (.Type >= 622 And .Type <= 625) Then
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
        End If
        If .Type = 169 Then
            PlaySound 32
            BeltDirection = -BeltDirection 'for the blet direction changing block
        End If
        If .Type = 170 Then 'smw switch blocks
            PlaySound 32
            For B = 1 To numBlock
                If Block(B).Type = 171 Then
                    Block(B).Type = 172
                ElseIf Block(B).Type = 172 Then
                    Block(B).Type = 171
                End If
            Next B
            For B = 1 To numNPCs
                If NPC(B).Type = 60 Then
                    NPC(B).Direction = -NPC(B).Direction
                End If
            Next B
        End If
        If .Type = 173 Then 'smw switch blocks
            PlaySound 32
            For B = 1 To numBlock
                If Block(B).Type = 174 Then
                    Block(B).Type = 175
                ElseIf Block(B).Type = 175 Then
                    Block(B).Type = 174
                End If
            Next B
            For B = 1 To numNPCs
                If NPC(B).Type = 62 Then
                    NPC(B).Direction = -NPC(B).Direction
                End If
            Next B
        End If
        If .Type = 176 Then 'smw switch blocks
            PlaySound 32
            For B = 1 To numBlock
                If Block(B).Type = 177 Then
                    Block(B).Type = 178
                ElseIf Block(B).Type = 178 Then
                    Block(B).Type = 177
                End If
            Next B
            For B = 1 To numNPCs
                If NPC(B).Type = 64 Then
                    NPC(B).Direction = -NPC(B).Direction
                End If
            Next B
        End If
        If .Type = 179 Then 'smw switch blocks
            PlaySound 32
            For B = 1 To numBlock
                If Block(B).Type = 180 Then
                    Block(B).Type = 181
                ElseIf Block(B).Type = 181 Then
                    Block(B).Type = 180
                End If
            Next B
            For B = 1 To numNPCs
                If NPC(B).Type = 66 Then
                    NPC(B).Direction = -NPC(B).Direction
                End If
            Next B
        End If
'Find out what the block should turn into
        If .Type = 88 Or .Type = 90 Or .Type = 89 Or .Type = 171 Or .Type = 174 Or .Type = 177 Or .Type = 180 Then 'SMW
            newBlock = 89
        ElseIf .Type = 188 Or .Type = 192 Or .Type = 193 Or .Type = 60 Or .Type = 369 Then 'SMB1
            newBlock = 192
        ElseIf .Type = 224 Or .Type = 225 Or .Type = 226 Then 'Large SMB3 blocks
            newBlock = 225
        ElseIf .Type = 159 Then 'SMB3 Battle Block
            newBlock = 159
        Else 'Everything else defaults to SMB3
            newBlock = 2
        End If
        If .Special > 0 And .Special < 100 Then 'Block has coins
            If whatPlayer > 0 And Player(whatPlayer).Character = 4 Then .RapidHit = Int(Rnd * 3) + 1
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            If whatPlayer > 0 And (Player(whatPlayer).Character = 2 Or Player(whatPlayer).Character = 5) Then
                tempBool = False
                For B = 1 To numBlock
                    If B <> A And Block(B).Hidden = False And Not BlockOnlyHitspot1(Block(B).Type) And Not BlockIsSizable(Block(B).Type) Then
                        If CheckCollision(Block(B).Location, newLoc(.Location.X + 1, .Location.Y - 31, 30, 30)) Then
                            tempBool = True
                            Exit For
                        End If
                    End If
                Next B
                If tempBool = False Then
                    For B = 1 To .Special
                        numNPCs = numNPCs + 1
                        With NPC(numNPCs)
                            .Active = True
                            .TimeLeft = 100
                            If newBlock = 89 Then
                                .Type = 33
                            ElseIf newBlock = 192 Then
                                .Type = 88
                            Else
                                .Type = 10
                            End If
                            If Player(whatPlayer).Character = 5 Then
                                .Type = 251
                                If Rnd * 20 <= 3 Then .Type = 252
                                If Rnd * 60 <= 3 Then .Type = 253
                                PlaySound 81
                            Else
                                PlaySound 14
                            End If
                            .Location.Width = NPCWidth(.Type)
                            .Location.Height = NPCHeight(.Type)
                            .Location.X = Block(A).Location.X + Block(A).Location.Width / 2 - .Location.Width / 2
                            .Location.Y = Block(A).Location.Y - .Location.Height - 0.01
                            .Location.SpeedX = Rnd * 3 - 1.5
                            .Location.SpeedY = -Rnd * 4 - 3
                            If HitDown = True Then
                                .Location.SpeedY = -.Location.SpeedY * 0.5
                                .Location.Y = Block(A).Location.Y + Block(A).Location.Height
                            End If
                            .Special = 1
                            .Immune = 20
                            CheckSectionNPC numNPCs
                        End With
                        If B > 20 Or (Player(whatPlayer).Character = 5 And B > 5) Then Exit For
                    Next B
                    .Special = 0
                Else
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
                    PlaySound 14
                    NewEffect 11, .Location
                    .Special = .Special - 1
                End If
            ElseIf .RapidHit > 0 Then '(whatPlayer > 0 And Player(whatPlayer).Character = 3)
                tempBool = False
                For B = 1 To numBlock
                    If B <> A And Block(B).Hidden = False And Not BlockOnlyHitspot1(Block(B).Type) And Not BlockIsSizable(Block(B).Type) Then
                        If CheckCollision(Block(B).Location, newLoc(.Location.X + 1, .Location.Y - 31, 30, 30)) Then
                            tempBool = True
                            Exit For
                        End If
                    End If
                Next B
                If tempBool = False Then
                    numNPCs = numNPCs + 1
                    With NPC(numNPCs)
                        .Active = True
                        .TimeLeft = 100
                        If newBlock = 89 Then
                            .Type = 33
                        ElseIf newBlock = 192 Then
                            .Type = 88
                        Else
                            .Type = 10
                        End If
                        .Type = 138
                        .Location.Width = NPCWidth(.Type)
                        .Location.Height = NPCHeight(.Type)
                        .Location.X = Block(A).Location.X + Block(A).Location.Width / 2 - .Location.Width / 2
                        .Location.Y = Block(A).Location.Y - .Location.Height - 0.01
                        .Location.SpeedX = Rnd * 3 - 1.5
                        .Location.SpeedY = -Rnd * 4 - 3
                        .Special = 1
                        .Immune = 20
                        PlaySound 14
                        CheckSectionNPC numNPCs
                    End With
                    .Special = .Special - 1
                Else
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
                    PlaySound 14
                    NewEffect 11, .Location
                    .Special = .Special - 1
                End If
                
            Else
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
                PlaySound 14
                NewEffect 11, .Location
                .Special = .Special - 1
            End If
            If .Special = 0 And Not .Type = 55 Then
                .Type = newBlock
                .Location.Height = BlockHeight(newBlock)
                .Location.Width = BlockWidth(newBlock)
            End If
        ElseIf .Special >= 1000 Then 'New spawn code
            C = .Special - 1000 'this finds the NPC type and puts in the variable C
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            .Special = 0
            If Not .Type = 55 Then '55 is the bouncy note block
                .Type = newBlock
                .Location.Height = BlockHeight(newBlock)
                .Location.Width = BlockWidth(newBlock)
            End If
            If NPCIsABonus(C) And C <> 169 And C <> 170 Then 'check to see if it should spawn a dead player
                tempPlayer = CheckDead
                If numPlayers > 2 And nPlay.Online = False Then tempPlayer = 0
            End If
            
'don't spawn players from blocks anymore
    tempPlayer = 0
            
            If tempPlayer = 0 Then 'Spawn the npc
                numNPCs = numNPCs + 1 'create a new NPC
                NPC(numNPCs).Active = True
                NPC(numNPCs).TimeLeft = 1000
                If NPCIsYoshi(C) Then
                    NPC(numNPCs).Type = 96
                    NPC(numNPCs).Special = C
                ElseIf numPlayers > 2 Then
                    NPC(numNPCs).Type = C
                ElseIf C = 14 Or C = 34 Or C = 264 Or C = 277 Then
                    For B = 1 To numPlayers
                        If Player(B).State = 1 And Player(B).Character <> 5 Then makeShroom = True
                    Next B
                    If makeShroom = False Then
                        NPC(numNPCs).Type = C
                    Else
                        NPC(numNPCs).Type = 9
                    End If
                ElseIf C = 183 Then
                    For B = 1 To numPlayers
                        If Player(B).State = 1 And Player(B).Character <> 5 Then makeShroom = True
                    Next B
                    If makeShroom = False Then
                        NPC(numNPCs).Type = C
                    Else
                        NPC(numNPCs).Type = 185
                    End If
                ElseIf C = 182 Then
                    For B = 1 To numPlayers
                        If Player(B).State = 1 And Player(B).Character <> 5 Then makeShroom = True
                    Next B
                    If makeShroom = False Then
                        NPC(numNPCs).Type = C
                    Else
                        NPC(numNPCs).Type = 184
                    End If
                Else
                    NPC(numNPCs).Type = C
                End If
                If makeShroom = True And whatPlayer > 0 And (Player(whatPlayer).State > 1 Or Player(whatPlayer).Character = 5) Then NPC(numNPCs).Type = C  'set the NPC type if the conditions are met
                If makeShroom = True And BattleMode = True Then NPC(numNPCs).Type = C 'always spawn the item in battlemode
                If NPC(numNPCs).Type = 287 Then NPC(numNPCs).Type = RandomBonus
                CharStuff numNPCs
                NPC(numNPCs).Location.Width = NPCWidth(C)
                If .Location.Width = 32 Then
                    .Location.Width = .Location.Width - 0.1
                    .Location.X = .Location.X + 0.05
                End If
                NPC(numNPCs).Location.Height = 0
                NPC(numNPCs).Location.X = (.Location.X + .Location.Width / 2 - NPC(numNPCs).Location.Width / 2)
                NPC(numNPCs).Location.SpeedX = 0
                NPC(numNPCs).Location.SpeedY = 0
                
                
                
                If NPCIsYoshi(C) Then 'if the npc is yoshi then set the color of the egg
                    If C = 98 Then
                        NPC(numNPCs).Frame = 1
                    ElseIf C = 99 Then
                        NPC(numNPCs).Frame = 2
                    ElseIf C = 100 Then
                        NPC(numNPCs).Frame = 3
                    ElseIf C = 148 Then
                        NPC(numNPCs).Frame = 4
                    ElseIf C = 149 Then
                        NPC(numNPCs).Frame = 5
                    ElseIf C = 150 Then
                        NPC(numNPCs).Frame = 6
                    End If
                End If
                If HitDown = False Then
                    NPC(numNPCs).Location.Y = .Location.Y '- 0.1
                    NPC(numNPCs).Location.Height = 0
                    If NPCIsYoshi(C) Then
                        NPC(numNPCs).Effect = 0
                        NPC(numNPCs).Location.Height = 32
                        NPC(numNPCs).Location.Y = .Location.Y - 32
                    ElseIf NPC(numNPCs).Type = 34 Then
                        NPC(numNPCs).Effect = 0
                        NPC(numNPCs).Location.Y = .Location.Y - 32
                        NPC(numNPCs).Location.SpeedY = -6
                        NPC(numNPCs).Location.Height = NPCHeight(C)
                        PlaySound 7
                    Else
                        NPC(numNPCs).Effect = 1
                        PlaySound 7
                    End If
                Else
                    NPC(numNPCs).Location.Y = .Location.Y + 4
                    NPC(numNPCs).Location.Height = NPCHeight(C)
                    NPC(numNPCs).Effect = 3
                    PlaySound 7
                End If
                NPC(numNPCs).Effect2 = 0
                CheckSectionNPC numNPCs
                With NPC(numNPCs)
                    If NPCIsYoshi(.Type) Or NPCIsBoot(.Type) Or .Type = 9 Or .Type = 14 Or .Type = 22 Or .Type = 90 Or .Type = 153 Or .Type = 169 Or .Type = 170 Or .Type = 182 Or .Type = 183 Or .Type = 184 Or .Type = 185 Or .Type = 186 Or .Type = 187 Or .Type = 188 Or .Type = 195 Then .TimeLeft = Physics.NPCTimeOffScreen * 20
                End With
            Else 'Spawn the player
                PlaySound 7
                Player(tempPlayer).State = 1
                Player(tempPlayer).Location.Width = Physics.PlayerWidth(Player(tempPlayer).Character, Player(tempPlayer).State)
                Player(tempPlayer).Location.Height = Physics.PlayerHeight(Player(tempPlayer).Character, Player(tempPlayer).State)
                Player(tempPlayer).Frame = 1
                Player(tempPlayer).Dead = False
                Player(tempPlayer).Location.X = .Location.X + .Location.Width * 0.5 - Player(tempPlayer).Location.Width * 0.5
                If HitDown = False Then
                    Player(tempPlayer).Location.Y = .Location.Y - 0.1 - Player(tempPlayer).Location.Height
                Else
                    Player(tempPlayer).Location.Y = .Location.Y + 0.1 + .Location.Height
                End If
                Player(tempPlayer).Location.SpeedX = 0
                Player(tempPlayer).Location.SpeedY = 0
                Player(tempPlayer).Immune = 150
            End If
            
        ElseIf .Special = 100 Then 'Block contains a mushroom
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            .Special = 0
            If Not .Type = 55 Then
                .Type = newBlock
                .Location.Height = BlockHeight(newBlock)
                .Location.Width = BlockWidth(newBlock)
            End If
            tempPlayer = CheckDead
            If numPlayers > 2 And nPlay.Online = False Then tempPlayer = 0
            PlaySound 7
            If tempPlayer = 0 Then
                numNPCs = numNPCs + 1
                NPC(numNPCs).Active = True
                NPC(numNPCs).TimeLeft = 1000
                NPC(numNPCs).Type = 9
                NPC(numNPCs).Location.Width = NPCWidth(9)
                NPC(numNPCs).Location.X = (.Location.X + .Location.Width / 2 - NPC(numNPCs).Location.Width / 2)
                NPC(numNPCs).Location.SpeedX = 0
                NPC(numNPCs).Location.SpeedY = 0
                If HitDown = False Then
                    NPC(numNPCs).Location.Y = .Location.Y - 0.1
                    NPC(numNPCs).Location.Height = 0
                    NPC(numNPCs).Effect = 1
                Else
                    NPC(numNPCs).Location.Y = .Location.Y + 4
                    NPC(numNPCs).Location.Height = 32
                    NPC(numNPCs).Effect = 3
                End If
                NPC(numNPCs).Effect2 = 0
                CheckSectionNPC numNPCs
            Else
                Player(tempPlayer).Location.Width = Physics.PlayerWidth(Player(tempPlayer).Character, Player(tempPlayer).State)
                Player(tempPlayer).Location.Height = Physics.PlayerHeight(Player(tempPlayer).Character, Player(tempPlayer).State)
                Player(tempPlayer).Frame = 1
                Player(tempPlayer).Dead = False
                Player(tempPlayer).Location.X = .Location.X + .Location.Width * 0.5 - Player(tempPlayer).Location.Width * 0.5
                If HitDown = False Then
                    Player(tempPlayer).Location.Y = .Location.Y - 0.1 - Player(tempPlayer).Location.Height
                Else
                    Player(tempPlayer).Location.Y = .Location.Y + 0.1 + .Location.Height
                End If
                Player(tempPlayer).Location.SpeedX = 0
                Player(tempPlayer).Location.SpeedY = 0
                Player(tempPlayer).Immune = 150
            End If
        ElseIf .Special = 102 Then 'Block contains a fire flower
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            .Special = 0
            If Not .Type = 55 Then
                .Type = newBlock
                .Location.Height = BlockHeight(newBlock)
                .Location.Width = BlockWidth(newBlock)
            End If
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            tempPlayer = CheckDead
            If numPlayers > 2 And nPlay.Online = False Then tempPlayer = 0
            PlaySound 7
            If tempPlayer = 0 Then
                numNPCs = numNPCs + 1
                NPC(numNPCs).Active = True
                NPC(numNPCs).TimeLeft = 1000
                For B = 1 To numPlayers
                    If Player(B).State = 1 Then makeShroom = True
                Next B
                If makeShroom = False Then
                    NPC(numNPCs).Type = 14
                Else
                    NPC(numNPCs).Type = 9
                End If
                NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                NPC(numNPCs).Location.X = (.Location.X + .Location.Width / 2 - NPC(numNPCs).Location.Width / 2)
                NPC(numNPCs).Location.SpeedX = 0
                NPC(numNPCs).Location.SpeedY = 0
                If HitDown = False Then
                    NPC(numNPCs).Location.Y = .Location.Y - 0.1
                    NPC(numNPCs).Location.Height = 0
                    NPC(numNPCs).Effect = 1
                Else
                    NPC(numNPCs).Location.Y = .Location.Y + 4
                    NPC(numNPCs).Location.Height = 32
                    NPC(numNPCs).Effect = 3
                End If
                NPC(numNPCs).Effect2 = 0
                CheckSectionNPC numNPCs
            Else 'Rez player
                Player(tempPlayer).Frame = 1
                Player(tempPlayer).Dead = False
                Player(tempPlayer).Location.Width = Physics.PlayerWidth(Player(tempPlayer).Character, Player(tempPlayer).State)
                Player(tempPlayer).Location.Height = Physics.PlayerHeight(Player(tempPlayer).Character, Player(tempPlayer).State)
                Player(tempPlayer).Location.X = .Location.X + .Location.Width * 0.5 - Player(tempPlayer).Location.Width * 0.5
                If HitDown = False Then
                    Player(tempPlayer).Location.Y = .Location.Y - 0.1 - Player(tempPlayer).Location.Height
                Else
                    Player(tempPlayer).Location.Y = .Location.Y + 0.1 + .Location.Height
                End If
                Player(tempPlayer).Location.SpeedX = 0
                Player(tempPlayer).Location.SpeedY = 0
                Player(tempPlayer).Immune = 150
            End If
        ElseIf .Special = 103 Then 'Block contains a Leaf
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            .Special = 0
            If Not .Type = 55 Then
                .Type = newBlock
                .Location.Height = BlockHeight(.Type)
                .Location.Width = BlockWidth(.Type)
            End If
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            tempPlayer = CheckDead
            If numPlayers > 2 And nPlay.Online = False Then tempPlayer = 0
            PlaySound 7
            If tempPlayer = 0 Then
                numNPCs = numNPCs + 1
                NPC(numNPCs).Active = True
                NPC(numNPCs).TimeLeft = 1000
                For B = 1 To numPlayers
                    If Player(B).State = 1 Then makeShroom = True
                Next B
                If makeShroom = False Then
                    NPC(numNPCs).Type = 34
                Else
                    NPC(numNPCs).Type = 9
                End If
                NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                NPC(numNPCs).Location.X = (.Location.X + .Location.Width / 2 - NPC(numNPCs).Location.Width / 2)
                NPC(numNPCs).Location.SpeedX = 0
                If HitDown = False Then
                    If NPC(numNPCs).Type = 34 Then
                        NPC(numNPCs).Location.Y = .Location.Y - 32
                        NPC(numNPCs).Location.SpeedY = -6
                        NPC(numNPCs).Location.Height = NPCHeight(34)
                    Else
                        NPC(numNPCs).Location.Y = .Location.Y - 0.1
                        NPC(numNPCs).Location.Height = 0
                        NPC(numNPCs).Effect = 1
                    End If
                Else
                    NPC(numNPCs).Location.Y = .Location.Y + 4
                    NPC(numNPCs).Location.Height = 32
                    NPC(numNPCs).Effect = 3
                End If
                NPC(numNPCs).Effect2 = 0
                CheckSectionNPC numNPCs
            Else 'Rez player
                Player(tempPlayer).Location.Width = Physics.PlayerWidth(Player(tempPlayer).Character, Player(tempPlayer).State)
                Player(tempPlayer).Location.Height = Physics.PlayerHeight(Player(tempPlayer).Character, Player(tempPlayer).State)
                Player(tempPlayer).Frame = 1
                Player(tempPlayer).Dead = False
                Player(tempPlayer).Location.X = .Location.X + .Location.Width * 0.5 - Player(tempPlayer).Location.Width * 0.5
                If HitDown = False Then
                    Player(tempPlayer).Location.Y = .Location.Y - 0.1 - Player(tempPlayer).Location.Height
                Else
                    Player(tempPlayer).Location.Y = .Location.Y + 0.1 + .Location.Height
                End If
                Player(tempPlayer).Location.SpeedX = 0
                Player(tempPlayer).Location.SpeedY = 0
                Player(tempPlayer).Immune = 150
            End If
        ElseIf .Special = 104 Then 'Block contains a Shoe
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            .Special = 0
            If Not .Type = 55 Then
                .Type = newBlock
                .Location.Height = BlockHeight(newBlock)
                .Location.Width = BlockWidth(newBlock)
            End If
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            PlaySound 7
            numNPCs = numNPCs + 1
            NPC(numNPCs).Active = True
            NPC(numNPCs).TimeLeft = 100
            NPC(numNPCs).Type = 35
            NPC(numNPCs).Direction = -1
            NPC(numNPCs).Location.Width = NPCWidth(35)
            NPC(numNPCs).Location.X = (.Location.X + .Location.Width / 2 - NPC(numNPCs).Location.Width / 2)
            NPC(numNPCs).Location.Y = .Location.Y - 0.1
            NPC(numNPCs).Location.SpeedX = 0
            NPC(numNPCs).Location.SpeedY = 0
            If HitDown = False Then
                NPC(numNPCs).Location.Y = .Location.Y - 0.1
                NPC(numNPCs).Location.Height = 0
                NPC(numNPCs).Effect = 1
            Else
                NPC(numNPCs).Location.Y = .Location.Y + 4
                NPC(numNPCs).Location.Height = 32
                NPC(numNPCs).Effect = 3
            End If
            NPC(numNPCs).Effect2 = 0
            CheckSectionNPC numNPCs
        ElseIf .Special = 105 Then 'Block contains a Green Yoshi
        
            SoundPause(2) = 2
            PlaySound 7
        
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            .Special = 0
            If Not .Type = 55 Then
                .Type = newBlock
                .Location.Height = BlockHeight(newBlock)
                .Location.Width = BlockWidth(newBlock)
            End If
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            numNPCs = numNPCs + 1
            NPC(numNPCs).Active = True
            NPC(numNPCs).TimeLeft = 100
            NPC(numNPCs).Type = 96
            NPC(numNPCs).Special = 95
            NPC(numNPCs).Direction = 1
            NPC(numNPCs).Location.Width = NPCWidth(96)
            NPC(numNPCs).Location.X = (.Location.X + .Location.Width / 2 - NPC(numNPCs).Location.Width / 2)
            NPC(numNPCs).Location.Y = .Location.Y - 0.1
            NPC(numNPCs).Location.SpeedX = 0
            NPC(numNPCs).Location.SpeedY = 0
            If HitDown = False Then
                NPC(numNPCs).Location.Height = 32
                NPC(numNPCs).Location.Y = .Location.Y - 32
                NPC(numNPCs).Effect = 0
            Else
                PlaySound 7
                NPC(numNPCs).Location.Y = .Location.Y + 4
                NPC(numNPCs).Location.Height = 32
                NPC(numNPCs).Effect = 3
            End If
            NPC(numNPCs).Effect2 = 0
            CheckSectionNPC numNPCs
         ElseIf .Special = 101 Then 'Block contains a Goomba
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            .Special = 0
            If Not .Type = 55 Then
                .Type = newBlock
                .Location.Height = BlockHeight(newBlock)
                .Location.Width = BlockWidth(newBlock)
            End If
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            PlaySound 7
            numNPCs = numNPCs + 1
            NPC(numNPCs).Active = True
            NPC(numNPCs).TimeLeft = 100
            NPC(numNPCs).Type = 1
            NPC(numNPCs).Location.Width = NPCWidth(9)
            NPC(numNPCs).Location.X = (.Location.X + .Location.Width / 2 - NPC(numNPCs).Location.Width / 2)
            NPC(numNPCs).Location.Y = .Location.Y - 0.1
            NPC(numNPCs).Location.SpeedX = 0
            NPC(numNPCs).Location.SpeedY = 0
            If HitDown = False Then
                NPC(numNPCs).Location.Y = .Location.Y - 0.1
                NPC(numNPCs).Location.Height = 0
                NPC(numNPCs).Effect = 1
            Else
                NPC(numNPCs).Location.Y = .Location.Y + 4
                NPC(numNPCs).Location.Height = 32
                NPC(numNPCs).Effect = 3
            End If
            NPC(numNPCs).Effect2 = 0
            CheckSectionNPC numNPCs
         ElseIf .Special = 201 Then 'Block contains a 1-up
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            .Special = 0
            If Not .Type = 55 Then
                .Type = newBlock
                .Location.Height = BlockHeight(newBlock)
                .Location.Width = BlockWidth(newBlock)
            End If
            If HitDown = False Then
                BlockShakeUp A
            Else
                BlockShakeDown A
            End If
            PlaySound 7
            numNPCs = numNPCs + 1
            NPC(numNPCs).Active = True
            NPC(numNPCs).TimeLeft = 100
            NPC(numNPCs).Type = 90
            NPC(numNPCs).Location.Width = NPCWidth(90)
            NPC(numNPCs).Location.X = (.Location.X + .Location.Width / 2 - NPC(numNPCs).Location.Width / 2)
            NPC(numNPCs).Location.Y = .Location.Y - 0.1
            NPC(numNPCs).Location.SpeedX = 0
            NPC(numNPCs).Location.SpeedY = 0
            If HitDown = False Then
                NPC(numNPCs).Location.Y = .Location.Y - 0.1
                NPC(numNPCs).Location.Height = 0
                NPC(numNPCs).Effect = 1
            Else
                NPC(numNPCs).Location.Y = .Location.Y + 4
                NPC(numNPCs).Location.Height = 32
                NPC(numNPCs).Effect = 3
            End If
            NPC(numNPCs).Effect2 = 0
            CheckSectionNPC numNPCs
        End If
        If PSwitchTime > 0 And newBlock = 89 And .Special = 0 And oldSpecial > 0 Then
            numNPCs = numNPCs + 1
                With NPC(numNPCs)
                   .Active = True
                   .TimeLeft = 1
                   .Type = 33
                   .Block = 89
                   .Location = Block(A).Location
                   .Location.Width = NPCWidth(.Type)
                   .Location.Height = NPCHeight(.Type)
                   .Location.X = .Location.X + (Block(A).Location.Width - .Location.Width) / 2
                   .Location.Y = .Location.Y - 0.01
                   .DefaultLocation = .Location
                   .DefaultType = .Type
                   CheckSectionNPC numNPCs
                End With
            Block(A) = blankBlock
        End If
        If .Type = 90 Then BlockHitHard A
    End With
End Sub

Public Sub BlockShakeUp(A As Integer) 'Shake the block up
    If Block(A).Hidden = False Then
        With Block(A)
            .ShakeY = -12 'Go up
            .ShakeY2 = 12 'Come back down
            .ShakeY3 = 0
        End With
        If A <> iBlock(iBlocks) Then
            iBlocks = iBlocks + 1
            iBlock(iBlocks) = A
        End If
    End If
End Sub

Public Sub BlockShakeUpPow(A As Integer) 'Shake the block up
    If Block(A).Hidden = False Then
        With Block(A)
            .ShakeY = -6 'Go up
            .ShakeY2 = 6 'Come back down
            .ShakeY3 = 0
        End With
        If A <> iBlock(iBlocks) Then
            iBlocks = iBlocks + 1
            iBlock(iBlocks) = A
        End If
    End If
End Sub

Public Sub BlockShakeDown(A As Integer) 'Shake the block down
    If Block(A).Hidden = False Then
        With Block(A)
            .ShakeY = 12 'Go down
            .ShakeY2 = -12 'Come back up
            .ShakeY3 = 0
        End With
        If A <> iBlock(iBlocks) Then
            iBlocks = iBlocks + 1
            iBlock(iBlocks) = A
        End If
    End If
End Sub

Public Sub BlockHitHard(A As Integer)
    If Block(A).Hidden = False Then
    
If nPlay.Online = True And nPlay.Mode = 1 Then
    Netplay.sendData "3c" & A & LB
End If
    
        If Block(A).Type = 90 Then
            'Block(A).Hidden = True
            'NewEffect 82, Block(A).Location, , A
            'PlaySound 3
        Else
            Block(A).Kill = True
            iBlocks = iBlocks + 1
            iBlock(iBlocks) = A
        End If
    End If
End Sub

Public Sub KillBlock(A As Integer, Optional Splode As Boolean = True)  'Destroy a block
    Dim blankBlock As Block
    Dim tempBool As Boolean
    Dim C As Integer
    If Block(A).Hidden = True Then Exit Sub
    If BattleMode = True And Block(A).RespawnDelay = 0 Then
        Block(A).RespawnDelay = 1
    End If
    If Splode = True Then
        If Block(A).Type = 526 Then
            PlaySound 64
        ElseIf Block(A).Type = 186 Then
            PlaySound 43
        Else
            PlaySound 4 'Block smashed
        End If
        'Create the break effect
        If Block(A).Type = 60 Then
            NewEffect 21, Block(A).Location
        ElseIf Block(A).Type = 188 Then
            NewEffect 51, Block(A).Location
        ElseIf Block(A).Type = 457 Then
            NewEffect 100, Block(A).Location
        ElseIf Block(A).Type = 526 Then
            NewEffect 107, Block(A).Location
        ElseIf Block(A).Type = 293 Then
            NewEffect 135, Block(A).Location
        Else
            NewEffect 1, Block(A).Location
        End If
    End If
    If LevelEditor = True Then
        If numBlock > 0 Then
            Block(A) = Block(numBlock)
            Block(numBlock) = blankBlock
            numBlock = numBlock - 1
        End If
    Else
        Score = Score + 50
        If Block(A).TriggerDeath <> "" Then
            ProcEvent Block(A).TriggerDeath
        End If
        If Block(A).TriggerLast <> "" Then
            tempBool = False
            For C = 1 To numNPCs
                If NPC(C).Layer = Block(A).Layer And NPC(C).Generator = False Then tempBool = True
            Next C
            For C = 1 To numBlock
                If C <> A Then
                    If Block(A).Layer = Block(C).Layer Then tempBool = True
                End If
            Next C
            If tempBool = False Then ProcEvent Block(A).TriggerLast
        End If
        Block(A).Hidden = True
        Block(A).Layer = "Destroyed Blocks"
        Block(A).Kill = False
    End If
End Sub

Public Sub BlockFrames() 'update the frames for animated blocks
    Dim A As Integer
    
    Dim pChar(0 To 5) As Boolean
    
    Dim tempBool As Boolean
    If FreezeNPCs = True Then Exit Sub
    'Update block frame counter
    BlockFrame2(4) = BlockFrame2(4) + 1
    If BlockFrame2(4) = 8 Then BlockFrame2(4) = 0
    BlockFrame2(5) = BlockFrame2(5) + 1
    If BlockFrame2(5) = 8 Then BlockFrame2(5) = 0
    BlockFrame2(30) = BlockFrame2(30) + 1
    If BlockFrame2(30) = 8 Then BlockFrame2(30) = 0
    BlockFrame2(55) = BlockFrame2(55) + 1
    If BlockFrame2(55) = 8 Then BlockFrame2(55) = 0
    BlockFrame2(88) = BlockFrame2(88) + 1
    If BlockFrame2(88) = 8 Then BlockFrame2(88) = 0
    BlockFrame2(109) = BlockFrame2(109) + 1
    If BlockFrame2(109) = 4 Then BlockFrame2(109) = 0
    BlockFrame2(371) = BlockFrame2(371) + 1
    If BlockFrame2(371) = 8 Then BlockFrame2(371) = 0
    BlockFrame2(379) = BlockFrame2(379) + 1
    If BlockFrame2(379) >= 12 Then BlockFrame2(379) = 0
    'Check if the block type is ready for the next frame
    If BlockFrame2(4) = 0 Then
        BlockFrame(4) = BlockFrame(4) + 1
        If BlockFrame(4) = 4 Then BlockFrame(4) = 0
    End If
    If BlockFrame2(5) = 0 Then
        BlockFrame(5) = BlockFrame(5) + 1
        If BlockFrame(5) = 4 Then BlockFrame(5) = 0
    End If
    BlockFrame(598) = BlockFrame(5)
    BlockFrame(511) = BlockFrame(5)
    BlockFrame(169) = BlockFrame(5)
    BlockFrame(173) = BlockFrame(5)
    BlockFrame(176) = BlockFrame(5)
    BlockFrame(179) = BlockFrame(5)
    BlockFrame(193) = BlockFrame(5)
    BlockFrame(389) = BlockFrame(5)
    BlockFrame(391) = BlockFrame(5)
    BlockFrame(392) = BlockFrame(5)
    BlockFrame(404) = BlockFrame(5)
    BlockFrame(459) = BlockFrame(5)
    BlockFrame(460) = BlockFrame(5)
    BlockFrame(461) = BlockFrame(5)
    BlockFrame(462) = BlockFrame(5)
    BlockFrame(463) = BlockFrame(5)
    BlockFrame(464) = BlockFrame(5)
    BlockFrame(465) = BlockFrame(5)
    BlockFrame(466) = BlockFrame(5)
    BlockFrame(468) = BlockFrame(5)
    BlockFrame(469) = BlockFrame(5)
    BlockFrame(470) = BlockFrame(5)
    BlockFrame(471) = BlockFrame(5)
    BlockFrame(472) = BlockFrame(5)
    BlockFrame(473) = BlockFrame(5)
    BlockFrame(474) = BlockFrame(5)
    BlockFrame(475) = BlockFrame(5)
    BlockFrame(476) = BlockFrame(5)
    BlockFrame(477) = BlockFrame(5)
    BlockFrame(478) = BlockFrame(5)
    BlockFrame(479) = BlockFrame(5)
    BlockFrame(480) = BlockFrame(5)
    BlockFrame(481) = BlockFrame(5)
    BlockFrame(482) = BlockFrame(5)
    BlockFrame(483) = BlockFrame(5)
    BlockFrame(484) = BlockFrame(5)
    BlockFrame(485) = BlockFrame(5)
    BlockFrame(486) = BlockFrame(5)
    BlockFrame(487) = BlockFrame(5)
    BlockFrame(622) = BlockFrame(5)
    BlockFrame(623) = BlockFrame(5)
    BlockFrame(624) = BlockFrame(5)
    BlockFrame(625) = BlockFrame(5)
    BlockFrame(631) = BlockFrame(5)
    For A = 1 To numPlayers
        If Player(A).Character = 1 Then BlockFrame(622) = 4
        If Player(A).Character = 2 Then BlockFrame(623) = 4
        If Player(A).Character = 3 Then BlockFrame(624) = 4
        If Player(A).Character = 4 Then BlockFrame(625) = 4
        If Player(A).Character = 5 Then BlockFrame(631) = 4
    Next A
    
    BlockFrame2(626) = BlockFrame2(626) + 1
    If BlockFrame2(626) < 8 Then
        BlockFrame(626) = 3
    ElseIf BlockFrame2(626) < 16 Then
        BlockFrame(626) = 2
    ElseIf BlockFrame2(626) < 23 Then
        BlockFrame(626) = 1
    Else
        BlockFrame2(626) = 0
        BlockFrame(626) = 1
    End If
    BlockFrame(627) = BlockFrame(626)
    BlockFrame(628) = BlockFrame(626)
    BlockFrame(629) = BlockFrame(626)
    BlockFrame(632) = BlockFrame(626)
    For A = 1 To numPlayers
        If Player(A).Character <= 5 Then
            pChar(Player(A).Character) = True
        End If
    Next A
    
    If pChar(1) = False Then BlockFrame(626) = 0
    If pChar(2) = False Then BlockFrame(627) = 0
    If pChar(3) = False Then BlockFrame(628) = 0
    If pChar(4) = False Then BlockFrame(629) = 0
    If pChar(5) = False Then BlockFrame(632) = 0
    
    If BlockFrame2(30) = 0 Then
        BlockFrame(30) = BlockFrame(30) + 1
        If BlockFrame(30) = 4 Then BlockFrame(30) = 0
    End If
    If BlockFrame2(55) = 0 Then
        BlockFrame(55) = BlockFrame(55) + 1
        If BlockFrame(55) = 4 Then BlockFrame(55) = 0
    End If
    If BlockFrame2(88) = 0 Then
        BlockFrame(88) = BlockFrame(88) + 1
        If BlockFrame(88) = 4 Then BlockFrame(88) = 0
    End If
    BlockFrame(170) = BlockFrame(88)
    If BlockFrame2(109) = 0 Then
        BlockFrame(109) = BlockFrame(109) + 1
        If BlockFrame(109) = 8 Then BlockFrame(109) = 0
    End If
    If BlockFrame2(371) = 0 Then
        BlockFrame(371) = BlockFrame(371) + 1
        If BlockFrame(371) = 8 Then BlockFrame(371) = 0
    End If
    If BlockFrame2(379) = 0 Then
        BlockFrame(379) = BlockFrame(379) + 1
        If BlockFrame(379) = 4 Then BlockFrame(379) = 0
    End If
    BlockFrame(380) = BlockFrame(379)
    BlockFrame(381) = BlockFrame(379)
    BlockFrame(382) = BlockFrame(379)
    
    BlockFrame2(530) = BlockFrame2(530) + 1
    If BlockFrame2(530) <= 8 Then
        BlockFrame(530) = 0
    ElseIf BlockFrame2(530) <= 16 Then
        BlockFrame(530) = 1
    ElseIf BlockFrame2(530) <= 24 Then
        BlockFrame(530) = 2
    ElseIf BlockFrame2(530) <= 32 Then
        BlockFrame(530) = 3
    ElseIf BlockFrame2(530) <= 40 Then
        BlockFrame(530) = 2
    ElseIf BlockFrame2(530) <= 48 Then
        BlockFrame(530) = 1
    Else
        BlockFrame(530) = 0
        BlockFrame2(530) = 0
    End If
    
    
    If LevelEditor = True And TestLevel = False Then
        BlockFrame(458) = 5
    Else
        tempBool = False
        For A = 1 To numPlayers
            If Player(A).Stoned = True Then
                tempBool = True
                Exit For
            End If
        Next A
        If BlockFrame(458) < 5 And tempBool = True Then
            BlockFrame2(458) = BlockFrame2(458) + 1
            If BlockFrame2(458) >= 4 Then
                BlockFrame2(458) = 0
                BlockFrame(458) = BlockFrame(458) + 1
            End If
        ElseIf BlockFrame(458) > 0 And tempBool = False Then
            BlockFrame2(458) = BlockFrame2(458) + 1
            If BlockFrame2(458) >= 4 Then
                BlockFrame2(458) = 0
                BlockFrame(458) = BlockFrame(458) - 1
            End If
        Else
            BlockFrame2(458) = 0
        End If
    End If
    
End Sub

Public Sub UpdateBlocks()   'Update the blocks
    Dim A As Integer
    Dim B As Integer
    If FreezeNPCs = True Then Exit Sub
    BlockFrames
    If BattleMode = True Then
        For A = 1 To numBlock
            With Block(A)
                'respawn
                If .RespawnDelay > 0 Then
                    .RespawnDelay = .RespawnDelay + 1
                    If .RespawnDelay >= 65 * 60 Then
                        If .DefaultType > 0 Or .DefaultSpecial > 0 Or .Layer = "Destroyed Blocks" Then
                            For B = 1 To numPlayers
                                If CheckCollision(.Location, newLoc(Player(B).Location.X - 64, Player(B).Location.Y - 64, 128, 128)) Then
                                    B = 0
                                    Exit For
                                End If
                            Next B
                            If B > 0 Then
                                If .Layer = "Destroyed Blocks" Then
                                    .Layer = "Default"
                                End If
                                If .Hidden = True Then
                                    For B = 0 To 100
                                        If Layer(B).Name = .Layer Then .Hidden = Layer(B).Hidden
                                    Next B
                                    If .Hidden = False Then NewEffect 10, newLoc(.Location.X + .Location.Width / 2 - EffectWidth(10) / 2, .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2)
                                End If
                                If .Type <> .DefaultType Or .Special <> .DefaultSpecial Then
                                    If .Type <> .DefaultType Then NewEffect 10, newLoc(.Location.X + .Location.Width / 2 - EffectWidth(10) / 2, .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2)
                                    .Special = .DefaultSpecial
                                    .Type = .DefaultType
                                End If
                                .RespawnDelay = 0
                            Else
                                .RespawnDelay = 65 * 30
                            End If
                        Else
                            .RespawnDelay = 0
                        End If
                    End If
                End If
            End With
        Next A
    End If
    For A = 1 To iBlocks
        With Block(iBlock(A))
            'Update the shake effect
            If .Hidden = True Then
                .ShakeY = 0
                .ShakeY2 = 0
                .ShakeY3 = 0
            End If
            If .ShakeY < 0 Then 'Block Shake Up
                .ShakeY = .ShakeY + 2
                .ShakeY3 = .ShakeY3 - 2
                If .ShakeY = 0 Then
                    If .TriggerHit <> "" Then ProcEvent .TriggerHit
                    If .Type = 282 Then
                        .Type = 283
                    ElseIf .Type = 283 Then
                        .Type = 282
                    End If
                    If .Type = 90 And .Special = 0 Then
                        Block(iBlock(A)).Hidden = True
                        NewEffect 82, Block(iBlock(A)).Location, , iBlock(A)
                        .ShakeY = 0
                        .ShakeY2 = 0
                        .ShakeY3 = 0
                    End If
                End If
            ElseIf .ShakeY > 0 Then 'Block Shake Down
                .ShakeY = .ShakeY - 2
                .ShakeY3 = .ShakeY3 + 2
                If .ShakeY = 0 Then
                    If .TriggerHit <> "" Then ProcEvent .TriggerHit
                    If .Type = 282 Then
                        .Type = 283
                    ElseIf .Type = 283 Then
                        .Type = 282
                    End If
                    If .Type = 90 Then
                        Block(iBlock(A)).Hidden = True
                        NewEffect 82, Block(iBlock(A)).Location, , iBlock(A)
                        .ShakeY = 0
                        .ShakeY2 = 0
                        .ShakeY3 = 0
                    End If
                End If
            ElseIf .ShakeY2 > 0 Then 'Come back down
                .ShakeY2 = .ShakeY2 - 2
                .ShakeY3 = .ShakeY3 + 2
                
                If .RapidHit > 0 And .Special > 0 And .ShakeY3 = 0 Then
                    BlockHit iBlock(A)
                    .RapidHit = .RapidHit - 1
                End If
            ElseIf .ShakeY2 < 0 Then 'Go back up
                .ShakeY2 = .ShakeY2 + 2
                .ShakeY3 = .ShakeY3 - 2
            End If
        End With
        If Block(iBlock(A)).ShakeY3 <> 0 Then
            For B = 1 To numNPCs
                With NPC(B)
                    If NPC(B).Active = True Then
                        If NPC(B).Killed = 0 And NPC(B).Effect = 0 And NPC(B).HoldingPlayer = 0 And (NPCNoClipping(NPC(B).Type) = False Or NPCIsACoin(NPC(B).Type) = True) Then
                            If Not Block(iBlock(A)).ShakeY3 > 0 Or NPCIsACoin(NPC(B).Type) Then
                                If ShakeCollision(.Location, Block(iBlock(A)).Location, Block(iBlock(A)).ShakeY3) = True Then
                                    If iBlock(A) <> NPC(B).tempBlock Then
                                        If Block(iBlock(A)).IsReally <> B Then
                                            If BlockIsSizable(Block(iBlock(A)).Type) = False And BlockOnlyHitspot1(Block(iBlock(A)).Type) = False Then
                                                NPCHit B, 2, iBlock(A)
                                            Else
                                                If Block(iBlock(A)).Location.Y + 1 >= NPC(B).Location.Y + NPC(B).Location.Height - 1 Then
                                                    NPCHit B, 2, iBlock(A)
                                                End If
                                            End If
                                        End If
                                    End If
                                End If
                            End If
                        End If
                    End If
                End With
            Next B
            For B = 1 To numPlayers
                With Player(B)
                    If .Dead = False Then
                        If .Effect = 0 And Block(iBlock(A)).Type <> 55 Then
                            If ShakeCollision(.Location, Block(iBlock(A)).Location, Block(iBlock(A)).ShakeY3) = True Then
                                If BlockIsSizable(Block(iBlock(A)).Type) = False And BlockOnlyHitspot1(Block(iBlock(A)).Type) = False Then
                                    .Location.SpeedY = Physics.PlayerJumpVelocity
                                    .StandUp = True
                                    PlaySound 2
                                Else
                                    If Block(iBlock(A)).Location.Y + 1 >= Player(B).Location.Y + Player(B).Location.Height - 1 Then
                                        .Location.SpeedY = Physics.PlayerJumpVelocity
                                        .StandUp = True
                                        PlaySound 2
                                    End If
                                End If
                            End If
                        End If
                    End If
                End With
            Next B
        End If
        With Block(iBlock(A))
            If .Kill = True Then 'See if block should be broke
                .Kill = False
                If .Special = 0 Then
                    If .Type = 4 Or .Type = 60 Or .Type = 90 Or .Type = 188 Or .Type = 226 Or .Type = 293 Or .Type = 526 Then 'Check to see if it is breakable
                        KillBlock iBlock(A) 'Destroy the block
                    End If
                End If
            End If
        End With
    Next A
    For A = iBlocks To 1 Step -1
        With Block(iBlock(A))
            If .ShakeY = 0 Then
                If .ShakeY2 = 0 Then
                    If .ShakeY3 = 0 Then
                        iBlock(A) = iBlock(iBlocks)
                        iBlocks = iBlocks - 1
                    End If
                End If
            End If
        End With
    Next A
    
    If PSwitchTime > 0 Then
        If PSwitchTime = Physics.NPCPSwitch Then
            StopMusic
            StartMusic -1
            PlaySound 32
            PSwitch True
        End If
        PSwitchTime = PSwitchTime - 1
        If PSwitchTime <= 1 Then
            PSwitch False
            StopMusic
            StartMusic Player(PSwitchPlayer).Section
        End If
    End If
End Sub

Public Sub PSwitch(bool As Boolean) 'turns all the blocks to coins and vice versa
    Dim A As Integer
    Dim B As Integer
    Dim blankBlock As Block
    If bool = True Then
        For A = 1 To numNPCs
            With NPC(A)
                If NPCIsACoin(.Type) = True And .Block = 0 And .Hidden = False And .Special = 0 Then
                    If numBlock < maxBlocks Then
                        numBlock = numBlock + 1
                        With Block(numBlock)
                            If (NPC(A).Type = 251 Or NPC(A).Type = 252 Or NPC(A).Type = 253) And NPC(A).DefaultType <> 0 Then
                                NPC(A).Type = NPC(A).DefaultType
                            End If
                            If NPC(A).Type = 33 Or NPC(A).Type = 258 Then
                                .Type = 89
                            ElseIf NPC(A).Type = 88 Then
                                .Type = 188
                            ElseIf NPC(A).Type = 103 Then
                                .Type = 280
                            ElseIf NPC(A).Type = 138 Then
                                .Type = 293
                            Else
                                .Type = 4
                            End If
                            .TriggerDeath = NPC(A).TriggerDeath
                            .TriggerLast = NPC(A).TriggerLast
                            .Layer = NPC(A).Layer
                            .Invis = False
                            .Hidden = False
                            .Location = NPC(A).Location
                            .Location.Width = BlockWidth(.Type)
                            .Location.Height = BlockHeight(.Type)
                            .Location.X = .Location.X + (NPC(A).Location.Width - .Location.Width) / 2
                            .Location.SpeedX = 0
                            .Location.SpeedY = 0
                            .Special = 0
                            .Kill = False
                            .NPC = NPC(A).Type
                        End With
                    End If
                    .Killed = 9
                End If
            End With
        Next A
        For A = numBlock To 1 Step -1
            With Block(A)
                If BlockPSwitch(.Type) = True And .Special = 0 And .NPC = 0 And .Hidden = False Then
                    If numNPCs < maxNPCs Then
                        numNPCs = numNPCs + 1
                         With NPC(numNPCs)
                            .Active = True
                            .TimeLeft = 1
                            If Block(A).Type = 89 Then
                                .Type = 33
                            ElseIf Block(A).Type = 188 Or Block(A).Type = 60 Then
                                .Type = 88
                            ElseIf Block(A).Type = 280 Then
                                .Type = 103
                            ElseIf Block(A).Type = 293 Then
                                .Type = 138
                            Else
                                .Type = 10
                            End If
                            .Layer = Block(A).Layer
                            .TriggerDeath = Block(A).TriggerDeath
                            .TriggerLast = Block(A).TriggerLast
                            .Block = Block(A).Type
                            .Hidden = False
                            .Location = Block(A).Location
                            .Location.SpeedX = 0
                            .Location.SpeedY = 0
                            .Location.Width = NPCWidth(.Type)
                            .Location.Height = NPCHeight(.Type)
                            .Location.X = .Location.X + (Block(A).Location.Width - .Location.Width) / 2
                            .DefaultLocation = .Location
                            .DefaultType = .Type
                            CheckSectionNPC numNPCs
                         End With
                        Block(A) = Block(numBlock)
                        Block(numBlock) = blankBlock
                        numBlock = numBlock - 1
                    End If
                End If
            End With
        Next A
        ProcEvent "P Switch - Start", True
    Else
        
        For A = 1 To numNPCs
            With NPC(A)
                If .Block > 0 Then
                    If numBlock < maxBlocks Then
                        numBlock = numBlock + 1
                        With Block(numBlock)
                            .Layer = NPC(A).Layer
                            .TriggerDeath = NPC(A).TriggerDeath
                            .TriggerLast = NPC(A).TriggerLast
                            .Hidden = NPC(A).Hidden
                            .Invis = False
                            .Type = NPC(A).Block
                            .Location = NPC(A).Location
                            .Location.SpeedX = 0
                            .Location.SpeedY = 0
                            .Location.Width = BlockWidth(.Type)
                            .Location.Height = BlockHeight(.Type)
                            .Location.X = .Location.X + (NPC(A).Location.Width - .Location.Width) / 2
                            .Special = 0
                            .Kill = False
                        End With
                    End If
                    .Killed = 9
                End If
            End With
        Next A
        
        
        'Stop
        For A = numBlock To 1 Step -1
            With Block(A)
                If .NPC > 0 And .Hidden = False Then
                    If numNPCs < maxNPCs Then
                        numNPCs = numNPCs + 1
                         With NPC(numNPCs)
                            .Layer = Block(A).Layer
                            .TriggerDeath = Block(A).TriggerDeath
                            .TriggerLast = Block(A).TriggerLast
                            .Active = True
                            .TimeLeft = 1
                            .Hidden = Block(A).Hidden
                            .Type = Block(A).NPC
                            .Location = Block(A).Location
                            .Location.SpeedX = 0
                            .Location.SpeedY = 0
                            .Location.Width = NPCWidth(.Type)
                            .Location.Height = NPCHeight(.Type)
                            .Location.X = .Location.X + (Block(A).Location.Width - .Location.Width) / 2
                            .DefaultLocation = .Location
                            .DefaultType = .Type
                            CheckSectionNPC numNPCs
                            .Killed = 0
                         End With
                        KillBlock A, False
                        Block(A).Layer = "Used P Switch"
                    End If
                End If
            End With
        Next A
        
        
        
        ProcEvent "P Switch - End", True
    End If
    qSortBlocksX 1, numBlock
    B = 1
    For A = 2 To numBlock
        If Block(A).Location.X > Block(B).Location.X Then
            qSortBlocksY B, A - 1
            B = A
        End If
    Next A
    qSortBlocksY B, A - 1
    FindSBlocks
    FindBlocks
    iBlocks = numBlock
    For A = 1 To numBlock
        iBlock(A) = A
    Next A
    overTime = 0
    GoalTime = GetTickCount + 1000
    fpsCount = 0
    fpsTime = 0
    cycleCount = 0
    gameTime = 0
End Sub



Public Sub PowBlock() 'drops coins and shakes all blocks on screen when player throws a POW block
    Dim numScreens As Integer
    Dim A As Integer
    Dim Z As Integer
    PlaySound 37
    numScreens = 1
    If LevelEditor = False Then
        If ScreenType = 1 Then numScreens = 2
        If ScreenType = 4 Then numScreens = 2
        If ScreenType = 5 Then
            DynamicScreen
            If vScreen(2).Visible = True Then
                numScreens = 2
            Else
                numScreens = 1
            End If
        End If
        If ScreenType = 8 Then numScreens = 1
    End If
    For Z = 1 To numScreens
        For A = 1 To numBlock
            If vScreenCollision(Z, Block(A).Location) Then
                If Block(A).Hidden = False Then
                    BlockShakeUpPow A
                End If
            End If
        Next A
    Next Z
    For A = 1 To numNPCs
        If NPC(A).Active = True Then
            If NPCIsACoin(NPC(A).Type) Then
                NPC(A).Special = 1
                NPC(A).Location.SpeedX = Rnd * 1 - 0.5
            End If
        End If
    Next A
    If GameMenu = False Then ScreenShake = 20
End Sub



