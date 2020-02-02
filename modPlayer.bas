Attribute VB_Name = "modPlayer"
Option Explicit

Public Sub SetupPlayers() 'this set's the players values to their defaults and prepares them for playing a level
    Dim tempLocation As Location
    Dim blankControls As Controls
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    FreezeNPCs = False
    qScreen = False
    ForcedControls = False
'online stuff
    If nPlay.Online = True Then
        For A = 0 To 15
            nPlay.Player(A).Controls = blankControls
            nPlay.MyControls = blankControls
        Next A
    End If
    If nPlay.Online = True Then
        If nPlay.Mode = 1 Then
            nPlay.MySlot = 0
        Else
            For A = 1 To 15
                If nPlay.Player(A).IsMe Then
                    nPlay.MySlot = A
                    Exit For
                End If
            Next A
        End If
    End If
    
'battle mode
    If BattleMode = True Then
        For A = 1 To numPlayers
            Player(A).State = 2
            Player(A).Hearts = 2
        Next A
        Checkpoint = ""
    Else
        BattleIntro = 0
        BattleOutro = 0
    End If
    
    
    For A = 1 To numPlayers 'set up players
        With Player(A)
            If .Character = 0 Then 'player has no character
                .Character = 1  'Sets as Mario
                If numPlayers = 2 And A = 2 And nPlay.Online = False Then .Character = 2   'Sets as Luigi
            End If
            If nPlay.Online = True Then 'online stuff
                .State = 2 'Super mario
                .Mount = 0
                If A = nPlay.MySlot + 1 Then
                    If frmNetplay.optPlayer(2).Value = True Then
                        .Character = 2
                    ElseIf frmNetplay.optPlayer(3).Value = True Then
                        .Character = 3
                    ElseIf frmNetplay.optPlayer(4).Value = True Then
                        .Character = 4
                    Else
                        .Character = 1
                    End If
                End If
            End If
            If .State = 0 Then 'if no state it defaults to small mario
                .State = 1
            End If
            'box to hearts
            
            If .Character = 3 Or .Character = 4 Or .Character = 5 Then 'Peach and Toad
                If .Hearts <= 0 Then .Hearts = 1
                
                'power up limiter
                'If (.Character = 3 Or .Character = 4) And .State > 3 And .State <> 7 Then .State = 2
                
                If .Hearts <= 1 And .State > 1 And .Character <> 5 Then .Hearts = 2
                If .HeldBonus > 0 Then
                    .Hearts = .Hearts + 1
                    .HeldBonus = 0
                End If
                If .State = 1 And .Hearts > 1 Then .State = 2
                If .Hearts > 3 Then .Hearts = 3
                If .Mount = 3 Then .Mount = 0
            Else 'Mario and Luigi
                If .Hearts = 3 And .HeldBonus = 0 Then
                    .HeldBonus = 9
                End If
                .Hearts = 0
            End If
            If .Character = 5 Then .Mount = 0
            
            .Location.Width = Physics.PlayerWidth(.Character, .State) 'set height
            .Location.Height = Physics.PlayerHeight(.Character, .State) 'set width
            If .State = 1 And .Mount = 1 Then .Location.Height = Physics.PlayerHeight(1, 2) 'if small and in a shoe then set the height to super mario
            If numPlayers = 2 And A = 2 Then
                B = 2
            Else
                B = 1
            End If
            If A = 2 And PlayerStart(B).X = 0 And PlayerStart(B).Y = 0 Then
                .Location.X = PlayerStart(1).X + PlayerStart(1).Width * 0.5 - .Location.Width * 0.5
                .Location.Y = PlayerStart(1).Y + PlayerStart(1).Height - .Location.Height '- 2
            Else
                .Location.X = PlayerStart(B).X + PlayerStart(B).Width * 0.5 - .Location.Width * 0.5
                .Location.Y = PlayerStart(B).Y + PlayerStart(B).Height - .Location.Height '- 2
            End If
            If GrabAll = True Then
                .CanGrabNPCs = True
            Else
                .CanGrabNPCs = False
            End If
'reset all variables
            If .Mount = 2 Then .Mount = 0
            If .Character >= 3 And .Mount = 3 Then .Mount = 0
            .Slippy = False
            .DoubleJump = False
            .FlySparks = False
            .Quicksand = 0
            .Bombs = 0
            .Wet = 0
            .ShellSurf = False
            .WetFrame = False
            .Slide = False
            .Vine = 0
            .Fairy = False
            .GrabSpeed = 0
            .GrabTime = 0
            .SwordPoke = 0
            .FireBallCD2 = 0
            .SpinJump = False
            .Stoned = False
            .Slope = 0
            .SpinFireDir = 0
            .SpinFrame = 0
            .YoshiNPC = 0
            .YoshiPlayer = 0
            .YoshiRed = False
            .YoshiBlue = False
            .YoshiYellow = False
            .YoshiBFrame = 0
            .YoshiBFrameCount = 0
            .YoshiTFrame = 0
            .YoshiTFrameCount = 0
            .CanFly = False
            .CanFly2 = False
            .RunCount = 0
            .FlyCount = 0
            .ForceHitSpot3 = False
            .StandUp = False
            .StandUp2 = False
            .TailCount = 0
            .HasKey = False
            .TimeToLive = 0
            .Warp = 0
            .WarpCD = 0
            .CanPound = False
            .GroundPound = False
            .GroundPound2 = False
            .Duck = False
            .MountSpecial = 0
            .YoshiTongueLength = 0
            .Direction = 1
            .Location.SpeedX = 0
            .Location.SpeedY = 2
            .Frame = 1
            .FrameCount = 0
            .NPCPinched = 0
            .Pinched1 = 0
            .Pinched2 = 0
            .Pinched3 = 0
            .StandingOnNPC = 0
            .StandingOnTempNPC = 0
            .Pinched4 = 0
            .HoldingNPC = 0
            .Dead = False
            If nPlay.Online = True And nPlay.Mode = 0 Then
                If nPlay.Player(A - 1).Active = False Then .Dead = True
            End If
            .TimeToLive = 0
            .Bumped = 0
            .Bumped2 = 0
            .Effect = 0
            .Effect2 = 0
            .Immune = 0
            .Immune2 = False
            .Jump = 0
            .Frame = 1
            .FrameCount = 0
            .RunRelease = False
            .FloatTime = 0
            .CanFloat = False
            If .Character = 3 Then .CanFloat = True
            If .Character = 3 Or .Character = 4 Then
                If .State = 1 Then .Hearts = 1
                If .State > 1 And .Hearts < 2 Then .Hearts = 2
            End If
            
            If numPlayers > 2 And GameMenu = False Then 'online stuff
                If nPlay.Online = True Then
                    .Location = Player(1).Location
                    .Location.X = .Location.X + A * 32 - 32
                ElseIf GameOutro = True Then
                    .Location = Player(1).Location
                    .Location.X = .Location.X + A * 52 - 52
                Else
                    .Location = Player(1).Location
                    .Location.SpeedY = Rnd * -12 - 6
                End If
            End If
            .Section = -1
            CheckSection A 'find the section the player is in
            If .Section = -1 Then
                .Section = 0
                CheckSection A
            End If
            If .Location.X + .Location.Width / 2 > level(.Section).X + (level(.Section).Width - level(.Section).X) / 2 Then .Direction = -1
            If nPlay.Online = True And A <= 15 Then
                If nPlay.Player(A - 1).Active = False And A <> 1 Then .Dead = True
            End If
        End With
        SizeCheck A
    Next A
    If nPlay.Online = True Then
        Netplay.sendData "1d" & nPlay.MySlot + 1 & "|" & Player(nPlay.MySlot + 1).Character & "|" & Player(nPlay.MySlot + 1).State & LB & Netplay.PutPlayerLoc(nPlay.MySlot + 1)
        StartMusic Player(nPlay.MySlot + 1).Section
    End If
    SetupScreens 'setup the screen depending on how many players there are
    
    
    If Checkpoint = FullFileName And Checkpoint <> "" Then 'if this level has a checkpoint the put the player in the correct position
        For A = 1 To numNPCs
            If NPC(A).Type = 192 Then
                NPC(A).Killed = 9
                tempLocation = NPC(A).Location
                tempLocation.Height = 600
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
                For B = 1 To numPlayers
                    Player(B).Location.Y = Block(C).Location.Y - Player(B).Location.Height
                    Player(B).Location.X = NPC(A).Location.X + NPC(A).Location.Width / 2 - Player(B).Location.Width / 2
                    CheckSection B
                Next B
                If numPlayers > 1 Then
                    Player(1).Location.X = Player(1).Location.X - 16
                    Player(2).Location.X = Player(2).Location.X + 16
                End If
            End If
        Next A
    ElseIf StartLevel <> FileName Then 'if not in the level for the checkpoint, blank the checkpoint
        Checkpoint = ""
    End If
End Sub

Public Sub UpdatePlayer() 'This is the main sub for the players
'this is 1 of the 2 clusterfuck subs in the code, be weary

    Dim A As Integer
    Dim B As Integer
    Dim C As Single
    Dim D As Single
    Dim blankControls As Controls
    Dim speedVar As Single 'adjusts the players speed by percentages
    Dim fBlock As Long 'for collision detection optimizations
    Dim lBlock As Long
    Dim tempSpeed As Double
    Dim HitSpot As Integer
        'the hitspot is used for collision detection to find out where to put the player after it collides with a block
        'the numbers tell what side the collision happened so it can move the plaer to the correct position
        '1 means the player hit the block from the top
        '2 is from the right
        '3 is from the bottom
        '4 is from the left
    Dim tempBlockHit(1 To 2) As Integer
    Dim tempBlockA(1 To 2) As Double
    Dim tempHit As Boolean
    Dim tempSpring As Boolean
    Dim tempShell As Boolean
    Dim tempHit2 As Boolean
    Dim tempHit3 As Integer
    Dim tempHitSpeed As Single
    Dim oldSpeedY As Single 'holds the players previous Y speed
    Dim tempLocation As Location
    Dim tempLocation3 As Location
    Dim spinKill As Boolean
    Dim oldSlope As Integer
    Dim A1 As Single
    Dim B1 As Single
    Dim C1 As Single
    Dim X As Single
    Dim Y As Single
    Dim canWarp As Boolean
    Dim tempBool As Boolean
    Dim blankNPC As NPC
    Dim MessageNPC As Integer
'used for slope calculations
    Dim PlrMid As Double
    Dim Slope As Double
    Dim tempSlope As Integer
    Dim tempSlope2 As Integer
    Dim tempSlope2X As Double 'The old X before player was moved
    Dim tempSlope3 As Integer  'keeps track of hit 5 for slope detection
    Dim movingBlock As Boolean 'helps with collisions for moving blocks
    Dim blockPushX As Integer
    Dim oldLoc As Location
    Dim curLoc As Location
    Dim oldGrab As Integer
    Dim DontResetGrabTime As Boolean 'helps with grabbing things from the top
    Dim SlippySpeedX As Double
    Dim wasSlippy As Boolean
    Dim Angle As Double
    Dim slideSpeed As Double
    Dim maxSlideSpeed
    
    
    StealBonus 'allows a dead player to come back to life by using a 1-up
    ClownCar 'updates players in the clown car
    
'online stuff
    If nPlay.Online = True Then
        A = nPlay.MySlot + 1
        nPlay.PlayerWaitCount = nPlay.PlayerWaitCount + 1
        If Player(A).Dead = True Or Player(A).TimeToLive > 0 Then
            If nPlay.PlayerWaitCount = 10 Then
                nPlay.PlayerWaitCount = 0
                Netplay.sendData "1p" & A & LB
            End If
        ElseIf Player(A).Effect <> 0 Then
            If nPlay.PlayerWaitCount >= 10 Then
                Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1c" & A & "|" & Player(A).Effect & "|" & Player(A).Effect2 & LB & "1h" & A & "|" & Player(A).State & LB
                nPlay.PlayerWaitCount = 0
            End If
        Else
            If (nPlay.PlayerWaitCount >= 6 And (Player(nPlay.MySlot + 1).Location.SpeedX <> 0 Or Player(nPlay.MySlot + 1).Location.SpeedY <> 0) Or nPlay.PlayerWaitCount >= 60) Then
                Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot)
                If Player(A).YoshiPlayer > 0 Then
                    Netplay.sendData Netplay.PutPlayerLoc(Player(A).YoshiPlayer - 1) & "1c" & Player(A).YoshiPlayer & "|" & Player(Player(A).YoshiPlayer).Effect & "|" & Player(Player(A).YoshiPlayer).Effect2 & LB & "1h" & A & "|" & Player(Player(A).YoshiPlayer).State & LB
                End If
                If Player(A).Mount = 3 Then
                    Netplay.sendData "1r" & A & "|" & Player(A).YoshiPlayer & LB
                End If
                nPlay.PlayerWaitCount = 0
            End If
        End If
    End If

    
'A is the current player, numPlayers is the last player. this loop updates all the players
    For A = 1 To numPlayers
        If nPlay.Online = True And A > 1 Then
            If nPlay.Player(A - 1).Active = False Then Player(A).Dead = True
            If Player(A).Dead = True Then nPlay.Player(A - 1).Controls = blankControls
        End If
'reset variables from the previous player
        DontResetGrabTime = False
        oldGrab = Player(A).HoldingNPC
        movingBlock = False
        blockPushX = 0
        Player(A).ShowWarp = 0
        Player(A).mountBump = 0
        spinKill = False
        tempHit = False
        tempHit2 = False
        tempHit3 = 0
        tempBlockHit(1) = 0
        tempBlockHit(2) = 0
        tempBlockA(1) = 0
        tempBlockA(2) = 0
        With Player(A)
            If .GrabTime > 0 Then 'if grabbing something, take control away from the player
                .Slide = False
                .Controls.Run = True
                .Controls.Down = True
                .Controls.AltRun = False
                .Controls.Jump = False
                .Controls.AltJump = False
            End If
            If .Dismount > 0 Then .Dismount = .Dismount - 1 'count down to being able to hop in a shoe or yoshi
            If .Mount <> 0 Or .Stoned = True Or .Fairy = True Then  'if .holdingnpc is -1 then the player can't grab anything. this stops the player from grabbing things while on a yoshi/shoe
                .HoldingNPC = -1
            ElseIf .HoldingNPC = -1 Then .HoldingNPC = 0
            End If
            If .Controls.Drop = True And .DropRelease = True Then 'this is for the single player coop cheat code
                If SingleCoop > 0 And .Controls.Down = True Then
                    SwapCoop
                 Else
                    DropBonus A
                End If
            End If
            If .Controls.Drop = True Then 'for dropping something from the container. this makes the player have to let go of the drop button before dropping something else
                .DropRelease = False
            Else
                .DropRelease = True
            End If
'Handle the death effecs
            If .TimeToLive > 0 Then
                .TimeToLive = .TimeToLive + 1
                If .TimeToLive >= 200 Or ScreenType <> 5 Then
                    B = CheckLiving
                    If BattleMode = True And BattleLives(1) > 0 And BattleLives(2) > 0 And BattleWinner = 0 Then
                        B = 20 + A
                        Player(20 + A).Location.Width = .Location.Width
                        Player(20 + A).Location.Height = .Location.Height
                        Player(20 + A).Location.X = PlayerStart(A).X + PlayerStart(A).Width * 0.5 - .Location.Width
                        Player(20 + A).Location.Y = PlayerStart(A).Y + PlayerStart(A).Height - .Location.Height
                        CheckSection 20 + A
                        If .Section <> Player(B).Section Then
                            .Location = Player(B).Location
                            .Section = Player(B).Section
                        End If
                    End If
                    If B > 0 Then 'Move camera to the other living players
                        If ScreenType = 5 Then
                            A1 = (Player(B).Location.X + Player(B).Location.Width * 0.5) - (.Location.X + .Location.Width * 0.5)
                            B1 = Player(B).Location.Y - .Location.Y
                        Else
                            A1 = (-vScreenX(1) + vScreen(1).Width * 0.5) - (.Location.X + .Location.Width * 0.5)
                            B1 = (-vScreenY(1) + vScreen(1).Height * 0.5) - .Location.Y
                        End If
                        C1 = Sqr((A1 * A1) + (B1 * B1))
                        If C1 <> 0 Then
                            X = A1 / C1
                            Y = B1 / C1
                        Else
                            X = 0
                            Y = 0
                        End If
                        .Location.X = .Location.X + X * 10
                        .Location.Y = .Location.Y + Y * 10
                        If ScreenType = 5 And Player(1).Section <> Player(2).Section Then
                            C1 = 0
                            If A = 1 Then
                                .Location.X = Player(2).Location.X
                                .Location.Y = Player(2).Location.Y
                                CheckSection A
                            Else
                                .Location.X = Player(1).Location.X
                                .Location.Y = Player(1).Location.Y
                                CheckSection A
                            End If
                        End If
                        If C1 < 10 And C1 > -10 Then KillPlayer (A)
                    ElseIf .TimeToLive >= 200 Then 'ScreenType = 1
                        KillPlayer (A) 'Time to die
                    End If
                End If
            ElseIf .Dead = True Then
                If numPlayers > 2 Then
                    B = CheckLiving
                    .Location.X = Player(B).Location.X
                    .Location.Y = Player(B).Location.Y
                    .Section = Player(B).Section
                Else
                    If A = 1 Then
                        .Location.X = Player(2).Location.X
                        .Location.Y = Player(2).Location.Y
                        CheckSection A
                    Else
                        .Location.X = Player(1).Location.X
                        .Location.Y = Player(1).Location.Y
                        CheckSection A
                    End If
                End If
            ElseIf .Dead = False Then
            oldLoc = .Location
            If .SlideCounter > 0 Then .SlideCounter = .SlideCounter - 1 'for making the slide Effect

'for the purple yoshi ground pound
        If .Effect = 0 Then
            If .Location.SpeedY <> 0 And .StandingOnNPC = 0 And .Slope = 0 Then
                If .Mount = 3 And .MountType = 6 Then 'Purple Yoshi Pound
                    If .Controls.Down = True And .DuckRelease = True And .CanPound = True Then
                        .GroundPound = True
                        .GroundPound2 = True
                        If .Location.SpeedY < 0 Then .Location.SpeedY = 0
                    End If
                End If
            Else
                .CanPound = False
            End If
            If .GroundPound = True Then
                If .CanPound = False And .Location.SpeedY < 0 Then .GroundPound = False
                .Controls.Down = True
                .CanJump = False
                .Controls.Left = False
                .Controls.Up = False
                .Controls.Right = False
                .Controls.Jump = True
                .Location.SpeedX = .Location.SpeedX * 0.95
                .RunRelease = False
                .CanFly = False
                .FlyCount = 0
                .CanFly2 = False
                .Location.SpeedY = .Location.SpeedY + 1
                .CanPound = False
                .Jump = 0
            Else
                If .Location.SpeedY < -5 And ((.Jump < 15 And .Jump <> 0) Or .CanFly = True) Then
                    .CanPound = True
                End If
                If .GroundPound2 = True Then
                    .Location.SpeedY = -4
                    .StandingOnNPC = 0
                    .GroundPound2 = False
                End If
            End If
                    
SizeCheck A 'check that the player is the correct size for it's character/state/mount and set it if not
            
        If .Stoned = True Then 'stop the player from climbing/spinning/jumping when in tanooki statue form
            .Jump = 0
            .Vine = 0
            .SpinJump = False
            .Controls.Left = False
            .Controls.Right = False
            .Controls.AltJump = False
            .Controls.Jump = False
            .CanAltJump = False
            .CanJump = False
        End If
                        
        'let the player slide if not on a mount and holding something
        If .GrabTime > 0 Then .Slide = False
        If .Slope > 0 And .Controls.Down = True And .Mount = 0 And .HoldingNPC = 0 And Not (.Character = 3 Or .Character = 4 Or .Character = 5) And .GrabTime = 0 Then
            If .Duck = True Then UnDuck A
            .Slide = True
        ElseIf .Location.SpeedX = 0 Then
            .Slide = False
        End If
        If .Mount > 0 Or .HoldingNPC > 0 Then .Slide = False
        
'unduck a player that should be able to duck
    If .Duck = True And (.Character = 1 Or .Character = 2) And .State = 1 And (.Mount = 0 Or .Mount = 2) Then UnDuck A

If GameMenu = True And .SpinJump = False Then .Direction = 1 'force the player to look right when on the game menu

WaterCheck A 'This sub handles all the water related stuff

PowerUps A 'misc power-up code
                    
If .StandingOnNPC > 0 Then
    If NPC(.StandingOnNPC).Type = 263 And NPC(.StandingOnNPC).Location.SpeedX = 0 Then .Slippy = True
End If
SlippySpeedX = .Location.SpeedX
                    

'Player's X movement. ---------------------------
        
        'Modify player's speed if he is running up/down hill
        speedVar = 1 'Speed var is a percentage of the player's speed
        If .Slope > 0 Then
            If (.Location.SpeedX > 0 And BlockSlope(Block(.Slope).Type) = -1) Or .Location.SpeedX < 0 And BlockSlope(Block(.Slope).Type) = 1 Then
                speedVar = (1 - Block(.Slope).Location.Height / Block(.Slope).Location.Width * 0.5)
            ElseIf .Slide = False Then
                speedVar = 1 + (Block(.Slope).Location.Height / Block(.Slope).Location.Width * 0.5) * 0.5
            End If
        End If
        If .Stoned = True Then speedVar = 1 'if statue form reset to normal
        If .Character = 3 Then speedVar = speedVar * 0.93
        If .Character = 4 Then speedVar = speedVar * 1.07
                                
        'modify speedvar to slow the player down under water
        If .Wet > 0 Then
            If .Location.SpeedY = 0 Or .Slope > 0 Or .StandingOnNPC <> 0 Then
                speedVar = speedVar * 0.25 'if walking go really slow
            Else
                speedVar = speedVar * 0.5 'if swimming go slower faster the walking
            End If
        End If
                        
                        If .Slide = True Then 'Code used to move the player while sliding down a slope
                            If .Slope > 0 Then
                                Angle = 1 / (Block(.Slope).Location.Width / Block(.Slope).Location.Height)
                                slideSpeed = 0.1 * Angle * BlockSlope(Block(.Slope).Type)
                                If slideSpeed > 0 And .Location.SpeedX < 0 Then
                                    .Location.SpeedX = .Location.SpeedX + slideSpeed * 2
                                ElseIf slideSpeed < 0 And .Location.SpeedX > 0 Then
                                    .Location.SpeedX = .Location.SpeedX + slideSpeed * 2
                                Else
                                    .Location.SpeedX = .Location.SpeedX + slideSpeed
                                End If
                            ElseIf .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Then
                                If .Location.SpeedX > 0.2 Then
                                    .Location.SpeedX = .Location.SpeedX - 0.1
                                ElseIf .Location.SpeedX < -0.2 Then
                                    .Location.SpeedX = .Location.SpeedX + 0.1
                                Else
                                    .Location.SpeedX = 0
                                    .Slide = False
                                End If
                            End If
                            If .Location.SpeedX > 11 Then .Location.SpeedX = 11
                            If .Location.SpeedX < -11 Then .Location.SpeedX = -11
                            If .Controls.Jump = True Or .Controls.AltJump = True Then .Slide = False
                            
'if not sliding and in the clown car
                        ElseIf .Mount = 2 Then
                            If .Controls.Jump = False Then .CanJump = True
                            If .Controls.AltJump = True And .CanAltJump = True Then  ' Jump out of the Clown Car
                                .CanJump = False
                                tempBool = True
                                tempLocation = .Location
                                tempLocation.Height = Physics.PlayerHeight(.Character, .State)
                                tempLocation.Y = tempLocation.Y - Physics.PlayerHeight(.Character, .State)
                                tempLocation.Width = Physics.PlayerWidth(.Character, .State)
                                tempLocation.X = tempLocation.X + 64 - tempLocation.Width / 2
                                fBlock = FirstBlock((tempLocation.X / 32) - 1)
                                lBlock = LastBlock(((tempLocation.X + tempLocation.Width) / 32) + 1)
                                For B = fBlock To lBlock
                                    If Block(B).Invis = False And BlockIsSizable(Block(B).Type) = False And BlockOnlyHitspot1(Block(B).Type) = False And BlockNoClipping(Block(B).Type) = False And Block(B).Hidden = False Then
                                        If CheckCollision(tempLocation, Block(B).Location) = True Then
                                            tempBool = False
                                            PlaySound 3
                                        End If
                                    End If
                                Next B
                                For B = 1 To numNPCs
                                    If NPCIsABlock(NPC(B).Type) = True And NPCStandsOnPlayer(NPC(B).Type) = False And NPC(B).Active = True And NPC(B).Type <> 56 Then
                                        If CheckCollision(tempLocation, NPC(B).Location) = True Then
                                            tempBool = False
                                            PlaySound 3
                                        End If
                                    End If
                                Next B
                                If tempBool = True Then
                                    .CanJump = False
                                     PlaySound 1 'Jump sound
                                     PlaySound 35
                                    .Jump = Physics.PlayerJumpHeight
                                    If .Character = 2 Then .Jump = .Jump + 3
                                    If .SpinJump = True Then .Jump = .Jump - 6
                                    .Mount = 0
                                    numNPCs = numNPCs + 1
                                    With NPC(numNPCs)
                                        .Direction = Player(A).Direction
                                        If .Direction = 1 Then .Frame = 4
                                        .Frame = .Frame + SpecialFrame(2)
                                        .Active = True
                                        .TimeLeft = 100
                                        .Type = 56
                                        .Location.Height = 128
                                        .Location.Width = 128
                                        .Location.Y = Int(Player(A).Location.Y)
                                        .Location.X = Int(Player(A).Location.X)
                                        .Location.SpeedY = 0
                                        .Location.SpeedX = 0
                                        .CantHurt = 10
                                        .CantHurtPlayer = A
                                    End With
                                    .Location.SpeedY = Physics.PlayerJumpVelocity - tempSpeed
                                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                                    .Location.Width = Physics.PlayerWidth(.Character, .State)
                                    .Location.X = .Location.X + 64 - Physics.PlayerWidth(.Character, .State) / 2
                                    .StandUp = True
                                    .StandUp2 = True
                                    .ForceHitSpot3 = True
                                    .Dismount = 30
                                    .Slope = 0
                                    .Location.Y = NPC(numNPCs).Location.Y - .Location.Height
                                    For B = 1 To numPlayers
                                        If B <> A And Player(B).Mount <> 2 And CheckCollision(.Location, Player(B).Location) = True Then
                                            Player(B).Location.Y = .Location.Y - Player(B).Location.Height
                                        End If
                                        If Player(B).StandingOnTempNPC = 56 Then
                                            Player(B).StandingOnNPC = numNPCs
                                            Player(B).StandingOnTempNPC = 0
                                        End If
                                    Next B
                                    For B = 1 To numNPCs
                                        If NPC(B).standingOnPlayer = A Then
                                            NPC(B).standingOnPlayer = 0
                                            NPC(B).Location.SpeedY = 0
                                            NPC(B).Location.Y = NPC(numNPCs).Location.Y - 0.1 - NPC(B).standingOnPlayerY
                                            NPC(B).standingOnPlayerY = 0
                                            If NPC(B).Type = 22 Then NPC(B).Special = 0
                                            If NPC(B).Type = 50 Then
                                                NPC(B).Killed = 9
                                                NPC(B).Special = 0
                                            ElseIf NPC(B).Type = 49 Then
                                                NPC(B).Special = 0
                                            End If
                                        End If
                                    Next B
                                End If
                            End If
                        ElseIf .Driving = True Then 'driving
                            If .Duck = True Then UnDuck A
                            .Driving = False
                            If .StandingOnNPC > 0 Then
                                NPC(.StandingOnNPC).Special4 = 1
                                If .Controls.Left = True Then
                                    NPC(.StandingOnNPC).Special5 = -1
                                ElseIf .Controls.Right = True Then
                                    NPC(.StandingOnNPC).Special5 = 1
                                Else
                                    NPC(.StandingOnNPC).Special5 = 0
                                End If
                                If .Controls.Up = True Then
                                    NPC(.StandingOnNPC).Special6 = -1
                                ElseIf .Controls.Down = True Then
                                    NPC(.StandingOnNPC).Special6 = 1
                                Else
                                    NPC(.StandingOnNPC).Special6 = 0
                                End If
                            End If
                            .Location.SpeedX = 0
                        
                        ElseIf .Fairy = True Then 'if a fairy
                            If .Controls.Right = True Then
                                If .Location.SpeedX < 3 Then .Location.SpeedX = .Location.SpeedX + 0.15
                                If .Location.SpeedX < 0 Then .Location.SpeedX = .Location.SpeedX + 0.1
                            ElseIf .Controls.Left = True Then
                                If .Location.SpeedX > -3 Then .Location.SpeedX = .Location.SpeedX - 0.15
                                If .Location.SpeedX > 0 Then .Location.SpeedX = .Location.SpeedX - 0.1
                            ElseIf .Location.SpeedX > 0.1 Then
                                .Location.SpeedX = .Location.SpeedX - 0.1
                            ElseIf .Location.SpeedX < -0.1 Then
                                .Location.SpeedX = .Location.SpeedX + 0.1
                            Else
                                .Location.SpeedX = 0
                            End If
                        'if the player is climbing a vine
                        ElseIf .Vine > 0 Then
                            If .StandingOnNPC > 0 And .Controls.Up = False Then
                                .Vine = 0
                            End If
                            .CanFly = False
                            .CanFly2 = False
                            .RunCount = 0
                            .SpinJump = False
                            If .Controls.Left = True Then
                                .Location.SpeedX = -1.5
                            ElseIf .Controls.Right = True Then
                                .Location.SpeedX = 1.5
                            Else
                                .Location.SpeedX = 0
                            End If
                            If .Controls.Up = True And .Vine > 2 Then
                                .Location.SpeedY = -2
                            ElseIf .Controls.Down = True Then
                                .Location.SpeedY = 3
                            Else
                                .Location.SpeedY = 0
                            End If
                            .Location.SpeedX = .Location.SpeedX + NPC(.VineNPC).Location.SpeedX
                            .Location.SpeedY = .Location.SpeedY + NPC(.VineNPC).Location.SpeedY
                        Else
                        
'if none of the above apply then the player controls like normal. remeber this is for the players X movement
                        
                        
                'ducking for link
                        If .Duck = True And .WetFrame = True Then
                            If .Location.SpeedY <> 0 And .Slope = 0 And .StandingOnNPC = 0 Then UnDuck A
                        End If
                'the following code controls the players ability to duck
                        If Not (.Character = 5 And ((.Location.SpeedY <> 0 And .Slope = 0 And .StandingOnNPC = 0) Or .FireBallCD <> 0)) Then  'Link can't duck/unduck in air
                            If .Controls.Down = True And .SpinJump = False And .Stoned = False And .Vine = 0 And .Slide = False And (.Slope = 0 Or .Mount > 0 Or .WetFrame = True Or .Character >= 3 Or .GrabTime > 0) And ((.WetFrame = False Or .Character >= 3) Or .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope <> 0 Or .Mount = 1) And .Fairy = False And .ShellSurf = False And .Driving = False Then
                                .Bumped = False
                                If .Mount <> 2 Then 'cant duck in the clown car
                                    If .Mount = 3 Then 'duck on a yoshi
                                        If .Duck = False Then
                                            .Location.Y = .Location.Y + .Location.Height
                                            .Location.Height = 31
                                            .Location.Y = .Location.Y - .Location.Height
                                            .Duck = True
                                            'If nPlay.Online = True And A = nPlay.MySlot + 1 Then Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1q" & A & LB
                                            If nPlay.Online = True And A = nPlay.MySlot + 1 Then Netplay.sendData "1q" & A & LB
                                        End If
                                    Else 'normal duck
                                        If (.State > 1 And .HoldingNPC <= 0) Or (.Character = 3 Or .Character = 4 Or .Character = 5) Then
                                            If .Duck = False And .TailCount = 0 Then 'Player ducks
                                                If .Character = 5 Then .SwordPoke = 0
                                                .Duck = True
                                                .Location.Y = .Location.Y + .Location.Height
                                                .Location.Height = Physics.PlayerDuckHeight(.Character, .State)
                                                .Location.Y = .Location.Y - .Location.Height
                                                If nPlay.Online = True And A = nPlay.MySlot + 1 Then Netplay.sendData "1q" & A & LB
                                            End If
                                        ElseIf .Mount = 1 Then
                                            If .Duck = False And .TailCount = 0 Then 'Player ducks
                                                .Duck = True
                                                .Location.Height = Physics.PlayerDuckHeight(1, 2)
                                                .Location.Y = .Location.Y - Physics.PlayerDuckHeight(1, 2) + Physics.PlayerHeight(1, 2)
                                                If nPlay.Online = True And A = nPlay.MySlot + 1 Then Netplay.sendData "1q" & A & LB
                                            End If
                                        End If
                                    End If
                                End If
                            Else
                                If .Duck = True Then UnDuck A
                            End If
                        End If
                            C = 1
                            'If .Character = 5 Then C = 0.94
                            If .Character = 5 Then C = 0.95
                            If .Controls.Left = True And (.Duck = False And .GrabTime = 0 Or (.Location.SpeedY <> 0 And .StandingOnNPC = 0 And .Slope = 0) Or .Mount = 1) Then
                                .Bumped = False
                                If .Controls.Run = True Or .Location.SpeedX > -Physics.PlayerWalkSpeed * speedVar Or .Character = 5 Then
                                    If .Location.SpeedX > -Physics.PlayerWalkSpeed * speedVar * C Then
                                        If .Character = 2 Then .Location.SpeedX = .Location.SpeedX + 0.1 * 0.175 'LUIGI
                                        If .Character = 3 Then .Location.SpeedX = .Location.SpeedX + 0.05 * 0.175 'PEACH
                                        If .Character = 4 Then .Location.SpeedX = .Location.SpeedX - 0.05 * 0.175 'toad
                                        .Location.SpeedX = .Location.SpeedX - 0.1 * speedVar
                                    Else 'Running
                                        If .Character = 2 Then .Location.SpeedX = .Location.SpeedX + 0.05 * 0.175 'LUIGI
                                        If .Character = 3 Then .Location.SpeedX = .Location.SpeedX + 0.025 * 0.175 'PEACH
                                        If .Character = 4 Then .Location.SpeedX = .Location.SpeedX - 0.025 * 0.175 'toad
                                        If .Character = 5 Then 'Link
                                            .Location.SpeedX = .Location.SpeedX - 0.025 * speedVar
                                        Else 'Mario
                                            .Location.SpeedX = .Location.SpeedX - 0.05 * speedVar
                                        End If
                                    End If
                                    If .Location.SpeedX > 0 Then
                                        .Location.SpeedX = .Location.SpeedX - 0.18
                                        If .Character = 2 Then .Location.SpeedX = .Location.SpeedX + 0.18 * 0.29 'LUIGI
                                        If .Character = 3 Then .Location.SpeedX = .Location.SpeedX + 0.09 * 0.29 'PEACH
                                        If .Character = 4 Then .Location.SpeedX = .Location.SpeedX - 0.09 * 0.29 'toad
                                        If SuperSpeed = True Then .Location.SpeedX = .Location.SpeedX * 0.95
                                    End If
                                End If
                                If SuperSpeed = True And .Controls.Run = True Then .Location.SpeedX = .Location.SpeedX - 0.1
                            ElseIf .Controls.Right = True And ((.Duck = False And .GrabTime = 0) Or (.Location.SpeedY <> 0 And .StandingOnNPC = 0 And .Slope = 0) Or .Mount = 1) Then
                                .Bumped = False
                                If .Controls.Run = True Or .Location.SpeedX < Physics.PlayerWalkSpeed * speedVar Or .Character = 5 Then
                                    If .Location.SpeedX < Physics.PlayerWalkSpeed * speedVar * C Then
                                        If .Character = 2 Then .Location.SpeedX = .Location.SpeedX - 0.1 * 0.175 'LUIGI
                                        If .Character = 3 Then .Location.SpeedX = .Location.SpeedX - 0.05 * 0.175 'PEACH
                                        If .Character = 4 Then .Location.SpeedX = .Location.SpeedX + 0.05 * 0.175 'toad
                                        .Location.SpeedX = .Location.SpeedX + 0.1 * speedVar
                                    Else
                                        If .Character = 2 Then .Location.SpeedX = .Location.SpeedX - 0.05 * 0.175 'LUIGI
                                        If .Character = 3 Then .Location.SpeedX = .Location.SpeedX - 0.025 * 0.175 'PEACH
                                        If .Character = 4 Then .Location.SpeedX = .Location.SpeedX + 0.025 * 0.175 'toad
                                        If .Character = 5 Then 'Link
                                            .Location.SpeedX = .Location.SpeedX + 0.025 * speedVar
                                        Else 'Mario
                                            .Location.SpeedX = .Location.SpeedX + 0.05 * speedVar
                                        End If
                                    End If
                                    If .Location.SpeedX < 0 Then
                                        .Location.SpeedX = .Location.SpeedX + 0.18
                                        If .Character = 2 Then .Location.SpeedX = .Location.SpeedX - 0.18 * 0.29 'LUIGI
                                        If .Character = 3 Then .Location.SpeedX = .Location.SpeedX - 0.09 * 0.29 'PEACH
                                        If .Character = 4 Then .Location.SpeedX = .Location.SpeedX + 0.09 * 0.29 'toad
                                        If SuperSpeed = True Then .Location.SpeedX = .Location.SpeedX * 0.95
                                    End If
                                End If
                                If SuperSpeed = True And .Controls.Run = True Then .Location.SpeedX = .Location.SpeedX + 0.1
                            Else
                                If .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope > 0 Or .WetFrame = True Then  'Only lose speed when not in the air
                                    If .Location.SpeedX > 0 Then .Location.SpeedX = .Location.SpeedX - 0.07 * speedVar
                                    If .Location.SpeedX < 0 Then .Location.SpeedX = .Location.SpeedX + 0.07 * speedVar
                                    If .Character = 2 Then .Location.SpeedX = .Location.SpeedX * 1.003 'LUIGI
                                    If .Character = 3 Then .Location.SpeedX = .Location.SpeedX * 1.0015 'PEACH
                                    If .Character = 4 Then .Location.SpeedX = .Location.SpeedX * 0.9985 'toad
                                    If SuperSpeed = True Then .Location.SpeedX = .Location.SpeedX * 0.95
                                End If
                                If .Location.SpeedX > -0.18 And .Location.SpeedX < 0.18 Then
                                    .Bumped = False
                                    .Location.SpeedX = 0
                                End If
                            End If
                            If .Location.SpeedX < -16 Then
                                .Location.SpeedX = -16
                            ElseIf .Location.SpeedX > 16 Then
                                .Location.SpeedX = 16
                            End If
                            If .Controls.Run = True Or .Character = 5 Then
                                If .Location.SpeedX >= Physics.PlayerRunSpeed * speedVar Then
                                    If SuperSpeed = False Then .Location.SpeedX = Physics.PlayerRunSpeed * speedVar
                                ElseIf .Location.SpeedX <= -Physics.PlayerRunSpeed * speedVar Then
                                    If SuperSpeed = False Then .Location.SpeedX = -Physics.PlayerRunSpeed * speedVar
                                Else
                                End If
                            Else
                                If .Location.SpeedX > Physics.PlayerWalkSpeed + 0.1 * speedVar Then
                                    .Location.SpeedX = .Location.SpeedX - 0.1
                                ElseIf .Location.SpeedX < -Physics.PlayerWalkSpeed - 0.1 * speedVar Then .Location.SpeedX = .Location.SpeedX + 0.1
                                ElseIf Abs(.Location.SpeedX) > Physics.PlayerWalkSpeed * speedVar Then
                                    If .Location.SpeedX > 0 Then
                                        .Location.SpeedX = Physics.PlayerWalkSpeed * speedVar
                                    Else
                                        .Location.SpeedX = -Physics.PlayerWalkSpeed * speedVar
                                    End If
                                End If
                            End If
                            If .Mount = 1 And .MountType = 3 Then
                                .CanFly2 = True
                                .FlyCount = 1000
                            End If
                            If .Mount <> 3 Then .YoshiBlue = False
                            If FlyForever = True And .GroundPound = False Then
                                If .Mount = 3 Then .YoshiBlue = True
                                If (.State = 4 Or .State = 5) Or (.YoshiBlue = True And .Mount = 3) Or (.Mount = 1 And .MountType = 3) Then
                                    .CanFly2 = True
                                Else
                                    .CanFly2 = False
                                    .CanFly = False
                                    .FlyCount = 0
                                    .YoshiBlue = False
                                End If
                            End If
            'Racoon/Tanooki Mario.  this handles the ability to fly after running
                            If (.State = 4 Or .State = 5) And .Wet = 0 Then
                                If (.Location.SpeedY = 0 Or .CanFly2 = True Or .StandingOnNPC <> 0 Or .Slope > 0) And (Abs(.Location.SpeedX) >= Physics.PlayerRunSpeed Or (.Character = 3 And Abs(.Location.SpeedX) >= 5.58)) Then
                                    .RunCount = .RunCount + 1
                                Else
                                    If Not (Abs(.Location.SpeedX) >= Physics.PlayerRunSpeed Or (.Character = 3 And Abs(.Location.SpeedX) >= 5.58)) Then
                                        .RunCount = .RunCount - 0.3
                                    End If
                                End If
                                If .RunCount >= 35 And .Character = 1 Then
                                    .CanFly = True
                                    .RunCount = 35
                                ElseIf .RunCount >= 40 And .Character = 2 Then
                                    .CanFly = True
                                    .RunCount = 40
                                ElseIf .RunCount >= 80 And .Character = 3 Then
                                    .CanFly = True
                                    .RunCount = 80
                                ElseIf .RunCount >= 60 And .Character = 4 Then
                                    .CanFly = True
                                    .RunCount = 60
                                ElseIf .RunCount >= 10 And .Character = 5 Then 'link flying
                                    .CanFly = True
                                    .RunCount = 10
                                Else
                                    .CanFly = False
                                    If .RunCount < 0 Then .RunCount = 0
                                End If
                            End If
                            If .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope > 0 Then .FlyCount = 1
                            If .FlyCount > 1 Then
                                .FlyCount = .FlyCount - 1
                            ElseIf .FlyCount = 1 Then
                                .CanFly2 = False
                                .FlyCount = 0
                            End If
                        End If
                    
                    
                'stop link when stabbing
                    If .Character = 5 Then
                        If .FireBallCD > 0 And (.Location.SpeedY = 0 Or .Slope <> 0 Or .StandingOnNPC <> 0) Then
                            If .Slippy = True Then
                                .Location.SpeedX = .Location.SpeedX * 0.75
                            Else
                                .Location.SpeedX = 0
                            End If
                        End If
                    End If
                'fairy stuff
                    If .FairyTime <> 0 And .Fairy = True Then
                        If Rnd * 10 > 9 Then
                            NewEffect 80, newLoc(.Location.X - 8 + Rnd * (.Location.Width + 16) - 4, .Location.Y - 8 + Rnd * (.Location.Height + 16)), , , ShadowMode
                            Effect(numEffects).Location.SpeedX = Rnd * 0.5 - 0.25
                            Effect(numEffects).Location.SpeedY = Rnd * 0.5 - 0.25
                            Effect(numEffects).Frame = 1
                        End If
                        If .FairyTime > 0 Then .FairyTime = .FairyTime - 1
                        If .FairyTime <> -1 And .FairyTime < 20 And .Character = 5 Then
                            For B = 1 To numNPCs
                                If NPC(B).Active = True Then
                                    If NPC(B).Hidden = False Then
                                        If NPCIsAVine(NPC(B).Type) Then
                                            tempLocation = NPC(B).Location
                                            tempLocation.Width = tempLocation.Width + 32
                                            tempLocation.Height = tempLocation.Height + 32
                                            tempLocation.X = tempLocation.X - 16
                                            tempLocation.Y = tempLocation.Y - 16
                                            If CheckCollision(tempLocation, .Location) Then
                                                .FairyTime = 20
                                                .FairyCD = 0
                                            End If
                                        End If
                                    End If
                                End If
                            Next B
                            For B = 1 To numBackground
                                If BackgroundFence(Background(B).Type) Then
                                    If Background(B).Hidden = False Then
                                        tempLocation = Background(B).Location
                                        tempLocation.Width = tempLocation.Width + 32
                                        tempLocation.Height = tempLocation.Height + 32
                                        tempLocation.X = tempLocation.X - 16
                                        tempLocation.Y = tempLocation.Y - 16
                                        If CheckCollision(tempLocation, .Location) Then
                                            .FairyTime = 20
                                            .FairyCD = 0
                                        End If
                                    End If
                                End If
                            Next B
                            
                        End If
                    ElseIf .Fairy = True Then
                        PlaySound 87
                        .Immune = 10
                        .Effect = 8
                        .Effect2 = 4
                        .Fairy = False
                        SizeCheck A
                        NewEffect 63, .Location
                        PlayerPush A, 3
                    Else
                        .FairyTime = 0
                    End If
                    If .FairyCD <> 0 And (.Location.SpeedY = 0 Or .Slope <> 0 Or .StandingOnNPC <> 0 Or .WetFrame = True) Then .FairyCD = .FairyCD - 1
                        

                        If .StandingOnNPC <> 0 And NPC(.StandingOnNPC).Pinched = False And FreezeNPCs = False Then
                            If .StandingOnNPC < 0 Then
                                NPC(.StandingOnNPC).Location = Block(NPC(.StandingOnNPC).Special).Location
                            End If
                            .Location.SpeedX = .Location.SpeedX + NPC(.StandingOnNPC).Location.SpeedX + NPC(.StandingOnNPC).BeltSpeed
                        End If
                        
                        If GameOutro = True Then 'force the player to walk a specific speed during the credits
                            If .Location.SpeedX < -2 Then .Location.SpeedX = -2
                            If .Location.SpeedX > 2 Then .Location.SpeedX = 2
                        End If
                        
                        
                        
'slippy code
If .Slippy = True And (.Slide = False Or .Slope = 0) Then
    If .Slope > 0 Then
        .Location.SpeedX = (.Location.SpeedX + SlippySpeedX * 4) / 5
        If .Location.SpeedX > -0.01 And .Location.SpeedX < 0.01 Then .Location.SpeedX = 0
    Else
        .Location.SpeedX = (.Location.SpeedX + SlippySpeedX * 3) / 4
        If .Location.SpeedX > -0.01 And .Location.SpeedX < 0.01 Then .Location.SpeedX = 0
    End If
End If
wasSlippy = .Slippy
.Slippy = False
                        
                            If .Quicksand > 1 Then
                                .Slide = False
                                If .Location.SpeedY >= 0 Then
                                    .Location.SpeedX = .Location.SpeedX * 0.5
                                End If
                            End If
                        
                        
                        .Location.X = .Location.X + .Location.SpeedX 'This is where the actual movement happens
                        
'Players Y movement.
                        If Block(.Slope).Location.SpeedY <> 0 And .Slope <> 0 Then
                            .Location.Y = .Location.Y + Block(.Slope).Location.SpeedY
                        End If
                    
                    If .Fairy = True Then ' the player is a fairy
                        .WetFrame = False
                        .Wet = 0
                        If .FairyCD = 0 Then
                            If .Controls.Jump = True Or .Controls.AltJump = True Or .Controls.Up = True Then
                                .Location.SpeedY = .Location.SpeedY - 0.15
                                If .Location.SpeedY > 0 Then .Location.SpeedY = .Location.SpeedY - 0.1
                            ElseIf .Location.SpeedY < -0.1 Or .Controls.Down = True Then
                                If .Location.SpeedY < 3 Then .Location.SpeedY = .Location.SpeedY + Physics.PlayerGravity * 0.05
                                If .Location.SpeedY < 0 Then .Location.SpeedY = .Location.SpeedY + Physics.PlayerGravity * 0.05
                                .Location.SpeedY = .Location.SpeedY + Physics.PlayerGravity * 0.1
                                If .Controls.Down = True Then
                                    .Location.SpeedY = .Location.SpeedY + 0.05
                                End If
                            ElseIf .Location.SpeedY > 0.1 Then
                                .Location.SpeedY = .Location.SpeedY - 0.15
                            Else
                                .Location.SpeedY = 0
                            End If
                        Else
                            If .Controls.Jump = True Or .Controls.AltJump = True Or .Controls.Up = True Then
                                .Location.SpeedY = .Location.SpeedY - 0.15
                                If .Location.SpeedY > 0 Then .Location.SpeedY = .Location.SpeedY - 0.1
                            Else
                                If .Location.SpeedY < 3 Then .Location.SpeedY = .Location.SpeedY + Physics.PlayerGravity * 0.05
                                If .Location.SpeedY < 0 Then .Location.SpeedY = .Location.SpeedY + Physics.PlayerGravity * 0.05
                                .Location.SpeedY = .Location.SpeedY + Physics.PlayerGravity * 0.1
                                If .Controls.Down = True Then
                                    .Location.SpeedY = .Location.SpeedY + 0.05
                                End If
                            End If
                        End If
                        
                        If .Location.SpeedY > 4 Then
                            .Location.SpeedY = 4
                        ElseIf .Location.SpeedY < -3 Then
                            .Location.SpeedY = -3
                        End If
                        .Location.Y = .Location.Y + .Location.SpeedY
                    ElseIf .Wet > 0 And .Quicksand = 0 Then 'the player is swimming
                        If .Mount = 1 Then
                            If .Controls.AltJump = True And .CanAltJump = True Then
                                .CanJump = False
                                 PlaySound 1 'Jump sound
                                 PlaySound 35
                                .Location.SpeedY = Physics.PlayerJumpVelocity - tempSpeed
                                .Jump = Physics.PlayerJumpHeight
                                If .Character = 2 Then .Jump = .Jump + 3
                                If .SpinJump = True Then .Jump = .Jump - 6
                                .Mount = 0
                                .StandingOnNPC = 0
                                numNPCs = numNPCs + 1
                                .FlyCount = 0
                                .RunCount = 0
                                .CanFly = False
                                .CanFly2 = False
                                With NPC(numNPCs)
                                    .Direction = Player(A).Direction
                                    .Active = True
                                    .TimeLeft = 100
                                    If Player(A).MountType = 1 Then
                                        .Type = 35
                                    ElseIf Player(A).MountType = 2 Then
                                        .Type = 191
                                    ElseIf Player(A).MountType = 3 Then
                                        .Type = 193
                                    End If
                                    .Location.Height = 32
                                    .Location.Width = 32
                                    .Location.Y = Player(A).Location.Y + Player(A).Location.Height - 32
                                    .Location.X = Int(Player(A).Location.X + Player(A).Location.Width / 2 - 16)
                                    .Location.SpeedY = 1
                                    .Location.SpeedX = (Player(A).Location.SpeedX - NPC(Player(A).StandingOnNPC).Location.SpeedX) * 0.8
                                    .CantHurt = 10
                                    .CantHurtPlayer = A
                                End With
                                .Location.Y = .Location.Y + .Location.Height
                                .Location.Height = Physics.PlayerHeight(.Character, .State)
                                .Location.Y = .Location.Y - .Location.Height
                            End If
                        ElseIf .Mount = 3 Then
                            If .Controls.AltJump = True And .CanAltJump = True Then
                                UnDuck A
                                If .YoshiNPC > 0 Or .YoshiPlayer > 0 Then
                                    YoshiSpit A
                                End If
                                .CanJump = False
                                .StandingOnNPC = 0
                                .Mount = 0
                                numNPCs = numNPCs + 1
                                With NPC(numNPCs)
                                    .Direction = Player(A).Direction
                                    .Active = True
                                    .TimeLeft = 100
                                    If Player(A).MountType = 1 Then
                                        .Type = 95
                                    ElseIf Player(A).MountType = 2 Then
                                        .Type = 98
                                    ElseIf Player(A).MountType = 3 Then
                                        .Type = 99
                                    ElseIf Player(A).MountType = 4 Then
                                        .Type = 100
                                    ElseIf Player(A).MountType = 5 Then
                                        .Type = 148
                                    ElseIf Player(A).MountType = 6 Then
                                        .Type = 149
                                    ElseIf Player(A).MountType = 7 Then
                                        .Type = 150
                                    ElseIf Player(A).MountType = 8 Then
                                        .Type = 228
                                    End If
                                    .Location.Height = 32
                                    .Location.Width = 32
                                    .Location.Y = Player(A).Location.Y + Player(A).Location.Height - 32
                                    .Location.X = Int(Player(A).Location.X + Player(A).Location.Width / 2 - 16)
                                    .Location.SpeedY = 0.5
                                    .Location.SpeedX = 0
                                    .CantHurt = 10
                                    .CantHurtPlayer = A
                                    'If ShadowMode = True Then .Shadow = True
                                End With
                                .Location.Height = Physics.PlayerHeight(.Character, .State)
                            End If
                        End If
                        
                        If .Duck = True Then
                            If .StandingOnNPC = 0 And .Slope = 0 And .Location.SpeedY <> 0 And .Mount <> 1 Then
                                If .Character <= 2 Then UnDuck A 'unduck wet players that aren't peach o toad
                            End If
                        End If
                        
                        .Location.SpeedY = .Location.SpeedY + Physics.PlayerGravity * 0.1
                        If .Location.SpeedY >= 3 Then .Location.SpeedY = 3 'Terminal Velocity in water
                        If .Mount = 1 Then
                            If .Controls.Left = True Or .Controls.Right = True Then
                                If .Location.SpeedY = Physics.PlayerGravity * 0.1 Or .Slope > 0 Or (.StandingOnNPC <> 0 And .Location.Y + .Location.Height >= NPC(.StandingOnNPC).Location.Y - NPC(.StandingOnNPC).Location.SpeedY) Then
                                    If .Controls.Left = True And .Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX - NPC(.StandingOnNPC).BeltSpeed <= 0 Then
                                        .Location.SpeedY = -1.1 + NPC(.StandingOnNPC).Location.SpeedY
                                    ElseIf .Controls.Right = True And .Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX - NPC(.StandingOnNPC).BeltSpeed >= 0 Then
                                        .Location.SpeedY = -1.1 + NPC(.StandingOnNPC).Location.SpeedY
                                    Else
                                        PlaySound 10
                                    End If
                                    .MountSpecial = 1
                                End If
                            End If
                            
                            If .Location.SpeedY < -1.1 Then
                                .MountSpecial = 0
                            ElseIf .Location.SpeedY > 1.1 Then
                                .MountSpecial = 0
                            ElseIf .FloatTime >= 0 Then
                                .MountSpecial = 0
                            End If
                            
                            
                            If .Controls.Jump = True And .MountSpecial = 1 And .CanJump = True Then
                                .Location.SpeedY = Physics.PlayerGravity * 0.1
                                .MountSpecial = 0
                                .StandUp = True
                            End If
                        End If
                        
                        If .SwimCount > 0 Then .SwimCount = .SwimCount - 1
                        If .SwimCount = 0 Then
                            If .Mount <> 1 Or .Location.SpeedY = Physics.PlayerGravity * 0.1 Or .Slope <> 0 Or .StandingOnNPC <> 0 Then
                                If .Controls.Jump = True And .CanJump = True Or .Controls.AltJump = True And .CanAltJump = True Then
                                    If .Duck = True And .Mount <> 1 And .Character <= 2 Then UnDuck A
                                    If .Slope <> 0 Then .Location.SpeedY = 0
                                    .Vine = 0
                                    If .StandingOnNPC <> 0 Then
                                        .Location.SpeedY = NPC(.StandingOnNPC).Location.SpeedY
                                        .StandingOnNPC = 0
                                    End If
                                    .SwimCount = 15
                                    'If .Location.SpeedY = 0 Then .Location.Y = .Location.Y - 1
                                    If .Controls.Down = True Then
                                        If .Location.SpeedY >= Physics.PlayerJumpVelocity * 0.2 Then
                                            .Location.SpeedY = .Location.SpeedY + Physics.PlayerJumpVelocity * 0.2
                                            If .Location.SpeedY < Physics.PlayerJumpVelocity * 0.2 Then .Location.SpeedY = Physics.PlayerJumpVelocity * 0.2
                                        End If
                                    Else
                                        If .Controls.Up = True Then
                                            .Location.SpeedY = .Location.SpeedY + Physics.PlayerJumpVelocity * 0.5
                                        Else
                                            .Location.SpeedY = .Location.SpeedY + Physics.PlayerJumpVelocity * 0.4
                                        End If
                                        If .Mount = 1 Then .Location.SpeedY = Physics.PlayerJumpVelocity
                                    End If
                                    If .Location.SpeedY > 0 Then .Location.SpeedY = Physics.PlayerJumpVelocity * 0.2
                                    PlaySound 72
                                End If
                            End If
                        End If
                        
                        If .Controls.Jump = True Then
                            .CanJump = False
                        Else
                            .CanJump = True
                        End If
                        If .Controls.AltJump = True Then
                            .CanAltJump = False
                        Else
                            .CanAltJump = True
                        End If
                        If .Controls.Up = True Then
                            If .Location.SpeedY < -4 Then .Location.SpeedY = -4
                        Else
                            If .Location.SpeedY < -3 Then .Location.SpeedY = -3
                        End If
                        
                        .Location.Y = .Location.Y + .Location.SpeedY
                    
                    Else 'the player is not swimming
    
                        If .Mount <> 2 Then 'if not in the clown car
                        
                            If .Mount = 1 Then 'this gives the player the bounce when in the kurbio's shoe
                                If .Controls.Left = True Or .Controls.Right = True Then
                                    If .Location.SpeedY = 0 Or .Slope > 0 Or (.StandingOnNPC <> 0 And .Location.Y + .Location.Height >= NPC(.StandingOnNPC).Location.Y - NPC(.StandingOnNPC).Location.SpeedY) Then
                                        If .Controls.Left = True And .Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX - NPC(.StandingOnNPC).BeltSpeed <= 0 Then
                                            .Location.SpeedY = -4.1 + NPC(.StandingOnNPC).Location.SpeedY
                                        ElseIf .Controls.Right = True And .Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX - NPC(.StandingOnNPC).BeltSpeed >= 0 Then
                                            .Location.SpeedY = -4.1 + NPC(.StandingOnNPC).Location.SpeedY
                                        Else
                                            PlaySound 10
                                        End If
                                        .MountSpecial = 1
                                    End If
                                End If
                                If .Location.SpeedY < -4.1 Then
                                    .MountSpecial = 0
                                ElseIf .Location.SpeedY > 4.1 Then
                                    .MountSpecial = 0
                                End If
                                If .Controls.Jump = True And .MountSpecial = 1 And .CanJump = True Then
                                    .Location.SpeedY = 0
                                    .StandUp = True
                                End If
                            End If
                            
                            If .Mount = 1 Then
                                If .Controls.AltJump = True And .CanAltJump = True Then  'check to see if the player should jump out of the shoe
                                    UnDuck A
                                    .CanJump = False
                                     PlaySound 1 'Jump sound
                                     PlaySound 35
                                    .Location.SpeedY = Physics.PlayerJumpVelocity - tempSpeed
                                    .Jump = Physics.PlayerJumpHeight
                                    If .Character = 2 Then .Jump = .Jump + 3
                                    If .SpinJump = True Then .Jump = .Jump - 6
                                    .Mount = 0
                                    .StandingOnNPC = 0
                                    numNPCs = numNPCs + 1
                                    .FlyCount = 0
                                    .RunCount = 0
                                    .CanFly = False
                                    .CanFly2 = False
                                    With NPC(numNPCs)
                                        .Direction = Player(A).Direction
                                        .Active = True
                                        .TimeLeft = 100
                                        If Player(A).MountType = 1 Then
                                            .Type = 35
                                        ElseIf Player(A).MountType = 2 Then
                                            .Type = 191
                                        ElseIf Player(A).MountType = 3 Then
                                            .Type = 193
                                        End If
                                        .Location.Height = 32
                                        .Location.Width = 32
                                        .Location.Y = Player(A).Location.Y + Player(A).Location.Height - 32
                                        .Location.X = Int(Player(A).Location.X + Player(A).Location.Width / 2 - 16)
                                        .Location.SpeedY = 1
                                        .Location.SpeedX = (Player(A).Location.SpeedX - NPC(Player(A).StandingOnNPC).Location.SpeedX) * 0.8
                                        .CantHurt = 10
                                        .CantHurtPlayer = A
                                    End With
                                    .Location.Y = .Location.Y + .Location.Height
                                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                                    .Location.Y = .Location.Y - .Location.Height
                                End If
                            ElseIf .Mount = 3 Then
                                If .Controls.AltJump = True And .CanAltJump = True Then 'jump off of yoshi
                                    UnDuck A
                                    If .YoshiNPC > 0 Or .YoshiPlayer > 0 Then
                                        YoshiSpit A
                                    End If
                                    .CanJump = False
                                    .StandingOnNPC = 0
                                     PlaySound 1 'Jump sound
                                    .Location.SpeedY = Physics.PlayerJumpVelocity - tempSpeed
                                    .Jump = Physics.PlayerJumpHeight
                                    If .Character = 2 Then .Jump = .Jump + 3
                                    If .SpinJump = True Then .Jump = .Jump - 6
                                    .Mount = 0
                                    numNPCs = numNPCs + 1
                                    With NPC(numNPCs)
                                        .Direction = Player(A).Direction
                                        .Active = True
                                        .TimeLeft = 100
                                        If Player(A).MountType = 1 Then
                                            .Type = 95
                                        ElseIf Player(A).MountType = 2 Then
                                            .Type = 98
                                        ElseIf Player(A).MountType = 3 Then
                                            .Type = 99
                                        ElseIf Player(A).MountType = 4 Then
                                            .Type = 100
                                        ElseIf Player(A).MountType = 5 Then
                                            .Type = 148
                                        ElseIf Player(A).MountType = 6 Then
                                            .Type = 149
                                        ElseIf Player(A).MountType = 7 Then
                                            .Type = 150
                                        ElseIf Player(A).MountType = 8 Then
                                            .Type = 228
                                        End If
                                        .Location.Height = 32
                                        .Location.Width = 32
                                        .Location.Y = Player(A).Location.Y + Player(A).Location.Height - 32
                                        .Location.X = Int(Player(A).Location.X + Player(A).Location.Width / 2 - 16)
                                        .Location.SpeedY = 0.5
                                        .Location.SpeedX = 0
                                        .CantHurt = 10
                                        .CantHurtPlayer = A
                                    End With
                                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                                End If
                            End If
                            
                            If (.Location.SpeedY = 0 Or .Jump > 0 Or .Vine > 0) And .FloatTime = 0 Then .CanFloat = True 'princess float
                            If .Wet > 0 Or .WetFrame = True Then .CanFloat = False
'handles the regular jump
                            If .Controls.Jump = True Or (.Controls.AltJump = True And ((.Character > 2 And .Character <> 4) Or .Quicksand > 0) And .CanAltJump = True) Then
                                If .Location.SpeedX > 0 Then
                                    tempSpeed = .Location.SpeedX * 0.2 'tempSpeed gives the player a height boost when jumping while running, based off his SpeedX
                                Else
                                    tempSpeed = -.Location.SpeedX * 0.2
                                End If
                                If .ShellSurf = True Then 'this code modifies the jump based on him riding a shell
                                    If NPC(.StandingOnNPC).Location.SpeedY = 0 Or NPC(.StandingOnNPC).Slope > 0 Then
                                        If .CanJump = True Then
                                            PlaySound 33 'Jump sound
                                            .Jump = Physics.PlayerJumpHeight * 0.6
                                            NPC(.StandingOnNPC).Location.SpeedY = Physics.PlayerJumpVelocity * 0.9
                                        End If
                                    ElseIf .Jump > 0 Then
                                        NPC(.StandingOnNPC).Location.SpeedY = Physics.PlayerJumpVelocity * 0.9
                                    End If
                                
                'if not surfing a shell then proceed like normal
                                Else
                                    If (.Vine > 0 Or .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or MultiHop = True Or .Slope > 0 Or (.Location.SpeedY > 0 And .Quicksand > 0)) And .CanJump = True Then
                                        PlaySound 1 'Jump sound
                                        .Location.SpeedY = Physics.PlayerJumpVelocity - tempSpeed
                                        .Jump = Physics.PlayerJumpHeight
                                        If .Character = 4 And (.State = 4 Or .State = 5) And .SpinJump = False Then .DoubleJump = True
                                        If .Character = 2 Then .Jump = .Jump + 3
                                        If .SpinJump = True Then .Jump = .Jump - 6
                                        If .StandingOnNPC > 0 And FreezeNPCs = False Then
                                            If NPC(.StandingOnNPC).Type <> 91 Then .Location.SpeedX = .Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX
                                        End If
                                        .StandingOnNPC = 0 'the player can't stand on an NPC after jumping
                                        If .CanFly = True Then 'let's the player fly if the conditions are met
                                            .StandingOnNPC = 0
                                            .Jump = 30
                                            If .Character = 2 Then .Jump = .Jump + 3
                                            If .SpinJump = True Then .Jump = .Jump - 6
                                            .CanFly = False
                                            .RunCount = 0
                                            .CanFly2 = True
                                            If .Character = 2 Then 'luigi doesn't fly as long as mario
                                                .FlyCount = 300 'Length of flight time
                                            ElseIf .Character = 3 Then 'special handling for peach
                                                .FlyCount = 0
                                                .RunCount = 80
                                                .CanFly2 = False
                                                .Jump = 70
                                                .CanFloat = True
                                                .FlySparks = True
                                            ElseIf .Character = 3 Then 'special handling for peach
                                                .FlyCount = 280 'Length of flight time
                                            Else
                                                .FlyCount = 320 'Length of flight time
                                            End If
                                        End If
                                    ElseIf .Jump > 0 Then 'controls the height of the jump
                                        .Location.SpeedY = Physics.PlayerJumpVelocity - tempSpeed
                                        If .Jump > 20 Then
                                            If .Jump > 40 Then
                                                .Location.SpeedY = .Location.SpeedY - (40 - 20) * 0.2
                                            Else
                                                .Location.SpeedY = .Location.SpeedY - (.Jump - 20) * 0.2
                                            End If
                                        End If
                                    ElseIf .CanFly2 = True Then
                                        If .Location.SpeedY > Physics.PlayerJumpVelocity * 0.5 Then
                                            .Location.SpeedY = .Location.SpeedY - 1
                                            .CanPound = True
                                            If .YoshiBlue = True Or .Mount = 1 And .MountType = 3 Then
                                                PlaySound 50
                                            End If
                                        End If
                                    End If
                                End If
                                .CanJump = False
                            Else
                                .CanJump = True
                            End If
                            If .Jump > 0 Then .Slope = 0
                            If .SpinJump = True Or (.State <> 4 And .State <> 5) Or .StandingOnNPC > 0 Or .Slope > 0 Or .Location.SpeedY = 0 Then .DoubleJump = False
                            'double jump code
                            If .DoubleJump = True And .Jump = 0 And .Location.SpeedY <> 0 And .Slope = 0 And .StandingOnNPC = 0 And .Wet = 0 And .Vine = 0 And .WetFrame = False And .Fairy = False And .CanFly2 = False Then
                                If .Controls.Jump = True And .JumpRelease = True Then
                                    PlaySound 1
                                    .Location.SpeedY = Physics.PlayerJumpVelocity
                                    .Jump = 10
                                    .DoubleJump = False
                                    tempLocation = .Location
                                    tempLocation.Y = .Location.Y + .Location.Height - EffectHeight(80) / 2 + .Location.SpeedY
                                    tempLocation.Height = EffectHeight(80)
                                    tempLocation.Width = EffectWidth(80)
                                    tempLocation.X = .Location.X
                                    For B = 1 To 10
                                        NewEffect 80, tempLocation
                                        Effect(numEffects).Location.SpeedX = Rnd * 3 - 1.5
                                        Effect(numEffects).Location.SpeedY = Rnd * 0.5 + (1.5 - Abs(Effect(numEffects).Location.SpeedX)) * 0.5
                                        Effect(numEffects).Location.SpeedX = Effect(numEffects).Location.SpeedX - .Location.SpeedX * 0.2
                                    Next B
                                End If
                            End If
                            
                            
                            
                            If .NoShellKick > 0 Then .NoShellKick = .NoShellKick - 1 'countdown for the next time the player kicks a turtle shell
                            
                            If .ShellSurf = True Then
                                If .Mount <> 0 Then .ShellSurf = False
                                If .Direction <> NPC(.StandingOnNPC).Direction And 1 = 2 Then
                                    .ShellSurf = False
                                    .Location.SpeedY = NPC(.StandingOnNPC).Location.SpeedY
                                    If .Location.SpeedY > 0 Then .Location.SpeedY = 0
                                    PlaySound 10
                                    NPC(.StandingOnNPC).CantHurt = 30
                                    NPC(.StandingOnNPC).CantHurtPlayer = A
                                    .Location.SpeedX = NPC(.StandingOnNPC).Location.SpeedX / 2
                                    .StandingOnNPC = 0
                                    .NoShellKick = 30
                                Else
                                    If Rnd * 10 > 3 Then
                                    tempLocation.Y = .Location.Y + .Location.Height - 2 + Rnd * (NPC(.StandingOnNPC).Location.Height - 8) + 4
                                    tempLocation.X = .Location.X - 4 + Rnd * (.Location.Width - 8) + 4 - 8 * .Direction
                                    NewEffect 80, tempLocation, , , ShadowMode
                                    Effect(numEffects).Frame = Int(Rnd * 3)
                                    Effect(numEffects).Location.SpeedY = (.Location.Y + .Location.Height + NPC(.StandingOnNPC).Location.Height / 32 - tempLocation.Y + 12) * 0.05
                                    End If
                                End If
                                    If NPC(.StandingOnNPC).Wet = 2 Then
                                        If NPC(.StandingOnNPC).Type = 195 Then NPC(.StandingOnNPC).Special4 = 1
                                        NPC(.StandingOnNPC).Location.SpeedY = NPC(.StandingOnNPC).Location.SpeedY - Physics.NPCGravity * 1.5
                                    End If
                            End If
                            
                        'START ALT JUMP - this code does the player's spin jump
                            If .Controls.AltJump = True And (.Character = 1 Or .Character = 2 Or .Character = 4) Then
                                    If .Location.SpeedX > 0 Then
                                        tempSpeed = .Location.SpeedX * 0.2
                                    Else
                                        tempSpeed = -.Location.SpeedX * 0.2
                                    End If
                                    If (.Vine > 0 Or .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope > 0 Or MultiHop = True) And .CanAltJump = True Then     'Player Jumped
                                        If .Duck = False Then
                                            .Slope = 0
                                            .SpinFireDir = .Direction
                                            .Location.SpeedY = Physics.PlayerJumpVelocity - tempSpeed
                                            .Jump = Physics.PlayerJumpHeight
                                            If .Character = 2 Then .Jump = .Jump + 3
                                            
                                            If .StandingOnNPC > 0 And FreezeNPCs = False Then
                                                If NPC(.StandingOnNPC).Type <> 91 Then .Location.SpeedX = .Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX
                                            End If
                                        
                                            PlaySound 33 'Jump sound
                                            .Jump = .Jump - 6
                                            If .Direction = 1 Then
                                                .SpinFrame = 0
                                            Else
                                                .SpinFrame = 6
                                            End If
                                            .SpinJump = True
                                            If nPlay.Online = True And nPlay.MySlot + 1 = A Then Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1l" & A & LB
                                            If .Duck = True Then UnDuck A

                                            If .ShellSurf = True Then
                                                .ShellSurf = False
                                                .Location.SpeedX = NPC(.StandingOnNPC).Location.SpeedX + NPC(.StandingOnNPC).BeltSpeed * 0.8
                                                .Jump = 0
                                            End If
                                            
                                            .StandingOnNPC = 0
                                            
                                            If .CanFly = True Then
                                                .StandingOnNPC = 0
                                                .Jump = 30
                                                If .Character = 2 Then .Jump = .Jump + 3
                                                If .SpinJump = True Then .Jump = .Jump - 6
                                                .CanFly = False
                                                .RunCount = 0
                                                .CanFly2 = True
                                                .FlyCount = 150 'Length of flight time
                                            End If
                                        End If
                                    ElseIf .Jump > 0 Then
                                        .Location.SpeedY = Physics.PlayerJumpVelocity - tempSpeed
                                        If .Jump > 20 Then
                                            .Location.SpeedY = .Location.SpeedY - (.Jump - 20) * 0.2
                                        End If
                                    ElseIf .CanFly2 = True Then
                                        If .Location.SpeedY > Physics.PlayerJumpVelocity * 0.5 Then
                                            .Location.SpeedY = .Location.SpeedY - 1
                                            .CanPound = True
                                            If .YoshiBlue = True Then
                                                PlaySound 50
                                            End If
                                        End If
                                    End If
                                'End If
                                .CanAltJump = False
                                
                            Else
                                .CanAltJump = True
                            End If
                            'END ALT JUMP
                            
                            
                            If (.Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope > 0) And .SpinJump = True Then
                                .SpinJump = False
                                If nPlay.Online = True And nPlay.MySlot + 1 = A Then Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1m" & A & LB
                                .TailCount = 0
                            End If
                            If .Mount > 0 Then .SpinJump = False
                            If .Controls.AltJump = False And .Controls.Jump = False Then
                                .Jump = 0
                            End If
                            If .Jump > 0 Then
                                .Jump = .Jump - 1
                            End If
                            
                            If .Jump > 0 Then .Vine = 0
                    
                    
                            If .Quicksand > 1 Then
                                .Slide = False
                                If .Location.SpeedY < -0.7 Then
                                    .Location.SpeedY = -0.7
                                    .Jump = .Jump - 1
                                ElseIf .Location.SpeedY < 0 Then
                                    .Location.SpeedY = .Location.SpeedY + 0.1
                                    .Jump = 0
                                End If
                                If .Location.SpeedY >= 0.1 Then
                                    .Location.SpeedY = 0.1
                                End If
                                .Location.Y = .Location.Y + .Location.SpeedY
                            End If
                    
                    
                    'gravity
                            If .Vine = 0 Then
                                If .NoGravity = 0 Then
                                    If .Character = 2 Then
                                        .Location.SpeedY = .Location.SpeedY + Physics.PlayerGravity * 0.9
                                    Else
                                        .Location.SpeedY = .Location.SpeedY + Physics.PlayerGravity
                                    End If
                                    If .HoldingNPC > 0 Then
                                        If NPC(.HoldingNPC).Type = 278 Or NPC(.HoldingNPC).Type = 279 Then
                                            If .Controls.Jump = True Or .Controls.AltJump Then
                                                If .Character = 2 Then
                                                    .Location.SpeedY = .Location.SpeedY - Physics.PlayerGravity * 0.9 * 0.8
                                                Else
                                                    .Location.SpeedY = .Location.SpeedY - Physics.PlayerGravity * 0.8
                                                End If
                                                If .Location.SpeedY > Physics.PlayerGravity * 3 Then .Location.SpeedY = Physics.PlayerGravity * 3
                                            Else
                                                NPC(.HoldingNPC).Special = 0
                                            End If
                                        End If
                                    End If
                                    If .Location.SpeedY > Physics.PlayerTerminalVelocity Then .Location.SpeedY = Physics.PlayerTerminalVelocity
                                Else
                                    .NoGravity = .NoGravity - 1
                                End If
                            End If
                            
                    'princess float
                        

                            If .Character = 3 And .Wet = 0 And .WetFrame = False Then
                                If .Location.SpeedY = 0 Or .StandingOnNPC > 0 Or .Slope > 0 Or .CanFly2 = True Then
                                    .CanFloat = True
                                ElseIf .CanFloat = True Then
                                    If .Jump = 0 And ((.Controls.Jump = True And .FloatRelease = True) Or (.Controls.AltJump = True And .Location.SpeedY > 0)) Then
                                        If .State = 4 Or .State = 5 Then
                                            .FloatTime = 100
                                            .FlySparks = True
                                        Else
                                            .FloatTime = 65
                                        End If
                                        .FloatDir = 1
                                        If .Location.SpeedY < -0.5 Then
                                            .FloatSpeed = 0.5
                                        ElseIf .Location.SpeedY > 0.5 Then
                                            .FloatSpeed = 0.5
                                        Else
                                            .FloatSpeed = .Location.SpeedY
                                        End If
                                        .CanFloat = False
                                    End If
                                End If
                            End If
                            If .Character = 3 And .FlySparks = True Then
                                If .FloatTime = 0 And .Location.SpeedY >= 0 Then .FlySparks = False
                            End If
                            If .CanFloat = True Then .FloatTime = 0
                            If .FloatTime > 0 And .Character = 3 Then
                                If (.Controls.Jump = True Or .Controls.AltJump = True) And .Vine = 0 Then
                                    .FloatTime = .FloatTime - 1
                                    .FloatSpeed = .FloatSpeed + .FloatDir * 0.1
                                    If .FloatSpeed > 0.8 Then .FloatDir = -1
                                    If .FloatSpeed < -0.8 Then .FloatDir = 1
                                    .Location.SpeedY = .FloatSpeed
                                    If .FloatTime = 0 And .Location.SpeedY = 0 Then .Location.SpeedY = 0.1
                                Else
                                    .FloatTime = 0
                                End If
                            End If
                            
                            
                        'Racoon Mario
                            If (.State = 4 Or .State = 5) Or .YoshiBlue = True Or (.Mount = 1 And .MountType = 3) Then
                                If (.Controls.Jump = True Or .Controls.AltJump = True) And ((.Location.SpeedY > Physics.PlayerGravity * 5 And .Character <> 3 And .Character <> 4) Or (.Location.SpeedY > Physics.PlayerGravity * 10 And .Character = 3) Or (.Location.SpeedY > Physics.PlayerGravity * 7.5 And .Character = 4)) And .GroundPound = False And .Slope = 0 And .Character <> 5 Then
                                    If .ShellSurf = False Then
                                        If .Character = 3 Then
                                            .Location.SpeedY = Physics.PlayerGravity * 10
                                        ElseIf .Character = 4 Then
                                            .Location.SpeedY = Physics.PlayerGravity * 7.5
                                        Else
                                            .Location.SpeedY = Physics.PlayerGravity * 5
                                        End If
                                    Else
                                        If NPC(.StandingOnNPC).Location.SpeedY > Physics.PlayerGravity * 5 Then NPC(.StandingOnNPC).Location.SpeedY = Physics.PlayerGravity * 5
                                    End If
                                    
                                    If Not ((.YoshiBlue = False And (.CanFly = True Or .CanFly2 = True)) Or .Mount = 3 And .CanFly2 = True) Then
                                        If Rnd * 10 > 9 Then
                                            NewEffect 80, newLoc(.Location.X - 8 + Rnd * (.Location.Width + 16) - 4, .Location.Y - 8 + Rnd * (.Location.Height + 16)), , , ShadowMode
                                            Effect(numEffects).Location.SpeedX = Rnd * 0.5 - 0.25
                                            Effect(numEffects).Location.SpeedY = Rnd * 0.5 - 0.25
                                            Effect(numEffects).Frame = 1
                                        End If
                                    End If
                                End If
                            End If
                        End If
                        .Location.Y = .Location.Y + .Location.SpeedY
                    End If
                    
                'princess peach and toad stuff
                    If .Character = 3 Or .Character = 4 Or .Character = 5 Then
                        .HeldBonus = 0
                        'power up limiter
                        'If (.Character = 3 Or .Character = 4) And .State > 3 And .State <> 7 Then .State = 2
                        
                        If .Mount = 3 Then
                            PlayerHurt A
                            .Mount = 0
                        End If
                        If .Slide = True Then .Slide = False
                        'If .Stoned = True Then .Stoned = False
                        If .Hearts = 1 And .State > 1 Then .Hearts = 2
                        If .Hearts > 1 And .State = 1 Then .Hearts = 1
                        If .Hearts = 0 Then
                            If .State = 1 Then .Hearts = 1
                            If .State >= 2 Then .Hearts = 2
                        End If
                    End If
                
                'link stuff
                    If .Character = 5 Then
                        If .State = 4 Or .State = 5 Then
                       
                            If .FlyCount > 0 Or ((.Controls.AltJump = True Or (.Controls.Jump = True And .FloatRelease = True)) And .Location.SpeedY <> Physics.PlayerGravity And .Slope = 0 And .StandingOnNPC = 0) Then
                                If .FlyCount > 0 Then .FairyCD = 0
                                If .Fairy = False And .FairyCD = 0 And .Jump = 0 And .Wet = 0 Then
                                        .Jump = 0
                                        If .FlyCount = 0 Then .FlyCount = 50
                                        .FairyTime = .FlyCount
                                        .FairyCD = 1
                                        .FlyCount = 0
                                        .Fairy = True
                                        SizeCheck A
                                        PlaySound 87
                                        .Immune = 10
                                        .Effect = 8
                                        .Effect2 = 4
                                        NewEffect 63, .Location
                                End If
                            End If
                            If .Controls.Run = True And .RunRelease = True And (.FairyTime > 0 Or .Effect = 8) Then
                                .FairyTime = 0
                                .Controls.Run = False
                            End If
                            If .Fairy = True Then
                                If .Slope > 0 Or .StandingOnNPC > 0 Then
                                    .FairyTime = 0
                                    .FairyCD = 0
                                End If
                            End If
                                'Coins = Coins - 1
                                'If Coins < 0 Then
                                    'Lives = Lives - 1
                                    'Coins = Coins + 99
                                    'If Lives < 0 Then
                                        'Lives = 0
                                        'Coins = 0
                                        '.FairyTime = 0
                                    'End If
                                'End If
                            'End If
                        End If
                        If .HasKey = True Then
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
                        If .SwordPoke < 0 Then
                            .SwordPoke = .SwordPoke - 1
                            If .SwordPoke = -7 Then .SwordPoke = 1
                            If .SwordPoke = -40 Then .SwordPoke = 0
                            If Not (wasSlippy = True And .Controls.Left = False And .Controls.Right = False) Then
                                If .FireBallCD = 0 And .Location.SpeedX <> 0 Then .SwordPoke = 0
                            End If
                        ElseIf .SwordPoke > 0 Then
                            If .SwordPoke = 1 Then
                                TailSwipe A, True, True
                                PlaySound 77
                                If (.State = 3 Or .State = 7 Or .State = 6) And .FireBallCD2 = 0 Then
                                    .FireBallCD2 = 40
                                    If .State = 6 Then .FireBallCD2 = 25
                                    If .State = 6 Then
                                        PlaySound 90
                                    Else
                                        PlaySound 82
                                    End If
                                    
                                    numNPCs = numNPCs + 1
                                    If ShadowMode = True Then NPC(numNPCs).Shadow = True
                                    NPC(numNPCs).Type = 13
                                    If .State = 7 Then NPC(numNPCs).Type = 265
                                    If .State = 6 Then NPC(numNPCs).Type = 266
                                    NPC(numNPCs).Projectile = True
                                    NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                                    NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                                    NPC(numNPCs).Location.X = .Location.X + .Location.Width / 2 + (40 * .Direction) - 8
                                    If .Duck = False Then
                                        NPC(numNPCs).Location.Y = .Location.Y + 5
                                        If .State = 6 Then NPC(numNPCs).Location.Y = NPC(numNPCs).Location.Y + 7
                                    Else
                                        NPC(numNPCs).Location.Y = .Location.Y + 18
                                        If .State = 6 Then NPC(numNPCs).Location.Y = NPC(numNPCs).Location.Y + 4
                                    End If
                                    
                                    
                                    NPC(numNPCs).Active = True
                                    NPC(numNPCs).TimeLeft = 100
                                    NPC(numNPCs).Location.SpeedY = 20
                                    NPC(numNPCs).CantHurt = 100
                                    NPC(numNPCs).CantHurtPlayer = A
                                    NPC(numNPCs).Special = .Character
                                    If NPC(numNPCs).Type = 13 Then NPC(numNPCs).Frame = 16
                                    NPC(numNPCs).WallDeath = 5
                                    NPC(numNPCs).Location.SpeedY = 0
                                    NPC(numNPCs).Location.SpeedX = 5 * .Direction + (.Location.SpeedX / 3)
                                    If .State = 6 Then NPC(numNPCs).Location.SpeedX = 9 * .Direction + (.Location.SpeedX / 3)
                                    If .StandingOnNPC <> 0 Then
                                        NPC(numNPCs).Location.Y = NPC(numNPCs).Location.Y - .Location.SpeedY
                                    End If
                                    CheckSectionNPC numNPCs
                                End If
                            Else
                                TailSwipe A, False, True
                            End If
                            .SwordPoke = .SwordPoke + 1
                            If .Duck = True Then
                                If .SwordPoke >= 10 Then
                                    .SwordPoke = 0
                                    .FireBallCD = 7
                                End If
                            Else
                                If .SwordPoke >= 10 Then
                                    .SwordPoke = -11
                                    .FireBallCD = 0
                                End If
                            End If
                        End If
                        If .FireBallCD = 0 And .Wet = 0 And .Fairy = False And .Mount = 0 Then
                            If .Duck = False And .Location.SpeedY < Physics.PlayerGravity And .StandingOnNPC = 0 And .Slope = 0 And .Controls.Up = False And .Stoned = False Then       'Link ducks when jumping
                                .SwordPoke = 0
                                .Duck = True
                                .Location.Y = .Location.Y + .Location.Height
                                .Location.Height = Physics.PlayerDuckHeight(.Character, .State)
                                .Location.Y = .Location.Y - .Location.Height
                            ElseIf .Duck = True And .Location.SpeedY > Physics.PlayerGravity And .StandingOnNPC = 0 And .Slope = 0 Then    'Link stands when falling
                                .SwordPoke = 0
                                UnDuck A
                            End If
                        End If
                        If .Mount > 0 And .Mount <> 2 Then
                            PlayerHurt A
                            .Mount = 0
                        End If
                        .HoldingNPC = -1
                    End If
                    
                    If .Controls.Jump = True Then
                        .FloatRelease = False
                    Else
                        .FloatRelease = True
                    End If
                    
'Player interactions
                    .Location.SpeedX = .Location.SpeedX + .Bumped2
                    .Location.X = .Location.X + .Bumped2
                    .Bumped2 = 0
                    If .Mount = 0 Then .YoshiYellow = False
                    
                'level wrap
                    If LevelWrap(.Section) = True Then
                        If .Location.X + .Location.Width < level(.Section).X Then
                            .Location.X = level(.Section).Width - 1
                        ElseIf .Location.X > level(.Section).Width Then
                            .Location.X = level(.Section).X - .Location.Width + 1
                        End If
                'Walk offscreen exit
                    ElseIf OffScreenExit(.Section) = True Then
                        If .Location.X + .Location.Width < level(.Section).X Then
                            LevelBeatCode = 3
                            EndLevel = True
                            For B = 1 To numPlayers
                                Player(B).TailCount = 0
                            Next B
                            LevelMacro = 0
                            LevelMacroCounter = 0
                            BitBlt myBackBuffer, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
                            BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
                        ElseIf .Location.X > level(.Section).Width Then
                            LevelBeatCode = 3
                            EndLevel = True
                            LevelMacro = 0
                            LevelMacroCounter = 0
                            BitBlt myBackBuffer, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
                            BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
                        End If
                    ElseIf LevelMacro <> 1 And LevelMacro <> 7 And GameMenu = False Then
'Check edge of levels
                        If .Location.X < level(.Section).X Then
                            .Location.X = level(.Section).X
                            If .Location.SpeedX < 0 Then .Location.SpeedX = 0
                            .Pinched2 = 2
                            If AutoX(.Section) <> 0 Then .NPCPinched = 2
                        ElseIf .Location.X + .Location.Width > level(.Section).Width Then
                            .Location.X = level(.Section).Width - .Location.Width
                            If .Location.SpeedX > 0 Then .Location.SpeedX = 0
                            .Pinched4 = 2
                            If AutoX(.Section) <> 0 Then .NPCPinched = 2
                        End If
                    End If
                    If .Location.Y < level(.Section).Y - .Location.Height - 32 And .StandingOnTempNPC = 0 Then
                        .Location.Y = level(.Section).Y - .Location.Height - 32
                        If AutoY(.Section) <> 0 Then .NPCPinched = 3
                    End If
                    
                'gives the players the sparkles when he is flying
                    If ((.YoshiBlue = False And (.CanFly = True Or .CanFly2 = True)) Or .Mount = 3 And .CanFly2 = True) Or .FlySparks = True Then
                        If Rnd * 4 > 3 Then
                            NewEffect 80, newLoc(.Location.X - 8 + Rnd * (.Location.Width + 16) - 4, .Location.Y - 8 + Rnd * (.Location.Height + 16)), , , ShadowMode
                            Effect(numEffects).Location.SpeedX = Rnd * 0.5 - 0.25
                            Effect(numEffects).Location.SpeedY = Rnd * 0.5 - 0.25
                        End If
                    End If
                    

Tanooki A 'tanooki suit code

                    
                    
                    oldSpeedY = .Location.SpeedY
                    

                    If .StandingOnNPC = -A Then
                        If .Slope <> 0 Then
                            B = NPC(.StandingOnNPC).Special
                            If BlockSlope(Block(B).Type) = 1 Then
                                PlrMid = .Location.X
                            Else
                                PlrMid = .Location.X + .Location.Width
                            End If
                            Slope = (PlrMid - Block(B).Location.X) / Block(B).Location.Width
                            If BlockSlope(Block(B).Type) < 0 Then Slope = 1 - Slope
                            If Slope < 0 Then Slope = 0
                            If Slope > 1 Then Slope = 1
                        End If
                    End If
  
                  
                    
'Block collisions.
                    oldSlope = .Slope
                    .Slope = 0
                    tempSlope = 0
                    tempSlope2 = 0
                    tempSlope3 = 0
                    If .Pinched1 > 0 Then .Pinched1 = .Pinched1 - 1
                    If .Pinched2 > 0 Then .Pinched2 = .Pinched2 - 1
                    If .Pinched3 > 0 Then .Pinched3 = .Pinched3 - 1
                    If .Pinched4 > 0 Then .Pinched4 = .Pinched4 - 1
                    If .NPCPinched > 0 Then .NPCPinched = .NPCPinched - 1
                    
                    If .Character = 5 And .Duck = True And (.Location.SpeedY = Physics.PlayerGravity Or .StandingOnNPC <> 0 Or .Slope <> 0) Then
                        .Location.Y = .Location.Y + .Location.Height
                        .Location.Height = 30
                        .Location.Y = .Location.Y - .Location.Height
                    End If

                    
                'block collision optimization
                    fBlock = FirstBlock((Player(A).Location.X / 32) - 1)
                    lBlock = LastBlock(((Player(A).Location.X + Player(A).Location.Width) / 32) + 1)
                    
                    For B = fBlock To lBlock

'checks to see if a collision happened
If .Location.X + .Location.Width >= Block(B).Location.X Then
If .Location.X <= Block(B).Location.X + Block(B).Location.Width Then
If .Location.Y + .Location.Height >= Block(B).Location.Y Then
If .Location.Y <= Block(B).Location.Y + Block(B).Location.Height Then
                    
                        If Block(B).Hidden = False Then
                            HitSpot = FindRunningCollision(.Location, Block(B).Location) 'this finds what part of the block the player collided
                            
                            If BlockNoClipping(Block(B).Type) = True Then HitSpot = 0 'blocks that the player can't touch are forced to hitspot 0 (which means no collision)
                            
                            If BlockIsSizable(Block(B).Type) Or BlockOnlyHitspot1(Block(B).Type) = True Then 'for sizable blocks, if the player didn't land on them from the top then he can walk through them
                                If HitSpot <> 1 Then HitSpot = 0
                                If .Mount = 2 Or .StandingOnTempNPC = 56 Then HitSpot = 0
                            End If
                            
                            'for blocks that hurt the player
                            If BlockHurts(Block(B).Type) Then
                                If .Mount = 2 Or (HitSpot = 1 And .Mount <> 0) And Not Block(B).Type = 598 Then
                                Else
                                    If HitSpot = 1 And (Block(B).Type = 110 Or Block(B).Type = 408 Or Block(B).Type = 430 Or Block(B).Type = 511) Then PlayerHurt A
                                    If HitSpot = 4 And (Block(B).Type = 269 Or Block(B).Type = 429) Then PlayerHurt A
                                    If HitSpot = 3 And (Block(B).Type = 268 Or Block(B).Type = 407 Or Block(B).Type = 431) Then PlayerHurt A
                                    If HitSpot = 2 And (Block(B).Type = 267 Or Block(B).Type = 428) Then PlayerHurt A
                                    If Block(B).Type = 109 Then PlayerHurt A
                                    If Block(B).Type = 598 Then
                                        If .Mount > 0 And HitSpot = 1 Then
                                            C = .Location.Y + .Location.Height
                                            .Location.Y = Block(B).Location.Y - .Location.Height
                                            PlayerHurt A
                                            .Location.Y = C - .Location.Height
                                        Else
                                            PlayerHurt A
                                        End If
                                    End If
                                    
                                    
                                    If .TimeToLive > 0 Then Exit For
                                End If
                            End If
                            
                            'hitspot 5 means the game doesn't know where the collision happened
                            'if the player just stopped ducking and there is a hitspot 5 then force hitspot 3 (hit block from below)
                            If HitSpot = 5 And (.StandUp = True Or NPC(.StandingOnNPC).Location.SpeedY < 0) Then
                                If BlockSlope(Block(B).Type) = 0 Then
                                    HitSpot = 3
                                End If
                            End If
                            
                            'if the block is invisible and the player didn't hit it from below then the player won't collide with it
                            If Block(B).Invis = True Then
                                If HitSpot <> 3 Then HitSpot = 0
                            End If
                            
                            'fixes a bug with holding an npc that is really a block
                            If .HoldingNPC > 0 Then
                                If NPC(.HoldingNPC).Block > 0 Then
                                    If NPC(.HoldingNPC).Block = B Then HitSpot = 0
                                End If
                            End If
                            
                            'destroy some blocks if the player is touching it as a statue
                            If Block(B).Type = 457 And .Stoned = True Then
                                HitSpot = 0
                                KillBlock B
                            End If
                            
                            'shadowmode is a cheat that allows the player to walk through walls
                            If ShadowMode = True And HitSpot <> 1 And Not (Block(B).Special > 0 And HitSpot = 3) Then HitSpot = 0
                            
                        'this handles the collision for blocks that are sloped on the bottom
                            If BlockSlope2(Block(B).Type) <> 0 And (.Location.Y > Block(B).Location.Y Or (HitSpot <> 2 And HitSpot <> 4)) And HitSpot <> 1 And ShadowMode = False Then
                                HitSpot = 0
                                tempSlope = B
                                If BlockSlope2(Block(B).Type) = 1 Then
                                    PlrMid = .Location.X + .Location.Width
                                Else
                                    PlrMid = .Location.X
                                End If
                                Slope = (PlrMid - Block(B).Location.X) / Block(B).Location.Width
                                If BlockSlope2(Block(B).Type) > 0 Then Slope = 1 - Slope
                                If Slope < 0 Then Slope = 0
                                If Slope > 1 Then Slope = 1
                                    If .Location.Y <= Block(B).Location.Y + Block(B).Location.Height - (Block(B).Location.Height * Slope) Then
                                        If BlockKills(Block(B).Type) = True Then
                                            If GodMode = False Then
                                                PlayerDead A
                                            End If
                                        End If
                                        If .Location.SpeedY = 0 Or .Location.SpeedY = Physics.PlayerGravity Or .Slope > 0 Or .StandingOnNPC <> 0 Then
                                            PlrMid = .Location.Y
                                            Slope = (PlrMid - Block(B).Location.Y) / Block(B).Location.Height
                                            If Slope < 0 Then Slope = 0
                                            If Slope > 1 Then Slope = 1
                                            If BlockSlope2(Block(B).Type) < 0 Then
                                                .Location.X = Block(B).Location.X + Block(B).Location.Width - (Block(B).Location.Width * Slope)
                                            Else
                                                .Location.X = Block(B).Location.X + (Block(B).Location.Width * Slope) - .Location.Width
                                            End If
                                            .Location.SpeedX = 0
                                            
                                        Else
                                            .Location.Y = Block(B).Location.Y + Block(B).Location.Height - (Block(B).Location.Height * Slope)
                                            If .Location.SpeedY < 0 Then
                                                PlaySound 3
                                            End If
                                            If .Location.SpeedY < -0.01 Then .Location.SpeedY = -0.01
                                            If .Mount = 2 Then .Location.SpeedY = 2
                                            If .CanFly2 = True Then .Location.SpeedY = 2
                                        End If
                                        .Jump = 0
                                    End If
                            End If

                        'collision for blocks that are sloped on the top
                            If BlockSlope(Block(B).Type) <> 0 And HitSpot <> 3 And Not (BlockSlope(Block(B).Type) = -1 And HitSpot = 2) And Not (BlockSlope(Block(B).Type) = 1 And HitSpot = 4) And (.Location.Y + .Location.Height - 4 - C <= Block(B).Location.Y + Block(B).Location.Height Or (.Location.Y + .Location.Height - 12 <= Block(B).Location.Y + Block(B).Location.Height And .StandingOnNPC <> 0)) Then
                                HitSpot = 0
                                If (.Mount = 1 Or .Location.SpeedY >= 0 Or .Slide = True Or SuperSpeed = True Or .Stoned = True) And (.Location.Y + .Location.Height <= Block(B).Location.Y + Block(B).Location.Height + .Location.SpeedY + 0.001 Or .Slope = 0 And Block(B).Location.SpeedY < 0) Then
                                    If BlockSlope(Block(B).Type) = 1 Then
                                        PlrMid = .Location.X
                                    Else
                                        PlrMid = .Location.X + .Location.Width
                                    End If
                                    Slope = (PlrMid - Block(B).Location.X) / Block(B).Location.Width
                                    If BlockSlope(Block(B).Type) < 0 Then Slope = 1 - Slope
                                    If Slope < 0 Then Slope = 0
                                    If Slope > 1 Then Slope = 1
                                    If tempHit3 > 0 Then
                                        If BlockIsSizable(Block(tempHit3).Type) = False Then
                                            If Block(tempHit3).Location.Y <> Block(B).Location.Y Then
                                                tempHit3 = 0
                                            End If
                                        Else
                                            If Block(tempHit3).Location.Y = Block(B).Location.Y + Block(B).Location.Height Then
                                                tempHit3 = 0
                                            End If
                                        End If
                                    End If
                                    If tempHit2 = True Then
                                        If Block(tempSlope2).Location.Y + Block(tempSlope2).Location.Height = Block(B).Location.Y And BlockSlope(Block(tempSlope2).Type) = BlockSlope(Block(B).Type) Then
                                            tempHit2 = False
                                            tempSlope2 = 0
                                            .Location.X = tempSlope2X
                                        End If
                                    End If
                                    If tempSlope3 > 0 Then
                                        .Location.Y = Block(tempSlope3).Location.Y + Block(tempSlope3).Location.Height + 0.01
                                        PlrMid = .Location.Y + .Location.Height
                                        Slope = 1 - (PlrMid - Block(B).Location.Y) / Block(B).Location.Height
                                        If Slope < 0 Then Slope = 0
                                        If Slope > 1 Then Slope = 1
                                        If BlockSlope(Block(B).Type) > 0 Then
                                            .Location.X = Block(B).Location.X + Block(B).Location.Width - (Block(B).Location.Width * Slope)
                                        Else
                                            .Location.X = Block(B).Location.X + (Block(B).Location.Width * Slope) - .Location.Width
                                        End If
                                        .Location.SpeedX = 0
                                    Else
                                        If .Location.Y >= Block(B).Location.Y + (Block(B).Location.Height * Slope) - .Location.Height - 0.1 Then
                                        
                                            If .GroundPound = True Then
                                                YoshiPound A, tempHit3, True
                                                .GroundPound = False
                                            ElseIf .YoshiYellow = True Then
                                                If oldSlope = 0 Then YoshiPound A, tempHit3
                                            End If
                                            
                                            .Location.Y = Block(B).Location.Y + (Block(B).Location.Height * Slope) - .Location.Height - 0.1
                                            
                                            If .Location.SpeedY > .Location.SpeedX * (Block(B).Location.Height / Block(B).Location.Width) * BlockSlope(Block(B).Type) Or .Slide = False Then
                                                If .WetFrame = False Then
                                                    C = .Location.SpeedX * (Block(B).Location.Height / Block(B).Location.Width) * BlockSlope(Block(B).Type)
                                                    .Location.SpeedY = C
                                                    If .Location.SpeedY > 0 And .Slide = False And .Mount <> 1 And .Mount <> 2 Then
                                                        .Location.SpeedY = .Location.SpeedY * 4
                                                    End If
                                                End If
                                            End If
                                            
                                            .Slope = B
                                            If BlockSlope(Block(B).Type) = 1 And GameMenu = True And .Location.SpeedX >= 2 Then
                                                If .Mount = 0 And .HoldingNPC = 0 And .Character <= 2 Then
                                                    If .Duck = True Then UnDuck A
                                                    .Slide = True
                                                End If
                                            End If
                                            

                                            
                                            If .Location.SpeedY < 0 And .Slide = False And SuperSpeed = False And .Stoned = False Then .Location.SpeedY = 0
                                            If (Block(B).Location.SpeedX <> 0 Or Block(B).Location.SpeedY <> 0) Then
                                                NPC(-A) = blankNPC
                                                NPC(-A).Location = Block(B).Location
                                                NPC(-A).Type = 58
                                                NPC(-A).Active = True
                                                NPC(-A).TimeLeft = 100
                                                NPC(-A).Section = .Section
                                                NPC(-A).Special = B
                                                NPC(-A).Special2 = BlockSlope(Block(B).Type)
                                                .StandingOnNPC = -A
                                                movingBlock = True
                                                If (.Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX < 0 And BlockSlope(Block(B).Type)) < 0 Or (.Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX > 0 And BlockSlope(Block(B).Type) > 0) Then
                                                    If (.Location.SpeedX < 0 And Block(B).Location.SpeedX > 0) Or (.Location.SpeedX > 0 And Block(B).Location.SpeedX < 0) Then
                                                        .Location.SpeedY = 12
                                                    End If
                                                End If
                                                NPC(-A).Location.Y = .Location.Y + .Location.Height
                                            End If
                                        End If
                                    End If
                                End If
                            End If
                            
                            
                        'this is a fix to help the player deal with lava blocks a bit easier
                        'it moves the blocks hitbox down a few pixels
                            If BlockKills(Block(B).Type) And BlockSlope(Block(B).Type) = 0 And GodMode = False And Not (.Mount = 1 And .MountType = 2) Then
                                If Player(A).Location.Y + Player(A).Location.Height < Block(B).Location.Y + 6 Then HitSpot = 0
                            End If
                            
                        'kill the player if touching a lava block
                            If BlockKills(Block(B).Type) And (HitSpot > 0 Or .Slope = B) Then
                                If GodMode = False Then
                                    If Not (.Mount = 1 And .MountType = 2) Then
                                        PlayerDead A
                                        Exit For
                                    ElseIf HitSpot <> 1 And BlockSlope(Block(B).Type) = 0 Then
                                        PlayerDead A
                                        Exit For
                                    Else
                                        tempLocation.Y = .Location.Y + .Location.Height - 2
                                        tempLocation.X = .Location.X - 4 + Rnd * (.Location.Width + 8) - 4
                                        NewEffect 74, tempLocation
                                    End If
                                End If
                            End If
                            
                        'if hitspot 5 with a sloped block then don't collide with it. the collision should have already been handled by the slope code above
                            If HitSpot = 5 And BlockSlope(Block(B).Type) <> 0 Then
                                HitSpot = 0
                            End If
                            
                            'shelsurfing code
                            If HitSpot > 1 And .ShellSurf = True Then
                                .ShellSurf = False
                                .Location.SpeedY = NPC(.StandingOnNPC).Location.SpeedY + Physics.PlayerJumpVelocity * 0.75
                                .StandingOnNPC = 0
                                PlaySound 3
                            End If
                            
                            If Block(B).Type = 626 And .Character = 1 Then HitSpot = 0
                            If Block(B).Type = 627 And .Character = 2 Then HitSpot = 0
                            If Block(B).Type = 628 And .Character = 3 Then HitSpot = 0
                            If Block(B).Type = 629 And .Character = 4 Then HitSpot = 0
                            If Block(B).Type = 632 And .Character = 5 Then HitSpot = 0
                            
'the following code is where the collisions are handled

                            
                            
                            
                            If (HitSpot = 1 Or .Slope = B) And Block(B).Slippy = True Then
                                .Slippy = True
                            End If
                            
                            
                            If HitSpot = 5 And .Quicksand > 0 Then 'fixes quicksand hitspot 3 bug
                                If .Location.Y - .Location.SpeedY < Block(B).Location.Y + Block(B).Location.Height Then
                                    HitSpot = 3
                                End If
                            End If
                            
                            If HitSpot = 1 Then 'landed on the block from the top   V
                                If .Fairy = True And (.FairyCD > 0 Or .Location.SpeedY > 0) Then .FairyTime = 0
                                .Pinched1 = 2 'for players getting squashed
                                If Block(B).Location.SpeedY <> 0 Then .NPCPinched = 2
                                .Vine = 0 'stop climbing because you are now walking
                                If .Mount = 2 Then 'for the clown car, make a niose and pound the ground if moving down fast enough
                                    If .Location.SpeedY > 3 Then
                                        PlaySound 37
                                        YoshiPound A, B, True
                                    End If
                                End If
                                If tempHit3 = 0 Then 'For walking
                                    tempHit3 = B
                                    tempLocation3 = Block(B).Location
                                Else  'Find the best block to walk on if touching multiple blocks
                                    If Block(B).Location.SpeedY <> 0 And Block(tempHit3).Location.SpeedY = 0 Then
                                        tempHit3 = B
                                        tempLocation3 = Block(B).Location
                                    ElseIf Block(B).Location.SpeedY = 0 And Block(tempHit3).Location.SpeedY <> 0 Then
                                    Else
                                        With Block(B).Location
                                            C = .X + .Width * 0.5
                                        End With
                                        With Block(tempHit3).Location
                                            D = .X + .Width * 0.5
                                        End With
                                        
                                        C = C - (.Location.X + .Location.Width * 0.5)
                                        D = D - (.Location.X + .Location.Width * 0.5)
                                        If C < 0 Then C = -C
                                        If D < 0 Then D = -D
                                        If C < D Then
                                            tempHit3 = B
                                        End If
                                    End If
                                    
                                    'if this block is moving up give it priority
                                    If Block(B).Location.SpeedY < 0 And Block(B).Location.Y < Block(tempHit3).Location.Y Then
                                        tempHit3 = B
                                        tempLocation3 = Block(B).Location
                                    End If
                                    
                                End If
                                
                                ElseIf HitSpot = 2 Then 'hit the block from the right <----
                                    
                                    If BlockSlope(Block(oldSlope).Type) = 1 And Block(oldSlope).Location.Y <= Block(B).Location.Y Then
                                        
                                    Else
                                        If .Mount = 2 Then
                                            .mountBump = .Location.X
                                        End If
                                        tempSlope2X = .Location.X
                                        .Location.X = Block(B).Location.X + Block(B).Location.Width + 0.01
                                        tempSlope2 = B
                                        tempHit2 = True
                                        blockPushX = Block(B).Location.SpeedX
                                        If .Mount = 2 Then .mountBump = -.mountBump + .Location.X
                                        .Pinched2 = 2
                                        If Block(B).Location.SpeedX <> 0 Then .NPCPinched = 2
                                    End If
                                ElseIf HitSpot = 4 Then 'hit the block from the left -------->
                                    If .Mount = 2 Then
                                        .mountBump = .Location.X
                                    End If
                                    tempSlope2X = .Location.X
                                    .Location.X = Block(B).Location.X - .Location.Width - 0.01
                                    tempSlope2 = B
                                    tempHit2 = True
                                    blockPushX = Block(B).Location.SpeedX
                                    If .Mount = 2 Then .mountBump = -.mountBump + .Location.X
                                    .Pinched4 = 2
                                    If Block(B).Location.SpeedX <> 0 Then .NPCPinched = 2
                                ElseIf HitSpot = 3 Then 'hit the block from below
                                    If .ForceHitSpot3 = False And .StandUp = False Then .Pinched3 = 2
                                    If Block(B).Location.SpeedY <> 0 Then .NPCPinched = 2
                                    tempHit = True
                                    If tempBlockHit(1) = 0 Then
                                        tempBlockHit(1) = B
                                    Else
                                        tempBlockHit(2) = B
                                    End If
                                ElseIf HitSpot = 5 Then 'try to find out where the player hit the block from
                                    If oldSlope > 0 Then
                                        .Location.Y = Block(B).Location.Y + Block(B).Location.Height + 0.01
                                        PlrMid = .Location.Y + .Location.Height
                                        Slope = 1 - (PlrMid - Block(oldSlope).Location.Y) / Block(oldSlope).Location.Height
                                        If Slope < 0 Then Slope = 0
                                        If Slope > 1 Then Slope = 1
                                        If BlockSlope(Block(oldSlope).Type) > 0 Then
                                            .Location.X = Block(oldSlope).Location.X + Block(oldSlope).Location.Width - (Block(oldSlope).Location.Width * Slope)
                                        Else
                                            .Location.X = Block(oldSlope).Location.X + (Block(oldSlope).Location.Width * Slope) - .Location.Width
                                        End If
                                        .Location.SpeedX = 0
                                    Else
                                        tempSlope3 = B
                                        If .Location.X + .Location.Width / 2 < Block(B).Location.X + Block(B).Location.Width / 2 Then
                                            .Pinched4 = 2
                                        Else
                                            .Pinched2 = 2
                                        End If
                                        If Block(B).Location.SpeedX <> 0 Or Block(B).Location.SpeedY <> 0 Then .NPCPinched = 2
                                        tempLocation.X = .Location.X
                                        tempLocation.Width = .Location.Width
                                        tempLocation.Y = .Location.Y + .Location.Height
                                        tempLocation.Height = 0.1
                                        tempBool = False
                                        fBlock = FirstBlock((tempLocation.X / 32) - 1)
                                        lBlock = LastBlock(((tempLocation.X + tempLocation.Width) / 32) + 1)
                                        For C = fBlock To lBlock
                                            If CheckCollision(tempLocation, Block(C).Location) = True And Block(C).Hidden = False Then
                                            
                                                If BlockSlope(Block(C).Type) = 0 Then
                                                    tempBool = True
                                                Else
                                                    .Location.Y = Block(B).Location.Y + Block(B).Location.Height '+ 0.01
                                                    PlrMid = .Location.Y + .Location.Height
                                                    Slope = 1 - (PlrMid - Block(C).Location.Y) / Block(C).Location.Height
                                                    If Slope < 0 Then Slope = 0
                                                    If Slope > 1 Then Slope = 1
                                                    If BlockSlope(Block(C).Type) > 0 Then
                                                        .Location.X = Block(C).Location.X + Block(C).Location.Width - (Block(C).Location.Width * Slope)
                                                    Else
                                                        .Location.X = Block(C).Location.X + (Block(C).Location.Width * Slope) - .Location.Width
                                                    End If
                                                    .Location.SpeedX = 0
                                                    Exit For
                                                End If
                                            End If
                                        Next C
                                        If tempBool = True Then
                                            .CanJump = False
                                            .Jump = 0
                                            .Location.X = .Location.X - 4 * .Direction
                                            .Location.Y = .Location.Y - .Location.SpeedY
                                            .Location.SpeedX = 0
                                            .Location.SpeedY = 0
                                        End If
                                    End If
                                End If
                            End If
End If
End If
End If
Else
End If
                        Next B
                        
                    If .Character = 5 And .Duck = True Then
                        .Location.Y = .Location.Y + .Location.Height
                        .Location.Height = Physics.PlayerDuckHeight(.Character, .State)
                        .Location.Y = .Location.Y - .Location.Height
                    End If
                        

'helps the player run down slopes at different angles
If .Slope = 0 And oldSlope > 0 And .Mount <> 1 And .Mount <> 2 And .Slide = False Then
    If .Location.SpeedY > 0 Then
        C = .Location.SpeedX * (Block(oldSlope).Location.Height / Block(oldSlope).Location.Width) * BlockSlope(Block(oldSlope).Type)
        If C > 0 Then .Location.SpeedY = C
    End If
End If
                        
            If tempHit3 > 0 Then 'For walking
            
            If .StandingOnNPC = -A Then 'fors standing on movable blocks
                If NPC(.StandingOnNPC).Special2 <> 0 Then
                    .Location.SpeedX = .Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX
                    movingBlock = False
                    .StandingOnNPC = 0
                End If
            End If
                    
'diggable dirt
            If Block(tempHit3).Type = 370 And .StandingOnNPC <= 0 Then 'dig dirt
                DontResetGrabTime = True
                B = tempHit3
                If .TailCount = 0 And .Controls.Down = True And .Controls.Run = True And .Mount = 0 And .Stoned = False And .HoldingNPC = 0 And (.GrabTime > 0 Or .RunRelease = True) Then
                    If (.GrabTime >= 12 And .Character < 3) Or (.GrabTime >= 16 And .Character = 3) Or (.GrabTime >= 8 And .Character = 4) Then
                        .Location.SpeedX = .GrabSpeed
                        .GrabSpeed = 0
                        Block(B).Hidden = True
                        Block(B).Layer = "Destroyed Blocks"
                        NewEffect 10, Block(B).Location
                        Effect(numEffects).Location.SpeedY = -2
                        .GrabTime = 0
                    Else
                        If .GrabTime = 0 Then
                            PlaySound 23
                            .FrameCount = 0
                            .GrabSpeed = .Location.SpeedX
                        End If
                        .Location.SpeedX = 0
                        .Slide = False
                        .GrabTime = .GrabTime + 1
                    End If
                End If
            End If
                        If tempHit2 = True Then
                            If WalkingCollision(.Location, Block(tempHit3).Location) = True Then
                            
If nPlay.Online = True And A = nPlay.MySlot + 1 Then 'online stuffs
    curLoc = .Location
    .Location = oldLoc
    If Block(tempHit3).Type = 55 And FreezeNPCs = False Then
        Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot)
    ElseIf .SpinJump = True And (Block(tempHit3).Type = 90 Or Block(tempHit3).Type = 526) And .State > 1 And Block(tempHit3).Special = 0 Then
        Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1l" & A & LB
    End If
    .Location = curLoc
End If
                                .Location.Y = tempLocation3.Y - .Location.Height
                                If .GroundPound = True Then
                                    YoshiPound A, tempHit3, True
                                    .GroundPound = False
                                ElseIf .YoshiYellow = True Then
                                    YoshiPound A, tempHit3
                                End If
                                Player(A).Location.SpeedY = 0
                                If (tempLocation3.SpeedX <> 0 Or tempLocation3.SpeedY <> 0) Then
                                    NPC(-A) = blankNPC
                                    NPC(-A).Location = tempLocation3
                                    NPC(-A).Type = 58
                                    NPC(-A).Active = True
                                    NPC(-A).TimeLeft = 100
                                    NPC(-A).Section = .Section
                                    NPC(-A).Special = tempHit3
                                    .StandingOnNPC = -A
                                    movingBlock = True
                                    .Location.SpeedY = 12
                                End If
                                If Block(tempHit3).Type = 55 And FreezeNPCs = False Then    'Make the player jump if the block is bouncy
                                    If .Slide = False Then .Multiplier = 0
                                    BlockHit tempHit3, True
                                    .Location.SpeedY = Physics.PlayerJumpVelocity
                                    PlaySound 3
                                    If .Controls.Jump = True Or .Controls.AltJump = True Then
                                        PlaySound 1
                                        .Jump = Physics.PlayerBlockJumpHeight
                                        If .Character = 2 Then .Jump = .Jump + 3
                                        If .SpinJump = True Then .Jump = .Jump - 6
                                    End If
                                End If
                                If .SpinJump = True And (Block(tempHit3).Type = 90 Or Block(tempHit3).Type = 526) And .State > 1 And Block(tempHit3).Special = 0 Then
                                    .Location.SpeedY = Physics.PlayerJumpVelocity
                                    Block(tempHit3).Kill = True
                                    iBlocks = iBlocks + 1
                                    iBlock(iBlocks) = tempHit3
                                    HitSpot = 0
                                    tempHit3 = 0
                                    .Jump = 7
                                    If .Character = 2 Then .Jump = .Jump + 3
                                    If .Controls.Down = True Then
                                        .Jump = 0
                                        .Location.SpeedY = Physics.PlayerJumpVelocity * 0.5
                                    End If
                                End If
                            End If
                        Else
                        

If nPlay.Online = True And A = nPlay.MySlot + 1 Then 'online stuffs
    curLoc = .Location
    .Location = oldLoc
    If Block(tempHit3).Type = 55 And FreezeNPCs = False Then
        Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot)
    ElseIf .SpinJump = True And (Block(tempHit3).Type = 90 Or Block(tempHit3).Type = 526) And .State > 1 And Block(tempHit3).Special = 0 Then
        Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1l" & A & LB
    End If
    .Location = curLoc
End If
                        
                        
                            .Location.Y = tempLocation3.Y - .Location.Height
                            If .StandingOnNPC <> 0 Then
                                If NPC(.StandingOnNPC).Location.Y <= tempLocation3.Y And .StandingOnNPC <> .HoldingNPC Then
                                    .Location.Y = NPC(.StandingOnNPC).Location.Y - .Location.Height
                                End If
                            End If
                            If .GroundPound = True Then
                                YoshiPound A, tempHit3, True
                                .GroundPound = False
                            ElseIf .YoshiYellow = True Then
                                YoshiPound A, tempHit3
                            End If
                            If .Slope = 0 Or .Slide = True Then Player(A).Location.SpeedY = 0
                            If (tempLocation3.SpeedX <> 0 Or tempLocation3.SpeedY <> 0) Then
                                NPC(-A) = blankNPC
                                NPC(-A).Location = tempLocation3
                                NPC(-A).Type = 58
                                NPC(-A).Active = True
                                NPC(-A).TimeLeft = 100
                                NPC(-A).Section = .Section
                                NPC(-A).Special = tempHit3
                                .StandingOnNPC = -A
                                movingBlock = True
                                .Location.SpeedY = 12
                            End If

                            If .StandingOnNPC <> 0 And movingBlock = False Then
                                Player(A).Location.SpeedY = 1
                                If NPC(.StandingOnNPC).Pinched = False And FreezeNPCs = False Then Player(A).Location.SpeedX = Player(A).Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX - NPC(.StandingOnNPC).BeltSpeed
                                .StandingOnNPC = 0
                            ElseIf movingBlock = True Then

                                Player(A).Location.SpeedY = NPC(-A).Location.SpeedY + 1
                                If Player(A).Location.SpeedY < 0 Then Player(A).Location.SpeedY = 0
                            Else
                                If .Slope = 0 Or .Slide = True Then Player(A).Location.SpeedY = 0
                            End If
                            
                            If Block(tempHit3).Type = 55 And FreezeNPCs = False Then  'Make the player jump if the block is bouncy
                                BlockHit tempHit3, True
                                If .Slide = False Then .Multiplier = 0
                                .Location.SpeedY = Physics.PlayerJumpVelocity
                                PlaySound 3
                                If .Controls.Jump = True Or .Controls.AltJump = True Then
                                    PlaySound 1
                                    .Jump = Physics.PlayerBlockJumpHeight
                                    If .Character = 2 Then .Jump = .Jump + 3
                                    If .SpinJump = True Then .Jump = .Jump - 6
                                End If
                            End If
                            If .SpinJump = True And (Block(tempHit3).Type = 90 Or Block(tempHit3).Type = 526) And .State > 1 And Block(tempHit3).Special = 0 Then
                                .Location.SpeedY = Physics.PlayerJumpVelocity
                                Block(tempHit3).Kill = True
                                iBlocks = iBlocks + 1
                                iBlock(iBlocks) = tempHit3
                                tempHit3 = 0
                                .Jump = 7
                                If .Character = 2 Then .Jump = .Jump + 3
                                If .Controls.Down = True Then
                                    .Jump = 0
                                    .Location.SpeedY = Physics.PlayerJumpVelocity * 0.5
                                End If
                            End If
                            

                            
                        End If
                    End If
                    If tempSlope2 > 0 And tempSlope > 0 Then
                        If Block(tempSlope).Location.Y + Block(tempSlope).Location.Height = Block(tempSlope2).Location.Y + Block(tempSlope2).Location.Height Then tempHit2 = False
                    End If
                    If tempHit = False And tempHit2 = True Then
                        If .Location.SpeedX + NPC(.StandingOnNPC).Location.SpeedX > 0 And .Controls.Right = True Then
                            .Location.SpeedX = 0.2 * .Direction
                            If blockPushX > 0 Then .Location.SpeedX = .Location.SpeedX + blockPushX
                        ElseIf .Location.SpeedX + NPC(.StandingOnNPC).Location.SpeedX < 0 And .Controls.Left = True Then
                            .Location.SpeedX = 0.2 * .Direction
                            If blockPushX < 0 Then .Location.SpeedX = .Location.SpeedX + blockPushX
                        Else
                            If .Controls.Right = True Or .Controls.Left = True Then
                                .Location.SpeedX = -NPC(.StandingOnNPC).Location.SpeedX + 0.2 * .Direction
                            Else
                                .Location.SpeedX = 0
                            End If
                        End If
                        If .Mount = 2 Then .Location.SpeedX = 0
                    End If
                    If tempBlockHit(2) <> 0 Then 'Hitting a block from below
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
                            B = tempBlockHit(1)
                        Else
                            B = tempBlockHit(2)
                        End If
                    ElseIf tempBlockHit(1) <> 0 Then
                        B = tempBlockHit(1)
                        If Block(B).Location.X + Block(B).Location.Width - .Location.X <= 4 Then
                            .Location.X = Block(B).Location.X + Block(B).Location.Width + 0.1
                            B = 0
                        ElseIf .Location.X + .Location.Width - Block(B).Location.X <= 4 Then
                            .Location.X = Block(B).Location.X - .Location.Width - 0.1
                            B = 0
                        End If
                    Else
                        B = 0
                    End If
                    If B > 0 Then
                    
'Netplay code
                        If nPlay.Online = True And A = nPlay.MySlot + 1 Then 'online stuffs
                            curLoc = .Location
                            .Location = oldLoc
                            Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot)
                            .Location = curLoc
                        End If
                        PlaySound 3
                        .Jump = 0
                        .Location.Y = Block(B).Location.Y + Block(B).Location.Height + 0.01
                        .Location.SpeedY = -0.01 + Block(B).Location.SpeedY
                        If .Fairy = True Then .Location.SpeedY = 2
                        If .Vine > 0 Then .Location.Y = .Location.Y + 0.1
                        If .Mount = 2 Then .Location.SpeedY = 2
                        If .CanFly2 = True Then .Location.SpeedY = 2
                        If .Mount <> 2 Then BlockHit B, False, A 'Tell the block it was hit
                        If Block(B).Type = 55 Then .Location.SpeedY = 3 'If it is a bouncy block the knock the player down
                        If .State > 1 And .Character <> 5 Then 'If the player was big ask the block nicely to die
                            If .Mount <> 2 And Block(B).Type <> 293 Then BlockHitHard B
                        End If
                    End If
                    
                    If .Slide = True And oldSlope > 0 And .Slope = 0 And .Location.SpeedY < 0 Then
                        If .NoGravity = 0 Then
                            .NoGravity = Int(.Location.SpeedY / Physics.PlayerJumpVelocity * 8)
                        End If
                    ElseIf .Slope > 0 Or oldSlope > 0 Or .Slide = False Then
                        .NoGravity = 0
                    End If
                    If .Slide = True Then
                        If .Location.SpeedX > 1 Or .Location.SpeedX < -1 Then
                            .SlideKill = True
                        Else
                            .SlideKill = False
                        End If
                    Else
                        .SlideKill = False
                    End If
                    




'Check NPC collisions
                    If .Vine > 0 Then .Vine = .Vine - 1
                    tempBlockHit(1) = 0
                    tempBlockHit(2) = 0
                    tempHitSpeed = 0
                    spinKill = False
                        
                        
'check vine backgrounds
    For B = 1 To numBackground
        If BackgroundFence(Background(B).Type) = True Then
            If CheckCollision(.Location, Background(B).Location) Then
                tempLocation = Background(B).Location
                tempLocation.Height = tempLocation.Height - 16
                tempLocation.Width = tempLocation.Width - 20
                tempLocation.X = tempLocation.X + 10
                If CheckCollision(.Location, tempLocation) Then
                    If .Character = 5 Then
                        If .Immune = 0 And .Controls.Up = True Then
                            .FairyCD = 0
                            If .Fairy = False Then
                                .Fairy = True
                                SizeCheck A
                                PlaySound 87
                                .Immune = 10
                                .Effect = 8
                                .Effect2 = 4
                                NewEffect 63, .Location
                            End If
                            If .FairyTime <> -1 And .FairyTime < 20 Then .FairyTime = 20
                        End If
                    ElseIf .Fairy = False And .Stoned = False Then
                        If .Mount = 0 And .HoldingNPC <= 0 Then
                            If .Vine > 0 Then
                                If .Duck = True Then UnDuck A
                                If .Location.Y >= Background(B).Location.Y - 20 And .Vine < 2 Then .Vine = 2
                                If .Location.Y >= Background(B).Location.Y - 18 Then .Vine = 3
                            ElseIf (.Controls.Up = True Or (.Controls.Down = True And Not .Location.SpeedY = 0 And Not .StandingOnNPC <> 0 And Not .Slope > 0)) And .Jump = 0 Then
                                If .Duck = True Then UnDuck A
                                If .Location.Y >= Background(B).Location.Y - 20 And .Vine < 2 Then .Vine = 2
                                If .Location.Y >= Background(B).Location.Y - 18 Then .Vine = 3
                            End If
                            If .Vine > 0 Then .VineNPC = -1
                        End If
                    End If
                End If
            End If
        End If
    Next B

                    If .StandingOnNPC <> 0 Then
                        If tempHit2 = False Then
                            If NPC(.StandingOnNPC).Pinched = False And FreezeNPCs = False Then .Location.SpeedX = .Location.SpeedX - NPC(.StandingOnNPC).Location.SpeedX - NPC(.StandingOnNPC).BeltSpeed
                        End If
                    End If
                    tempHit = False 'Used for JUMP detection
                    tempHit2 = False
                    For B = 1 To numNPCs
                        If NPC(B).Active = True And NPC(B).Killed = 0 And NPC(B).Effect <> 5 And NPC(B).Effect <> 6 Then
                            'If Not (NPC(B).Type = 17 And NPC(B).CantHurt > 0) And Not (.Mount = 2 And NPC(B).Type = 56) And Not NPC(B).standingOnPlayer = A And Not NPC(B).Type = 197 And Not NPC(B).Type = 237 Then
                            If Not (.Mount = 2 And NPC(B).Type = 56) And Not NPC(B).standingOnPlayer = A And Not NPC(B).Type = 197 And Not NPC(B).Type = 237 Then
                                If NPC(B).HoldingPlayer = 0 Or NPCIsABonus(NPC(B).Type) Or (BattleMode = True And NPC(B).HoldingPlayer <> A) Then
                                    If CheckCollision(.Location, NPC(B).Location) = True Then
                                        If (NPC(B).Type = 58 Or NPC(B).Type = 21 Or NPC(B).Type = 67 Or NPC(B).Type = 68 Or NPC(B).Type = 69 Or NPC(B).Type = 70) And NPC(B).Projectile = True Then PlayerHurt A
                                        If (.Mount = 1 Or .Mount = 3 Or .SpinJump = True Or (.ShellSurf = True And NPCIsAShell(NPC(B).Type) = True) Or (.Stoned = True And NPCCanWalkOn(NPC(B).Type) = False)) And NPCMovesPlayer(NPC(B).Type) = False Then
                                            HitSpot = BootCollision(.Location, NPC(B).Location, NPCCanWalkOn(NPC(B).Type)) 'find the hitspot for normal mario
                                        Else
                                            HitSpot = EasyModeCollision(.Location, NPC(B).Location, NPCCanWalkOn(NPC(B).Type)) 'find the hitspot when in a shoe or on a yoshi
                                        End If
                                    
If NPC(B).Inert = False Then
                                        'battlemode stuff
                                        If NPC(B).Type = 13 Or NPC(B).Type = 171 Or NPC(B).Type = 265 Or NPC(B).Type = 266 Or NPC(B).Type = 108 Or NPC(B).Type = 291 Or NPC(B).Type = 292 Then
                                            If BattleMode = True And NPC(B).CantHurtPlayer <> A Then
                                                If .State = 6 And .Duck = True And .Character <> 5 Then
                                                    NPCHit B, 3, B
                                                Else
                                                    If .Immune = 0 Then
                                                        NPCHit B, 3, B
                                                        If NPC(B).Type = 266 Then PlaySound 89
                                                    End If
                                                    PlayerHurt A
                                                End If
                                            End If
                                            HitSpot = 0
                                        End If
                                        If NPC(B).Type = 17 And NPC(B).CantHurt > 0 Then
                                            If BattleMode = False Then
                                                HitSpot = 0
                                            ElseIf NPC(B).CantHurtPlayer <> A Then
                                                If HitSpot <> 1 Then
                                                    PlayerHurt A
                                                Else
                                                    NPC(B).CantHurt = 0
                                                    NPC(B).CantHurtPlayer = 0
                                                    NPC(B).Projectile = False
                                                End If
                                            End If
                                        End If
                                        If (NPC(B).Type = 50 Or NPC(B).Type = 30) And BattleMode = True And NPC(B).CantHurtPlayer <> A Then
                                            PlayerHurt A
                                        End If
                                        If (NPC(B).Type = 263 Or NPC(B).Type = 96) And BattleMode = True And NPC(B).CantHurtPlayer <> A And NPC(B).Projectile = True And NPC(B).BattleOwner <> A Then
                                            If Player(A).Immune = 0 And NPC(B).Type = 96 Then NPC(B).Special2 = 1
                                            PlayerHurt A
                                            HitSpot = 0
                                        End If
                                        If (NPCIsAShell(NPC(B).Type) = True Or NPCIsVeggie(NPC(B).Type) Or NPC(B).Type = 263 Or NPC(B).Type = 45) And BattleMode = True And NPC(B).HoldingPlayer > 0 And NPC(B).HoldingPlayer <> A Then
                                            If .Immune = 0 Then
                                                PlayerHurt A
                                                NPCHit B, 5, B
                                            End If
                                        End If
                                        If NPCIsAParaTroopa(NPC(B).Type) And BattleMode = True And NPC(B).CantHurtPlayer = A Then HitSpot = 0
                                        If BattleMode = True And NPCIsVeggie(NPC(B).Type) And NPC(B).Projectile = True Then
                                            If NPC(B).CantHurtPlayer <> A Then
                                                If .Immune = 0 Then
                                                    PlayerHurt A
                                                    NPCHit B, 4, B
                                                    PlaySound 39
                                                End If
                                            End If
                                        End If
                                        If BattleMode = True And NPC(B).HoldingPlayer > 0 And NPC(B).HoldingPlayer <> A Then
                                            If NPCWontHurt(NPC(B).Type) = True Then
                                                HitSpot = 0
                                            Else
                                                HitSpot = 5
                                            End If
                                        End If
                                        If BattleMode = True And NPC(B).BattleOwner <> A And NPC(B).Projectile = True And NPC(B).CantHurtPlayer <> A Then
                                            If NPC(B).Type = 134 Or NPC(B).Type = 137 Or NPC(B).Type = 154 Or NPC(B).Type = 155 Or NPC(B).Type = 156 Or NPC(B).Type = 157 Or NPC(B).Type = 166 Or ((NPCIsAShell(NPC(B).Type) Or NPC(B).Type = 45) And NPC(B).Location.SpeedX = 0) Then
                                                If NPCIsAShell(NPC(B).Type) And HitSpot = 1 And .SpinJump = True Then
                                                ElseIf .Immune = 0 Then
                                                    If Not NPC(B).Type = 45 And Not NPCIsAShell(NPC(B).Type) Then NPCHit B, 3, B
                                                    PlayerHurt A
                                                    HitSpot = 0
                                                End If
                                            End If
                                        End If
                                    'end battlemode
End If
                                        If NPC(B).Type = 283 Then
                                            NPCHit B, 1, A
                                            HitSpot = 0
                                        End If
                                        If GameOutro = True Then HitSpot = 0
                                        If NPC(B).Type = 30 And NPC(B).CantHurt > 0 Then HitSpot = 0
                                        If NPC(B).Type = 96 And HitSpot = 1 Then HitSpot = 0
                                        If NPC(B).Inert = True Then 'if the npc is friendly then you can't touch it
                                            HitSpot = 0
                                            If NPC(B).Text <> "" And .Controls.Up = True And FreezeNPCs = False Then
                                                MessageNPC = B
                                            End If
                                        End If
                                        If .Stoned = True And HitSpot <> 1 Then 'if you are a statue then SLAM into the npc
                                            If .Location.SpeedX > 3 Or .Location.SpeedX < -3 Then
                                                NPCHit B, 3, B
                                            End If
                                        End If
                                    
                                    'the following code is for spin jumping and landing on things as yoshi/shoe
                                        If .Mount = 1 Or .Mount = 3 Or .SpinJump = True Or (.Stoned = True And NPCCanWalkOn(NPC(B).Type) = False) Then
                                            If HitSpot = 1 Then
                                                If .Mount = 1 Or .Mount = 2 Or .Stoned = True Then
                                                    NPCHit B, 8, A
                                                ElseIf Not (NPC(B).Type = 245 Or NPC(B).Type = 275 Or NPC(B).Type = 8 Or NPC(B).Type = 12 Or NPC(B).Type = 36 Or NPC(B).Type = 285 Or NPC(B).Type = 286 Or NPC(B).Type = 51 Or NPC(B).Type = 52 Or NPC(B).Type = 53 Or NPC(B).Type = 54 Or NPC(B).Type = 74 Or NPC(B).Type = 93 Or NPC(B).Type = 200 Or NPC(B).Type = 205 Or NPC(B).Type = 207 Or NPC(B).Type = 201 Or NPC(B).Type = 261 Or NPC(B).Type = 270) And NPCCanWalkOn(NPC(B).Type) = False Then
                                                    If .Wet > 0 And (NPCIsCheep(NPC(B).Type) = True Or NPC(B).Type = 231 Or NPC(B).Type = 235) Then
                                                    Else
                                                        NPCHit B, 8, A
                                                    End If
                                                End If
                                                If NPC(B).Killed = 8 Or NPCIsCheep(NPC(B).Type) = True Or NPC(B).Type = 179 Or NPC(B).Type = 37 Or NPC(B).Type = 180 Or NPC(B).Type = 38 Or NPC(B).Type = 42 Or NPC(B).Type = 43 Or NPC(B).Type = 44 Or NPC(B).Type = 8 Or NPC(B).Type = 12 Or NPC(B).Type = 36 Or NPC(B).Type = 51 Or NPC(B).Type = 52 Or NPC(B).Type = 53 Or NPC(B).Type = 54 Or NPC(B).Type = 74 Or NPC(B).Type = 93 Or NPC(B).Type = 200 Or NPC(B).Type = 205 Or NPC(B).Type = 207 Or NPC(B).Type = 201 Or NPC(B).Type = 199 Or NPC(B).Type = 245 Or NPC(B).Type = 256 Or NPC(B).Type = 261 Or NPC(B).Type = 275 Or NPC(B).Type = 285 Or NPC(B).Type = 286 Or NPC(B).Type = 270 Then         'tap
                                                    If NPC(B).Killed = 8 And .Mount = 1 And .MountType = 2 Then
                                                        numNPCs = numNPCs + 1
                                                        With NPC(numNPCs)
                                                            .Active = True
                                                            .TimeLeft = 100
                                                            .Section = Player(A).Section
                                                            .Type = 13
                                                            .Special = Player(A).Character
                                                            .Location.Height = NPCHeight(.Type)
                                                            .Location.Width = NPCWidth(.Type)
                                                            .Location.Y = Player(A).Location.Height + Player(A).Location.Y - .Location.Height
                                                            .Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - .Location.Width / 2
                                                            .Location.SpeedX = 4
                                                            .Location.SpeedY = 10
                                                        End With
                                                        numNPCs = numNPCs + 1
                                                        With NPC(numNPCs)
                                                            .Active = True
                                                            .TimeLeft = 100
                                                            .Section = Player(A).Section
                                                            .Type = 13
                                                            .Special = Player(A).Character
                                                            .Location.Height = NPCHeight(.Type)
                                                            .Location.Width = NPCWidth(.Type)
                                                            .Location.Y = Player(A).Location.Height + Player(A).Location.Y - .Location.Height
                                                            .Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - .Location.Width / 2
                                                            .Location.SpeedX = -4
                                                            .Location.SpeedY = 10
                                                        End With
                                                    End If
                                                    If NPC(B).Killed = 0 And .SpinJump = 0 Then PlaySound 2
                                                    .ForceHitSpot3 = True
                                                    If HitSpot = 1 And Not (.GroundPound = True And NPC(B).Killed = 8) Then
                                                        tempHit = True
                                                        tempLocation.Y = NPC(B).Location.Y - .Location.Height
                                                        If .SpinJump = True Then
                                                            If NPC(B).Killed > 0 Then
                                                                If .Controls.Down = True Then
                                                                    tempHit = False
                                                                Else
                                                                    spinKill = True
                                                                End If
                                                            Else
                                                                PlaySound 2
                                                            End If
                                                        End If
                                                    End If
                                                    HitSpot = 0
                                                End If
                                            End If
                                        ElseIf .Mount = 2 Then
                                            If NPC(B).standingOnPlayer = A Then
                                                HitSpot = 0
                                            ElseIf Not (NPC(B).Type = 17 And NPC(B).CantHurt > 0) Then
                                                If (NPC(B).Location.Y + NPC(B).Location.Height > .Location.Y + 18 And HitSpot <> 3) Or HitSpot = 1 Then
                                                    NPCHit B, 8, A
                                                    If NPC(B).Killed = 8 Then HitSpot = 0
                                                    
                                                    If NPC(B).Type = 135 Or NPC(B).Type = 136 Or NPC(B).Type = 137 Then
                                                        NPCHit B, 3, B
                                                        If NPC(B).Killed = 3 Then HitSpot = 0
                                                    End If
                                                    
                                                End If
                                            End If
                                        End If
                                        
                                        If (.State = 6 And .Duck = True And .Mount = 0 And .Character <> 5) Or (.Mount = 1 And .MountType = 2) Then 'Fireball immune for ducking in the hammer suit
                                            If NPC(B).Type = 85 Or NPC(B).Type = 87 Or NPC(B).Type = 246 Or NPC(B).Type = 276 Then
                                                With NPC(B)
                                                    PlaySound 3
                                                    HitSpot = 0
                                                    .Killed = 9
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
                                                    .Location.X = .Location.X + .Location.Width / 2 - EffectWidth(10) / 2
                                                    .Location.Y = .Location.Y + .Location.Height / 2 - EffectHeight(10) / 2
                                                    NewEffect 10, .Location
                                                End With
                                            End If
                                        End If
                                        
                                        
                                        If NPCIsAVine(NPC(B).Type) = True Then   'if the player collided with a vine then see if he should climb it
                                            If .Character = 5 Then
                                                If .Immune = 0 And .Controls.Up = True Then
                                                    .FairyCD = 0
                                                    If .Fairy = False Then
                                                        .Fairy = True
                                                        SizeCheck A
                                                        PlaySound 87
                                                        .Immune = 10
                                                        .Effect = 8
                                                        .Effect2 = 4
                                                        NewEffect 63, .Location
                                                    End If
                                                    If .FairyTime <> -1 And .FairyTime < 20 Then .FairyTime = 20
                                                End If
                                            ElseIf .Fairy = False And .Stoned = False Then
                                                If .Mount = 0 And .HoldingNPC <= 0 Then
                                                    If .Vine > 0 Then
                                                        If .Duck = True Then UnDuck A
                                                        If .Location.Y >= NPC(B).Location.Y - 20 And .Vine < 2 Then .Vine = 2
                                                        If .Location.Y >= NPC(B).Location.Y - 18 Then .Vine = 3
                                                    ElseIf (.Controls.Up = True Or (.Controls.Down = True And Not .Location.SpeedY = 0 And Not .StandingOnNPC <> 0 And Not .Slope > 0)) And .Jump = 0 Then
                                                        If .Duck = True Then UnDuck A
                                                        If .Location.Y >= NPC(B).Location.Y - 20 And .Vine < 2 Then .Vine = 2
                                                        If .Location.Y >= NPC(B).Location.Y - 18 Then .Vine = 3
                                                    End If
                                                    If .Vine > 0 Then .VineNPC = B
                                                End If
                                            End If
                                        End If
                                    
                                    'subcon warps
                                            If NPC(B).Type = 289 And HitSpot > 0 And .Controls.Up = True Then
                                                If NPC(B).Special2 >= 0 Then
                                                    NPC(B).Killed = 9
                                                    PlaySound 46
                                                    .Effect = 7
                                                    .Warp = numWarps + 1
                                                    With Warp(numWarps + 1)
                                                        .Entrance = NPC(B).Location
                                                        tempLocation = NPC(B).Location
                                                        tempLocation.X = NPC(B).Location.X - level(Player(A).Section).X + level(NPC(B).Special2).X
                                                        tempLocation.Y = NPC(B).Location.Y - level(Player(A).Section).Y + level(NPC(B).Special2).Y
                                                        .Exit = tempLocation
                                                        .Hidden = False
                                                        .NoYoshi = False
                                                        .WarpNPC = True
                                                        .Locked = False
                                                        .Stars = 0
                                                    End With
                                                    .Location.SpeedX = 0
                                                    .Location.SpeedY = 0
                                                    'Stop
                                                    .Location.X = Warp(.Warp).Entrance.X + Warp(.Warp).Entrance.Width / 2 - .Location.Width / 2
                                                    .Location.Y = Warp(.Warp).Entrance.Y + Warp(.Warp).Entrance.Height - .Location.Height
                                                    tempLocation = Warp(numWarps + 1).Entrance
                                                    tempLocation.Y = tempLocation.Y - 32
                                                    tempLocation.Height = 64
                                                    NewEffect 54, tempLocation
                                                    tempLocation = Warp(numWarps + 1).Exit
                                                    tempLocation.Y = tempLocation.Y - 32
                                                    tempLocation.Height = 64
                                                    NewEffect 54, tempLocation
                                                End If
                                            End If
                                        
                                        
                                        If HitSpot = 1 And (NPC(B).Type = 32 Or NPC(B).Type = 238 Or NPC(B).Type = 239) And NPC(B).Projectile = True Then
                                            HitSpot = 0
                                        End If
                                        
                                        If NPC(B).Type = 255 And .HasKey = True Then
                                            .HasKey = False
                                            HitSpot = 0
                                            NPC(B).Killed = 3
                                        End If
                                        
                                        If NPC(B).Type = 45 And NPC(B).Projectile = True And HitSpot > 1 Then
                                            HitSpot = 5
                                        End If
                                        
                                        If HitSpot = 1 Then  'Player landed on a NPC
                                            If NPCCanWalkOn(NPC(B).Type) = True Or (.ShellSurf = True And NPCIsAShell(NPC(B).Type) = True) Then     'NPCs that can be walked on
                                                'the player landed on an NPC he can stand on
                                                If tempBlockHit(1) = 0 Then
                                                    tempBlockHit(1) = B
                                                ElseIf tempBlockHit(2) = 0 Then
                                                    tempBlockHit(2) = B
                                                ElseIf .StandingOnNPC = B Then
                                                    'if standing on 2 or more NPCs find out the best one to stand on
                                                    With NPC(tempBlockHit(1)).Location
                                                        C = .X + .Width * 0.5
                                                    End With
                                                    With NPC(tempBlockHit(2)).Location
                                                        D = .X + .Width * 0.5
                                                    End With
                                                    C = C - (.Location.X + .Location.Width * 0.5)
                                                    D = D - (.Location.X + .Location.Width * 0.5)
                                                    If C < 0 Then C = -C
                                                    If D < 0 Then D = -D
                                                    If C < D Then
                                                        tempBlockHit(2) = B
                                                    Else
                                                        tempBlockHit(1) = B
                                                    End If
                                                Else
                                                    tempBlockHit(2) = B
                                                End If
                                            
                                                'if landing on a yoshi or boot, mount up!
                                            ElseIf (NPCIsYoshi(NPC(B).Type) Or NPCIsBoot(NPC(B).Type)) And .Character <> 5 And .Fairy = False Then
                                                If .Mount = 0 And NPC(B).CantHurtPlayer <> A And .Dismount = 0 Then
                                                        If NPCIsBoot(NPC(B).Type) Then
                                                            UnDuck A
                                                            NPC(B).Killed = 9
                                                            If .State = 1 Then
                                                                .Location.Height = Physics.PlayerHeight(1, 2)
                                                                .Location.Y = .Location.Y - Physics.PlayerHeight(1, 2) + Physics.PlayerHeight(.Character, 1)
                                                            End If
                                                            .Mount = 1
                                                            If NPC(B).Type = 35 Then .MountType = 1
                                                            If NPC(B).Type = 191 Then .MountType = 2
                                                            If NPC(B).Type = 193 Then .MountType = 3
                                                            PlaySound 2
                                                        ElseIf NPCIsYoshi(NPC(B).Type) And (.Character = 1 Or .Character = 2) Then
                                                            UnDuck A
                                                            NPC(B).Killed = 9
                                                            .Mount = 3
                                                            If NPC(B).Type = 95 Then
                                                                .MountType = 1
                                                            ElseIf NPC(B).Type = 98 Then
                                                                .MountType = 2
                                                            ElseIf NPC(B).Type = 99 Then
                                                                .MountType = 3
                                                            ElseIf NPC(B).Type = 100 Then
                                                                .MountType = 4
                                                            ElseIf NPC(B).Type = 148 Then
                                                                .MountType = 5
                                                            ElseIf NPC(B).Type = 149 Then
                                                                .MountType = 6
                                                            ElseIf NPC(B).Type = 150 Then
                                                                .MountType = 7
                                                            ElseIf NPC(B).Type = 228 Then
                                                                .MountType = 8
                                                            End If
                                                            .YoshiNPC = 0
                                                            .YoshiPlayer = 0
                                                            .MountSpecial = 0
                                                            .YoshiTonugeBool = False
                                                            .YoshiTongueLength = 0
                                                            PlaySound 48
                                                            YoshiHeight A
                                                        End If
                                                    End If
                                            ElseIf Not NPC(B).Type = 22 And Not NPC(B).Type = 31 And Not NPC(B).Type = 49 And Not NPC(B).Type = 50 And (.SlideKill = False Or NPCWontHurt(NPC(B).Type) = True) Then                      'NPCs that cannot be walked on
                                                If NPC(B).CantHurtPlayer = A And .NoShellKick > 0 Then
                                                Else
                                                    If NPCIsABonus(NPC(B).Type) Then 'Bonus
                                                        TouchBonus A, B
                                                    ElseIf NPCIsAShell(NPC(B).Type) = True And NPC(B).Location.SpeedX = 0 And .HoldingNPC = 0 And .Controls.Run = True Then
                                                        'grab turtle shells
                                                        If nPlay.Online = False Or nPlay.MySlot + 1 = A Then
                                                            If .Character >= 3 Then
                                                                PlaySound 23
                                                            Else
                                                                UnDuck A
                                                            End If
                                                            .HoldingNPC = B
                                                            NPC(B).HoldingPlayer = A
                                                            NPC(B).CantHurt = Physics.NPCCanHurtWait
                                                            NPC(B).CantHurtPlayer = A
                                                        End If
                                                        
                                                    ElseIf NPCJumpHurt(NPC(B).Type) Or (NPCIsCheep(NPC(B).Type) = True And .WetFrame = True) Then     'NPCs that cause damage even when jumped on
                                                        If Not (NPC(B).Type = 8 And NPC(B).Special2 = 4) And NPCWontHurt(NPC(B).Type) = False And NPC(B).CantHurtPlayer <> A Then
                                                            
                                                                'the n00bcollision function reduces the size of the npc's hit box before it damages the player
                                                            If n00bCollision(.Location, NPC(B).Location) Then PlayerHurt A
                                                        End If
                                                    ElseIf NPC(B).Type = 15 Then 'Special code for BOOM BOOM
                                                        If NPC(B).Special = 0 Or .Mount = 1 Or .Mount = 3 Then
                                                            If NPC(B).Special <> 0 Then PlaySound 2
                                                            tempHit = True
                                                            tempLocation.Y = NPC(B).Location.Y - .Location.Height
                                                        ElseIf NPC(B).Special <> 4 Then
                                                            If n00bCollision(.Location, NPC(B).Location) Then PlayerHurt A
                                                        End If
                                                    ElseIf (NPC(B).Type = 137) Or NPC(B).Type = 166 Then
                                                        NPCHit B, 1, A 'NPC 'B' was jumped on '1' by player 'A'
                                                    ElseIf NPC(B).Killed <> 10 And NPCIsBoot(NPC(B).Type) = False And NPCIsYoshi(NPC(B).Type) = False And Not (NPCIsAShell(NPC(B).Type) And NPC(B).CantHurtPlayer = A) Then      'Bounce off everything except Bonus and Piranha Plants
                                                        If NPC(B).Type = 26 Then tempSpring = True
                                                        If NPCIsAShell(NPC(B).Type) And NPC(B).Location.SpeedX = 0 And NPC(B).Location.SpeedY = 0 Then tempShell = True
                                                        tempHit = True
                                                        tempLocation.Y = NPC(B).Location.Y - .Location.Height
                                                        If NPC(B).Type = 32 Or NPC(B).Type = 238 Or NPC(B).Type = 239 Then
                                                            tempHit = False
                                                            .Jump = False
                                                            .Location.SpeedY = Physics.PlayerJumpVelocity
                                                            .Location.SpeedY = -Physics.PlayerGravity
                                                        End If
                                                    End If
                                                    If Not (.WetFrame = True And (NPC(B).Type = 229 Or NPC(B).Type = 230) Or NPCIsAVine(NPC(B).Type)) And .HoldingNPC <> B Then
                                                        If .Vine > 0 Then
                                                            .Vine = 0
                                                            .Jump = 1
                                                        End If
                                                        If Not (NPCIsAShell(NPC(B).Type) And NPC(B).CantHurtPlayer = A) Then
                                                            NPCHit B, 1, A 'NPC 'B' was jumped on '1' by player 'A'
                                                        End If
                                                    End If
                                                End If
                                            End If
                                        ElseIf HitSpot = 0 Then 'if hitspot = 0 then do nothing
                                        
                                            'player touched an npc anywhere except from the top
                                        ElseIf Not (NPC(B).Type = 15 And NPC(B).Special = 4) Then 'Player touched an NPC
                                                'grab code
                                            If (.CanGrabNPCs = True Or NPCIsGrabbable(NPC(B).Type) = True Or (NPC(B).Effect = 2 And NPCIsABonus(NPC(B).Type) = False)) And (NPC(B).Effect = 0 Or NPC(B).Effect = 2) Or (NPCIsAShell(NPC(B).Type) And FreezeNPCs = True) Then      'GRAB EVERYTHING
                                                If .Controls.Run = True Then
                                                    If (HitSpot = 2 And .Direction = -1) Or (HitSpot = 4 And .Direction = 1) Or (NPC(B).Type = 22 Or NPC(B).Type = 49 Or NPC(B).Effect = 2 Or (NPCIsVeggie(NPC(B).Type And NPC(B).CantHurtPlayer <> A))) Then
                                                        If .HoldingNPC = 0 Then
                                                            If Not NPCIsAShell(NPC(B).Type) Or .Character >= 3 Then
                                                                If NPCIsVeggie(NPC(B).Type) = True Then
                                                                    PlaySound 73
                                                                Else
                                                                    PlaySound 23
                                                                End If
                                                            End If
                                                            If .Character <= 2 Then UnDuck A
                                                            .HoldingNPC = B
                                                            NPC(B).Direction = .Direction
                                                            NPC(B).Frame = EditorNPCFrame(NPC(B).Type, NPC(B).Direction)
                                                            NPC(B).HoldingPlayer = A
                                                            NPC(B).CantHurt = Physics.NPCCanHurtWait
                                                            NPC(B).CantHurtPlayer = A
                                                        End If
                                                    End If
                                                End If
                                            End If
                                            If NPCIsAShell(NPC(B).Type) Or (NPC(B).Type = 45 And NPC(B).Special = 1) Then    'Turtle shell
                                                If (NPC(B).Location.SpeedX = 0 And NPC(B).Location.SpeedY >= 0) Then      'Shell is not moving
                                                    If ((.Controls.Run = True And .HoldingNPC = 0) Or .HoldingNPC = B) And Not NPC(B).CantHurtPlayer = A Then    'Grab the shell
                                                        If .Character >= 3 Then
                                                            PlaySound 23
                                                        Else
                                                            UnDuck A
                                                        End If
                                                        .HoldingNPC = B
                                                        NPC(B).HoldingPlayer = A
                                                        NPC(B).CantHurt = Physics.NPCCanHurtWait
                                                        NPC(B).CantHurtPlayer = A
                                                    ElseIf NPC(B).HoldingPlayer = 0 Then  'Kick the shell
                                                        If (.Mount = 1 Or .Mount = 2 Or .Mount = 3) And NPC(B).Type <> 45 Then
                                                            If NPC(B).Type <> 195 Then
                                                                tempLocation.Y = .Location.Y
                                                                tempHit = True
                                                                NPCHit B, 8, A
                                                            End If
                                                        Else
                                                            tempLocation.Height = 0
                                                            tempLocation.Width = 0
                                                            tempLocation.Y = (.Location.Y + NPC(B).Location.Y * 4) / 5
                                                            tempLocation.X = (.Location.X + NPC(B).Location.X * 4) / 5
                                                            NewEffect 132, tempLocation
                                                            NPC(B).CantHurt = 0
                                                            NPC(B).CantHurtPlayer = 0
                                                            NPCHit B, 1, A
                                                        End If
                                                    End If
                                                ElseIf NPC(B).Location.SpeedX <> 0 Then 'Got hit by the shell
                                                    If NPC(B).CantHurtPlayer <> A And FreezeNPCs = False And NPC(B).Type <> 195 Then
                                                        If n00bCollision(.Location, NPC(B).Location) Then PlayerHurt A
                                                    End If
                                                End If
                                            ElseIf NPCIsABonus(NPC(B).Type) Then 'Bonus
                                                TouchBonus A, B
                                            Else 'Everything else
                                                If (NPC(B).Type = 137 Or NPC(B).Type = 166) And NPC(B).HoldingPlayer <> A Then 'kick the bob-om
                                                    If NPC(B).TailCD = 0 Then
                                                        NPC(B).TailCD = 12
                                                        If NPC(B).Type <> 166 And NPC(B).Type <> 137 Then NewEffect 75, newLoc((.Location.X + NPC(B).Location.X + (.Location.Width + NPC(B).Location.Width) / 2) / 2, (.Location.Y + NPC(B).Location.Y + (.Location.Height + NPC(B).Location.Height) / 2) / 2)
                                                        NPCHit B, 1, A
                                                    End If
                                                ElseIf NPC(B).CantHurtPlayer <> A And NPCWontHurt(NPC(B).Type) = False Then
                                                    If Not (NPC(B).Type = 17 And NPC(B).Projectile = True) Then
                                                        If NPC(B).Type >= 117 And NPC(B).Type <= 120 And NPC(B).Projectile = True Then
                                                            NPCHit B, 3, B
                                                        Else
                                                            If NPC(B).Effect <> 2 Then
                                                                If .SlideKill = True And NPCJumpHurt(NPC(B).Type) = False Then
                                                                    NPCHit B, 3, B
                                                                End If
                                                                If NPC(B).Killed = 0 Then
                                                                    If n00bCollision(.Location, NPC(B).Location) Then
                                                                        If BattleMode = True And NPC(B).HoldingPlayer <> A And NPC(B).HoldingPlayer > 0 And .Immune = 0 Then NPCHit B, 5, B
                                                                        PlayerHurt A
                                                                    End If
                                                                Else
                                                                    MoreScore NPCScore(NPC(B).Type), NPC(B).Location, .Multiplier
                                                                End If
                                                            End If
                                                        End If
                                                    End If
                                                End If
                                                
                                                    'this is for NPC that physically push the player
                                                If NPCMovesPlayer(NPC(B).Type) = True And NPC(B).Projectile = False And Not .HoldingNPC = B And Not (.Mount = 2 And (NPC(B).Type = 31 Or NPC(B).Type = 32)) And ShadowMode = False And NPC(B).Effect <> 2 Then
                                                    If .StandUp = True And .StandingOnNPC = 0 Then
                                                        If HitSpot = 5 And .Location.Y + .Location.Height - Physics.PlayerDuckHeight(.Character, .State) - .Location.SpeedY >= NPC(B).Location.Y + NPC(B).Location.Height Then HitSpot = 3
                                                    End If
                                                    If HitSpot = 3 Then
                                                        If NPC(B).Type = 263 And .Character <> 5 And .State > 1 Then NPCHit B, 3, B
                                                        tempLocation = .Location
                                                        .Location.SpeedY = 0.1 + NPC(B).Location.SpeedY
                                                        .Location.Y = NPC(B).Location.Y + NPC(B).Location.Height + 0.1
                                                        fBlock = FirstBlock((Player(A).Location.X / 32) - 1)
                                                        lBlock = LastBlock(((Player(A).Location.X + Player(A).Location.Width) / 32) + 1)
                                                        For C = fBlock To lBlock
                                                            If CheckCollision(.Location, Block(C).Location) And Block(C).Hidden = False And BlockIsSizable(Block(C).Type) = False And BlockOnlyHitspot1(Block(C).Type) = False Then .Location = tempLocation
                                                        Next C
                                                         PlaySound 3
                                                        .Jump = 0
                                                        If .Mount = 2 Then .Location.SpeedY = .Location.SpeedY + 2
                                                        If NPC(B).Type = 58 Or NPC(B).Type = 21 Or NPC(B).Type = 67 Or NPC(B).Type = 68 Or NPC(B).Type = 69 Or NPC(B).Type = 70 Or (NPC(B).Type >= 78 And NPC(B).Type <= 83) Then
                                                            If NPC(B).Location.SpeedY >= Physics.NPCGravity * 20 Then
                                                                PlayerHurt A
                                                            End If
                                                        End If
                                                    Else
                                                        tempBool = False
                                                        If .StandingOnNPC <> 0 Then
                                                            If NPC(.StandingOnNPC).Type = 57 Then tempBool = True
                                                        End If
                                                        
                                                        D = .Location.X
                                                        If .Location.X + .Location.Width / 2 < NPC(B).Location.X + NPC(B).Location.Width / 2 Then
                                                            .Pinched4 = 2
                                                            
                                                            If NPC(B).Type <> 31 And NPC(B).Type <> 32 And NPC(B).Type <> 57 And (NPC(B).Location.SpeedX <> 0 Or NPC(B).Location.SpeedY <> 0 Or NPC(B).BeltSpeed) Then .NPCPinched = 2
                                                            .Location.X = NPC(B).Location.X - .Location.Width - 0.1
                                                            tempHit2 = True
                                                            .RunCount = 0
                                                            tempHitSpeed = NPC(B).Location.SpeedX + NPC(B).BeltSpeed
                                                            If tempHit3 <> 0 Then
                                                                If Abs(Block(tempHit3).Location.X - NPC(B).Location.X) < 1 Then
                                                                    .Location.X = NPC(B).Location.X - .Location.Width - 1
                                                                    .Location.SpeedY = oldSpeedY
                                                                End If
                                                            End If
                                                            If tempBool = False And NPC(B).Type <> 168 Then .Location.SpeedX = 0.2 * .Direction
                                                            If NPC(.StandingOnNPC).Type = 57 Then .Location.X = .Location.X - 1
                                                            If tempBlockHit(1) > 0 Then
                                                                If NPC(B).Location.X >= NPC(tempBlockHit(1)).Location.X - 2 And NPC(B).Location.X <= NPC(tempBlockHit(1)).Location.X + 2 Then
                                                                    tempBlockHit(1) = tempBlockHit(2)
                                                                End If
                                                            End If
                                                            If tempBlockHit(2) > 0 Then
                                                                If NPC(B).Location.X >= NPC(tempBlockHit(2)).Location.X - 2 And NPC(B).Location.X <= NPC(tempBlockHit(2)).Location.X + 2 Then
                                                                    tempBlockHit(2) = 0
                                                                End If
                                                            End If
                                                        Else
                                                            .Pinched2 = 2
                                                            If NPC(B).Type <> 31 And NPC(B).Type <> 32 And NPC(B).Type <> 57 And (NPC(B).Location.SpeedX <> 0 Or NPC(B).Location.SpeedY <> 0 Or NPC(B).BeltSpeed) Then .NPCPinched = 2
                                                            .Location.X = NPC(B).Location.X + NPC(B).Location.Width + 0.01
                                                            tempHit2 = True
                                                            .RunCount = 0
                                                            tempHitSpeed = NPC(B).Location.SpeedX + NPC(B).BeltSpeed
                                                            If tempHit3 <> 0 Then
                                                                If Abs(Block(tempHit3).Location.X + Block(tempHit3).Location.Width - NPC(B).Location.X - NPC(B).Location.Width) < 1 Then
                                                                    .Location.X = NPC(B).Location.X + NPC(B).Location.Width + 1
                                                                    .Location.SpeedY = oldSpeedY
                                                                End If
                                                            End If
                                                            If tempBool = False And NPC(B).Type <> 168 Then .Location.SpeedX = 0.2 * .Direction
                                                            If tempBlockHit(1) > 0 Then
                                                                If NPC(B).Location.X + NPC(B).Location.Width >= NPC(tempBlockHit(1)).Location.X + NPC(tempBlockHit(1)).Location.Width - 2 And NPC(B).Location.X + NPC(B).Location.Width <= NPC(tempBlockHit(1)).Location.X + NPC(tempBlockHit(1)).Location.Width + 2 Then
                                                                    tempBlockHit(1) = tempBlockHit(2)
                                                                End If
                                                            End If
                                                            If tempBlockHit(2) > 0 Then
                                                                If NPC(B).Location.X + NPC(B).Location.Width >= NPC(tempBlockHit(2)).Location.X + NPC(tempBlockHit(2)).Location.Width - 2 And NPC(B).Location.X + NPC(B).Location.Width <= NPC(tempBlockHit(2)).Location.X + NPC(tempBlockHit(2)).Location.Width + 2 Then
                                                                    tempBlockHit(2) = 0
                                                                End If
                                                            End If
                                                        End If
                                                        If .Mount = 2 Then
                                                        D = .Location.X - D
                                                        For C = 1 To numNPCs
                                                            If NPC(C).standingOnPlayer = A Then
                                                                NPC(C).Location.X = NPC(C).Location.X + D
                                                            End If
                                                        Next C
                                                        For C = 1 To numPlayers
                                                            If Player(C).StandingOnTempNPC = 56 Then
                                                                Player(C).Location.X = Player(C).Location.X + D
                                                            End If
                                                        Next C
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
                    
                        'if the player collided on the left or right of some npcs then stop his movement
                    If tempHit2 = True Then
                        If .Location.SpeedX + NPC(.StandingOnNPC).Location.SpeedX + tempHitSpeed > 0 And .Controls.Right = True Then
                            .Location.SpeedX = 0.2 * .Direction + tempHitSpeed
                        ElseIf .Location.SpeedX + NPC(.StandingOnNPC).Location.SpeedX + tempHitSpeed < 0 And .Controls.Left = True Then
                            .Location.SpeedX = 0.2 * .Direction + tempHitSpeed
                        Else
                            If .Controls.Right = True Or .Controls.Left = True Then
                                .Location.SpeedX = -NPC(.StandingOnNPC).Location.SpeedX + 0.2 * .Direction
                            Else
                                .Location.SpeedX = 0
                            End If
                        End If
                    End If
                    If tempHit = True Then 'For multiple NPC hits
                        If .Character = 4 And (.State = 4 Or .State = 5) And .SpinJump = False Then .DoubleJump = True
                        .CanJump = True
                        If tempSpring = True Then
                            .Jump = Physics.PlayerSpringJumpHeight
                            If .Character = 2 Then .Jump = .Jump + 3
                            If .SpinJump = True Then .Jump = .Jump - 6
                            .Location.SpeedY = Physics.PlayerJumpVelocity - 4
                            If .Wet > 0 Then .Location.SpeedY = .Location.SpeedY * 0.3
                        Else
                            .Jump = Physics.PlayerNPCJumpHeight
                            If .Character = 2 Then .Jump = .Jump + 3
                            If .SpinJump = True Then .Jump = .Jump - 6
                            .Location.SpeedY = Physics.PlayerJumpVelocity
                            If .Wet > 0 Then .Location.SpeedY = .Location.SpeedY * 0.3
                        End If
                        .Location.Y = tempLocation.Y
                        If tempShell = True Then
                            NewEffect 132, newLoc(.Location.X + .Location.Width / 2 - EffectWidth(132) / 2, .Location.Y + .Location.Height - EffectHeight(132) / 2)
                        ElseIf tempSpring = False Then
                            NewEffect 75, newLoc(.Location.X + .Location.Width / 2 - 16, .Location.Y + .Location.Height - 16)
                        Else
                            tempSpring = False
                        End If
                        PlayerPush A, 3
                        If .YoshiBlue = True Then
                            .CanFly2 = True
                            .FlyCount = 300
                        End If
                        If spinKill = True Then
                            .Jump = 0
                            .Location.SpeedY = Physics.PlayerJumpVelocity '* 0.5
                        End If
                    End If



'Find out which NPC to stand on

'this code is for standing on moving NPCs.
                    If tempBlockHit(2) <> 0 Then
                        If NPC(tempBlockHit(1)).Location.Y = NPC(tempBlockHit(2)).Location.Y Then
                            With NPC(tempBlockHit(1)).Location
                                C = .X + .Width * 0.5
                            End With
                            With NPC(tempBlockHit(2)).Location
                                D = .X + .Width * 0.5
                            End With
                            C = C - (.Location.X + .Location.Width * 0.5)
                            D = D - (.Location.X + .Location.Width * 0.5)
                            If C < 0 Then C = -C
                            If D < 0 Then D = -D
                            If C < D Then
                                B = tempBlockHit(1)
                            Else
                                B = tempBlockHit(2)
                            End If
                        Else
                            If NPC(tempBlockHit(1)).Location.Y < NPC(tempBlockHit(2)).Location.Y Then
                                B = tempBlockHit(1)
                            Else
                                B = tempBlockHit(2)
                            End If

                        End If
                    ElseIf tempBlockHit(1) <> 0 Then
                        B = tempBlockHit(1)
                    Else
                        B = 0
                    End If
                    If NPC(tempBlockHit(1)).Type >= 60 And NPC(tempBlockHit(1)).Type <= 66 Then
                        B = tempBlockHit(1)
                    ElseIf NPC(tempBlockHit(2)).Type >= 60 And NPC(tempBlockHit(2)).Type <= 66 Then
                        B = tempBlockHit(2)
                    End If
                    If NPC(B).Effect = 2 Then B = 0
                    If NPC(B).Projectile = True And NPCIsVeggie(NPC(B).Type) = True Then
                        B = 0
                    End If
                    
    'B is the number of the NPC that the player is standing on
    '.StandingOnNPC is the number of the NPC that the player was standing on last cycle
    'if B = 0 and .standingonnpc > 0 then the player was standing on something and is no longer standing on something
                    
                    
                    If B > 0 And .SpinJump = True Then
                        If NPC(B).Type = 263 Then
                            .Location.SpeedY = Physics.PlayerJumpVelocity
                            NPC(B).Multiplier = NPC(B).Multiplier + .Multiplier
                            NPCHit B, 3, B
                            .Jump = 7
                            If .Character = 2 Then .Jump = .Jump + 3
                            If .Controls.Down = True Then
                                .Jump = 0
                                .Location.SpeedY = Physics.PlayerJumpVelocity * 0.5
                            End If
                            B = 0
                        End If
                    End If
                    
                    If .HoldingNPC = B Then B = 0 'cant hold an npc that you are standing on
                    If B = 0 And .StandingOnTempNPC > 0 And .Mount = 0 Then
                        .Location.SpeedX = .Location.SpeedX + (NPC(.StandingOnNPC).Location.SpeedX + NPC(.StandingOnNPC).BeltSpeed)
                    ElseIf B > 0 And .StandingOnNPC = 0 And NPC(B).playerTemp = True And .Location.SpeedY >= 0 Then
                        .Location.SpeedX = .Location.SpeedX - (NPC(B).Location.SpeedX + NPC(B).BeltSpeed)
                    End If
                    
                    If movingBlock = True Then 'this is for when the player is standing on a moving block
                        If B > 0 Then
                            If NPC(B).Type = 91 Then
                                movingBlock = False
                            Else
                                B = -A
                            End If
                        Else
                            B = -A
                        End If
                    End If
                    
                    If B <> 0 Then
                        If .StandingOnNPC = 0 Then
                            If .GroundPound = True Then
                                numBlock = numBlock + 1
                                Block(numBlock).Location.Y = NPC(B).Location.Y
                                YoshiPound A, numBlock, True
                                Block(numBlock).Location.Y = 0
                                numBlock = numBlock - 1
                                .GroundPound = False
                            ElseIf .YoshiYellow = True Then
                                numBlock = numBlock + 1
                                Block(numBlock).Location.Y = NPC(B).Location.Y
                                YoshiPound A, numBlock
                                Block(numBlock).Location.Y = 0
                                numBlock = numBlock - 1
                            End If
                        End If
                        If NPC(B).playerTemp = 0 Then .StandingOnTempNPC = 0
                        If .Location.SpeedY >= 0 Then .StandingOnNPC = B
                        .Location.Y = NPC(B).Location.Y - .Location.Height
                        If NPC(B).Type = 46 Or NPC(B).Type = 212 Then NPC(B).Special2 = 1
                        If NPC(B).Type = 105 Then NPC(B).Special = 1
                        If NPC(B).Type = 104 And .Location.SpeedY > 0 Then NPC(B).Direction = 1
                        If NPC(B).Type = 190 And NPC(B).Special = 0 Then
                            NPC(B).Special = 1
                            SkullRide B
                        End If
                        If NPC(B).Type = 57 Then
                            .Location.SpeedY = 0
                        End If
                        
                        
                        If NPC(B).Type = 56 And .Controls.Down = True And .Mount = 0 And NPC(B).playerTemp = False And .DuckRelease = True And (.HoldingNPC = 0 Or .Character = 5) Then
                            UnDuck A
                            .Location = NPC(B).Location
                            .Mount = 2
                            NPC(B).Killed = 9
                            .HoldingNPC = 0
                            .StandingOnNPC = 0
                            PlaySound 2
                            For C = 1 To numPlayers
                                If Player(C).StandingOnNPC = B Then
                                    Player(C).StandingOnTempNPC = 56
                                End If
                            Next C
                        ElseIf .Mount = 2 Then
                            .StandingOnNPC = 0
                             If .Location.SpeedY > 4 + NPC(B).Location.SpeedY Then PlaySound 37
                            .Location.SpeedY = NPC(B).Location.SpeedY
                        End If
                        
                    ElseIf .Mount = 1 And .Jump = 0 Then
                        If .StandingOnNPC <> 0 Then
                            If .Location.X > NPC(.StandingOnNPC).Location.X + NPC(.StandingOnNPC).Location.Width Or .Location.X + .Location.Width < NPC(.StandingOnNPC).Location.X Then
                                .StandingOnNPC = 0
                                .StandingOnTempNPC = 0
                                If .Location.SpeedY > 4.1 Then
                                    .Location.Y = .Location.Y - .Location.SpeedY
                                    .Location.SpeedY = NPC(.StandingOnNPC).Location.SpeedY
                                    If .Location.SpeedY > Physics.PlayerTerminalVelocity Then .Location.SpeedY = Physics.PlayerTerminalVelocity
                                    .Location.Y = .Location.Y + .Location.SpeedY
                                End If
                            End If
                        End If
                    ElseIf .Mount = 1 And .Jump > 0 Then
                        If B = 0 And .StandingOnTempNPC > 0 Then
                            .Location.SpeedX = .Location.SpeedX + (NPC(.StandingOnNPC).Location.SpeedX + NPC(.StandingOnNPC).BeltSpeed)
                        ElseIf B > 0 And .StandingOnNPC = 0 And NPC(B).playerTemp = True Then
                            .Location.SpeedX = .Location.SpeedX - (NPC(B).Location.SpeedX + NPC(B).BeltSpeed)
                        End If
                        .StandingOnNPC = 0
                        .StandingOnTempNPC = 0
                    Else
                        If .StandingOnNPC <> 0 Then
                        
                            If .StandingOnNPC < 0 Then
                                .Location.SpeedX = .Location.SpeedX + NPC(.StandingOnNPC).Location.SpeedX
                            End If
                            .Location.Y = .Location.Y - .Location.SpeedY
                            .Location.SpeedY = NPC(.StandingOnNPC).Location.SpeedY
                            If FreezeNPCs = True Then .Location.SpeedY = 0
                            If .Location.SpeedY > Physics.PlayerTerminalVelocity Then .Location.SpeedY = Physics.PlayerTerminalVelocity
                            .Location.Y = .Location.Y + .Location.SpeedY
                        End If
                        .StandingOnNPC = 0
                        .StandingOnTempNPC = 0
                    End If
                    
                    If .StandingOnNPC > 0 And .Mount = 0 Then 'driving stuff
                        If NPC(.StandingOnNPC).Type = 290 Then
                            .Driving = True
                            .Location.X = NPC(.StandingOnNPC).Location.X + NPC(.StandingOnNPC).Location.Width / 2 - .Location.Width / 2
                            .Direction = NPC(.StandingOnNPC).DefaultDirection
                        End If
                    End If
                    
                    If (.Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope > 0) And .Slide = False And FreezeNPCs = False Then .Multiplier = 0
                    If .Mount = 2 Then .Multiplier = 0
                    PlayerCollide A
                    
'Talk to NPC
                    If MessageNPC > 0 Then
                        MessageText = NPC(MessageNPC).Text
                        PauseGame A
                        MessageText = ""
                        If NPC(MessageNPC).TriggerTalk <> "" Then ProcEvent NPC(MessageNPC).TriggerTalk
                        MessageNPC = 0
                    End If
                    YoshiEatCode A

'pinch code
                    If GodMode = False Then
                        If ((.Pinched1 > 0 And .Pinched3 > 0) Or (.Pinched2 > 0 And .Pinched4 > 0)) And .NPCPinched > 0 And .Mount <> 2 Then
                            If .Mount <> 2 Then .Mount = 0
                            .State = 1
                            .Immune = 0
                            .Immune2 = False
                            PlayerHurt A
                        End If
                    End If

SuperWarp A 'this sub checks warps
                    
'shell surf
                        If .ShellSurf = True And .StandingOnNPC <> 0 Then
                            .Location.X = NPC(.StandingOnNPC).Location.X + NPC(.StandingOnNPC).Location.Width / 2 - .Location.Width / 2
                            .Location.SpeedX = 0 '1 * .Direction
                            If NPC(.StandingOnNPC).Location.SpeedX = 0 Then .ShellSurf = False
                        End If
                    
'Check edge of screen
                    If LevelWrap(.Section) = False And LevelMacro = 0 Then
                        If ScreenType = 3 Then
                            If .Location.X < -vScreenX(1) Then
                                .Location.X = -vScreenX(1) + 1
                                .Location.SpeedX = 4
                            ElseIf .Location.X > -vScreenX(1) + frmMain.ScaleWidth - .Location.Width Then
                                .Location.X = -vScreenX(1) + frmMain.ScaleWidth - .Location.Width - 1
                                .Location.SpeedX = -4
                            End If
                        End If
                    End If
                    If .Location.Y > level(.Section).Height + 64 Then
                        PlayerDead A
                    End If
                    If NPCIsAShell(NPC(.StandingOnNPC).Type) = False Then .ShellSurf = False
                    
                    PlayerGrabCode A, DontResetGrabTime 'Player holding NPC code **GRAB CODE**
                    
                    If .Controls.Run = False And .Controls.AltRun = False Then
                        .RunRelease = True
                    Else
                        .RunRelease = False
                    End If
                    
                    If .Controls.Jump = False And .Controls.AltJump = False Then
                        .JumpRelease = True
                    Else
                        .JumpRelease = False
                    End If
                    
                    PlayerFrame A ' Update players frames
                    .StandUp = False 'Fixes a block collision bug
                    .StandUp2 = False
                    If .ForceHitSpot3 = True Then .StandUp = True
                    .ForceHitSpot3 = False
                    If .ForceHold > 0 Then .ForceHold = .ForceHold - 1
                Else 'Player special effects
                    PlayerEffects A
                End If
                If nPlay.Online = True Then
                    If A = nPlay.MySlot + 1 Then
                        If .HoldingNPC <> oldGrab Then
                            If .HoldingNPC > 0 Then
                                NPC(.HoldingNPC).NetTimeout = 10
                                C = .HoldingNPC
                                Netplay.sendData "K" & C & "|" & NPC(C).Type & "|" & NPC(C).Location.X & "|" & NPC(C).Location.Y & "|" & NPC(C).Location.Width & "|" & NPC(C).Location.Height & "|" & NPC(C).Location.SpeedX & "|" & NPC(C).Location.SpeedY & "|" & NPC(C).Section & "|" & NPC(C).TimeLeft & "|" & NPC(C).Direction & "|" & Int(NPC(C).Projectile) & "|" & NPC(C).Special & "|" & NPC(C).Special2 & "|" & NPC(C).Special3 & "|" & NPC(C).Special4 & "|" & NPC(C).Special5 & "|" & NPC(C).Effect & LB & "1n" & A & "|" & .HoldingNPC & "|" & NPC(.HoldingNPC).Type & LB
                            Else
                                C = oldGrab
                                Netplay.sendData Netplay.PutPlayerControls(nPlay.MySlot) & "K" & C & "|" & NPC(C).Type & "|" & NPC(C).Location.X & "|" & NPC(C).Location.Y & "|" & NPC(C).Location.Width & "|" & NPC(C).Location.Height & "|" & NPC(C).Location.SpeedX & "|" & NPC(C).Location.SpeedY & "|" & NPC(C).Section & "|" & NPC(C).TimeLeft & "|" & NPC(C).Direction & "|" & Int(NPC(C).Projectile) & "|" & NPC(C).Special & "|" & NPC(C).Special2 & "|" & NPC(C).Special3 & "|" & NPC(C).Special4 & "|" & NPC(C).Special5 & "|" & NPC(C).Effect & LB & "1o" & A & "|" & oldGrab & LB
                            End If
                        ElseIf .HoldingNPC > 0 Then
                            C = .HoldingNPC
                            NPC(.HoldingNPC).NetTimeout = 10
                            If nPlay.PlayerWaitCount Mod 3 = 0 Then
                                Netplay.sendData "K" & C & "|" & NPC(C).Type & "|" & NPC(C).Location.X & "|" & NPC(C).Location.Y & "|" & NPC(C).Location.Width & "|" & NPC(C).Location.Height & "|" & NPC(C).Location.SpeedX & "|" & NPC(C).Location.SpeedY & "|" & NPC(C).Section & "|" & NPC(C).TimeLeft & "|" & NPC(C).Direction & "|" & Int(NPC(C).Projectile) & "|" & NPC(C).Special & "|" & NPC(C).Special2 & "|" & NPC(C).Special3 & "|" & NPC(C).Special4 & "|" & NPC(C).Special5 & "|" & NPC(C).Effect & LB & "1n" & A & "|" & .HoldingNPC & "|" & NPC(.HoldingNPC).Type & LB
                            End If
                        End If
                    End If
                End If
            End If
            If .Controls.Down = True Then
                .DuckRelease = False
            Else
                .DuckRelease = True
            End If
        End With
    Next A
    C = 0
    For A = numNPCs To 1 Step -1
        With NPC(A)
            If .playerTemp = True Then
                For B = 1 To numPlayers
                    If Player(B).StandingOnNPC = A Then Player(B).StandingOnTempNPC = .Type
                Next B
                NPC(C) = NPC(A)
                KillNPC A, 9
            End If
        End With
    Next A
End Sub

Public Sub PlayerHurt(A As Integer) 'Player got hurt
    If GodMode = True Or GameOutro = True Or BattleOutro > 0 Then Exit Sub
    Dim tempLocation As Location
    Dim B As Integer
    With Player(A)
        If .Dead = True Or .TimeToLive > 0 Or .Stoned = True Or .Immune > 0 Or .Effect > 0 Then Exit Sub
        If nPlay.Online = True Then 'netplay stuffs
            If nPlay.Allow = False And A <> nPlay.MySlot + 1 Then Exit Sub
            If A = nPlay.MySlot + 1 Then
                Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1a" & A & "|" & .State & LB
            End If
        End If
        .DoubleJump = False
        .GrabSpeed = 0
        .GrabTime = 0
        .Slide = False
        .SlideKill = False
        .CanFly = False
        .CanFly2 = False
        .FlyCount = 0
        .RunCount = 0
        If .Fairy = True Then
            PlaySound 87
            .Immune = 30
            .Effect = 8
            .Effect2 = 4
            .Fairy = False
            .FairyTime = 0
            SizeCheck B
            NewEffect 63, .Location
            If .Character = 5 Then
                .FrameCount = -10
                .Location.SpeedX = 3 * -.Direction
                .Location.SpeedY = -7.01
                .StandingOnNPC = 0
                .FireBallCD = 20
                PlaySound 78
            End If
            Exit Sub
        End If
        If GameMenu = True Then
            If .State > 1 Then
                .Hearts = 2
            Else
                .Hearts = 1
            End If
        End If
        
        If NPC(.HoldingNPC).Type = 13 Then .HoldingNPC = 0
        
        If LevelMacro = 0 Then
            If .Immune = 0 Then
                If .Mount = 1 Then
                    .Mount = 0
                    PlaySound 35
                    UnDuck A
                    tempLocation = .Location
                    tempLocation.SpeedX = 5 * -.Direction
                    If .MountType = 1 Then
                        NewEffect 26, tempLocation
                    ElseIf .MountType = 2 Then
                        NewEffect 101, tempLocation
                    Else
                        NewEffect 102, tempLocation
                    End If
                    .Location.Y = .Location.Y + .Location.Height
                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                    .Location.Y = .Location.Y - .Location.Height
                    .Immune = 150
                    .Immune2 = True
                ElseIf .Mount = 3 Then
                    UnDuck A
                    PlaySound 49
                    .Immune = 100
                    .Immune2 = True
                    .CanJump = False
                    .Location.SpeedX = 0
                    If .Location.SpeedY > Physics.PlayerJumpVelocity Then
                        .Location.SpeedY = Physics.PlayerJumpVelocity
                    End If
                    .Jump = 0
                    .Mount = 0
                    .YoshiBlue = False
                    .YoshiRed = False
                    .GroundPound = False
                    .GroundPound2 = False
                    .YoshiYellow = False
                    .Dismount = .Immune
                    numNPCs = numNPCs + 1
                    If .YoshiNPC > 0 Or .YoshiPlayer > 0 Then
                        YoshiSpit A
                    End If
                    With NPC(numNPCs)
                        'If ShadowMode = True Then .Shadow = True
                        .Direction = Player(A).Direction
                        .Active = True
                        .TimeLeft = 100
                        If Player(A).MountType = 1 Then
                            .Type = 95
                        ElseIf Player(A).MountType = 2 Then
                            .Type = 98
                        ElseIf Player(A).MountType = 3 Then
                            .Type = 99
                        ElseIf Player(A).MountType = 4 Then
                            .Type = 100
                        ElseIf Player(A).MountType = 5 Then
                            .Type = 148
                        ElseIf Player(A).MountType = 6 Then
                            .Type = 149
                        ElseIf Player(A).MountType = 7 Then
                            .Type = 150
                        ElseIf Player(A).MountType = 8 Then
                            .Type = 228
                        End If
                        .Special = 1
                        .Location.Height = 32
                        .Location.Width = 32
                        .Location.Y = Player(A).Location.Y + Player(A).Location.Height - 33
                        .Location.X = Int(Player(A).Location.X + Player(A).Location.Width / 2 - 16)
                        .Location.SpeedY = 0.5
                        .Location.SpeedX = 0
                        .CantHurt = 10
                        .CantHurtPlayer = A
                    End With
                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                Else
                    If .Character = 3 Or .Character = 4 Then
                        If .Hearts = 3 And (.State = 2 Or .State = 4 Or .State = 5 Or .State = 6) Then
                            .State = 2
                            .Immune = 150
                            .Immune2 = True
                            .Hearts = .Hearts - 1
                            PlaySound 76
                            Exit Sub
                        Else
                            .Hearts = .Hearts - 1
                            If .Hearts = 0 Then
                                .State = 1
                            ElseIf .State = 3 And .Hearts = 2 Then
                                .Effect = 227
                                .Effect2 = 0
                                PlaySound 5
                                Exit Sub
                            ElseIf .State = 7 And .Hearts = 2 Then
                                .Effect = 228
                                .Effect2 = 0
                                PlaySound 5
                                Exit Sub
                            Else
                                .State = 2
                            End If
                        End If
                    ElseIf .Character = 5 Then
                        .Hearts = .Hearts - 1
                        If .Hearts > 0 Then
                            If .Hearts = 1 Then
                                .State = 1
                            Else
                                .State = 2
                            End If
                            If .State < 1 Then .State = 1
                            If .Mount = 0 Then
                                .FrameCount = -10
                                .Location.SpeedX = 3 * -.Direction
                                .Location.SpeedY = -7.01
                                .FireBallCD = 30
                                .SwordPoke = 0
                            End If
                            .Immune = 150
                            .Immune2 = True
                            PlaySound 78
                            Exit Sub
                        End If
                    End If
                    If .State > 1 Then
                        PlaySound 5
                        .StateNPC = 0
                        .Effect = 2
                    Else
                        PlayerDead (A)
                        Player(A).HoldingNPC = 0
                        If .Mount = 2 Then
                            .Mount = 0
                            numNPCs = numNPCs + 1
                            With NPC(numNPCs)
                                .Direction = Player(A).Direction
                                If .Direction = 1 Then .Frame = 4
                                .Frame = .Frame + SpecialFrame(2)
                                .Active = True
                                .TimeLeft = 100
                                .Type = 56
                                .Location.Height = 128
                                .Location.Width = 128
                                .Location.Y = Int(Player(A).Location.Y)
                                .Location.X = Int(Player(A).Location.X)
                                .Location.SpeedY = 0
                                .Location.SpeedX = 0
                                .CantHurt = 10
                                .CantHurtPlayer = A
                            End With
                            .Location.Height = Physics.PlayerHeight(.Character, .State)
                            .Location.Width = Physics.PlayerWidth(.Character, .State)
                            .Location.X = .Location.X + 64 - Physics.PlayerWidth(.Character, .State) / 2
                            .ForceHitSpot3 = True
                            .Location.Y = NPC(numNPCs).Location.Y - .Location.Height
                            For B = 1 To numNPCs
                                If NPC(B).standingOnPlayer = A Then
                                    NPC(B).standingOnPlayer = 0
                                    NPC(B).Location.SpeedY = 0
                                    NPC(B).Location.Y = NPC(numNPCs).Location.Y - 0.1 - NPC(B).standingOnPlayerY
                                    NPC(B).standingOnPlayerY = 0
                                    If NPC(B).Type = 22 Then NPC(B).Special = 0
                                    If NPC(B).Type = 50 Then
                                        NPC(B).Killed = 9
                                        NPC(B).Special = 0
                                    ElseIf NPC(B).Type = 49 Then
                                        NPC(B).Special = 0
                                    End If
                                End If
                            Next B
                        End If
                    End If
                End If
            End If
        End If
    End With
End Sub

Public Sub PlayerDead(A As Integer) 'Set player up to die
    Dim tempBool As Boolean
    Dim B As Integer
    
If nPlay.Online = True Then 'netplay stuffs
    If nPlay.Allow = False And A <> nPlay.MySlot + 1 Then Exit Sub
    If A = nPlay.MySlot + 1 Then Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1b" & A & LB
End If
    
    If Player(A).Character = 5 Then
        PlaySound 80
    Else
        If BattleMode = True Then
            PlaySound 54
        ElseIf numPlayers > 2 Then
            For B = 1 To numPlayers
                If Player(B).Dead = False And Player(B).TimeToLive = 0 And A <> B Then
                    tempBool = True
                End If
            Next B
            If tempBool = True Then
                PlaySound 54
            Else
                PlaySound 8
            End If
        Else
            PlaySound 8
        End If
    End If
    With Player(A)
        If .YoshiNPC > 0 Or .YoshiPlayer > 0 Then YoshiSpit A
        .Location.SpeedX = 0
        .Location.SpeedY = 0
        .Hearts = 0
        .Wet = 0
        .WetFrame = 0
        .Quicksand = 0
        .Effect = 0
        .Effect2 = 0
        .Fairy = False
        If .Mount = 2 Then
            numNPCs = numNPCs + 1
            With NPC(numNPCs)
                .Direction = Player(A).Direction
                If .Direction = 1 Then .Frame = 4
                .Frame = .Frame + SpecialFrame(2)
                .Active = True
                .TimeLeft = 100
                .Type = 56
                .Location.Height = 128
                .Location.Width = 128
                .Location.Y = Int(Player(A).Location.Y)
                .Location.X = Int(Player(A).Location.X)
                .Location.SpeedY = 0
                .Location.SpeedX = 0
                .CantHurt = 10
                .CantHurtPlayer = A
            End With
            .Mount = 0
            .Location.Y = .Location.Y - 32
            .Location.Height = 32
            SizeCheck A
        End If
        .Mount = 0
        .State = 1
        .HoldingNPC = 0
        .GroundPound = False
        .GroundPound2 = False
        If .Character = 1 Then
            NewEffect 3, .Location, , , ShadowMode
        ElseIf .Character = 2 Then
            NewEffect 5, .Location, , , ShadowMode
        ElseIf .Character = 3 Then
            NewEffect 129, .Location, , , ShadowMode
        ElseIf .Character = 4 Then
            NewEffect 130, .Location, , , ShadowMode
        ElseIf .Character = 5 Then
            NewEffect 134, .Location, CSng(.Direction), , ShadowMode
            Effect(numEffects).Location.SpeedX = 2 * -.Direction
        End If
        .TimeToLive = 1
    End With
    If CheckLiving = 0 And GameMenu = False And BattleMode = False Then
        StopMusic
        FreezeNPCs = False
    End If
    If A = SingleCoop Then SwapCoop
End Sub

Public Sub KillPlayer(A As Integer) 'Kill the player
    Dim tempLocation As Location
    With Player(A)
        .Location.SpeedX = 0
        .Location.SpeedY = 0
        .State = 1
        .Stoned = False
        .Pinched1 = 0
        .Pinched2 = 0
        .Pinched3 = 0
        .Pinched4 = 0
        .NPCPinched = 0
        .TimeToLive = 0
        .Direction = 1
        .Frame = 1
        .Mount = 0
        .Dead = True
        .Location.X = 0
        .Location.Y = 0
        .Location.Width = Physics.PlayerWidth(.Character, .State)
        .Location.Height = Physics.PlayerHeight(.Character, .State)
        If .HoldingNPC > 0 Then
            If NPC(.HoldingNPC).Type = 272 Then NPC(.HoldingNPC).Projectile = True
        End If
        .HoldingNPC = 0
        If BattleMode = True Then
            If BattleLives(A) <= 0 Then
                If BattleOutro = 0 Then
                    BattleOutro = 1
                    PlaySound 52
                    StopMusic
                End If
                If BattleWinner = 0 Then
                    If A = 1 Then
                        BattleWinner = 2
                    Else
                        BattleWinner = 1
                    End If
                End If
            End If
            If A = BattleWinner Or BattleWinner = 0 Then
                If BattleLives(A) > 0 Then BattleLives(A) = BattleLives(A) - 1
                PlaySound 34
                .Frame = 1
                .Location.SpeedX = 0
                .Location.SpeedY = 0
                .Mount = 0
                .State = 2
                .Hearts = 2
                .Effect = 0
                .Location.Width = Physics.PlayerWidth(.Character, .State)
                .Location.Height = Physics.PlayerHeight(.Character, .State)
                .Location.X = PlayerStart(A).X + PlayerStart(A).Width * 0.5 - .Location.Width * 0.5
                .Location.Y = PlayerStart(A).Y + PlayerStart(A).Height - .Location.Height
                .Direction = 1
                .Dead = False
                CheckSection A
                If .Location.X + .Location.Width / 2 > level(.Section).X + (level(.Section).Width - level(.Section).X) / 2 Then .Direction = -1
                .Immune = 300
                tempLocation.Width = 32
                tempLocation.Height = 32
                tempLocation.X = .Location.X + .Location.Width / 2 - tempLocation.Width / 2
                tempLocation.Y = .Location.Y + .Location.Height / 2 - tempLocation.Height / 2
                NewEffect 131, tempLocation
            End If
        End If
    End With
End Sub

Public Function CheckDead() As Integer 'Check if players are dead and return which one, returns 0 if everyones dead
    Dim A As Integer
    For A = 1 To numPlayers
        If Player(A).Dead = True And Player(A).State > 0 And Player(A).Character > 0 Then
            If nPlay.Online = False Then
                CheckDead = A
                Exit Function
            Else
                If nPlay.Player(A - 1).Active = True Or A = 1 Then
                    CheckDead = A
                    Exit Function
                End If
            End If
        End If
    Next A
    CheckDead = 0
End Function

Public Function CheckLiving() As Integer 'Check if players are alive, returns the first player or 0 if everyones dead
    Dim A As Integer
    For A = 1 To numPlayers
        If Player(A).Dead = False And Player(A).TimeToLive = 0 Then
            CheckLiving = A
            Exit Function
        End If
    Next A
    CheckLiving = 0
End Function

Public Function LivingPlayers() As Boolean 'true if there are still living players
    Dim A As Integer
    For A = 1 To numPlayers
        If Player(A).Dead = False Then LivingPlayers = True
    Next A
End Function

Public Sub EveryonesDead() 'Handles the game when all players have died
    Dim A As Integer
    If BattleMode = True Then Exit Sub
    LevelMacro = 0
    FreezeNPCs = False
    StopMusic
    BitBlt myBackBuffer, 0, 0, ScreenW, ScreenH, 0, 0, 0, vbWhiteness
    BitBlt frmMain.hdc, 0, 0, frmMain.ScaleWidth, frmMain.ScaleHeight, 0, 0, 0, vbWhiteness
    If MagicHand = True Then
        BitBlt frmLevelWindow.vScreen(1).hdc, 0, 0, frmLevelWindow.vScreen(1).ScaleWidth, frmLevelWindow.vScreen(1).ScaleHeight, 0, 0, 0, vbWhiteness
    End If
    Sleep 500
    Lives = Lives - 1
    If Lives >= 0 Then
        LevelMacro = 0
        LevelMacroCounter = 0
        ClearLevel
        If RestartLevel = True Then
            OpenLevel FullFileName
            LevelSelect = False
            SetupPlayers
        Else
            LevelSelect = True
        End If
    Else 'no more lives
'GAME OVER
        Lives = 3
        Coins = 0
        SaveGame
        LevelMacro = 0
        LevelMacroCounter = 0
        ClearLevel
        LevelSelect = True
        GameMenu = True
        MenuMode = 0
        MenuCursor = 0
    End If
    DoEvents
End Sub

Public Sub UnDuck(A As Integer) 'Un Duck the player
    With Player(A)
        If .Duck = True And .GrabTime = 0 Then 'Player stands up
            If .Location.SpeedY <> 0 Then .StandUp = True 'Fixes a block collision bug
            .StandUp2 = True
            .Frame = 1
            .FrameCount = 0
            .Duck = False
            If .Mount = 3 Then
                .Location.Y = .Location.Y + .Location.Height
                If .State = 1 Then
                    .Location.Height = 54
                Else
                    .Location.Height = 60
                End If
                .Location.Y = .Location.Y - .Location.Height
            Else
                If .State = 1 And .Mount = 1 Then
                    .Location.Height = Physics.PlayerHeight(1, 2)
                    .Location.Y = .Location.Y - Physics.PlayerHeight(1, 2) + Physics.PlayerDuckHeight(1, 2)
                Else
                    .Location.Y = .Location.Y + .Location.Height
                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                    .Location.Y = .Location.Y - .Location.Height
                End If
            End If
            SizeCheck A
        End If
    End With
End Sub

Public Sub CheckSection(A As Integer)
'finds out what section the player is in and handles the music for section changes
    Dim B As Integer
    Dim C As Integer
    Dim oldSection As Integer
    Dim foundSection As Boolean
    If LevelSelect = True Then Exit Sub
    With Player(A)
        oldSection = .Section
        For B = 0 To maxSections
            If .Location.X + .Location.Width >= level(B).X Then
                If .Location.X <= level(B).Width Then
                    If .Location.Y + .Location.Height >= level(B).Y Then
                        If .Location.Y <= level(B).Height Then
                            foundSection = True
                            If oldSection <> B And (nPlay.Online = False Or nPlay.MySlot = A - 1) Then
                                ClearBuffer = True
                                .Section = B
                                If nPlay.Online = True Then
                                    If nPlay.MySlot = A - 1 Then
                                        Netplay.sendData "1e" & A & "|" & .Section
                                    Else
                                        Exit Sub
                                    End If
                                End If
                                If curMusic >= 0 And GameMenu = False Then   'Dont interupt boss / switch music
                                    
                                    If Not curMusic = bgMusic(B) Then
                                        StartMusic B
                                    ElseIf bgMusic(B) = 24 Then
                                        If oldSection >= 0 Then
                                            If CustomMusic(oldSection) <> CustomMusic(.Section) Then
                                                StartMusic B
                                            End If
                                        End If
                                    End If
                                End If
                                Exit For
                            End If
                        End If
                    End If
                End If
            End If
        Next B
        If foundSection = False Then
            For B = 0 To maxSections
                If .Location.X + .Location.Width >= LevelREAL(B).X Then
                    If .Location.X <= LevelREAL(B).Width Then
                        If .Location.Y + .Location.Height >= LevelREAL(B).Y Then
                            If .Location.Y <= LevelREAL(B).Height Then
                                .Section = B
                                If nPlay.Online = True Then
                                    If nPlay.MySlot = A - 1 Then
                                        Netplay.sendData "1e" & A & "|" & .Section
                                    Else
                                        Exit Sub
                                    End If
                                End If
                                If oldSection <> B Then
                                    ClearBuffer = True
                                    If curMusic <> 6 And curMusic >= 0 And curMusic <> 15 Then 'Dont interupt boss / switch music
                                        If Not curMusic = bgMusic(B) Then
                                            StartMusic B
                                        ElseIf bgMusic(B) = 24 Then
                                            If CustomMusic(B) <> CustomMusic(.Section) Then
                                                StartMusic B
                                            End If
                                        End If
                                    End If
                                End If
                                For C = 1 To numPlayers
                                    If Player(C).Section = .Section And C <> A Then
                                        .Location.X = Player(C).Location.X + Player(C).Location.Width / 2 - .Location.Width / 2
                                        .Location.Y = Player(C).Location.Y + Player(C).Location.Height - .Location.Height - 0.01
                                        Exit For
                                    End If
                                Next C
                                Exit For
                            End If
                        End If
                    End If
                End If
            Next B
        End If
    End With
End Sub

Public Sub PlayerFrame(A As Integer)
'updates the players GFX
    Dim tempLocation As Location
    With Player(A)

'cause the flicker when he is immune
        If Not .Effect = 9 Then
            If .Immune > 0 Then
                .Immune = .Immune - 1
                If .Immune Mod 3 = 0 Then
                    If .Immune2 = False Then
                        .Immune2 = True
                    Else
                        .Immune2 = False
                    End If
                End If
            Else
                .Immune2 = False
            End If
        End If
'find frames for link
        If .Character = 5 Then
            LinkFrame A
            Exit Sub
        End If
'for the grab animation when picking something up from the top
        If .GrabTime > 0 Then
            .FrameCount = .FrameCount + 1
            If .FrameCount <= 6 Then
                .Frame = 23
            ElseIf .FrameCount <= 12 Then
                .Frame = 22
            Else
                .FrameCount = 0
                .Frame = 23
            End If
            Exit Sub
        End If
'statue frames
        If .Stoned = True Then
            .Frame = 0
            .FrameCount = 0
            If .Location.SpeedX <> 0 Then
                If .Location.SpeedY = 0 Or .Slope > 0 Or .StandingOnNPC <> 0 Then
                    If .SlideCounter <= 0 Then
                        .SlideCounter = 2 + Rnd * 2
                        tempLocation.Y = .Location.Y + .Location.Height - 5
                        tempLocation.X = .Location.X + .Location.Width / 2 - 4
                        NewEffect 74, tempLocation, , , ShadowMode
                    End If
                End If
            End If
            Exit Sub
        End If
'sliding frames
        If .Slide = True And (.Character = 1 Or .Character = 2) Then
            If .Location.SpeedX <> 0 Then
                If .Location.SpeedY = 0 Or .Slope > 0 Or .StandingOnNPC <> 0 Then
                    If .SlideCounter <= 0 And .SlideKill = True Then
                        .SlideCounter = 2 + Rnd * 2
                        tempLocation.Y = .Location.Y + .Location.Height - 4
                        If .Location.SpeedX < 0 Then
                            tempLocation.X = .Location.X + .Location.Width / 2 - 4 + 6
                        Else
                            tempLocation.X = .Location.X + .Location.Width / 2 - 4 - 6
                        End If
                        NewEffect 74, tempLocation, , , ShadowMode
                    End If
                End If
            End If
            .Frame = 24
            Exit Sub
        End If
'climbing a vine/ladder
        If .Vine > 0 Then
            If .Location.SpeedX <> NPC(.VineNPC).Location.SpeedX Or .Location.SpeedY < NPC(.VineNPC).Location.SpeedY - 0.1 Then 'Or .Location.SpeedY > 0.1 Then
                .FrameCount = .FrameCount + 1
                If .FrameCount >= 8 Then
                    .Frame = .Frame + 1
                    .FrameCount = 0
                End If
                PlaySound 71
            End If
            If .Frame < 25 Then
                .Frame = 26
            ElseIf .Frame > 26 Then
                .Frame = 25
            End If
            Exit Sub
        End If
'this finds the players direction
        If LevelSelect = False And .Effect <> 3 Then
            If Not (.Mount = 3 And .MountSpecial > 0) Then
                If .Controls.Left = True Then .Direction = -1
                If .Controls.Right = True Then .Direction = 1
            End If
        End If
        If .Driving = True And .StandingOnNPC > 0 Then
            .Direction = NPC(.StandingOnNPC).DefaultDirection
        End If
        If .Fairy = True Then Exit Sub
'ducking and holding
        If .HoldingNPC > 0 And .Duck = True Then
            .Frame = 27
            Exit Sub
        End If
        
        .MountOffsetY = 0
        
'for the spinjump/shellsurf
        If (.SpinJump = True Or .ShellSurf = True) And .Mount = 0 Then
            If .SpinFrame < 4 Or .SpinFrame >= 9 Then
                .Direction = -1
            Else
                .Direction = 1
            End If
            If .ShellSurf = True Then
                If NPC(.StandingOnNPC).Location.SpeedX > 0 Then .Direction = -.Direction
            End If
            .SpinFrame = .SpinFrame + 1
            If .SpinFrame < 0 Then .SpinFrame = 14
            If .SpinFrame < 3 Then
                .Frame = 1
                If .HoldingNPC > 0 Then
                    If .State = 1 Then
                        .Frame = 5
                    Else
                        .Frame = 8
                    End If
                End If
                If (.State = 4 Or .State = 5) Then .Frame = 12
            ElseIf .SpinFrame < 6 Then
                .Frame = 13
            ElseIf .SpinFrame < 9 Then
                .Frame = 1
                If .HoldingNPC > 0 Then
                    If .State = 1 Then
                        .Frame = 5
                    Else
                        .Frame = 8
                    End If
                End If
                If (.State = 4 Or .State = 5) Then .Frame = 12
            ElseIf .SpinFrame < 12 - 1 Then
                .Frame = 15
            Else
                .Frame = 15
                .SpinFrame = -1
            End If
        Else
            If .State = 1 And (.Character = 1 Or .Character = 2) Then 'Small Mario & Luigi
                If .HoldingNPC = 0 Then 'not holding anything
                    If .WetFrame = True And .Location.SpeedY <> 0 And .Slope = 0 And .StandingOnNPC = 0 And .Duck = False And .Quicksand = 0 Then 'swimming
                        If .Location.SpeedY < 0 Or .Frame = 42 Or .Frame = 43 Then
                            If .Frame <> 40 And .Frame <> 42 And .Frame <> 43 Then .FrameCount = 6
                            .FrameCount = .FrameCount + 1
                            If .FrameCount < 6 Then
                                .Frame = 40
                            ElseIf .FrameCount < 12 Then
                                .Frame = 42
                            ElseIf .FrameCount < 18 Then
                                .Frame = 43
                            Else
                                .Frame = 43
                                .FrameCount = 0
                            End If
                        Else
                            .FrameCount = .FrameCount + 1
                            If .FrameCount < 10 Then
                                .Frame = 40
                            ElseIf .FrameCount < 20 Then
                                .Frame = 41
                            Else
                                .Frame = 41
                                .FrameCount = 0
                            End If
                        End If
                    Else 'not swimming
                        If .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope > 0 Or (.Location.SpeedY > 0 And .Quicksand > 0) Then
                            If .Location.SpeedX > 0 And (.Controls.Left = True Or (.Direction = -1 And .Bumped = True)) And .Effect = 0 And .Quicksand = 0 Then
                                If LevelSelect = False Then
                                    If Not .Mount = 2 And .WetFrame = False And .Duck = False Then
                                        PlaySound 10
                                        If .SlideCounter <= 0 Then
                                            .SlideCounter = 2 + Rnd * 2
                                            tempLocation.Y = .Location.Y + .Location.Height - 5
                                            tempLocation.X = .Location.X + .Location.Width / 2 - 4 + 8 * -.Direction
                                            NewEffect 74, tempLocation, , , ShadowMode
                                        End If
                                    End If
                                    .Frame = 4
                                End If
                            ElseIf .Location.SpeedX < 0 And (.Controls.Right = True Or (.Direction = 1 And .Bumped = True)) And .Effect = 0 And .Quicksand = 0 Then
                                If LevelSelect = False Then
                                    If Not .Mount = 2 And .WetFrame = False And .Duck = False Then
                                        PlaySound 10
                                        If .SlideCounter <= 0 Then
                                            .SlideCounter = 2 + Rnd * 2
                                            tempLocation.Y = .Location.Y + .Location.Height - 5
                                            tempLocation.X = .Location.X + .Location.Width / 2 - 4 + 8 * -.Direction
                                            NewEffect 74, tempLocation, , , ShadowMode
                                        End If
                                    End If
                                    .Frame = 4
                                End If
                            Else
                                If .Location.SpeedX <> 0 And Not (.Slippy = True And .Controls.Left = False And .Controls.Right = False) Then
                                    .FrameCount = .FrameCount + 1
                                    If .Location.SpeedX > Physics.PlayerWalkSpeed - 1.5 Or .Location.SpeedX < -Physics.PlayerWalkSpeed + 1.5 Then .FrameCount = .FrameCount + 1
                                    If .Location.SpeedX > Physics.PlayerWalkSpeed Or .Location.SpeedX < -Physics.PlayerWalkSpeed Then .FrameCount = .FrameCount + 1
                                    If .Location.SpeedX > Physics.PlayerWalkSpeed + 1 Or .Location.SpeedX < -Physics.PlayerWalkSpeed - 1 Then .FrameCount = .FrameCount + 1
                                    If .Location.SpeedX > Physics.PlayerWalkSpeed + 2 Or .Location.SpeedX < -Physics.PlayerWalkSpeed - 2 Then .FrameCount = .FrameCount + 1
                                    If .FrameCount >= 10 Then
                                    .FrameCount = 0
                                        If .Frame = 1 Then
                                            .Frame = 2
                                        Else
                                            .Frame = 1
                                        End If
                                    End If
                                Else
                                    .Frame = 1
                                    .FrameCount = 0
                                End If
                            End If
                        Else
                            .Frame = 3
                        End If
                    End If
                Else
                    If .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope > 0 Then
                        If .Mount <> 2 And ((.Controls.Left = True And .Location.SpeedX > 0) Or (.Controls.Right = True And .Location.SpeedX < 0)) And .Effect = 0 And .Duck = False Then
                            PlaySound 10
                            If .SlideCounter <= 0 Then
                                .SlideCounter = 2 + Rnd * 2
                                tempLocation.Y = .Location.Y + .Location.Height - 5
                                tempLocation.X = .Location.X + .Location.Width / 2 - 4 + 10 * -.Direction
                                NewEffect 74, tempLocation, , , ShadowMode
                            End If
                        End If
                        If .Location.SpeedX <> 0 Then
                            .FrameCount = .FrameCount + 2
                            If .Location.SpeedX > Physics.PlayerWalkSpeed Or .Location.SpeedX < -Physics.PlayerWalkSpeed Then .FrameCount = .FrameCount + 3
                            If .FrameCount >= 10 Then
                            .FrameCount = 0
                                If .Frame = 5 Then
                                    .Frame = 6
                                Else
                                    .Frame = 5
                                End If
                            End If
                        Else
                            .Frame = 5
                            .FrameCount = 0
                        End If
                    Else
                        .Frame = 6
                    End If
                End If
            ElseIf .FrameCount >= 100 And .FrameCount <= 118 And (.State = 3 Or .State = 6 Or .State = 7) Then  'Fire Mario and Luigi
                If .Duck = True Then
                    .FrameCount = 0
                    .Frame = 7
                Else
                    If .FrameCount <= 106 Then
                        .Frame = 11
                        If .WetFrame = True And .Quicksand = 0 And .Location.SpeedY <> 0 And .Slope = 0 And .StandingOnNPC = 0 And .Character <= 2 Then .Frame = 43
                    ElseIf .FrameCount <= 112 Then
                        .Frame = 12
                        If .WetFrame = True And .Quicksand = 0 And .Location.SpeedY <> 0 And .Slope = 0 And .StandingOnNPC = 0 And .Character <= 2 Then .Frame = 44
                    Else
                        .Frame = 11
                        If .WetFrame = True And .Quicksand = 0 And .Location.SpeedY <> 0 And .Slope = 0 And .StandingOnNPC = 0 And .Character <= 2 Then .Frame = 43
                    End If
                    .FrameCount = .FrameCount + 1
                    If FlameThrower = True Then .FrameCount = .FrameCount + 2
                    If .FrameCount > 118 Then .FrameCount = 0
                End If
            ElseIf .TailCount > 0 Then 'Racoon Mario
                If .TailCount < 5 Or .TailCount >= 20 Then
                    .Frame = 12
                ElseIf .TailCount < 10 Then .Frame = 15
                ElseIf .TailCount < 15 Then .Frame = 14
                Else
                    .Frame = 13
                End If
            Else 'Large Mario, Luigi, and Peach
                If .HoldingNPC = 0 Or (.Effect = 3 And .Character >= 3) Then
                    If .WetFrame = True And .Location.SpeedY <> 0 And .Slope = 0 And .StandingOnNPC = 0 And .Duck = False And .Quicksand = 0 Then
                        If .Location.SpeedY < 0 Or .Frame = 43 Or .Frame = 44 Then
                            If .Character <= 2 Then
                                If .Frame <> 40 And .Frame <> 43 And .Frame <> 44 Then .FrameCount = 6
                            End If
                            
                            .FrameCount = .FrameCount + 1
                            If .FrameCount < 6 Then
                                .Frame = 40
                            ElseIf .FrameCount < 12 Then
                                .Frame = 43
                            ElseIf .FrameCount < 18 Then
                                .Frame = 44
                            Else
                                .Frame = 44
                                .FrameCount = 0
                            End If
                        Else
                            .FrameCount = .FrameCount + 1
                            If .FrameCount < 10 Then
                                .Frame = 40
                            ElseIf .FrameCount < 20 Then
                                .Frame = 41
                            ElseIf .FrameCount < 30 Then
                                .Frame = 42
                            ElseIf .FrameCount < 40 Then
                                .Frame = 41
                            Else
                                .Frame = 41
                                .FrameCount = 0
                            End If
                        End If
                        
                        If .Character >= 3 Then
                            If .Frame = 43 Then
                                .Frame = 1
                            ElseIf .Frame = 44 Then
                                .Frame = 2
                            Else
                                .Frame = 5
                            End If
                            
                        End If
                        
                    Else
                        If .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope > 0 Or (.Quicksand > 0 And .Location.SpeedY > 0) Then
                            If .Location.SpeedX > 0 And (.Controls.Left = True Or (.Direction = -1 And .Bumped = True)) And .Effect = 0 And .Duck = False And .Quicksand = 0 Then
                                If LevelSelect = False Then
                                    If Not .Mount = 2 And .Wet = 0 Then
                                        PlaySound 10
                                        If .SlideCounter <= 0 Then
                                            .SlideCounter = 2 + Rnd * 2
                                            tempLocation.Y = .Location.Y + .Location.Height - 5
                                            tempLocation.X = .Location.X + .Location.Width / 2 - 4 + 6 * -.Direction
                                            NewEffect 74, tempLocation, , , ShadowMode
                                        End If
                                    End If
                                    .Frame = 6
                                End If
                            ElseIf .Location.SpeedX < 0 And (.Controls.Right = True Or (.Direction = 1 And .Bumped = True)) And .Effect = 0 And .Duck = False And .Quicksand = 0 Then
                                If LevelSelect = False Then
                                    If Not .Mount = 2 And .Wet = 0 Then
                                        PlaySound 10
                                        If .SlideCounter <= 0 Then
                                            .SlideCounter = 2 + Rnd * 2
                                            tempLocation.Y = .Location.Y + .Location.Height - 5
                                            tempLocation.X = .Location.X + .Location.Width / 2 - 4 + 10 * -.Direction
                                            NewEffect 74, tempLocation, , , ShadowMode
                                        End If
                                    End If
                                    .Frame = 6
                                End If
                            Else
                                If .Location.SpeedX <> 0 And Not (.Slippy = True And .Controls.Left = False And .Controls.Right = False) Then
                                    .FrameCount = .FrameCount + 1
                                    If .Location.SpeedX >= Physics.PlayerWalkSpeed Or .Location.SpeedX <= -Physics.PlayerWalkSpeed Then .FrameCount = .FrameCount + 1
                                    If .Location.SpeedX > Physics.PlayerWalkSpeed + 1.5 Or .Location.SpeedX < -Physics.PlayerWalkSpeed - 1.5 Then .FrameCount = .FrameCount + 1
                                    If .FrameCount >= 5 And .FrameCount < 10 Then
                                        If .CanFly = True And .Character <> 3 Then
                                            .Frame = 16
                                        Else
                                            .Frame = 1
                                        End If
                                    ElseIf .FrameCount >= 10 And .FrameCount < 15 Then
                                        If .CanFly = True And .Character <> 3 Then
                                            .Frame = 17
                                        Else
                                            .Frame = 2
                                        End If
                                    ElseIf .FrameCount >= 15 And .FrameCount < 20 Then
                                        If .CanFly = True And .Character <> 3 Then
                                            .Frame = 18
                                        Else
                                            .Frame = 3
                                        End If
                                    ElseIf .FrameCount >= 20 Then
                                        .FrameCount = .FrameCount - 20
                                        If .CanFly = True And .Character <> 3 Then
                                            .Frame = 17
                                        Else
                                            .Frame = 2
                                        End If
                                    End If
                                Else
                                    .Frame = 1
                                    .FrameCount = 0
                                End If
                            End If
                        Else
                            If .CanFly2 = True Then
                                If .Controls.Jump = False And .Controls.AltJump = False Then
                                    If .Location.SpeedY < 0 Then
                                        .Frame = 19
                                    Else
                                        .Frame = 21
                                    End If
                                Else
                                    .FrameCount = .FrameCount + 1
                                    If Not (.Frame = 19 Or .Frame = 20 Or .Frame = 21) Then .Frame = 19
                                    If .FrameCount >= 5 Then
                                        .FrameCount = 0
                                        If .Frame = 19 Then
                                            .Frame = 20
                                        ElseIf .Frame = 20 Then
                                            .Frame = 21
                                        Else
                                            .Frame = 19
                                        End If
                                    End If
                                End If
                            Else
                                If .Location.SpeedY < 0 Then
                                    .Frame = 4
                                Else
                                    If (.State = 4 Or .State = 5) And .Controls.Jump = True And Not (.Character = 3 Or .Character = 4) Then
                                        .FrameCount = .FrameCount + 1
                                        If Not (.Frame = 3 Or .Frame = 5 Or .Frame = 11) Then .Frame = 11
                                        If .FrameCount >= 5 Then
                                            .FrameCount = 0
                                            If .Frame = 11 Then
                                                .Frame = 3
                                            ElseIf .Frame = 3 Then
                                                .Frame = 5
                                            Else
                                                .Frame = 11
                                            End If
                                        End If
                                    Else
                                        .Frame = 5
                                    End If
                                End If
                            End If
                        End If
                        If .Duck = True Then
                            .Frame = 7
                        End If
                    End If
                Else
                    If .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope > 0 Then
                        If .Mount <> 2 And ((.Controls.Left = True And .Location.SpeedX > 0) Or (.Controls.Right = True And .Location.SpeedX < 0)) And .Effect = 0 And .Duck = False Then
                            PlaySound 10
                            If .SlideCounter <= 0 Then
                                .SlideCounter = 2 + Rnd * 2
                                tempLocation.Y = .Location.Y + .Location.Height - 5
                                tempLocation.X = .Location.X + .Location.Width / 2 - 4 + 10 * -.Direction
                                NewEffect 74, tempLocation, , , ShadowMode
                            End If
                        End If
                        If .Location.SpeedX <> 0 Then
                            .FrameCount = .FrameCount + 1
                            If .Location.SpeedX > Physics.PlayerWalkSpeed Or .Location.SpeedX < -Physics.PlayerWalkSpeed Then .FrameCount = .FrameCount + 1
                            If .FrameCount >= 5 And .FrameCount < 10 Then
                                .Frame = 8
                            ElseIf .FrameCount >= 10 And .FrameCount < 15 Then
                                .Frame = 9
                            ElseIf .FrameCount >= 15 And .FrameCount < 20 Then
                                .Frame = 10
                            ElseIf .FrameCount >= 20 Then
                                .FrameCount = 0
                                .Frame = 9
                            End If
                        Else
                            .Frame = 8
                            .FrameCount = 0
                        End If
                    Else
                        .Frame = 10
                        If .Character = 3 Then .Frame = 9
                    End If
                End If
            End If
            If .Mount = 1 Then 'Goomba's Shoe
                .MountOffsetY = -.Location.SpeedY / 2
                If .Duck = True Or .StandingOnNPC <> 0 Then .MountOffsetY = 0
                If .Direction = 1 Then
                    .MountFrame = 2 + SpecialFrame(1)
                Else
                    .MountFrame = 0 + SpecialFrame(1)
                End If
                .Frame = 1
            ElseIf .Mount = 2 Then 'Koopa Clown Car
                .Frame = 1
                .MountFrame = SpecialFrame(2)
                If .Direction = 1 Then .MountFrame = .MountFrame + 4
            ElseIf .Mount = 3 Then 'Green Yoshi
                .YoshiBY = 42
                .YoshiBX = 0
                .YoshiTY = 10
                .YoshiTX = 20
                .Frame = 30
                .YoshiBFrame = 0
                .YoshiTFrame = 0
                .MountOffsetY = 0
                If .Location.SpeedY < 0 And .StandingOnNPC = 0 And .Slope = 0 Then
                    .YoshiBFrame = 3
                    .YoshiTFrame = 2
                ElseIf .Location.SpeedY > 0 And .StandingOnNPC = 0 And .Slope = 0 Then
                    .YoshiBFrame = 2
                    .YoshiTFrame = 0
                Else
                    If .Location.SpeedX <> 0 Then
                        If .Effect = 0 Then .YoshiBFrameCount = .YoshiBFrameCount + 1 + (Abs(.Location.SpeedX * 0.7))
                        If (.Direction = -1 And .Location.SpeedX > 0) Or (.Direction = 1 And .Location.SpeedX < 0) Then
                            .YoshiBFrameCount = 24
                        End If
                        If .YoshiBFrameCount < 0 Then .YoshiBFrameCount = 0
                        If .YoshiBFrameCount > 32 Then
                            .YoshiBFrame = 0
                            .YoshiBFrameCount = 0
                        ElseIf .YoshiBFrameCount > 24 Then
                            .YoshiBFrame = 1
                            .YoshiTX = .YoshiTX - 1
                            .YoshiTY = .YoshiTY + 2
                            .YoshiBY = .YoshiBY + 1
                            .MountOffsetY = .MountOffsetY + 1
                        ElseIf .YoshiBFrameCount > 16 Then
                            .YoshiBFrame = 2
                            .YoshiTX = .YoshiTX - 2
                            .YoshiTY = .YoshiTY + 4
                            .YoshiBY = .YoshiBY + 2
                            .MountOffsetY = .MountOffsetY + 2
                        ElseIf .YoshiBFrameCount > 8 Then
                            .YoshiBFrame = 1
                            .YoshiTX = .YoshiTX - 1
                            .YoshiTY = .YoshiTY + 2
                            .YoshiBY = .YoshiBY + 1
                            .MountOffsetY = .MountOffsetY + 1
                        Else
                            .YoshiBFrame = 0
                        End If
                    Else
                        .YoshiBFrameCount = 0
                    End If
                End If
                If .MountSpecial = 1 Then
                    If .Controls.Up = True Or (.StandingOnNPC = 0 And .Location.SpeedY <> 0 And .Slope = 0 And .Controls.Down = False) Then
                        '.YoshiBFrame = 0
                        .YoshiTFrame = 3
                        .MountOffsetY = .MountOffsetY
                        .YoshiTongue.Y = .YoshiTongue.Y + .MountOffsetY
                    Else
                        'defaults
                        .YoshiBY = 42
                        .YoshiBX = 0
                        .YoshiTY = 10
                        .YoshiTX = 20
                        .YoshiBFrame = 5
                        .YoshiTFrame = 4
                        .YoshiBY = .YoshiBY + 8
                        .YoshiTY = .YoshiTY + 24
                        .YoshiTX = .YoshiTX + 12
                        .MountOffsetY = 0
                        .MountOffsetY = .MountOffsetY + 8
                    End If
                End If
                If .Duck = True Then
                    .Frame = 31
                    If .MountSpecial = 0 Then .YoshiBFrame = 6
                    .YoshiBFrameCount = 0
                End If
                If .YoshiTFrameCount > 0 Then
                    If .YoshiNPC = 0 And .YoshiPlayer = 0 Then .YoshiTFrameCount = .YoshiTFrameCount + 1
                    If .YoshiTFrameCount < 10 Then
                        .YoshiTFrame = 1
                    ElseIf .YoshiTFrameCount < 20 Then
                        .YoshiTFrame = 2
                    Else
                        .YoshiTFrameCount = 0
                    End If
                ElseIf .YoshiTFrameCount < 0 Then
                    .YoshiTFrameCount = .YoshiTFrameCount - 1
                    If .YoshiTFrameCount > -10 Then
                        .YoshiTFrame = 3
                    Else
                        .YoshiTFrameCount = 0
                    End If
                End If
                If .Direction = 1 Then
                    .YoshiTFrame = .YoshiTFrame + 5
                    .YoshiBFrame = .YoshiBFrame + 7
                Else
                    .YoshiBX = -.YoshiBX
                    .YoshiTX = -.YoshiTX
                End If
                If .Duck = False Or .MountSpecial > 0 Then
                    .MountOffsetY = .MountOffsetY - (72 - .Location.Height)
                    .YoshiBY = .YoshiBY - (72 - .Location.Height)
                    .YoshiTY = .YoshiTY - (72 - .Location.Height)
                Else
                    .MountOffsetY = .MountOffsetY - (64 - .Location.Height)
                    .YoshiBY = .YoshiBY - (64 - .Location.Height)
                    .YoshiTY = .YoshiTY - (64 - .Location.Height)
                End If
                .YoshiBX = .YoshiBX - 4
                .YoshiTX = .YoshiTX - 4
                If .YoshiBlue = True Then
                    If .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Then
                        .YoshiWingsFrame = 1
                    ElseIf .Location.SpeedY < 0 Then
                        .YoshiWingsFrameCount = .YoshiWingsFrameCount + 1
                        If .YoshiWingsFrameCount < 6 Then
                            .YoshiWingsFrame = 1
                        ElseIf .YoshiWingsFrameCount < 12 Then
                            .YoshiWingsFrame = 0
                        Else
                            .YoshiWingsFrameCount = 0
                            .YoshiWingsFrame = 0
                        End If
                    Else
                        .YoshiWingsFrameCount = .YoshiWingsFrameCount + 1
                        If .YoshiWingsFrameCount < 12 Then
                            .YoshiWingsFrame = 1
                        ElseIf .YoshiWingsFrameCount < 24 Then
                            .YoshiWingsFrame = 0
                        Else
                            .YoshiWingsFrameCount = 0
                            .YoshiWingsFrame = 0
                        End If
                    End If
                    If .GroundPound = True Then .YoshiWingsFrame = 0
                    If .Direction = 1 Then .YoshiWingsFrame = .YoshiWingsFrame + 2
                End If
            End If
        End If
    If .Mount = 1 And .MountType = 3 Then
        If .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Then
            .YoshiWingsFrame = 1
        ElseIf .Location.SpeedY < 0 Then
            .YoshiWingsFrameCount = .YoshiWingsFrameCount + 1
            If .YoshiWingsFrameCount < 6 Then
                .YoshiWingsFrame = 1
            ElseIf .YoshiWingsFrameCount < 12 Then
                .YoshiWingsFrame = 0
            Else
                .YoshiWingsFrameCount = 0
                .YoshiWingsFrame = 0
            End If
        Else
            .YoshiWingsFrameCount = .YoshiWingsFrameCount + 1
            If .YoshiWingsFrameCount < 12 Then
                .YoshiWingsFrame = 1
            ElseIf .YoshiWingsFrameCount < 24 Then
                .YoshiWingsFrame = 0
            Else
                .YoshiWingsFrameCount = 0
                .YoshiWingsFrame = 0
            End If
        End If
        If .GroundPound = True Then .YoshiWingsFrame = 0
        If .Direction = 1 Then .YoshiWingsFrame = .YoshiWingsFrame + 2
    End If
  
    End With
End Sub

Public Sub UpdatePlayerBonus(A As Integer, B As Integer)
    '1 player growing
    '4 fire flower
    '5 leaf
    With Player(A)
        If Not .State = 1 Or (.Effect = 1 Or .Effect = 4 Or .Effect = 5) Then
            If B = 9 Or B = 185 Or B = 184 Or B = 250 Then
                If .HeldBonus = 0 Then .HeldBonus = B
            ElseIf (.State = 2 Or .Effect = 1) And Not (.Effect = 4 Or .Effect = 5) Then
                If .HeldBonus = 0 Then
                    If .StateNPC = 184 Then
                        .HeldBonus = 184
                    ElseIf .StateNPC = 185 Then
                        .HeldBonus = 185
                    Else
                        .HeldBonus = 9
                    End If
                End If
            Else
                If .State = 3 Or .Effect = 4 Then
                    If .StateNPC = 183 Then
                        .HeldBonus = 183
                    ElseIf .StateNPC = 182 Then
                        .HeldBonus = 182
                    Else
                        .HeldBonus = 14
                    End If
                End If
                If .State = 4 Or .Effect = 5 Then .HeldBonus = 34
                If .State = 5 Or .Effect = 11 Then .HeldBonus = 169
                If .State = 6 Or .Effect = 12 Then .HeldBonus = 170
                If .State = 7 Or .Effect = 41 Then
                    If .StateNPC = 277 Then
                        .HeldBonus = 277
                    Else
                        .HeldBonus = 264
                    End If
                End If
            End If
        End If
        If .Character = 3 Or .Character = 4 Or .Character = 5 Then .HeldBonus = 0
    End With
End Sub

Public Sub TailSwipe(plr As Integer, Optional bool As Boolean = False, Optional Stab As Boolean = False, Optional StabDir As Integer = 0)  'for whacking something with the tail
    Dim tailLoc As Location
    Dim tempLoc As Location
    Dim stabLoc As Location
    Dim oldNPC As NPC
    Dim A As Integer
    Dim B As Long
    Dim C As Integer
    Dim fBlock As Integer
    Dim lBlock As Integer
    With Player(plr)
        If Stab = True Then
            If .Duck = False Then
                If StabDir = 1 Then
                    tailLoc.Width = 6
                    tailLoc.Height = 14
                    tailLoc.Y = .Location.Y - tailLoc.Height
                    If .Direction = 1 Then
                        tailLoc.X = .Location.X + .Location.Width - 4
                    Else
                        tailLoc.X = .Location.X - tailLoc.Width + 4
                    End If
                ElseIf StabDir = 2 Then
                    'tailLoc.Width = 8
                    tailLoc.Height = 8
                    If Player(plr).Location.SpeedY >= 10 Then
                        tailLoc.Height = 12
                    ElseIf Player(plr).Location.SpeedY >= 8 Then
                        tailLoc.Height = 10
                    End If
                    tailLoc.Y = .Location.Y + .Location.Height
                    'tailLoc.X = .Location.X + .Location.Width / 2 - tailLoc.Width / 2 + (2 * .Direction)
                    tailLoc.Width = .Location.Width - 2
                    tailLoc.X = .Location.X + 1
                Else
                    tailLoc.Width = 38
                    tailLoc.Height = 6
                    tailLoc.Y = .Location.Y + .Location.Height - 42
                    If .Direction = 1 Then
                        tailLoc.X = .Location.X + .Location.Width
                    Else
                        tailLoc.X = .Location.X - tailLoc.Width
                    End If
                End If
            Else
                tailLoc.Width = 38
                tailLoc.Height = 8
                tailLoc.Y = .Location.Y + .Location.Height - 22
                If .Direction = 1 Then
                    tailLoc.X = .Location.X + .Location.Width
                Else
                    tailLoc.X = .Location.X - tailLoc.Width
                End If
            End If
        Else
            tailLoc.Width = 18
            tailLoc.Height = 12
            tailLoc.Y = .Location.Y + .Location.Height - 26
            If .Direction = 1 Then
                tailLoc.X = .Location.X + .Location.Width
            Else
                tailLoc.X = .Location.X - tailLoc.Width
            End If
        End If
    End With
    If Player(plr).Character = 4 Then 'move tail down for toad
     tailLoc.Y = tailLoc.Y + 4
    End If
    If bool = True Then 'the bool flag means hit a block
        fBlock = FirstBlock((tailLoc.X / 32) - 1)
        lBlock = LastBlock(((tailLoc.X + tailLoc.Width) / 32) + 1)
        For A = fBlock To lBlock
            With Block(A)
                If Not BlockIsSizable(.Type) And .Hidden = False And (.Type <> 293 Or Stab = True) And .Invis = False And BlockNoClipping(.Type) = False Then
                    If CheckCollision(tailLoc, .Location) = True Then
                        If .ShakeY = 0 And .ShakeY2 = 0 And .ShakeY3 = 0 Then
                            If .Special > 0 Or .Type = 55 Or .Type = 159 Or .Type = 90 Then PlaySound 3
                            If nPlay.Online = True And plr - 1 = nPlay.MySlot Then
                                Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1g" & plr & "|" & Player(plr).TailCount - 1
                            End If
                            UpdateGraphics
                            If StabDir = 2 Then
                                BlockHit A, True, plr
                            Else
                                BlockHit A, False, plr
                            End If
                            BlockHitHard A
                            If Stab = False Then
                                If Block(A).ShakeY <> 0 Then
                                    tempLoc.X = (Block(A).Location.X + tailLoc.X + (Block(A).Location.Width + tailLoc.Width) / 2) / 2 - 16
                                    tempLoc.Y = (Block(A).Location.Y + tailLoc.Y + (Block(A).Location.Height + tailLoc.Height) / 2) / 2 - 16
                                    NewEffect 73, tempLoc
                                End If
                                Exit For
                            Else
                                If StabDir = 2 Then
                                    If .Type = 293 Or .Type = 370 Or .ShakeY <> 0 Or .ShakeY2 <> 0 Or .ShakeY3 <> 0 Or .Hidden = True Or BlockHurts(.Type) Then
                                        If BlockHurts(.Type) Then PlaySound 24
                                        Player(plr).Location.Y = Player(plr).Location.Y - 0.1
                                        Player(plr).Location.SpeedY = Physics.PlayerJumpVelocity
                                        Player(plr).StandingOnNPC = 0
                                        If Player(plr).Controls.Jump = True Or Player(plr).Controls.AltJump = True Then Player(plr).Jump = 10
                                    End If
                                End If
                                If .Type = 370 Then
                                    PlaySound 88
                                    .Hidden = True
                                    .Layer = "Destroyed Blocks"
                                    NewEffect 10, .Location
                                    Effect(numEffects).Location.SpeedY = -2
                                End If
                                If .Type = 457 And Player(plr).State = 6 Then KillBlock A
                                                    
                            End If
                        End If
                    End If
                End If
            End With
        Next A
    End If
    For A = 1 To numNPCs
        With NPC(A)
            If .Active = True And .Effect = 0 And Not (NPCIsAnExit(.Type) Or (NPCIsACoin(.Type) And Stab = False)) And .CantHurtPlayer <> plr And Not (Player(plr).StandingOnNPC = A And Player(plr).ShellSurf = True) Then
                If .Type <> 13 And .Type <> 265 And Not (.Type = 17 And .Projectile = True) And .Type <> 108 And .Type <> 197 And .Type <> 192 Then
                    stabLoc = NPC(A).Location
                    If NPCHeightGFX(.Type) > .Location.Height And .Type <> 8 And .Type <> 15 And .Type <> 205 And .Type <> 9 And .Type <> 51 And .Type <> 52 And .Type <> 74 And .Type <> 93 And .Type <> 245 Then
                        stabLoc.Y = stabLoc.Y + stabLoc.Height
                        stabLoc.Height = NPCHeightGFX(.Type)
                        stabLoc.Y = stabLoc.Y - stabLoc.Height
                    End If
                    If .Type = 91 And Stab = True Then
                        stabLoc.Y = stabLoc.Y - stabLoc.Height
                    End If
                    If CheckCollision(tailLoc, stabLoc) = True And NPC(A).Killed = 0 And NPC(A).TailCD = 0 And Not (StabDir <> 0 And .Type = 91) Then
                        oldNPC = NPC(A)
                        If Stab = True Then
                            B = NPC(A).Damage
                            C = NPC(A).Type
                            If StabDir = 2 And ((.Type >= 154 And .Type <= 157) Or .Type = 26 Or .Type = 32 Or .Type = 238 Or .Type = 241) Then
                            Else
                                If .Type = 45 And StabDir <> 0 Then
                                    .Special = 1
                                    .Projectile = True
                                    NPCHit A, 3, A
                                    Player(plr).Location.SpeedY = Physics.PlayerJumpVelocity
                                    Player(plr).StandingOnNPC = 0
                                    If Player(plr).Controls.Jump = True Or Player(plr).Controls.AltJump = True Then Player(plr).Jump = 10
                                Else
                                    NPCHit A, 10, plr
                                End If
                                If StabDir = 2 And (NPC(A).Killed = 10 Or NPC(A).Damage <> B Or NPC(A).Type <> C) Then
                                    Player(plr).Location.SpeedY = Physics.PlayerJumpVelocity
                                    Player(plr).StandingOnNPC = 0
                                    If Player(plr).Controls.Jump = True Or Player(plr).Controls.AltJump = True Then Player(plr).Jump = 10
                                End If
                            End If
                        Else
                            NPCHit A, 7, plr
                            If NPC(A).Killed > 0 Or NPC(A).Type <> oldNPC.Type Or NPC(A).Projectile <> oldNPC.Projectile Or (NPC(A).Location.SpeedY <> oldNPC.Location.SpeedY) Then
                                If nPlay.Online = True And plr - 1 = nPlay.MySlot Then
                                    Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1g" & plr & "|" & Player(plr).TailCount - 1
                                End If
                                tempLoc.X = (NPC(A).Location.X + tailLoc.X + (NPC(A).Location.Width + tailLoc.Width) / 2) / 2 - 16
                                tempLoc.Y = (NPC(A).Location.Y + tailLoc.Y + (NPC(A).Location.Height + tailLoc.Height) / 2) / 2 - 16
                                NPC(A).BattleOwner = plr
                                NewEffect 73, tempLoc
                            End If
                        End If
                        NPC(A).TailCD = 8
                    End If
                End If
            End If
        End With
    Next A
    
    If BattleMode = True Then
        For A = 1 To numPlayers
            If A <> plr Then
                With Player(A)
                    stabLoc = Player(A).Location
                    If CheckCollision(tailLoc, stabLoc) = True And Player(A).Effect = 0 And Player(A).Immune = 0 And Player(A).Dead = False And Player(A).TimeToLive = 0 Then
                        If Stab = True Then
                            If StabDir = 2 Then
                                Player(plr).Location.SpeedY = Physics.PlayerJumpVelocity
                                Player(plr).StandingOnNPC = 0
                                If Player(plr).Controls.Jump = True Or Player(plr).Controls.AltJump = True Then Player(plr).Jump = 10
                            End If
                            PlayerHurt A
                            PlaySound 89
                        Else
                            .Location.SpeedX = 6 * Player(plr).Direction
                            .Location.SpeedY = -5
                            PlaySound 2
                        End If
                    End If
                End With
            End If
        Next A
    End If
    
    If Stab = False Then
        With tailLoc
            If (Player(plr).TailCount Mod 10 = 0 And Player(plr).SpinJump = False) Or (Player(plr).TailCount Mod 5 = 0 And Player(plr).SpinJump = True) Then
                NewEffect 80, newLoc(.X + Rnd * .Width - 4, .Y + Rnd * .Height), , , ShadowMode
                Effect(numEffects).Location.SpeedX = (0.5 + Rnd * 1) * Player(plr).Direction
                Effect(numEffects).Location.SpeedY = Rnd * 1 - 0.5
            End If
        End With
    End If
End Sub

Public Sub YoshiHeight(A As Integer) 'fix the players height when on a yoshi
    With Player(A)
        If .Mount = 3 Then
            .Location.Y = .Location.Y + .Location.Height
            If .State = 1 Then
                .Location.Height = 54
            Else
                .Location.Height = 60
            End If
            .Location.Y = .Location.Y - .Location.Height
        End If
    End With
End Sub

Public Sub YoshiEat(A As Integer)
    Dim B As Integer
    Dim tempLocation As Location
    With Player(A)
        For B = 1 To numPlayers
            If B <> A And Player(B).Effect = 0 And Player(B).Dead = False And Player(B).TimeToLive = 0 And Player(B).Mount = 0 Then
                If CheckCollision(.YoshiTongue, Player(B).Location) = True Then
                    .YoshiPlayer = B
                    Player(B).HoldingNPC = 0
                    Exit Sub
                End If
            End If
        Next B
        For B = 1 To numNPCs
            If ((NPCIsACoin(NPC(B).Type) And NPC(B).Special = 1) Or NPCNoYoshi(NPC(B).Type) = False) And NPC(B).Active = True And ((NPCIsACoin(NPC(B).Type) = False Or NPC(B).Special = 1) Or NPC(B).Type = 103) And NPCIsAnExit(NPC(B).Type) = False And NPC(B).Generator = False And NPC(B).Inert = False And NPCIsYoshi(NPC(B).Type) = False And NPC(B).Effect <> 5 And NPC(B).Immune = 0 And NPC(B).Type <> 91 And Not (NPC(B).Projectile = True And NPC(B).Type = 17) And NPC(B).HoldingPlayer = 0 Then
                tempLocation = NPC(B).Location
                If NPC(B).Type = 91 Then
                    tempLocation.Y = NPC(B).Location.Y - 16
                End If
                If CheckCollision(.YoshiTongue, tempLocation) Then
                    If NPC(B).Type = 91 Then
                        If NPCNoYoshi(NPC(B).Special) = False Then
                            PlaySound 23
                            With NPC(B)
                                .Generator = False
                                .Frame = 0
                                .Type = .Special
                                .Special = 0
                                If NPCIsYoshi(.Type) Then
                                    .Special = .Type
                                    .Type = 96
                                End If
                                .Location.Height = NPCHeight(.Type)
                                .Location.Width = NPCWidth(.Type)
                                If Not (.Type = 21 Or .Type = 22 Or .Type = 26 Or .Type = 31 Or .Type = 32 Or .Type = 35 Or .Type = 49 Or NPCIsAnExit(.Type)) Then
                                    .DefaultType = 0
                                End If
                            End With
                            NPC(B).Effect = 5
                            NPC(B).Effect2 = A
                            .YoshiNPC = B
                        End If
                    ElseIf NPC(B).Type = 283 Then
                        NPCHit B, 3, B
                    Else
                        NPC(B).Effect = 5
                        NPC(B).Effect2 = A
                        NPC(B).Location.Height = NPCHeight(NPC(B).Type)
                        .YoshiNPC = B
                    End If
                    If NPC(B).Type = 147 Then
                        NPC(B).Type = 139 + Int(Rnd * 9)
                        If NPC(B).Type = 147 Then NPC(B).Type = 92
                        NPC(B).Location.X = NPC(B).Location.X + NPC(B).Location.Width / 2
                        NPC(B).Location.Y = NPC(B).Location.Y + NPC(B).Location.Height / 2
                        NPC(B).Location.Width = NPCWidth(NPC(B).Type)
                        NPC(B).Location.Height = NPCHeight(NPC(B).Type)
                        NPC(B).Location.X = NPC(B).Location.X - NPC(B).Location.Width / 2
                        NPC(B).Location.Y = NPC(B).Location.Y - NPC(B).Location.Height / 2
                    End If
                    Exit For
                End If
            End If
        Next B
    End With
End Sub

Public Sub YoshiSpit(A As Integer)
    Dim B As Integer
    With Player(A)
        If nPlay.Online = True And A - 1 = nPlay.MySlot Then
            Netplay.sendData Netplay.PutPlayerControls(nPlay.MySlot)
        End If
        .YoshiTFrameCount = -1
        If .YoshiPlayer > 0 Then
            Player(.YoshiPlayer).Section = .Section
            Player(.YoshiPlayer).Effect = 0
            Player(.YoshiPlayer).Effect2 = 0
            Player(.YoshiPlayer).Slide = True
            If Player(.YoshiPlayer).State > 1 Then
                Player(.YoshiPlayer).Location.Height = Physics.PlayerDuckHeight(Player(.YoshiPlayer).Character, Player(.YoshiPlayer).State)
                'Player(.YoshiPlayer).Location.Y = Player(.YoshiPlayer).Location.Y - Physics.PlayerDuckHeight(Player(.YoshiPlayer).Character, Player(.YoshiPlayer).State) + Physics.PlayerHeight(Player(.YoshiPlayer).Character, Player(.YoshiPlayer).State)
                'Player(.YoshiPlayer).Duck = True
            End If
            If .Controls.Down = True Then
                Player(.YoshiPlayer).Location.X = .Location.X + .YoshiTX + Player(.YoshiPlayer).Location.Width * .Direction
                Player(.YoshiPlayer).Location.X = Player(.YoshiPlayer).Location.X + 5
                Player(.YoshiPlayer).Location.Y = .Location.Y + .Location.Height - Player(.YoshiPlayer).Location.Height
                Player(.YoshiPlayer).Location.SpeedX = 0 + .Location.SpeedX * 0.3
                Player(.YoshiPlayer).Location.SpeedY = 1 + .Location.SpeedY * 0.3
            Else
                Player(.YoshiPlayer).Location.X = .Location.X + .YoshiTX + Player(.YoshiPlayer).Location.Width * .Direction
                Player(.YoshiPlayer).Location.X = Player(.YoshiPlayer).Location.X + 5
                Player(.YoshiPlayer).Location.Y = .Location.Y + 1
                Player(.YoshiPlayer).Location.SpeedX = 7 * .Direction + .Location.SpeedX * 0.3
                Player(.YoshiPlayer).Location.SpeedY = -3 + .Location.SpeedY * 0.3
            End If
            Player(.YoshiPlayer).Direction = -.Direction
            Player(.YoshiPlayer).Bumped = True
            If .Direction = 1 Then
                PlayerPush .YoshiPlayer, 2
            Else
                PlayerPush .YoshiPlayer, 4
            End If
            .YoshiPlayer = 0
            PlaySound 38
        Else
            NPC(.YoshiNPC).RealSpeedX = 0
            If NPCIsAShell(NPC(.YoshiNPC).Type) Then NPC(.YoshiNPC).Special = 0
            If (NPCIsAShell(NPC(.YoshiNPC).Type) Or NPCIsABot(NPC(.YoshiNPC).Type) Or NPC(.YoshiNPC).Type = 194) And Not NPC(.YoshiNPC).Type = 24 And .YoshiRed = True Then
                NPC(.YoshiNPC).Killed = 9
                PlaySound 42
                For B = 1 To 3
                    numNPCs = numNPCs + 1
                    NPC(numNPCs).Direction = .Direction
                    NPC(numNPCs).Type = 108
                    NPC(numNPCs).Frame = EditorNPCFrame(NPC(numNPCs).Type, NPC(numNPCs).Direction)
                    NPC(numNPCs).Active = True
                    NPC(numNPCs).Section = .Section
                    NPC(numNPCs).TimeLeft = 100
                    NPC(numNPCs).Effect = 0
                    NPC(numNPCs).Location.X = .Location.X + .YoshiTX + 32 * .Direction
                    NPC(numNPCs).Location.Y = .Location.Y + .YoshiTY
                    NPC(numNPCs).Location.Width = 32
                    NPC(numNPCs).Location.Height = 32
                    If B = 1 Then
                        NPC(numNPCs).Location.SpeedY = -0.8
                        NPC(numNPCs).Location.SpeedX = 5 * .Direction
                    ElseIf B = 2 Then
                        NPC(numNPCs).Location.SpeedY = 0
                        NPC(numNPCs).Location.SpeedX = 5.5 * .Direction
                    Else
                        NPC(numNPCs).Location.SpeedY = 0.8
                        NPC(numNPCs).Location.SpeedX = 5 * .Direction
                    End If
                Next B
            Else
                NPC(.YoshiNPC).Direction = .Direction
                NPC(.YoshiNPC).Frame = 0
                NPC(.YoshiNPC).WallDeath = 5
                NPC(.YoshiNPC).FrameCount = 0
                NPC(.YoshiNPC).Frame = EditorNPCFrame(NPC(.YoshiNPC).Type, NPC(.YoshiNPC).Direction)
                NPC(.YoshiNPC).Active = True
                NPC(.YoshiNPC).Section = .Section
                NPC(.YoshiNPC).TimeLeft = 100
                NPC(.YoshiNPC).Effect = 0
                NPC(.YoshiNPC).Effect2 = 0
                NPC(.YoshiNPC).Location.X = .Location.X + .YoshiTX + 32 * .Direction
                NPC(.YoshiNPC).Location.Y = .Location.Y + .YoshiTY
                If .Duck = True Then NPC(.YoshiNPC).Location.Y = NPC(.YoshiNPC).Location.Y - 8
                NPC(.YoshiNPC).Location.Y = NPC(.YoshiNPC).Location.Y - 2
                NPC(.YoshiNPC).Location.SpeedX = 0
                NPC(.YoshiNPC).Location.SpeedY = 0
                
                
                
                If NPC(.YoshiNPC).Type = 45 Then NPC(.YoshiNPC).Special = 1
                PlaySound 38
                If .Controls.Down = False Or (.Location.SpeedY <> 0 And .StandingOnNPC = 0 And .Slope = 0) Then
                    If NPCIsAShell(NPC(.YoshiNPC).Type) Then
                        SoundPause(9) = 2
                        'NPCHit .YoshiNPC, 1, A
                        NPC(.YoshiNPC).Location.SpeedX = Physics.NPCShellSpeed * .Direction
                    ElseIf NPC(.YoshiNPC).Type = 45 Then
                        NPC(.YoshiNPC).Location.SpeedX = Physics.NPCShellSpeed * .Direction
                    Else
                        NPC(.YoshiNPC).Projectile = True
                        NPC(.YoshiNPC).Location.SpeedX = 7 * .Direction
                        NPC(.YoshiNPC).Location.SpeedY = -1.3
                    End If
                End If
                If NPC(.YoshiNPC).Type = 237 Then
                    NPC(.YoshiNPC).Direction = Player(A).Direction
                    NPC(.YoshiNPC).Projectile = True
                    NPC(.YoshiNPC).Location.SpeedX = Physics.NPCShellSpeed * .Direction * 0.6 + Player(A).Location.SpeedX * 0.4
                    NPC(.YoshiNPC).TurnAround = False
                End If
            End If
        End If
        .FireBallCD = 20
        .YoshiNPC = 0
        .YoshiRed = False
        If .YoshiBlue = True Then
            .CanFly = False
            .CanFly2 = False
        End If
        .YoshiBlue = False
        .YoshiYellow = False
    End With
End Sub

Public Sub YoshiPound(A As Integer, C As Integer, Optional BreakBlocks As Boolean = False)
    Dim B As Integer
    Dim tempLocation As Location
    Dim tempLocation2 As Location
    With Player(A)
        If .Location.SpeedY > 3 Then
            
            tempLocation.Width = 128
            tempLocation.X = .Location.X + .Location.Width / 2 - tempLocation.Width / 2
            tempLocation.Height = 32
            tempLocation.Y = .Location.Y + .Location.Height - 16

            For B = 1 To numNPCs
                If NPC(B).Hidden = False And NPC(B).Active = True And NPC(B).Effect = 0 Then
                    tempLocation2 = NPC(B).Location
                    tempLocation2.Y = tempLocation2.Y + tempLocation2.Height - 4
                    tempLocation2.Height = 8
                    If CheckCollision(tempLocation, tempLocation2) = True Then
                        Block(0).Location.Y = NPC(B).Location.Y + NPC(B).Location.Height
                        NPCHit B, 2, 0
                    End If
                End If
            Next B
            
            
            If BreakBlocks = True Then
                For B = 1 To numBlock
                    If Block(B).Hidden = False And Block(B).Invis = False And BlockNoClipping(Block(B).Type) = False And BlockIsSizable(Block(B).Type) = False Then
                        If CheckCollision(Player(A).Location, Block(B).Location) = True Then
                            BlockHit B, True, A
                            BlockHitHard B
                        End If
                    End If
                Next B
            End If
            tempLocation.Width = 32
            tempLocation.Height = 32
            tempLocation.Y = .Location.Y + .Location.Height - 16
            tempLocation.X = .Location.X + .Location.Width / 2 - 16 - 16
            NewEffect 10, tempLocation
            Effect(numEffects).Location.SpeedX = -2
            tempLocation.X = .Location.X + .Location.Width / 2 - 16 + 16
            NewEffect 10, tempLocation
            Effect(numEffects).Location.SpeedX = 2
            PlaySound 37
        End If
    End With
End Sub

Public Sub SwapCoop()
    If SingleCoop = 1 Then
        If Player(2).Dead = True Or Player(2).TimeToLive > 0 Then Exit Sub
        SingleCoop = 2
    Else
        If Player(1).Dead = True Or Player(1).TimeToLive > 0 Then Exit Sub
        SingleCoop = 1
    End If
    Player(1).DropRelease = False
    Player(1).Controls.Drop = True
    Player(2).DropRelease = False
    Player(2).Controls.Drop = True
    PlaySound 13

    Player(SingleCoop).Immune = 50
    If curMusic >= 0 And curMusic <> bgMusic(Player(SingleCoop).Section) Then
        StopMusic
        StartMusic Player(SingleCoop).Section
    End If
End Sub

Public Sub PlayerPush(A As Integer, HitSpot As Integer)
    Dim tempLocation As Location
    Dim fBlock As Double
    Dim lBlock As Double
    Dim B As Integer
    If ShadowMode = True Then Exit Sub
    With Player(A)
        fBlock = FirstBlock((Player(A).Location.X / 32) - 1)
        lBlock = LastBlock(((Player(A).Location.X + Player(A).Location.Width) / 32) + 1)
        For B = fBlock To lBlock
            If Block(B).Hidden = False Then
                If BlockIsSizable(Block(B).Type) = False Then
                    If BlockSlope(Block(B).Type) = 0 And BlockSlope2(Block(B).Type) = 0 Then
                        tempLocation = .Location
                        tempLocation.Height = tempLocation.Height - 1
                        If CheckCollision(tempLocation, Block(B).Location) = True Then
                            If BlockOnlyHitspot1(Block(B).Type) = False Then
                                If BlockNoClipping(Block(B).Type) = False Then
                                    If HitSpot = 2 Then
                                        .Location.X = Block(B).Location.X - .Location.Height - 0.01
                                    ElseIf HitSpot = 3 Then
                                        .Location.Y = Block(B).Location.Y + Block(B).Location.Height + 0.01
                                    ElseIf HitSpot = 4 Then
                                        .Location.X = Block(B).Location.X + Block(B).Location.Width + 0.01
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End If
        Next B
    End With
End Sub

Public Sub SizeCheck(A As Integer)

    On Error Resume Next
'player size fix
    'height
    With Player(A)
            If .State = 0 Then .State = 1
            If .Character = 0 Then .Character = 1
            If .Fairy = True Then
                If .Duck = True Then UnDuck A
                If .Location.Width <> 22 Then
                    .Location.X = .Location.X + .Location.Width / 2 - 11
                    .Location.Width = 22
                End If
                If .Location.Height <> 26 Then
                    .Location.Y = .Location.Y + .Location.Height - 26
                    .Location.Height = 26
                End If
            ElseIf .Mount = 0 Then
                If .Duck = False Then
                    If .Location.Height <> Physics.PlayerHeight(.Character, .State) Then
                        .Location.Y = .Location.Y + .Location.Height
                        .Location.Height = Physics.PlayerHeight(.Character, .State)
                        .Location.Y = .Location.Y - .Location.Height
                    End If
                Else
                    If .Location.Height <> Physics.PlayerDuckHeight(.Character, .State) Then
                        .Location.Y = .Location.Y + .Location.Height
                        .Location.Height = Physics.PlayerDuckHeight(.Character, .State)
                        .Location.Y = .Location.Y - .Location.Height
                    End If
                End If
            ElseIf .Mount = 1 Then
                If .Duck = True Then
                    If .Location.Height <> Physics.PlayerDuckHeight(.Character, 2) Then
                        .Location.Y = .Location.Y + .Location.Height
                        .Location.Height = Physics.PlayerDuckHeight(.Character, 2)
                        .Location.Y = .Location.Y - .Location.Height
                    End If
                ElseIf .Character = 2 And .State > 1 Then
                    If .Location.Height <> Physics.PlayerHeight(1, 2) Then
                        .Location.Y = .Location.Y + .Location.Height
                        .Location.Height = Physics.PlayerHeight(.Character, .State)
                        .Location.Y = .Location.Y - .Location.Height
                    End If
                Else
                    If .Location.Height <> Physics.PlayerHeight(1, 2) Then
                        .Location.Y = .Location.Y + .Location.Height
                        .Location.Height = Physics.PlayerHeight(1, 2)
                        .Location.Y = .Location.Y - .Location.Height
                    End If
                End If
            ElseIf .Mount = 2 Then
                If .Location.Height <> 128 Then
                    .Location.Y = .Location.Y + .Location.Height
                    .Location.Height = 128
                    .Location.Y = .Location.Y - .Location.Height
                End If
            ElseIf .Mount = 3 Then
                If .Duck = False Then
                    If .State = 1 Then
                        If .Location.Height <> Physics.PlayerHeight(1, 2) Then
                            .Location.Y = .Location.Y + .Location.Height
                            .Location.Height = Physics.PlayerHeight(1, 2)
                            .Location.Y = .Location.Y - .Location.Height
                        End If
                    Else
                        If .Location.Height <> Physics.PlayerHeight(2, 2) Then
                            .Location.Y = .Location.Y + .Location.Height
                            .Location.Height = Physics.PlayerHeight(2, 2)
                            .Location.Y = .Location.Y - .Location.Height
                        End If
                    End If
                Else
                    If .Location.Height <> 31 Then
                        .Location.Y = .Location.Y + .Location.Height
                        .Location.Height = 31
                        .Location.Y = .Location.Y - .Location.Height
                    End If
                End If
            End If
    'width
            If .Mount = 2 Then
                If .Location.Width <> 127.9 Then
                    .Location.X = .Location.X + .Location.Width / 2
                    .Location.Width = 127.9
                    .Location.X = .Location.X - .Location.Width / 2
                End If
            Else
                If .Location.Width <> Physics.PlayerWidth(.Character, .State) Then
                    .Location.X = .Location.X + .Location.Width / 2
                    .Location.Width = Physics.PlayerWidth(.Character, .State)
                    .Location.X = .Location.X - .Location.Width / 2
                End If
            End If
    End With
End Sub



Public Sub YoshiEatCode(A As Integer)
    Dim B As Integer
    Dim tempLocation As Location
    With Player(A)
        If .Mount = 3 And .Fairy = False Then
        'Shell Colors
            If .MountSpecial = 0 Then
                If .YoshiNPC > 0 Then
                    If NPC(.YoshiNPC).Type = 7 Or NPC(.YoshiNPC).Type = 6 Then .YoshiRed = True
                    If NPC(.YoshiNPC).Type = 110 Or NPC(.YoshiNPC).Type = 114 Or NPC(.YoshiNPC).Type = 128 Then .YoshiRed = True
                    If NPC(.YoshiNPC).Type = 110 Or NPC(.YoshiNPC).Type = 114 Or NPC(.YoshiNPC).Type = 128 Then .YoshiRed = True
                    If NPC(.YoshiNPC).Type = 174 Or NPC(.YoshiNPC).Type = 175 Or NPC(.YoshiNPC).Type = 177 Or NPC(.YoshiNPC).Type = 194 Then .YoshiRed = True
                    If NPC(.YoshiNPC).Type = 111 Or NPC(.YoshiNPC).Type = 115 Or NPC(.YoshiNPC).Type = 194 Or NPC(.YoshiNPC).Type = 195 Then
                        If .YoshiBlue = False Then
                            .CanFly2 = True
                            .CanFly2 = True
                            .FlyCount = 300
                        End If
                        .YoshiBlue = True
                    End If
                    If NPC(.YoshiNPC).Type = 112 Or NPC(.YoshiNPC).Type = 116 Or NPC(.YoshiNPC).Type = 127 Or NPC(.YoshiNPC).Type = 194 Or NPC(.YoshiNPC).Type = 195 Then .YoshiYellow = True
                End If
                If .YoshiNPC > 0 Or .YoshiPlayer > 0 Then
                    If .MountType = 2 Or .MountType = 5 Then
                        If .YoshiBlue = False Then
                            .CanFly2 = True
                            .CanFly2 = True
                            .FlyCount = 300
                        End If
                        .YoshiBlue = True
                    End If
                    If .MountType = 3 Or .MountType = 5 Then
                        .YoshiYellow = True
                    End If
                    If .MountType = 4 Or .MountType = 5 Then
                        .YoshiRed = 4
                    End If
                End If
            End If
            
            If .YoshiBlue = True Then
                .CanFly = True
                .RunCount = 1000
            End If
            If .MountSpecial = 0 Then
                If NPC(.YoshiNPC).Type = 31 Then 'key check
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
                ElseIf NPC(.YoshiNPC).Type = 45 Then
                    NPC(.YoshiNPC).Special = 1
                End If
                If .FireBallCD > 0 Then .FireBallCD = .FireBallCD - 1
                If .Controls.Run = True Then
                    If .RunRelease = True Then
                        If .YoshiNPC = 0 And .YoshiPlayer = 0 Then
                            If .FireBallCD = 0 Then
                                .MountSpecial = 1
                                .YoshiTongueLength = 0
                                .YoshiTonugeBool = False
                                PlaySound 50
                            End If
                        Else
                            YoshiSpit A
                        End If
                    End If
                End If
            End If
            If .MountSpecial <> 0 Then
                .YoshiTFrameCount = 0
                If .YoshiNPC > 0 Or .YoshiPlayer > 0 Then .YoshiTonugeBool = True
                If .YoshiTonugeBool = False Then
                    If .MountType <= 4 Then
                        If .YoshiTongueLength < 64 * 0.7 Then
                            .YoshiTongueLength = .YoshiTongueLength + 6
                        Else
                            .YoshiTongueLength = .YoshiTongueLength + 3
                        End If
                    Else
                        If .YoshiTongueLength < 80 * 0.7 Then
                            .YoshiTongueLength = .YoshiTongueLength + 7.5
                        Else
                            .YoshiTongueLength = .YoshiTongueLength + 3.75
                        End If
                    End If
                    
                    If .YoshiTongueLength >= 64 And .MountType <= 4 Then
                        .YoshiTonugeBool = True
                    ElseIf .YoshiTongueLength >= 80 Then
                        .YoshiTonugeBool = True
                    End If
                Else
                    If .MountType <= 4 Then
                        If .YoshiTongueLength < 64 * 0.7 Then
                            .YoshiTongueLength = .YoshiTongueLength - 6
                        Else
                            .YoshiTongueLength = .YoshiTongueLength - 3
                        End If
                    Else
                        If .YoshiTongueLength < 80 * 0.7 Then
                            .YoshiTongueLength = .YoshiTongueLength - 7.5
                        Else
                            .YoshiTongueLength = .YoshiTongueLength - 3.75
                        End If
                    End If
                    If .YoshiTongueLength <= -8 Then
                        .YoshiTongueLength = 0
                        .YoshiTonugeBool = False
                        .MountSpecial = 0
                    End If
                End If
                .YoshiTongue.Height = 12
                .YoshiTongue.Width = 16
                .YoshiTongueX = .Location.X + .Location.Width / 2
                If .Controls.Up = True Or (.StandingOnNPC = 0 And .Slope = 0 And .Location.SpeedY <> 0 And .Controls.Down = False) Then
                    .YoshiTongueX = .YoshiTongueX + .Direction * (22)
                    .YoshiTongue.Y = .Location.Y + 8 + (.Location.Height - 54)
                    .YoshiTongue.X = .YoshiTongueX + .YoshiTongueLength * .Direction
                Else
                    .YoshiTongueX = .YoshiTongueX + .Direction * (34)
                    .YoshiTongue.Y = .Location.Y + 30 + (.Location.Height - 54)
                    .YoshiTongue.X = .YoshiTongueX + .YoshiTongueLength * .Direction
                End If
                If .Direction = -1 Then .YoshiTongue.X = .YoshiTongue.X - 16
                If .YoshiNPC = 0 And .YoshiPlayer = 0 Then YoshiEat A
                If .YoshiNPC > 0 Then
                    NPC(.YoshiNPC).Effect2 = A
                    NPC(.YoshiNPC).Effect3 = 5
                    If .YoshiTonugeBool = False Then .YoshiTonugeBool = True
                    NPC(.YoshiNPC).Location.X = .YoshiTongue.X - NPC(.YoshiNPC).Location.Width / 2 + 8 + 4 * .Direction
                    NPC(.YoshiNPC).Location.Y = .YoshiTongue.Y - NPC(.YoshiNPC).Location.Height / 2 + 6
                End If
                If .YoshiPlayer > 0 Then
                    Player(.YoshiPlayer).Effect = 9
                    Player(.YoshiPlayer).Effect2 = A
                    Player(.YoshiPlayer).Location.X = .YoshiTongue.X + .YoshiTongue.Width / 2 - Player(.YoshiPlayer).Location.Width / 2
                    Player(.YoshiPlayer).Location.Y = .YoshiTongue.Y + .YoshiTongue.Height / 2 - Player(.YoshiPlayer).Location.Height / 2
                    If Player(.YoshiPlayer).Location.Y + Player(.YoshiPlayer).Location.Height > .Location.Y + .Location.Height Then Player(.YoshiPlayer).Location.Y = .Location.Y + .Location.Height - Player(.YoshiPlayer).Location.Height
                End If
            End If
            If .MountSpecial = 0 And .YoshiNPC > 0 Then
                .YoshiTFrameCount = 1
                If NPC(.YoshiNPC).Type = 4 Or NPC(.YoshiNPC).Type = 76 Then
                    NPC(.YoshiNPC).Type = 5
                ElseIf NPC(.YoshiNPC).Type = 6 Or NPC(.YoshiNPC).Type = 161 Then
                    NPC(.YoshiNPC).Type = 7
                ElseIf NPC(.YoshiNPC).Type = 23 Then
                    NPC(.YoshiNPC).Type = 24
                ElseIf NPC(.YoshiNPC).Type = 72 Then
                    NPC(.YoshiNPC).Type = 73
                ElseIf NPC(.YoshiNPC).Type >= 109 And NPC(.YoshiNPC).Type <= 112 Then
                    NPC(.YoshiNPC).Type = NPC(.YoshiNPC).Type + 4
                ElseIf NPC(.YoshiNPC).Type >= 121 And NPC(.YoshiNPC).Type <= 124 Then
                    NPC(.YoshiNPC).Type = NPC(.YoshiNPC).Type - 8
                    NPC(.YoshiNPC).Special = 0
                ElseIf NPC(.YoshiNPC).Type = 173 Or NPC(.YoshiNPC).Type = 176 Then
                    NPC(.YoshiNPC).Type = 172
                    NPC(.YoshiNPC).Location.Height = 28
                ElseIf NPC(.YoshiNPC).Type = 175 Or NPC(.YoshiNPC).Type = 177 Then
                    NPC(.YoshiNPC).Type = 174
                    NPC(.YoshiNPC).Location.Height = 28
                End If
                NPC(.YoshiNPC).Location.Height = NPCHeight(NPC(.YoshiNPC).Type)
                If (NPCIsGrabbable(NPC(.YoshiNPC).Type) = True Or NPCIsAShell(NPC(.YoshiNPC).Type) = True Or NPC(.YoshiNPC).Type = 40 Or NPCIsABot(NPC(.YoshiNPC).Type) Or NPC(.YoshiNPC).Type = 194 Or NPC(.YoshiNPC).Type = 135 Or NPC(.YoshiNPC).Type = 136 Or NPC(.YoshiNPC).Type = 137) And (NPC(.YoshiNPC).Type <> 166) Then
                    If NPC(.YoshiNPC).Type = 135 Then NPC(.YoshiNPC).Special = 450
                    If NPC(.YoshiNPC).Type = 134 Then NPC(.YoshiNPC).Special = 250
                    If NPC(.YoshiNPC).Type = 136 Or NPC(.YoshiNPC).Type = 137 Then
                        NPC(.YoshiNPC).Special = 250
                        NPC(.YoshiNPC).Type = 137
                        NPC(.YoshiNPC).Location.Height = NPCHeight(NPC(.YoshiNPC).Type)
                    End If
                    NPC(.YoshiNPC).Effect = 6
                    NPC(.YoshiNPC).Effect2 = A
                    NPC(.YoshiNPC).Active = False
                    If NPC(.YoshiNPC).Type = 49 Then
                        NPC(.YoshiNPC).Special = 0
                        NPC(.YoshiNPC).Special2 = 0
                    End If
                ElseIf .MountType = 7 And NPCIsABonus(NPC(.YoshiNPC).Type) = False Then
                    With NPC(.YoshiNPC)
                        B = Int(Rnd * 9)
                        .Type = 139 + B
                        If .Type = 147 Then .Type = 92
                        .Location.X = .Location.X + .Location.Width / 2
                        .Location.Y = .Location.Y + .Location.Height / 2
                        .Location.Width = NPCWidth(.Type)
                        .Location.Height = NPCHeight(.Type)
                        .Location.X = .Location.X - .Location.Width / 2
                        .Location.Y = .Location.Y - .Location.Height / 2
                    End With
                    NPC(.YoshiNPC).Effect = 6
                    NPC(.YoshiNPC).Effect2 = A
                    NPC(.YoshiNPC).Active = False
                ElseIf .MountType = 8 And NPCIsABonus(NPC(.YoshiNPC).Type) = False Then
                    With NPC(.YoshiNPC)
                        .Type = 237
                        .Location.X = .Location.X + .Location.Width / 2
                        .Location.Y = .Location.Y + .Location.Height / 2
                        .Location.Width = NPCWidth(.Type)
                        .Location.Height = NPCHeight(.Type)
                        .Location.X = .Location.X - .Location.Width / 2
                        .Location.Y = .Location.Y - .Location.Height / 2
                    End With
                    NPC(.YoshiNPC).Effect = 6
                    NPC(.YoshiNPC).Effect2 = A
                    NPC(.YoshiNPC).Active = False
                Else
                    If NPCIsABonus(NPC(.YoshiNPC).Type) Then
                        TouchBonus A, .YoshiNPC
                        .YoshiNPC = 0
                    Else
                        MoreScore NPCScore(NPC(.YoshiNPC).Type), NPC(.YoshiNPC).Location, .Multiplier
                        NPC(.YoshiNPC).Killed = 9
                        .YoshiNPC = 0
                        .FireBallCD = 30
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
                        PlaySound 55
                    End If
                End If
            ElseIf .MountSpecial = 0 And .YoshiPlayer > 0 Then
                Player(.YoshiPlayer).Effect = 10
                Player(.YoshiPlayer).Effect2 = A
                Player(.YoshiPlayer).Location.X = .Location.X + .Location.Width / 2 - Player(.YoshiPlayer).Location.Width / 2
                Player(.YoshiPlayer).Location.Y = .Location.Y + .Location.Height / 2 - Player(.YoshiPlayer).Location.Height / 2
                .YoshiTFrameCount = 1
            End If
        End If
    End With
End Sub


Public Sub StealBonus()
Dim A As Integer
Dim B As Integer
Dim C As Integer
Dim tempLocation As Location
    'dead players steal life
    If BattleMode = True Then Exit Sub
    If numPlayers = 2 And nPlay.Online = False Then
        If (Player(1).Dead = True Or Player(1).TimeToLive > 0) And (Player(2).Dead = True Or Player(2).TimeToLive > 0) Then Exit Sub
        For A = 1 To numPlayers
            With Player(A)
                If .Dead = True Then
                    If A = 1 Then
                        B = 2
                        C = 40
                    Else
                        B = 1
                        C = -40
                    End If
                    
                    If Lives > 0 And LevelMacro = 0 Then
                        If .Controls.Jump = True Or .Controls.Run = True Then
                            Lives = Lives - 1
                            If B = 1 Then C = -40
                            If B = 2 Then C = 40
                            .State = 1
                            .Hearts = 1
                            .Location.Width = Physics.PlayerWidth(.Character, .State)
                            .Location.Height = Physics.PlayerHeight(.Character, .State)
                            .Frame = 1
                            .Direction = Player(B).Direction
                            .Dead = False
                            .Location.SpeedX = 0
                            .Location.SpeedY = 0
                            .Effect = 6
                            .Effect2 = Player(B).Location.Y + Player(B).Location.Height - .Location.Height
                            If Player(B).Mount = 2 Then .Effect2 = Player(B).Location.Y - .Location.Height
                            .Location.Y = -vScreenY(1) - .Location.Height
                            .Location.X = Player(B).Location.X + Player(B).Location.Width / 2 - .Location.Width / 2
                            PlaySound 11
                        End If
                    End If
                End If
            End With
        Next A
    End If
End Sub

Public Sub ClownCar()
'for when the player is in the clown car
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    Dim blankNPC As NPC
    Dim tempBool As Boolean
    Dim tempLocation As Location
    For A = 1 To numPlayers 'Code for running the Koopa Clown Car
        If numPlayers > 2 And GameMenu = False And LevelMacro = 0 And nPlay.Online = False Then
            Player(A).Controls = Player(1).Controls
        End If
        If Player(A).Mount = 2 And Player(A).Dead = False And Player(A).TimeToLive = 0 Then
            With Player(A)
                If .Effect = 0 Then
                    If .Controls.Left = True Then
                        .Location.SpeedX = .Location.SpeedX - 0.1
                        If .Location.SpeedX > 0 Then .Location.SpeedX = .Location.SpeedX - 0.15
                    ElseIf .Controls.Right = True Then
                        .Location.SpeedX = .Location.SpeedX + 0.1
                        If .Location.SpeedX < 0 Then .Location.SpeedX = .Location.SpeedX + 0.15
                    Else
                        If .Location.SpeedX > 0.2 Then
                            .Location.SpeedX = .Location.SpeedX - 0.05
                        ElseIf .Location.SpeedX < -0.2 Then
                            .Location.SpeedX = .Location.SpeedX + 0.05
                        Else
                            .Location.SpeedX = 0
                        End If
                    End If
                    If .Controls.Up = True Then
                        .Location.SpeedY = .Location.SpeedY - 0.1
                        If .Location.SpeedY > 0 Then .Location.SpeedY = .Location.SpeedY - 0.2
                    ElseIf .Controls.Down = True Then
                        .Location.SpeedY = .Location.SpeedY + 0.2
                        If .Location.SpeedY < 0 Then .Location.SpeedY = .Location.SpeedY + 0.2
                    Else
                        If .Location.SpeedY > 0.1 Then
                            .Location.SpeedY = .Location.SpeedY - 0.1
                        ElseIf .Location.SpeedY < -0.1 Then
                            .Location.SpeedY = .Location.SpeedY + 0.1
                        Else
                            .Location.SpeedY = 0
                        End If
                    End If
                    If .Location.SpeedX > 4 Then
                        .Location.SpeedX = 4
                    ElseIf .Location.SpeedX < -4 Then
                        .Location.SpeedX = -4
                    End If
                    If .Location.SpeedY > 10 Then
                        .Location.SpeedY = 10
                    ElseIf .Location.SpeedY < -4 Then
                        .Location.SpeedY = -4
                    End If
                End If
            End With
            numNPCs = numNPCs + 1
            NPC(numNPCs) = blankNPC
            With NPC(numNPCs)
                .playerTemp = True
                .Type = 56
                .Active = True
                .TimeLeft = 100
                .Location = Player(A).Location
                If Player(A).Effect <> 0 Then
                    .Location.SpeedX = 0
                    .Location.SpeedY = 0
                End If
                .Location.Y = .Location.Y + .Location.SpeedY
                .Location.X = .Location.X + .Location.SpeedX
                .Section = Player(A).Section
            End With
            For B = 1 To numPlayers
                With Player(B)
                    If .StandingOnTempNPC = 56 Then
                        .StandingOnNPC = numNPCs
                        .Location.X = .Location.X + Player(A).mountBump
                        If .Effect <> 0 Then
                            .Location.Y = Player(A).Location.Y - .Location.Height
                            .Location.X = .Location.X + Player(A).Location.SpeedX
                        End If
                    End If
                End With
            Next B
            For B = 1 To numNPCs
                With NPC(B)
                    If .standingOnPlayer = A And NPC(B).Type <> 50 Then
                        If Player(A).Effect = 0 Then .Location.X = .Location.X + Player(A).Location.SpeedX + Player(A).mountBump
                        .TimeLeft = 100
                        .Location.SpeedY = Player(A).Location.SpeedY
                        .Location.SpeedX = 0
                        If Player(A).Effect <> 0 Then .Location.SpeedY = 0
                        .Location.Y = Player(A).Location.Y + .Location.SpeedY + 0.1 - .standingOnPlayerY
                        With Player(A)
                            If .Controls.Run = True Then
                                If NPC(B).Type = 49 Then
                                    With NPC(B)
                                        If .Special = 0 Then
                                            .Special = 1
                                            numNPCs = numNPCs + 1
                                            .Special2 = numNPCs
                                            With NPC(numNPCs)
                                                .Active = True
                                                .Section = Player(A).Section
                                                .TimeLeft = 100
                                                .Type = 50
                                                .Location.Height = 32
                                                .Location.Width = 48
                                                .Special = A
                                                .Special2 = B
                                                .Direction = NPC(B).Direction
                                                If .Direction = 1 Then .Frame = 2
                                            End With
                                        End If
                                    End With
                                    For C = 1 To numNPCs
                                        If NPC(C).Type = 50 And NPC(C).Special = A And NPC(C).Special2 = B Then
                                            NPC(C).standingOnPlayer = A
                                            NPC(C).Projectile = True
                                            NPC(C).Direction = NPC(B).Direction
                                            If NPC(C).Direction > 0 Then
                                                NPC(C).Location.X = NPC(B).Location.X + 32
                                            Else
                                                NPC(C).Location.X = NPC(B).Location.X - NPC(C).Location.Width
                                            End If
                                            NPC(C).Location.Y = NPC(B).Location.Y
                                            NPC(C).TimeLeft = 100
                                            Exit For
                                        End If
                                    Next C
                                End If
                            End If
                        End With
                        tempBool = False
                        tempLocation = .Location
                        tempLocation.Y = tempLocation.Y + tempLocation.Height + 0.1
                        tempLocation.X = tempLocation.X + 0.5
                        tempLocation.Width = tempLocation.Width - 1
                        tempLocation.Height = 1
                        For C = 1 To numNPCs
                            If B <> C And (NPC(C).standingOnPlayer = A Or NPC(C).playerTemp = True) Then
                                If CheckCollision(tempLocation, NPC(C).Location) = True Then
                                    tempBool = True
                                End If
                            End If
                        Next C
                        If tempBool = False Then
                            .standingOnPlayer = 0
                            .standingOnPlayerY = 0
                        Else
                            .Location.SpeedX = 0
                        End If
                    End If
                End With
            Next B
        End If
    Next A
End Sub

Private Sub WaterCheck(A As Integer)
    Dim tempLocation As Location
    Dim B As Integer
    With Player(A)
                    If .Wet > 0 Then
                        .Wet = .Wet - 1
                        .Multiplier = 0
                    End If
                    If .Quicksand > 0 Then
                        .Quicksand = .Quicksand - 1
                        If .Quicksand = 0 Then .WetFrame = False
                    End If
                    If UnderWater(.Section) = True Then .Wet = 2
                    If .Wet > 0 Then
                        .SpinJump = False
                        .WetFrame = True
                        .Slide = False
                    ElseIf .WetFrame = True Then
                        If .Location.SpeedY >= 3.1 Or .Location.SpeedY <= -3.1 Then
                            .WetFrame = False
                            tempLocation.Width = 32
                            tempLocation.Height = 32
                            tempLocation.X = .Location.X + .Location.Width / 2 - tempLocation.Width / 2
                            tempLocation.Y = .Location.Y + .Location.Height - tempLocation.Height
                            NewEffect 114, tempLocation
                        End If
                    End If
                    For B = 1 To numWater
                        If Water(B).Hidden = False Then
                            If CheckCollision(.Location, Water(B).Location) = True Then
                                If .Wet = 0 And .Mount <> 2 Then
                                    .FlyCount = 0
                                    .CanFly = False
                                    .CanFly2 = False
                                    If .Controls.Jump = False And .Controls.AltJump = False Then .CanJump = True
                                    .SwimCount = 0
                                    If .Location.SpeedY > 0.5 Then .Location.SpeedY = 0.5
                                    If .Location.SpeedY < -1.5 Then .Location.SpeedY = -1.5
                                    If .WetFrame = False Then
                                        If .Location.SpeedX > 0.5 Then .Location.SpeedX = 0.5
                                        If .Location.SpeedX < -0.5 Then .Location.SpeedX = -0.5
                                    End If
                                    If .Location.SpeedY > 0 And .WetFrame = False Then
                                        tempLocation.Width = 32
                                        tempLocation.Height = 32
                                        tempLocation.X = .Location.X + .Location.Width / 2 - tempLocation.Width / 2
                                        tempLocation.Y = .Location.Y + .Location.Height - tempLocation.Height
                                        NewEffect 114, tempLocation
                                    End If
                                End If
                                .Wet = 2
                                .SpinJump = False
                                If Water(B).Quicksand = True Then
                                    .Quicksand = 3
                                End If
                            End If
                        End If
                    Next B
                    If .Mount = 2 Then
                        .Wet = 0
                        .WetFrame = 0
                    End If
                    If .Wet = 1 Then
                        If .Location.SpeedY < 0 And (.Controls.AltJump = True Or .Controls.Jump = True) And .Controls.Down = False Then
                            .Jump = 12
                            .Location.SpeedY = Physics.PlayerJumpVelocity
                        End If
                    ElseIf .Wet = 2 And .Quicksand = 0 Then
                        If Rnd * 100 > 97 Then
                            If .Direction = 1 Then
                                tempLocation = newLoc(.Location.X + .Location.Width - Rnd * 8, .Location.Y + 4 + Rnd * 8, 8, 8)
                            Else
                                tempLocation = newLoc(.Location.X - 8 + Rnd * 8, .Location.Y + 4 + Rnd * 8, 8, 8)
                            End If
                            If UnderWater(.Section) = False Then
                                For B = 1 To numWater
                                    If CheckCollision(Water(B).Location, tempLocation) Then
                                        NewEffect 113, tempLocation, , , ShadowMode
                                        Exit For
                                    End If
                                Next B
                            Else
                                NewEffect 113, tempLocation, 1, 1, ShadowMode
                            End If
                        End If
                    End If
    End With
End Sub

Private Sub Tanooki(A As Integer)
    With Player(A)
        If .Fairy = True Then Exit Sub
'tanooki
                    If .Stoned = True And .Controls.Down = True And .StandingOnNPC = 0 Then
                        .Location.SpeedX = .Location.SpeedX * 0.8
                        If .Location.SpeedX >= -0.5 And .Location.SpeedX <= 0.5 Then .Location.SpeedX = 0
                        If .Location.SpeedY < 8 Then .Location.SpeedY = .Location.SpeedY + 0.25
                    End If
                    
                    If .StonedCD = 0 Then
                        'If .Mount = 0 And .State = 5 And .Controls.Run = True And .Controls.Down = True Then
                        If .Mount = 0 And .State = 5 And .Controls.AltRun = True And .Bombs = 0 Then
                            If .Stoned = False Then
                                .Effect = 500
                            End If
                        ElseIf .Stoned = True Then
                            .Effect = 500
                        End If
                    Else
                        .StonedCD = .StonedCD - 1
                    End If
                    If .Stoned = True Then
                        .StonedTime = .StonedTime + 1
                        If .StonedTime >= 240 Then
                            .Effect = 500
                            .StonedCD = 60
                        ElseIf .StonedTime >= 180 Then
                            .Immune = .Immune + 1
                            If .Immune Mod 3 = 0 Then
                                If .Immune2 = True Then
                                    .Immune2 = False
                                Else
                                    .Immune2 = True
                                End If
                            End If
                        End If
                    End If
    
    End With
End Sub

Private Sub PowerUps(A As Integer)
    Dim BoomOut As Boolean
    Dim B As Integer
    With Player(A)
        If .Fairy = True Then
            .SwordPoke = 0
            .FireBallCD = 0
            .FireBallCD2 = 0
            .TailCount = 0
            Exit Sub
        End If
        
        
        If .State = 6 And .Character = 4 And .Controls.Run = True And .RunRelease = True Then
            For B = 1 To numNPCs
                If NPC(B).Active = True Then
                    If NPC(B).Type = 292 Then
                        If NPC(B).Special5 = A Then
                            BoomOut = True
                        End If
                    End If
                End If
            Next B
        End If
        
'Hammer Throw Code
            If .Slide = False And .Vine = 0 And .State = 6 And .Duck = False And .Mount <> 2 And .Mount <> 3 And .HoldingNPC <= 0 And .Character <> 5 Then
                If .Controls.Run = True And .SpinJump = False And .FireBallCD <= 0 And BoomOut = False Then
                    If .RunRelease = True Or FlameThrower = True Then
                        If numNPCs < maxNPCs - 100 Then
                            If nPlay.Online = True And A - 1 = nPlay.MySlot Then
                                Netplay.sendData Netplay.PutPlayerControls(nPlay.MySlot) & "1f" & A & "|" & Player(A).FireBallCD - 1
                            End If
                            .FrameCount = 110
                            .FireBallCD = 25
                            numNPCs = numNPCs + 1
                            If ShadowMode = True Then NPC(numNPCs).Shadow = True
                            NPC(numNPCs).Type = 171
                            If .Character = 3 Then
                                .FireBallCD = 45
                                NPC(numNPCs).Type = 291
                                If .Controls.AltRun = True And .Mount = 0 Then
                                    NPC(numNPCs).HoldingPlayer = A
                                    .HoldingNPC = numNPCs
                                    PlaySound 73
                                Else
                                    PlaySound 75
                                End If
                            ElseIf .Character = 4 Then
                                
                                .FireBallCD = 0
                                If FlameThrower = True Then .FireBallCD = 40
                                NPC(numNPCs).Type = 292
                                NPC(numNPCs).Special5 = A
                                NPC(numNPCs).Special6 = .Direction
                                PlaySound 75
                            Else
                                PlaySound 18
                            End If
                            
                            NPC(numNPCs).Projectile = True
                            NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                            NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                            NPC(numNPCs).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State) * .Direction
                            NPC(numNPCs).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State)
                            NPC(numNPCs).Active = True
                            NPC(numNPCs).TimeLeft = 100
                            NPC(numNPCs).Location.SpeedY = 20
                            NPC(numNPCs).CantHurt = 100
                            NPC(numNPCs).CantHurtPlayer = A
                            If .Controls.Up = True Then
                                NPC(numNPCs).Location.SpeedX = 2 * .Direction + .Location.SpeedX * 0.9
                                If .StandingOnNPC = 0 Then
                                    NPC(numNPCs).Location.SpeedY = -8 + .Location.SpeedY * 0.3
                                Else
                                    NPC(numNPCs).Location.SpeedY = -8 + NPC(.StandingOnNPC).Location.SpeedY * 0.3
                                End If
                                NPC(numNPCs).Location.Y = NPC(numNPCs).Location.Y - 24
                                NPC(numNPCs).Location.X = NPC(numNPCs).Location.X - 6 * .Direction
                                If .Character = 3 Then
                                    NPC(numNPCs).Location.SpeedY = NPC(numNPCs).Location.SpeedY + 1
                                    NPC(numNPCs).Location.SpeedX = NPC(numNPCs).Location.SpeedX * 1.5
                                ElseIf .Character = 4 Then
                                    NPC(numNPCs).Location.SpeedY = -8
                                    NPC(numNPCs).Location.SpeedX = 12 * .Direction + .Location.SpeedX
                                End If
                            Else
                                NPC(numNPCs).Location.SpeedX = 4 * .Direction + .Location.SpeedX * 0.9
                                If .StandingOnNPC = 0 Then
                                    NPC(numNPCs).Location.SpeedY = -5 + .Location.SpeedY * 0.3
                                Else
                                    NPC(numNPCs).Location.SpeedY = -5 + NPC(.StandingOnNPC).Location.SpeedY * 0.3
                                End If
                                If .Character = 3 Then
                                    NPC(numNPCs).Location.SpeedY = NPC(numNPCs).Location.SpeedY + 1
                                ElseIf .Character = 4 Then
                                    NPC(numNPCs).Location.SpeedY = -5
                                    NPC(numNPCs).Location.SpeedX = 10 * .Direction + .Location.SpeedX
                                    NPC(numNPCs).Location.Y = NPC(numNPCs).Location.Y - 12
                                End If
                            End If
                            If .Character = 4 Then
                                NPC(numNPCs).Location.X = .Location.X + .Location.Width / 2 - NPC(numNPCs).Location.Width / 2
                            End If
                            CheckSectionNPC numNPCs
                        End If
                    End If
                End If
            End If




'Fire Mario / Luigi code ---- FIRE FLOWER ACTION BALLS OF DOOM
            If .Slide = False And .Vine = 0 And (.State = 3 Or .State = 7) And .Duck = False And .Mount <> 2 And .Mount <> 3 And .HoldingNPC <= 0 And .Character <> 5 Then
                If ((.Controls.Run = True And .SpinJump = False) Or (.SpinJump = True And .Direction <> .SpinFireDir)) And .FireBallCD <= 0 Then
                    If (.RunRelease = True Or .SpinJump = True) Or (FlameThrower = True And .HoldingNPC <= 0) Then
                        If .SpinJump = True Then .SpinFireDir = .Direction
                        If numNPCs < maxNPCs - 100 Then
                            If nPlay.Online = True And A - 1 = nPlay.MySlot Then
                                Netplay.sendData Netplay.PutPlayerControls(nPlay.MySlot) & "1f" & A & "|" & Player(A).FireBallCD - 1
                            End If
                            If .SpinJump = False Then .FrameCount = 110
                            numNPCs = numNPCs + 1
                            If ShadowMode = True Then NPC(numNPCs).Shadow = True
                            NPC(numNPCs).Type = 13
                            If .State = 7 Then NPC(numNPCs).Type = 265
                            NPC(numNPCs).Projectile = True
                            NPC(numNPCs).Location.Height = NPCHeight(NPC(numNPCs).Type)
                            NPC(numNPCs).Location.Width = NPCWidth(NPC(numNPCs).Type)
                            NPC(numNPCs).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State) * .Direction + 4
                            NPC(numNPCs).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State)
                            NPC(numNPCs).Active = True
                            NPC(numNPCs).TimeLeft = 100
                            NPC(numNPCs).Location.SpeedY = 20
                            NPC(numNPCs).CantHurt = 100
                            NPC(numNPCs).CantHurtPlayer = A
                            NPC(numNPCs).Special = .Character
                            If .State = 7 Then NPC(numNPCs).Special = 1
                            If (.Character = 3 Or .Character = 4) And .Mount = 0 And .Controls.AltRun = True Then   'peach holds fireballs
                                .HoldingNPC = numNPCs
                                NPC(numNPCs).HoldingPlayer = A
                            End If
                            If NPC(numNPCs).Special = 2 Then NPC(numNPCs).Frame = 4
                            If NPC(numNPCs).Special = 3 Then NPC(numNPCs).Frame = 8
                            If NPC(numNPCs).Special = 4 Then NPC(numNPCs).Frame = 12
                            CheckSectionNPC numNPCs
                            .FireBallCD = 30
                            If .Character = 2 Then .FireBallCD = 35
                            If .Character = 3 Then .FireBallCD = 40
                            If .Character = 4 Then .FireBallCD = 25
                            NPC(numNPCs).Location.SpeedX = 5 * .Direction + (.Location.SpeedX / 3.5)
                            
                            If .State = 7 Then
                                NPC(numNPCs).Location.SpeedY = 5
                                
                                If .Controls.Up = True Then
                                    If .StandingOnNPC <> 0 Then
                                        NPC(numNPCs).Location.SpeedY = -8 + NPC(.StandingOnNPC).Location.SpeedY * 0.1
                                    Else
                                        NPC(numNPCs).Location.SpeedY = -8 + .Location.SpeedY * 0.1
                                    End If
                                    NPC(numNPCs).Location.SpeedX = NPC(numNPCs).Location.SpeedX * 0.9
                                End If
                                If FlameThrower = True Then
                                    NPC(numNPCs).Location.SpeedX = NPC(numNPCs).Location.SpeedX * 1.5
                                    NPC(numNPCs).Location.SpeedY = NPC(numNPCs).Location.SpeedY * 1.5
                                End If
                                If .StandingOnNPC <> 0 Then NPC(numNPCs).Location.SpeedX = 5 * .Direction + (.Location.SpeedX / 3.5) + NPC(.StandingOnNPC).Location.SpeedX / 3.5
                                PlaySound 18
                                NPC(numNPCs).Location.SpeedX = NPC(numNPCs).Location.SpeedX * 0.8
                            Else
                                If NPC(numNPCs).Special = 2 Then NPC(numNPCs).Location.SpeedX = NPC(numNPCs).Location.SpeedX * 0.85
                                If .Controls.Up = True Then
                                    If .StandingOnNPC <> 0 Then
                                        NPC(numNPCs).Location.SpeedY = -6 + NPC(.StandingOnNPC).Location.SpeedY * 0.1
                                    Else
                                        NPC(numNPCs).Location.SpeedY = -6 + .Location.SpeedY * 0.1
                                    End If
                                    NPC(numNPCs).Location.SpeedX = NPC(numNPCs).Location.SpeedX * 0.9
                                End If
                                If FlameThrower = True Then
                                    NPC(numNPCs).Location.SpeedX = NPC(numNPCs).Location.SpeedX * 1.5
                                    NPC(numNPCs).Location.SpeedY = NPC(numNPCs).Location.SpeedY * 1.5
                                End If
                                If .StandingOnNPC <> 0 Then NPC(numNPCs).Location.SpeedX = 5 * .Direction + (.Location.SpeedX / 3.5) + NPC(.StandingOnNPC).Location.SpeedX / 3.5
                                PlaySound 18
                            End If
                        End If
                    End If
                End If
            End If
'RacoonMario
            If .Slide = False And .Vine = 0 And (.State = 4 Or .State = 5) And .Duck = False And .HoldingNPC = 0 And .Mount <> 2 And .Stoned = False And .Effect = 0 And .Character <> 5 Then
                 If .Controls.Run = True Or .SpinJump = True Then
                    If (.TailCount = 0 Or .TailCount >= 12) Then
                        If .RunRelease = True Or .SpinJump = True Then
                            .TailCount = 1
                            If .SpinJump = False Then PlaySound 33
                        End If
                    End If
                 End If
            End If
            If .TailCount > 0 Then
                .TailCount = .TailCount + 1
                If .TailCount = 25 Then .TailCount = 0
                If .TailCount Mod 7 = 0 Or (.SpinJump = True And .TailCount Mod 2 = 0) Then
                    TailSwipe A, True
                Else
                    TailSwipe A
                End If
                If .HoldingNPC > 0 Then .TailCount = 0
            End If


'link stab
        If .Character = 5 And .Vine = 0 And .Mount = 0 And .Stoned = False And .FireBallCD = 0 Then
            If .Bombs > 0 And .Controls.AltRun = True And .RunRelease = True Then
                .FireBallCD = 10
                .Bombs = .Bombs - 1
                numNPCs = numNPCs + 1
                With NPC(numNPCs)
                    .Active = True
                    .TimeLeft = Physics.NPCTimeOffScreen
                    .Section = Player(A).Section
                    .Type = 134
                    .Location.Width = NPCWidth(.Type)
                    .Location.Height = NPCHeight(.Type)
                    .CantHurtPlayer = A
                    .CantHurt = 1000
                    If Player(A).Duck = True And (Player(A).Location.SpeedY = 0 Or Player(A).Slope > 0 Or Player(A).StandingOnNPC <> 0) Then
                        .Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - .Location.Width / 2
                        .Location.Y = Player(A).Location.Y + Player(A).Location.Height - .Location.Height
                        .Location.SpeedX = 0
                        .Location.SpeedY = 0
                        PlaySound 23
                    Else
                        .Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - .Location.Width / 2
                        .Location.Y = Player(A).Location.Y
                        .Location.SpeedX = 5 * Player(A).Direction
                        .Location.SpeedY = -6
                        .Projectile = True
                        If Player(A).Location.SpeedY = 0 Or Player(A).Slope > 0 Or Player(A).StandingOnNPC <> 0 Then Player(A).SwordPoke = -10
                        PlaySound 75
                    End If
                End With
                
                
            ElseIf .FireBallCD = 0 And .Controls.Run = True And .RunRelease = True Then
                .FireBallCD = 20
                If .Location.SpeedY <> Physics.PlayerGravity And .StandingOnNPC = 0 And .Slope = 0 Then    'Link ducks when jumping
                    If .Wet = 0 And .WetFrame = False Then
                        If .Controls.Down = True And .Duck = False And .Mount = 0 Then
                            .Duck = True
                            .Location.Y = .Location.Y + .Location.Height
                            .Location.Height = Physics.PlayerDuckHeight(.Character, .State)
                            .Location.Y = .Location.Y - .Location.Height
                        ElseIf .Controls.Down = False And .Duck = True Then
                            UnDuck A
                        End If
                    End If
                End If
                If .Duck = True Then
                    .SwordPoke = 1
                Else
                    .SwordPoke = -1
                End If
            ElseIf .Controls.Up = True And .Location.SpeedY < 0 And .Duck = False And .SwordPoke = 0 Then 'Link stabs up
                If .WetFrame = False And .Frame = 10 Then TailSwipe A, True, True, 1
            ElseIf .Controls.Down = True And (.Location.SpeedY > 0 And .StandingOnNPC = 0 And .Slope = 0) And .Duck = False And .SwordPoke = 0 Then 'Link stabs down
                If .WetFrame = False And .Frame = 9 Then TailSwipe A, True, True, 2
            End If
        End If


'cooldown timer
        .FireBallCD2 = .FireBallCD2 - 1
        If .FireBallCD2 < 0 Then .FireBallCD2 = 0
        
        If Not (.Character = 3 And NPC(.HoldingNPC).Type = 13) Then
            .FireBallCD = .FireBallCD - 1
            If FlameThrower = True Then .FireBallCD = .FireBallCD - 3
            If .FireBallCD < 0 Then .FireBallCD = 0
        End If
    End With
End Sub

Private Sub SuperWarp(A As Integer)
    Dim B As Integer
    Dim C As Integer
    Dim tempLocation As Location
    Dim canWarp As Boolean
    With Player(A)
        If .WarpCD <= 0 And .Mount <> 2 And .GroundPound = False And .GroundPound2 = False Then
            For B = 1 To numWarps
                If CheckCollision(.Location, Warp(B).Entrance) And Warp(B).Hidden = False Then
                    .ShowWarp = B
                    canWarp = False
                    If Warp(B).Direction = 1 And .Controls.Up = True Then
                        If WarpCollision(.Location, B) = True Then canWarp = True
                    ElseIf Warp(B).Direction = 2 And .Controls.Left = True Then
                        If WarpCollision(.Location, B) = True Then canWarp = True
                    ElseIf Warp(B).Direction = 3 And .Controls.Down = True Then
                        If WarpCollision(.Location, B) = True Then canWarp = True
                    ElseIf Warp(B).Direction = 4 And .Controls.Right = True Then
                        If WarpCollision(.Location, B) = True Then canWarp = True
                    ElseIf Warp(B).Effect = 0 Then canWarp = True
                    End If
                    If Warp(B).LevelEnt = True Then canWarp = False
                    If Warp(B).Stars > numStars And canWarp = True Then
                        If Warp(B).Stars = 1 Then
                            MessageText = "You need 1 star to enter."
                        Else
                            MessageText = "You need " & Warp(B).Stars & " stars to enter."
                        End If
                        PauseGame A
                        MessageText = ""
                        canWarp = False
                    End If
                    
                    If canWarp = True Then
                        .Slide = False
                        .Stoned = False
                        If Warp(B).Locked = True Then
                            If .HoldingNPC > 0 And NPC(.HoldingNPC).Type = 31 Then
                                NPC(.HoldingNPC).Killed = 9
                                NewEffect 10, NPC(.HoldingNPC).Location
                                Warp(B).Locked = False
                                For C = numBackground To numBackground + numLocked
                                    If Background(C).Type = 98 Then
                                        If CheckCollision(Warp(B).Entrance, Background(C).Location) = True Then
                                            Background(C).Layer = ""
                                            Background(C).Hidden = True
                                        End If
                                    End If
                                Next C
                            ElseIf .Mount = 3 And .YoshiNPC > 0 And NPC(.YoshiNPC).Type = 31 Then
                                NPC(.YoshiNPC).Killed = 9
                                .YoshiNPC = 0
                                Warp(B).Locked = False
                                For C = numBackground To numBackground + numLocked
                                    If Background(C).Type = 98 Then
                                        If CheckCollision(Warp(B).Entrance, Background(C).Location) = True Then
                                            Background(C).Layer = ""
                                            Background(C).Hidden = True
                                        End If
                                    End If
                                Next C
                            ElseIf .HasKey = True Then
                                .HasKey = False
                                Warp(B).Locked = False
                                For C = numBackground To numBackground + numLocked
                                    If Background(C).Type = 98 Then
                                        If CheckCollision(Warp(B).Entrance, Background(C).Location) = True Then
                                            Background(C).Layer = ""
                                            Background(C).Hidden = True
                                        End If
                                    End If
                                Next C
                            Else
                                canWarp = False
                            End If
                        End If
                    End If
                    
                    If canWarp = True Then
                        UnDuck A
                        .YoshiTongueLength = 0
                        .MountSpecial = 0
                        .FrameCount = 0
                        .TailCount = 0
                        .CanFly = False
                        .CanFly2 = False
                        .RunCount = 0
                        If Warp(B).NoYoshi = True And .YoshiPlayer > 0 Then YoshiSpit A
                        If Warp(B).WarpNPC = False Or (.Mount = 3 And (.YoshiNPC <> 0 Or .YoshiPlayer <> 0) And Warp(B).NoYoshi = True) Then
                            If .HoldingNPC > 0 Then
                                If NPC(.HoldingNPC).Type = 29 Then NPCHit .HoldingNPC, 3, .HoldingNPC
                            End If
                            If .Character = 3 Or .Character = 4 And Warp(B).Effect = 1 And Warp(B).Direction = 1 Then
                                NPC(.HoldingNPC).Location.Y = Warp(B).Entrance.Y
                            End If
                            .HoldingNPC = 0
                            If .YoshiNPC > 0 Then YoshiSpit A
                        End If
                        If .HoldingNPC > 0 Then
                            If NPC(.HoldingNPC).Type = 263 Then 'can't bring ice through warps
                                NPC(.HoldingNPC).HoldingPlayer = 0
                                .HoldingNPC = 0
                            End If
                        End If
                        .StandingOnNPC = 0
                        .Location.SpeedX = 0
                        .Location.SpeedY = 0
                        If Warp(B).Effect = 0 Then
                            Player(A).Location.X = Warp(B).Exit.X + Warp(B).Exit.Width / 2 - Player(A).Location.Width / 2
                            Player(A).Location.Y = Warp(B).Exit.Y + Warp(B).Exit.Height - Player(A).Location.Height - 0.1
                            CheckSection A
                            .WarpCD = 50
                            Exit For
                        ElseIf Warp(B).Effect = 1 Then
                            PlaySound 17
                            .Effect = 3
                            .Warp = B
                            If nPlay.Online = True And A = nPlay.MySlot + 1 Then Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1j" & A & "|" & .Warp & LB
                        ElseIf Warp(B).Effect = 2 Then
                            PlaySound 46
                            .Effect = 7
                            .Warp = B
                            If nPlay.Online = True And A = nPlay.MySlot + 1 Then Netplay.sendData Netplay.PutPlayerLoc(nPlay.MySlot) & "1j" & A & "|" & .Warp & LB
                            .Location.X = Warp(.Warp).Entrance.X + Warp(.Warp).Entrance.Width / 2 - .Location.Width / 2
                            .Location.Y = Warp(.Warp).Entrance.Y + Warp(.Warp).Entrance.Height - .Location.Height
                            For C = 1 To numBackground
                                If CheckCollision(Warp(B).Entrance, Background(C).Location) Or CheckCollision(Warp(B).Exit, Background(C).Location) Then
                                    If Background(C).Type = 88 Then
                                        NewEffect 54, Background(C).Location
                                    ElseIf Background(C).Type = 87 Then
                                        NewEffect 55, Background(C).Location
                                    ElseIf Background(C).Type = 107 Then
                                        NewEffect 59, Background(C).Location
                                    ElseIf Background(C).Type = 141 Then
                                        tempLocation = Background(C).Location
                                        tempLocation.X = tempLocation.X + tempLocation.Width / 2
                                        tempLocation.Width = 104
                                        tempLocation.X = tempLocation.X - tempLocation.Width / 2
                                        NewEffect 103, tempLocation
                                    End If
                                End If
                            Next C
                        End If
                    End If
                End If
            Next B
        ElseIf .Mount <> 2 Then
            .WarpCD = .WarpCD - 1
        End If
    End With
End Sub

Private Sub PlayerCollide(A As Integer)
    Dim B As Integer
    Dim tempLocation As Location
    Dim tempLocation3 As Location
    Dim HitSpot As Integer
    With Player(A)
'Check player collisions
        For B = 1 To numPlayers
            If B <> A And Player(B).Dead = False And Player(B).TimeToLive = 0 And (Player(B).Effect = 0 Or Player(B).Effect = 3) And Not (Player(B).Mount = 2 Or .Mount = 2) And (BattleMode = False Or (Player(A).Immune = 0 And Player(B).Immune = 0)) Then
                tempLocation = .Location
                If .StandingOnNPC <> 0 And FreezeNPCs = False Then tempLocation.SpeedY = NPC(.StandingOnNPC).Location.SpeedY
                tempLocation3 = Player(B).Location
                If Player(B).StandingOnNPC <> 0 And FreezeNPCs = False Then tempLocation3.SpeedY = NPC(Player(B).StandingOnNPC).Location.SpeedY
                If CheckCollision(tempLocation, tempLocation3) = True Then
                    HitSpot = FindCollision(tempLocation, tempLocation3)
                    If HitSpot = 5 Then
                        If Player(A).StandUp2 = True And Player(A).Location.Y > Player(B).Location.Y Then
                            HitSpot = 3
                        ElseIf Player(B).StandUp2 = True And Player(A).Location.Y < Player(B).Location.Y Then
                            HitSpot = 1
                        End If
                    End If
                    If BattleMode = True Then
                        If Player(B).SlideKill = True Then
                            HitSpot = 0
                            PlayerHurt A
                        End If
                        If .SlideKill = True Then
                            HitSpot = 0
                            PlayerHurt B
                        End If
                        If .Stoned = True And (.Location.SpeedX > 3 Or .Location.SpeedX < -3 Or HitSpot = 1) Then
                            PlayerHurt B
                        ElseIf Player(B).Stoned = True And (Player(B).Location.SpeedX > 3 Or Player(B).Location.SpeedX < -3 Or HitSpot = 3) Then
                            PlayerHurt A
                        End If
                    Else

                    End If
                    If .Stoned = True Or Player(B).Stoned = True Then HitSpot = 0
                    If HitSpot = 2 Or HitSpot = 4 Then
                        If numPlayers < 3 Or nPlay.Online = True Then PlaySound 10
                        tempLocation = Player(A).Location
                        Player(A).Location.SpeedX = Player(B).Location.SpeedX
                        Player(B).Location.SpeedX = tempLocation.SpeedX
                        Player(A).Bumped = True
                        Player(B).Bumped = True
                    ElseIf HitSpot = 1 Then
                        If numPlayers < 3 Or nPlay.Online = True Then PlaySound 2
                        Player(A).Location.Y = Player(B).Location.Y - Player(A).Location.Height - 0.1
                        PlayerPush A, 3
                        Player(A).Location.SpeedY = Physics.PlayerJumpVelocity
                        Player(A).Jump = Physics.PlayerHeadJumpHeight
                        If Player(A).Character = 2 Then .Jump = .Jump + 3
                        If .SpinJump = True Then .Jump = .Jump - 6
                        Player(B).Jump = 0
                        If Player(B).Location.SpeedY <= 0 Then Player(B).Location.SpeedY = 0.1
                        Player(B).CanJump = False
                        NewEffect 75, newLoc(Player(A).Location.X + Player(A).Location.Width / 2 - 16, Player(A).Location.Y + Player(A).Location.Height - 16)
                    ElseIf HitSpot = 3 Then
                        If numPlayers < 3 Or nPlay.Online = True Then PlaySound 2
                        Player(B).Location.Y = Player(A).Location.Y - Player(B).Location.Height - 0.1
                        PlayerPush B, 3
                        Player(B).Location.SpeedY = Physics.PlayerJumpVelocity
                        Player(B).Jump = Physics.PlayerHeadJumpHeight
                        If Player(B).Character = 2 Then .Jump = .Jump + 3
                        If .SpinJump = True Then .Jump = .Jump - 6
                        Player(A).Jump = 0
                        If Player(A).Location.SpeedY <= 0 Then Player(A).Location.SpeedY = 0.1
                        Player(A).CanJump = False
                        NewEffect 75, newLoc(Player(B).Location.X + Player(B).Location.Width / 2 - 16, Player(B).Location.Y + Player(B).Location.Height - 16)
                    ElseIf HitSpot = 5 Then
                        If Player(A).Location.X + Player(A).Location.Width / 2 > Player(B).Location.X + Player(B).Location.Width / 2 Then
                            Player(A).Bumped2 = 1
                            Player(B).Bumped2 = -1
                        ElseIf Player(A).Location.X + Player(A).Location.Width / 2 < Player(B).Location.X + Player(B).Location.Width / 2 Then
                            Player(A).Bumped2 = -1
                            Player(B).Bumped2 = 1
                        ElseIf Int(Rnd * 2) = 1 Then
                            Player(A).Bumped2 = -1
                            Player(B).Bumped2 = 1
                        Else
                            Player(A).Bumped2 = 1
                            Player(B).Bumped2 = -1
                        End If
                        'If Player(A).Bumped2 < -1 Then Player(A).Bumped2 = -1 - Rnd
                        'If Player(A).Bumped2 > 1 Then Player(A).Bumped2 = 1 + Rnd
                        'If Player(B).Bumped2 < -1 Then Player(B).Bumped2 = -1 - Rnd
                        'If Player(B).Bumped2 > 1 Then Player(B).Bumped2 = 1 + Rnd
                    End If
                    If BattleMode = True Then
                        If HitSpot = 1 And Player(A).Mount = 1 Then
                            PlayerHurt B
                        ElseIf HitSpot = 3 And Player(B).Mount = 1 Then
                            PlayerHurt A
                        End If
                    End If
                End If
            End If
        Next B
    End With
End Sub

Public Sub PlayerGrabCode(A As Integer, Optional DontResetGrabTime As Boolean = False)
'this code handles all the grab related stuff
'for grabbing something while walking into it, refer to the NPC collision code in sub UpdatePlayer()
    Dim tempLocation As Location
    Dim LayerNPC As Integer
    Dim B As Integer
    Dim C As Integer
    Dim tempBool As Boolean
    Dim lyrX As Double
    Dim lyrY As Double
    With Player(A)
        If .StandingOnNPC <> 0 And .HoldingNPC = 0 Then
            If NPCGrabFromTop(NPC(.StandingOnNPC).Type) = True Then
                If ((.Controls.Run = True And .Controls.Down = True) Or ((.Controls.Down = True Or .Controls.Run = True) And .GrabTime > 0)) And (.RunRelease = True Or .GrabTime > 0) And .TailCount = 0 Then
                    If (.GrabTime >= 12 And .Character < 3) Or (.GrabTime >= 16 And .Character = 3) Or (.GrabTime >= 8 And .Character = 4) Then
                        .Location.SpeedX = .GrabSpeed
                        .GrabSpeed = 0
                        .GrabTime = 0
                        .TailCount = 0
                        If .Character = 1 Or .Character = 2 Then UnDuck A
                        .HoldingNPC = .StandingOnNPC
                        .Location.SpeedY = NPC(.StandingOnNPC).Location.SpeedY
                        If .Location.SpeedY = 0 Then .Location.SpeedY = 0.01
                        .CanJump = False
                        If NPCIsAShell(NPC(.StandingOnNPC).Type) = True Then
                            .Location.SpeedX = NPC(.StandingOnNPC).Location.SpeedX
                        End If
                        NPC(.StandingOnNPC).HoldingPlayer = A
                        NPC(.StandingOnNPC).CantHurt = Physics.NPCCanHurtWait
                        NPC(.StandingOnNPC).CantHurtPlayer = A
                        NPC(.StandingOnNPC).Direction = .Direction
                        NPCFrames .StandingOnNPC
                        If NPC(.StandingOnNPC).Type = 91 Then
                            .Location.SpeedX = .Location.SpeedX + NPC(.StandingOnNPC).Location.SpeedX
                            With NPC(.StandingOnNPC)
                                .Direction = Player(A).Direction
                                .Generator = False
                                .Frame = 0
                                .Frame = EditorNPCFrame(.Type, .Direction)
                                .Type = .Special
                                If .Type = 287 Then
                                    .Type = RandomBonus
                                    .DefaultSpecial = .Type
                                End If
                                CharStuff Player(A).StandingOnNPC
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
                                NPCFrames Player(A).StandingOnNPC
                            End With
                            .StandingOnNPC = 0
                        End If
                    Else
                        If .GrabTime = 0 Then
                            If NPC(.StandingOnNPC).Type = 91 Or NPCIsVeggie(NPC(.StandingOnNPC).Type) = True Then
                                PlaySound 73
                            Else
                                PlaySound 23
                            End If
                            .FrameCount = 0
                            .GrabSpeed = .Location.SpeedX
                        End If
                        .Location.SpeedX = 0
                        .GrabTime = .GrabTime + 1
                        .Slide = False
                    End If
                Else
                    .GrabTime = 0
                End If
            Else
                .GrabTime = 0
            End If
        ElseIf DontResetGrabTime = False Then
            .GrabTime = 0
        End If
        If .HoldingNPC > numNPCs Then .HoldingNPC = 0 'Can't hold an NPC that is dead
        If .HoldingNPC > 0 Then
            lyrX = NPC(.HoldingNPC).Location.X
            lyrY = NPC(.HoldingNPC).Location.Y
            LayerNPC = .HoldingNPC
            If NPC(.HoldingNPC).Type = 278 Or NPC(.HoldingNPC).Type = 279 Then
                If .Jump = 0 Then
                    NPC(.HoldingNPC).Special = 1
                ElseIf .Jump > 0 And NPC(.HoldingNPC).Special = 1 Then
                    .Jump = .Jump * 1.5
                    NPC(.HoldingNPC).Special = 0
                End If
                If NPC(.HoldingNPC).Type = 279 Then
                    NPC(.HoldingNPC).Special2 = NPC(.HoldingNPC).Special2 + 1
                    If .SpinJump = True Then
                        If NPC(.HoldingNPC).Special3 = 0 Then
                            NPC(.HoldingNPC).Special3 = .Direction
                        ElseIf NPC(.HoldingNPC).Special3 = -.Direction And NPC(.HoldingNPC).Special2 >= 25 Then
                            NPC(.HoldingNPC).Special3 = .Direction
                            NPC(.HoldingNPC).Special2 = 100
                        ElseIf NPC(.HoldingNPC).Special2 >= 25 Then
                            NPC(.HoldingNPC).Special2 = 25
                        End If
                        
                    End If
                    
                    
                    If NPC(.HoldingNPC).Special2 = 20 Or NPC(.HoldingNPC).Special2 = 40 Or NPC(.HoldingNPC).Special2 = 60 Or NPC(.HoldingNPC).Special2 = 80 Then
                        If NPC(.HoldingNPC).Special2 = 20 Or NPC(.HoldingNPC).Special2 = 60 Then
                            B = 1
                        ElseIf NPC(.HoldingNPC).Special2 = 40 Then
                            B = 2
                        ElseIf NPC(.HoldingNPC).Special2 = 80 Then
                            B = 3
                            NPC(.HoldingNPC).Special2 = 0
                        End If
                        
                            PlaySound 82
                        
                        'For B = 1 To 3
                            numNPCs = numNPCs + 1
                            With NPC(numNPCs)
                                .CantHurt = 10000
                                .CantHurtPlayer = A
                                .BattleOwner = A
                                .Type = 108
                                .Location.Width = NPCWidth(108)
                                .Location.Height = NPCHeight(108)
                                .Active = True
                                .TimeLeft = NPC(Player(A).HoldingNPC).TimeLeft
                                .Layer = "Spawned NPCs"
                                .Location.Y = NPC(Player(A).HoldingNPC).Location.Y + NPC(Player(A).HoldingNPC).Location.Height - .Location.Height
                                .Direction = Player(A).Direction
                                If .Direction = 1 Then
                                    .Location.X = NPC(Player(A).HoldingNPC).Location.X + NPC(Player(A).HoldingNPC).Location.Width * 2 - 8
                                Else
                                    .Location.X = NPC(Player(A).HoldingNPC).Location.X - .Location.Width - NPC(Player(A).HoldingNPC).Location.Width + 8
                                End If
                                
                                If B = 1 Then
                                    .Location.SpeedX = 7 * .Direction + (Player(A).Location.SpeedX / 3.5)
                                ElseIf B = 2 Then
                                    .Location.SpeedX = 6.5 * .Direction + (Player(A).Location.SpeedX / 3.5)
                                    .Location.SpeedY = -1.5
                                Else
                                    .Location.SpeedX = 6.5 * .Direction + (Player(A).Location.SpeedX / 3.5)
                                    .Location.SpeedY = 1.5
                                End If
                                
                                .Projectile = True
                                .Frame = EditorNPCFrame(.Type, .Direction)
                            End With
                        'Next B
                    End If
                End If
            End If
        
            If NPC(.HoldingNPC).Type = 263 Then NPC(.HoldingNPC).Special3 = 0
            NPC(.HoldingNPC).TimeLeft = Physics.NPCTimeOffScreen
            NPC(.HoldingNPC).Effect = 0
            NPC(.HoldingNPC).CantHurt = Physics.NPCCanHurtWait
            NPC(.HoldingNPC).CantHurtPlayer = A
            If NPCIsVeggie(NPC(.HoldingNPC).Type) Then NPC(.HoldingNPC).CantHurt = 1000
            If .Controls.Run = True Or .ForceHold > 0 Then
            
            'hold above head
                If .Character = 3 Or .Character = 4 Or (.Duck = True) Then
                    NPC(.HoldingNPC).Bouce = True
                    NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2
                    If .Character = 3 Then 'princess peach
                        If .State = 1 Then
                            NPC(.HoldingNPC).Location.Y = .Location.Y - NPC(.HoldingNPC).Location.Height
                        Else
                            NPC(.HoldingNPC).Location.Y = .Location.Y - NPC(.HoldingNPC).Location.Height + 6
                        End If
                    Else 'toad
                        If .State = 1 Then
                            NPC(.HoldingNPC).Location.Y = .Location.Y - NPC(.HoldingNPC).Location.Height + 6
                        Else
                            If NPC(.HoldingNPC).Type = 13 Or NPC(.HoldingNPC).Type = 265 Then
                                NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2 + Rnd * 4 - 2
                                NPC(.HoldingNPC).Location.Y = .Location.Y - NPC(.HoldingNPC).Location.Height - 4 + Rnd * 4 - 2
                            Else
                                NPC(.HoldingNPC).Location.Y = .Location.Y - NPC(.HoldingNPC).Location.Height + 10
                            End If
                        End If
                    End If
                Else
                    If .Direction > 0 Then
                        NPC(.HoldingNPC).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State)
                    Else
                        NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width - Physics.PlayerGrabSpotX(.Character, .State) - NPC(.HoldingNPC).Location.Width
                    End If
                    NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                End If
                If NPC(.HoldingNPC).Type = 49 And FreezeNPCs = False Then
                    With NPC(.HoldingNPC)
                        If .Special = 0 Then
                            .Special = 1
                            .Special2 = numNPCs + 1
                            numNPCs = numNPCs + 1
                            With NPC(numNPCs)
                                .Active = True
                                .Section = Player(A).Section
                                .TimeLeft = 100
                                .Type = 50
                                .Location.Height = 32
                                .Location.Width = 48
                                .Special = A
                                If Player(A).Direction > 0 Then .Frame = 2
                            End With
                        End If
                    End With
                    For B = 1 To numNPCs
                        If NPC(B).Type = 50 And NPC(B).Special = A Then
                            NPC(B).CantHurt = 10
                            NPC(B).CantHurtPlayer = A
                            NPC(B).Projectile = True
                            NPC(B).Direction = .Direction
                            NPC(B).TimeLeft = 100
                            If .Direction > 0 Then
                                NPC(B).Location.X = NPC(.HoldingNPC).Location.X + 32
                            Else
                                NPC(B).Location.X = NPC(.HoldingNPC).Location.X - NPC(B).Location.Width
                            End If
                            NPC(B).Location.Y = NPC(.HoldingNPC).Location.Y
                        End If
                    Next B
                End If
            Else
                NPC(.HoldingNPC).Location.SpeedX = 0
                NPC(.HoldingNPC).Location.SpeedY = 0
                NPC(.HoldingNPC).WallDeath = 5
                If NPC(.HoldingNPC).Type = 29 Then NPCHit .HoldingNPC, 3, .HoldingNPC
                If NPCIsACoin(NPC(.HoldingNPC).Type) And .Controls.Down = False Then NewEffect 10, NPC(.HoldingNPC).Location 'Smoke effect for coins
                If .Controls.Up = True And Not NPCIsACoin(NPC(.HoldingNPC).Type) And Not NPC(.HoldingNPC).Type = 17 Then 'Throw the npc up
                    If NPCIsAShell(NPC(.HoldingNPC).Type) Or NPC(.HoldingNPC).Type = 45 Or NPC(.HoldingNPC).Type = 263 Then
                        If .Controls.Left = True Or .Controls.Right = True Then 'Up and forward
                            NPC(.HoldingNPC).Location.SpeedX = Physics.NPCShellSpeed * .Direction
                            NPC(.HoldingNPC).Location.SpeedY = -7
                            tempLocation.Height = 0
                            tempLocation.Width = 0
                            tempLocation.Y = (.Location.Y + NPC(.HoldingNPC).Location.Y * 4) / 5
                            tempLocation.X = (.Location.X + NPC(.HoldingNPC).Location.X * 4) / 5
                            If NPC(.HoldingNPC).Type <> 263 Then NewEffect 132, tempLocation
                        Else
                            NPC(.HoldingNPC).Location.SpeedY = -Physics.NPCShellSpeedY
                            tempLocation.Height = 0
                            tempLocation.Width = 0
                            tempLocation.Y = (.Location.Y + NPC(.HoldingNPC).Location.Y * 4) / 5
                            tempLocation.X = (.Location.X + NPC(.HoldingNPC).Location.X * 4) / 5
                            If NPC(.HoldingNPC).Type <> 263 Then NewEffect 132, tempLocation
                        End If
                    Else
                        If .Controls.Left = True Or .Controls.Right = True Then 'Up and forward
                            If .Character = 3 Or .Character = 4 Then
                                NPC(.HoldingNPC).Location.SpeedX = 5 * .Direction
                                NPC(.HoldingNPC).Location.SpeedY = -6
                            Else
                                NPC(.HoldingNPC).Location.SpeedY = -8
                                NPC(.HoldingNPC).Location.SpeedX = 3 * .Direction
                            End If
                        Else
                            NPC(.HoldingNPC).Location.SpeedY = -10
                            If .Character = 3 Then NPC(.HoldingNPC).Location.SpeedY = -9 'peach
                        End If
                    End If
                    With NPC(.HoldingNPC) ' make sure to change up and no controls throw as well
                        If NPCIsVeggie(.Type) = True Or .Type = 19 Or .Type = 20 Or .Type = 25 Or .Type = 129 Or .Type = 130 Or .Type = 131 Or .Type = 132 Or .Type = 134 Or .Type = 135 Or .Type = 154 Or .Type = 155 Or .Type = 156 Or .Type = 157 Or .Type = 40 Or .Type = 240 Or .Type = 13 Or .Type = 265 Or .Type = 288 Or .Type = 291 Then
                            PlaySound 75
                        Else
                            PlaySound 9
                        End If
                    End With
                    NPC(.HoldingNPC).Projectile = True
                ElseIf .Controls.Down = True And NPC(.HoldingNPC).Type <> 17 Then 'Drop
                    tempBool = False
                    If (.Direction = 1 And .Location.SpeedX > 3) Or (.Direction = -1 And .Location.SpeedX < -3) Then
                        tempBool = True
                    End If
                    If tempBool = True And NPC(.HoldingNPC).Type = 195 Then
                        .Location.SpeedX = 0
                        NPC(.HoldingNPC).Location.SpeedX = Physics.NPCShellSpeed * .Direction
                        NPC(.HoldingNPC).Projectile = True
                        NPC(.HoldingNPC).CantHurt = 0
                        NPC(.HoldingNPC).CantHurtPlayer = 0
                        NPC(.HoldingNPC).HoldingPlayer = 0
                        PlaySound 9
                        With NPC(.HoldingNPC)
                            NewEffect 73, newLoc(.Location.X, .Location.Y + .Location.Height - 16)
                        End With
                        NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2
                        NPC(.HoldingNPC).Location.Y = .Location.Y + .Location.Height - NPC(.HoldingNPC).Location.Height
                        .Location.Y = NPC(.HoldingNPC).Location.Y - .Location.Height
                        NPC(.HoldingNPC).Location.SpeedY = .Location.SpeedY
                        .StandingOnNPC = .HoldingNPC
                        .HoldingNPC = 0
                        .ShellSurf = True
                        .Jump = 0
                        .Location.SpeedY = 10
                    Else
                        If .Direction = 1 Then
                            NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width + 0.1
                        Else
                            NPC(.HoldingNPC).Location.X = .Location.X - NPC(.HoldingNPC).Location.Width - 0.1
                        End If
                        NPC(.HoldingNPC).Projectile = False
                        If NPC(.HoldingNPC).Type = 272 Then NPC(.HoldingNPC).Projectile = True
                        If .StandingOnNPC <> 0 Then
                            NPC(.HoldingNPC).Location.Y = NPC(.HoldingNPC).Location.Y + NPC(.StandingOnNPC).Location.SpeedY
                        End If
                    End If
                    If NPC(.HoldingNPC).Type = 13 Or NPC(.HoldingNPC).Type = 265 Or NPC(.HoldingNPC).Type = 291 Then
                        NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2
                        If .State = 1 Then
                            NPC(.HoldingNPC).Location.Y = .Location.Y - NPC(.HoldingNPC).Location.Height
                        Else
                            NPC(.HoldingNPC).Location.Y = .Location.Y - NPC(.HoldingNPC).Location.Height + 6
                        End If
                        PlaySound 75
                        NPC(.HoldingNPC).Location.SpeedX = 0
                        NPC(.HoldingNPC).Location.SpeedY = 20
                    End If
                ElseIf Not (NPCIsAShell(NPC(.HoldingNPC).Type)) And Not NPC(.HoldingNPC).Type = 45 And Not NPC(.HoldingNPC).Type = 263 And Not NPCIsACoin(NPC(.HoldingNPC).Type) Then      'if not a shell or a coin the kick it up and forward
                    
                'peach
                    If .Character = 3 Then
                        If NPC(.HoldingNPC).Type = 13 Or NPC(.HoldingNPC).Type = 265 Or (.Location.SpeedY <> 0 And .StandingOnNPC = 0 And .Slope = 0) Then
                            NPC(.HoldingNPC).Location.SpeedX = 5 * .Direction + .Location.SpeedX * 0.3
                            NPC(.HoldingNPC).Location.SpeedY = 3
                        Else
                            NPC(.HoldingNPC).Location.SpeedX = 5 * .Direction + .Location.SpeedX * 0.3
                            NPC(.HoldingNPC).Location.SpeedY = 0
                        End If
                'toad
                    ElseIf .Character = 4 Then
                        If NPC(.HoldingNPC).Type = 13 Or NPC(.HoldingNPC).Type = 265 Or (.Location.SpeedY <> 0 And .StandingOnNPC = 0 And .Slope = 0) Then
                            NPC(.HoldingNPC).Location.SpeedX = 6 * .Direction + .Location.SpeedX * 0.4
                            NPC(.HoldingNPC).Location.SpeedY = 3.5
                        Else
                            NPC(.HoldingNPC).Location.SpeedX = 6 * .Direction + .Location.SpeedX * 0.4
                            NPC(.HoldingNPC).Location.SpeedY = 0
                            NPC(.HoldingNPC).CantHurt = NPC(.HoldingNPC).CantHurt * 2
                        End If
                    Else
                        NPC(.HoldingNPC).Location.SpeedX = 5 * .Direction
                        NPC(.HoldingNPC).Location.SpeedY = -6
                    End If
                    NPC(.HoldingNPC).Projectile = True
                    With NPC(.HoldingNPC) ' make sure to change up and no controls throw as well
                        If NPCIsVeggie(.Type) = True Or .Type = 19 Or .Type = 20 Or .Type = 25 Or .Type = 129 Or .Type = 130 Or .Type = 131 Or .Type = 132 Or .Type = 134 Or .Type = 135 Or .Type = 154 Or .Type = 155 Or .Type = 156 Or .Type = 157 Or .Type = 40 Or .Type = 240 Or .Type = 13 Or .Type = 265 Or .Type = 288 Or .Type = 291 Then
                            PlaySound 75
                        ElseIf .Type = 17 Then
                            PlaySound 22
                        Else
                            PlaySound 9
                        End If
                    End With
                ElseIf NPCIsAShell(NPC(.HoldingNPC).Type) = True Then
                    NPC(.HoldingNPC).Location.SpeedY = 0
                    NPC(.HoldingNPC).Location.SpeedX = 0
                    NPC(.HoldingNPC).HoldingPlayer = 0
                    NPC(.HoldingNPC).CantHurt = 0
                    NPC(.HoldingNPC).CantHurtPlayer = 0
                    NPC(.HoldingNPC).Projectile = False
                    NPCHit .HoldingNPC, 1, A
                    tempLocation.Height = 0
                    tempLocation.Width = 0
                    tempLocation.Y = (.Location.Y + NPC(.HoldingNPC).Location.Y * 4) / 5
                    tempLocation.X = (.Location.X + NPC(.HoldingNPC).Location.X * 4) / 5
                    NewEffect 132, tempLocation
                ElseIf NPC(.HoldingNPC).Type = 263 Then
                     PlaySound 9
                    NPC(.HoldingNPC).Location.SpeedX = Physics.NPCShellSpeed * .Direction
                    NPC(.HoldingNPC).CantHurt = Physics.NPCCanHurtWait
                    NPC(.HoldingNPC).CantHurtPlayer = A
                    NPC(.HoldingNPC).Projectile = True
                End If
                If NPC(.HoldingNPC).Type = 134 And NPC(.HoldingNPC).Location.SpeedX <> 0 Then
                    NPC(.HoldingNPC).Location.SpeedX = NPC(.HoldingNPC).Location.SpeedX + .Location.SpeedX * 0.5
                    If .StandingOnNPC <> 0 Then
                        NPC(.HoldingNPC).Location.SpeedX = NPC(.HoldingNPC).Location.SpeedX + NPC(.StandingOnNPC).Location.SpeedX
                    End If
                End If
                If NPC(.HoldingNPC).Type = 13 And NPC(.HoldingNPC).Special = 4 Then 'give toad fireballs a little spunk
                    If NPC(.HoldingNPC).Location.SpeedY < 0 Then NPC(.HoldingNPC).Location.SpeedY = NPC(.HoldingNPC).Location.SpeedY * 1.1
                End If
                If NPC(.HoldingNPC).Type = 291 Then
                    If .Location.SpeedX <> 0 And NPC(.HoldingNPC).Location.SpeedX <> 0 Then
                        NPC(.HoldingNPC).Location.SpeedX = NPC(.HoldingNPC).Location.SpeedX + .Location.SpeedX * 0.5
                    End If
                End If
                
            If NPC(.HoldingNPC).Type = 292 Then
                NPC(.HoldingNPC).Special5 = A
                NPC(.HoldingNPC).Special6 = .Direction
                NPC(.HoldingNPC).Location.SpeedY = -8
                NPC(.HoldingNPC).Location.SpeedX = 12 * .Direction + .Location.SpeedX
                NPC(.HoldingNPC).Projectile = True
            End If
                
                
                NPC(.HoldingNPC).HoldingPlayer = 0
                .HoldingNPC = 0
            End If
        End If
        
        If LayerNPC > 0 Then
            With NPC(LayerNPC)
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
            End With
        End If
        
    End With
End Sub

Public Sub LinkFrame(A As Integer)
    Dim tempLocation As Location
    With Player(A)
        'Hurt frame
        If .FrameCount = -10 Then
            If .SwordPoke = 0 Then
                If .Location.SpeedY = 0 Or .StandingOnNPC <> 0 Or .Slope <> 0 Or .Wet > 0 Or .Immune = 0 Then 'Hurt Frame
                    .FrameCount = 0
                Else
                    .Frame = 11
                    Exit Sub
                End If
            Else
                .FrameCount = 0
            End If
        End If
        If .Stoned = True Then
            .Frame = 12
            If .Location.SpeedX <> 0 Then
                If .Location.SpeedY = 0 Or .Slope > 0 Or .StandingOnNPC <> 0 Then
                    If .SlideCounter <= 0 Then
                        .SlideCounter = 2 + Rnd * 2
                        tempLocation.Y = .Location.Y + .Location.Height - 5
                        tempLocation.X = .Location.X + .Location.Width / 2 - 4
                        NewEffect 74, tempLocation, , , ShadowMode
                    End If
                End If
            End If
            Exit Sub
        End If
        If LevelSelect = False And .Effect = 0 And .FireBallCD = 0 Then
            If .Controls.Left = True Then .Direction = -1
            If .Controls.Right = True Then .Direction = 1
        End If
        If .Fairy = True Then Exit Sub
        If .SwordPoke < 0 Then 'Drawing back
            If .Duck = False Then
                .Frame = 6
            Else
                .Frame = 8
            End If
        ElseIf .SwordPoke > 0 Then 'Stabbing
            If .Duck = False Then
                .Frame = 7
            Else
                .Frame = 8
            End If
        ElseIf .Mount = 2 Then 'Clown Car
            .Frame = 1
            .MountFrame = SpecialFrame(2)
            If .Direction = 1 Then .MountFrame = .MountFrame + 4
        ElseIf .Duck = True Then 'Ducking
            .Frame = 5
        ElseIf .WetFrame = True And .Location.SpeedY <> 0 And .Slope = 0 And .StandingOnNPC = 0 And .Duck = False And .Quicksand = 0 Then  'Link is swimming
            If .Location.SpeedY < 0.5 Or .Frame <> 3 Then
                If .Frame <> 1 And .Frame <> 2 And .Frame <> 3 And .Frame <> 4 Then .FrameCount = 6
                .FrameCount = .FrameCount + 1
                If .FrameCount < 6 Then
                    .Frame = 3
                ElseIf .FrameCount < 12 Then
                    .Frame = 2
                ElseIf .FrameCount < 18 Then
                    .Frame = 3
                ElseIf .FrameCount < 24 Then
                    .Frame = 1
                Else
                    .Frame = 3
                    .FrameCount = 0
                End If
            Else
                .Frame = 3
            End If
        ElseIf .Location.SpeedY <> 0 And .StandingOnNPC = 0 And .Slope = 0 And Not (.Quicksand > 0 And .Location.SpeedY > 0) Then 'Jumping/falling
            If .Location.SpeedY < 0 Then
                If .Controls.Up = True Then
                    .Frame = 10
                Else
                    .Frame = 5
                End If
            Else
                If .Controls.Down = True Then
                    .Frame = 9
                Else
                    .Frame = 3
                End If
            End If
        ElseIf .Location.SpeedX = 0 Or (.Slippy = True And .Controls.Left = False And .Controls.Right = False) Then  'Standing
            .Frame = 1
        Else 'Running
            .FrameCount = .FrameCount + 1
            If .Location.SpeedX > Physics.PlayerWalkSpeed - 1.5 Or .Location.SpeedX < -Physics.PlayerWalkSpeed + 1.5 Then .FrameCount = .FrameCount + 1
            If .Location.SpeedX > Physics.PlayerWalkSpeed Or .Location.SpeedX < -Physics.PlayerWalkSpeed Then .FrameCount = .FrameCount + 1
            If .Location.SpeedX > Physics.PlayerWalkSpeed + 1 Or .Location.SpeedX < -Physics.PlayerWalkSpeed - 1 Then .FrameCount = .FrameCount + 1
            If .Location.SpeedX > Physics.PlayerWalkSpeed + 2 Or .Location.SpeedX < -Physics.PlayerWalkSpeed - 2 Then .FrameCount = .FrameCount + 1
            If .FrameCount >= 8 Then
                .FrameCount = 0
                .Frame = .Frame - 1
            End If
            If .Frame <= 0 Then
                .Frame = 4
            ElseIf .Frame >= 5 Then
                .Frame = 1
            End If
            If .Location.SpeedX >= Physics.PlayerRunSpeed * 0.9 Or .Location.SpeedX <= -Physics.PlayerRunSpeed * 0.9 Then
                If .SlideCounter <= 0 Then
                    PlaySound 86
                    .SlideCounter = 2 + Rnd * 2
                    tempLocation.Y = .Location.Y + .Location.Height - 4
                    If .Location.SpeedX < 0 Then
                        tempLocation.X = .Location.X + .Location.Width / 2 - 6 - 4
                    Else
                        tempLocation.X = .Location.X + .Location.Width / 2 + 6 - 4
                    End If
                    NewEffect 74, tempLocation, , , ShadowMode
                End If
            End If
        End If
    End With
End Sub

Private Sub PlayerEffects(A As Integer)
    Dim B As Integer
    Dim C As Single
    Dim D As Single
    Dim tempBool As Boolean
    Dim tempLocation As Location
    With Player(A)
        If .Effect <> 8 And .Fairy = True Then
            .Fairy = False
            SizeCheck A
        End If
        .TailCount = 0
        .Pinched1 = 0
        .Pinched2 = 0
        .Pinched3 = 0
        .Pinched4 = 0
        .NPCPinched = 0
        .SwordPoke = 0
        If .YoshiBlue = False And .Effect <> 500 Then
            .CanFly = False
            .CanFly2 = False
            .RunCount = 0
        End If
        .Immune2 = False
        If .Effect = 1 Then 'Player growing effect

            .Frame = 1
            .Effect2 = .Effect2 + 1
            If .Effect2 / 5 = Int(.Effect2 / 5) Then
                If .State = 1 Then
                    .State = 2
                    If .Mount = 0 Then
                        .Location.X = .Location.X - Physics.PlayerWidth(.Character, 2) * 0.5 + Physics.PlayerWidth(.Character, 1) * 0.5
                        .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, 2) + Physics.PlayerHeight(.Character, 1)
                        .Location.Width = Physics.PlayerWidth(.Character, .State)
                        .Location.Height = Physics.PlayerHeight(.Character, .State)
                    ElseIf .Mount = 3 Then
                        YoshiHeight A
                    ElseIf .Character = 2 And .Mount <> 2 Then
                        .Location.Y = .Location.Y - Physics.PlayerHeight(2, 2) + Physics.PlayerHeight(1, 2)
                        .Location.Height = Physics.PlayerHeight(.Character, .State)
                    End If
                Else
                    .State = 1
                    If .Mount = 0 Then
                        .Location.X = .Location.X - Physics.PlayerWidth(.Character, 1) * 0.5 + Physics.PlayerWidth(.Character, 2) * 0.5
                        .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, 1) + Physics.PlayerHeight(.Character, 2)
                        .Location.Width = Physics.PlayerWidth(.Character, .State)
                        .Location.Height = Physics.PlayerHeight(.Character, 1)
                    ElseIf .Mount = 3 Then
                        YoshiHeight A
                    ElseIf .Character = 2 And .Mount <> 2 Then
                        .Location.Y = .Location.Y - Physics.PlayerHeight(1, 2) + Physics.PlayerHeight(2, 2)
                        .Location.Height = Physics.PlayerHeight(1, 2)
                    End If
                End If
            End If
            If .Effect2 >= 50 And .State = 2 Then
                .Immune = .Immune + 50
                .Immune2 = True
                .Effect = 0
                .Effect2 = 0
                .StandUp = True
            End If
        ElseIf .Effect = 2 Then 'Player shrinking effect
            If .Duck = True Then
                .StandUp = True 'Fixes a block collision bug
                .Duck = False
                .Location.Height = Physics.PlayerHeight(.Character, .State)
                .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, .State) + Physics.PlayerDuckHeight(.Character, .State)
            End If
            .Frame = 1
            .Effect2 = .Effect2 + 1
            If .Effect2 / 5 = Int(.Effect2 / 5) Then
                If .State = 1 Then
                    .State = 2
                    If .Mount = 3 Then
                        YoshiHeight A
                    ElseIf Not .Mount = 2 Then
                        .Location.X = .Location.X - Physics.PlayerWidth(.Character, 2) * 0.5 + Physics.PlayerWidth(.Character, 1) * 0.5
                        .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, 2) + Physics.PlayerHeight(.Character, 1)
                        .Location.Width = Physics.PlayerWidth(.Character, .State)
                        .Location.Height = Physics.PlayerHeight(.Character, .State)
                    End If
                Else
                    .State = 1
                    If .Mount = 3 Then
                        YoshiHeight A
                    ElseIf Not .Mount = 2 Then
                        .Location.X = .Location.X - Physics.PlayerWidth(.Character, 1) * 0.5 + Physics.PlayerWidth(.Character, 2) * 0.5
                        .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, 1) + Physics.PlayerHeight(.Character, 2)
                        .Location.Width = Physics.PlayerWidth(.Character, .State)
                        .Location.Height = Physics.PlayerHeight(.Character, 1)
                    End If
                End If
            End If
            If .Effect2 >= 50 Then
                If .State = 2 Then
                    .State = 1
                    If Not .Mount = 2 Then
                        .Location.X = .Location.X - Physics.PlayerWidth(.Character, 1) * 0.5 + Physics.PlayerWidth(.Character, 2) * 0.5
                        .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, 1) + Physics.PlayerHeight(.Character, 2)
                        .Location.Width = Physics.PlayerWidth(.Character, .State)
                        .Location.Height = Physics.PlayerHeight(.Character, .State)
                    End If
                End If
                .Immune = 150
                .Immune2 = True
                .Effect = 0
                .Effect2 = 0
                'If numPlayers <= 2 Then DropBonus A
            End If
        ElseIf .Effect = 227 Then 'Player losing firepower
            If .Duck = True Then
                .StandUp = True 'Fixes a block collision bug
                .Duck = False
                .Location.Height = Physics.PlayerHeight(.Character, .State)
                .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, .State) + Physics.PlayerDuckHeight(.Character, .State)
            End If
            .Frame = 1
            .Effect2 = .Effect2 + 1
            If .Effect2 / 5 = Int(.Effect2 / 5) Then
                If .State = 2 Then
                    .State = 3
                Else
                    .State = 2
                End If
            End If
            If .Effect2 >= 50 Then
                If .State = 3 Then
                    .State = 2
                End If
                .Immune = 150
                .Immune2 = True
                .Effect = 0
                .Effect2 = 0
                'If numPlayers <= 2 Then DropBonus A
            End If
        ElseIf .Effect = 228 Then 'Player losing icepower
            If .Duck = True Then
                .StandUp = True 'Fixes a block collision bug
                .Duck = False
                .Location.Height = Physics.PlayerHeight(.Character, .State)
                .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, .State) + Physics.PlayerDuckHeight(.Character, .State)
            End If
            .Frame = 1
            .Effect2 = .Effect2 + 1
            If .Effect2 / 5 = Int(.Effect2 / 5) Then
                If .State = 2 Then
                    .State = 7
                Else
                    .State = 2
                End If
            End If
            If .Effect2 >= 50 Then
                If .State = 7 Then
                    .State = 2
                End If
                .Immune = 150
                .Immune2 = True
                .Effect = 0
                .Effect2 = 0
                'If numPlayers <= 2 Then DropBonus A
            End If
        ElseIf .Effect = 3 Then 'Warp effect
            .SpinJump = False
            .TailCount = 0
            .Location.SpeedY = 0
            If .Effect2 = 0 Then
                If Warp(.Warp).Direction = 3 Then
                    .Location.Y = .Location.Y + 1
                    .Location.X = Warp(.Warp).Entrance.X + Warp(.Warp).Entrance.Width / 2 - .Location.Width / 2
                    If .Location.Y > Warp(.Warp).Entrance.Y + Warp(.Warp).Entrance.Height + 8 Then
                        .Effect2 = 1
                    End If
                    If .Mount = 0 Then .Frame = 15
                    If .HoldingNPC > 0 Then
                        NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                        NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2
                    End If
                ElseIf Warp(.Warp).Direction = 1 Then
                    .Location.Y = .Location.Y - 1
                    .Location.X = Warp(.Warp).Entrance.X + Warp(.Warp).Entrance.Width / 2 - .Location.Width / 2
                    If .Location.Y + .Location.Height + 8 < Warp(.Warp).Entrance.Y Then
                        .Effect2 = 1
                    End If
                    If .HoldingNPC > 0 Then
                        NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                        NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2
                    End If
                    If .Mount = 0 Then .Frame = 15
                ElseIf Warp(.Warp).Direction = 2 Then
                    If .Mount = 3 Then
                        .Duck = True
                        .Location.Height = 30
                    End If
                    .Direction = -1
                    .Location.Y = Warp(.Warp).Entrance.Y + Warp(.Warp).Entrance.Height - .Location.Height - 2
                    .Location.X = .Location.X - 0.5
                    If .Location.X + .Location.Width + 8 < Warp(.Warp).Entrance.X Then
                        .Effect2 = 1
                    End If
                    If .HoldingNPC > 0 Then
                        NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                        If .Direction > 0 Then
                            NPC(.HoldingNPC).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State)
                        Else
                            NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width - Physics.PlayerGrabSpotX(.Character, .State) - NPC(.HoldingNPC).Location.Width
                        End If
                    End If
                    .Location.SpeedX = -0.5
                    PlayerFrame A
                    .Location.SpeedX = 0
                ElseIf Warp(.Warp).Direction = 4 Then
                    If .Mount = 3 Then
                        .Duck = True
                        .Location.Height = 30
                    End If
                    .Direction = 1
                    .Location.Y = Warp(.Warp).Entrance.Y + Warp(.Warp).Entrance.Height - .Location.Height - 2
                    .Location.X = .Location.X + 0.5
                    If .Location.X > Warp(.Warp).Entrance.X + Warp(.Warp).Entrance.Width + 8 Then
                        .Effect2 = 1
                    End If
                    If .HoldingNPC > 0 Then
                        NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                        If .Direction > 0 Then
                            NPC(.HoldingNPC).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State)
                        Else
                            NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width - Physics.PlayerGrabSpotX(.Character, .State) - NPC(.HoldingNPC).Location.Width
                        End If
                    End If
                    .Location.SpeedX = 0.5
                    PlayerFrame A
                    .Location.SpeedX = 0
                End If
            ElseIf .Effect2 = 1 Then
                If Warp(.Warp).NoYoshi = True Then
                    If OwedMount(A) = 0 And .Mount > 0 And .Mount <> 2 Then
                        OwedMount(A) = .Mount
                        OwedMountType(A) = .MountType
                    End If
                    UnDuck A
                    .Mount = 0
                    .MountType = 0
                    .MountOffsetY = 0
                    SizeCheck A
                End If
                If Warp(.Warp).Direction2 = 1 Then
                    .Location.X = Warp(.Warp).Exit.X + Warp(.Warp).Exit.Width / 2 - .Location.Width / 2
                    .Location.Y = Warp(.Warp).Exit.Y - .Location.Height - 8
                    If .Mount = 0 Then .Frame = 15
                    If .HoldingNPC > 0 Then
                        NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                        NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2
                    End If
                ElseIf Warp(.Warp).Direction2 = 3 Then
                    .Location.X = Warp(.Warp).Exit.X + Warp(.Warp).Exit.Width / 2 - .Location.Width / 2
                    .Location.Y = Warp(.Warp).Exit.Y + Warp(.Warp).Exit.Height + 8
                    If .Mount = 0 Then .Frame = 15
                    If .HoldingNPC > 0 Then
                        NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                        NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2
                    End If
                ElseIf Warp(.Warp).Direction2 = 2 Then
                    If .Mount = 3 Then
                        .Duck = True
                        .Location.Height = 30
                    End If
                    .Location.X = Warp(.Warp).Exit.X - .Location.Width - 8
                    .Location.Y = Warp(.Warp).Exit.Y + Warp(.Warp).Exit.Height - .Location.Height - 2
                    If .Mount = 0 Then .Frame = 1
                    .Direction = 1
                    If .HoldingNPC > 0 Then
                        If .State = 1 Then
                            .Frame = 5
                        Else
                            .Frame = 8
                        End If
                        NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                        .Direction = -1
                        If .Direction > 0 Then
                            NPC(.HoldingNPC).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State)
                        Else
                            NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width - Physics.PlayerGrabSpotX(.Character, .State) - NPC(.HoldingNPC).Location.Width
                        End If
                    End If
                ElseIf Warp(.Warp).Direction2 = 4 Then
                    If .Mount = 3 Then
                        .Duck = True
                        .Location.Height = 30
                    End If
                    .Location.X = Warp(.Warp).Exit.X + Warp(.Warp).Exit.Width + 8
                    .Location.Y = Warp(.Warp).Exit.Y + Warp(.Warp).Exit.Height - .Location.Height - 2
                    If .Mount = 0 Then .Frame = 1
                    .Direction = -1
                    If .HoldingNPC > 0 Then
                        If .State = 1 Then
                            .Frame = 5
                        Else
                            .Frame = 8
                        End If
                        .Direction = 1
                        NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                        If .Direction > 0 Then
                            NPC(.HoldingNPC).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State)
                        Else
                            NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width - Physics.PlayerGrabSpotX(.Character, .State) - NPC(.HoldingNPC).Location.Width
                        End If
                    End If
                End If
                .Effect2 = 100
                If .Duck = True Then
                    If Warp(.Warp).Direction2 = 1 Or Warp(.Warp).Direction2 = 3 Then
                        UnDuck A
                    End If
                End If
                CheckSection A
                If .HoldingNPC > 0 Then
                    CheckSectionNPC .HoldingNPC
                End If
                If numPlayers > 2 And nPlay.Online = False Then
                    For B = 1 To numPlayers
                        If B <> A Then
                            If Warp(.Warp).Direction2 <> 3 Then
                                Player(B).Location.Y = Player(A).Location.Y + Player(A).Location.Height - Player(B).Location.Height
                            Else
                                Player(B).Location.Y = Player(A).Location.Y
                            End If
                            Player(B).Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - Player(B).Location.Width / 2
                            Player(B).Location.SpeedY = Rnd * 24 - 12
                            Player(B).Effect = 8
                            Player(B).Effect2 = 0
                            CheckSection B
                            If Player(B).HoldingNPC > 0 Then
                                CheckSectionNPC Player(B).HoldingNPC
                            End If
                        End If
                    Next B
                End If
                If Warp(.Warp).level <> "" Then
                    GoToLevel = Warp(.Warp).level
                    .Effect = 8
                    .Effect2 = 2970
                    ReturnWarp = .Warp
                    StartWarp = Warp(.Warp).LevelWarp
                ElseIf Warp(.Warp).MapWarp = True Then
                    .Effect = 8
                    .Effect2 = 2970
                End If
            ElseIf .Effect2 >= 100 Then
                .Effect2 = .Effect2 + 1
                If .Effect2 >= 110 Then
                    .Effect2 = 2
                    PlaySound 17
                End If
            ElseIf .Effect2 = 2 Then
                If Warp(.Warp).Direction2 = 1 Then
                    .Location.Y = .Location.Y + 1
                    If .Location.Y >= Warp(.Warp).Exit.Y Then
                        .Effect2 = 3
                    End If
                    If .HoldingNPC > 0 Then
                        NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                        NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2
                    End If
                    If .Mount = 0 Then .Frame = 15
                ElseIf Warp(.Warp).Direction2 = 3 Then
                    .Location.Y = .Location.Y - 1
                    If .Location.Y + .Location.Height <= Warp(.Warp).Exit.Y + Warp(.Warp).Exit.Height Then
                        .Effect2 = 3
                    End If
                    If .HoldingNPC > 0 Then
                        NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                        NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2
                    End If
                    If .Mount = 0 Then .Frame = 15
                ElseIf Warp(.Warp).Direction2 = 4 Then
                    .Location.X = .Location.X - 0.5
                    .Direction = -1
                    If .Location.X + .Location.Width <= Warp(.Warp).Exit.X + Warp(.Warp).Exit.Width Then
                        .Effect2 = 3
                    End If
                    If .HoldingNPC > 0 Then
                        If .Character >= 3 Then  'peach/toad leaving a pipe
                            .Location.SpeedX = 1
                            PlayerFrame A
                            NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                            If .Direction < 0 Then
                                NPC(.HoldingNPC).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State)
                            Else
                                NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width - Physics.PlayerGrabSpotX(.Character, .State) - NPC(.HoldingNPC).Location.Width
                            End If
                        Else
                            .Direction = 1
                            If .State = 1 Then
                                .Frame = 5
                            Else
                                .Frame = 8
                            End If
                            NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                            If .Direction > 0 Then
                                NPC(.HoldingNPC).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State)
                            Else
                                NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width - Physics.PlayerGrabSpotX(.Character, .State) - NPC(.HoldingNPC).Location.Width
                            End If
                        End If
                    Else
                        .Location.SpeedX = -0.5
                        PlayerFrame A
                        .Location.SpeedX = 0
                    End If
                ElseIf Warp(.Warp).Direction2 = 2 Then
                    .Location.X = .Location.X + 0.5
                    .Direction = 1
                    If .Location.X >= Warp(.Warp).Exit.X Then
                        .Effect2 = 3
                    End If
                    If .HoldingNPC > 0 Then
                        If .Character >= 3 Then  'peach/toad leaving a pipe
                            .Location.SpeedX = 1
                            PlayerFrame A
                            NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                            If .Direction < 0 Then
                                NPC(.HoldingNPC).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State)
                            Else
                                NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width - Physics.PlayerGrabSpotX(.Character, .State) - NPC(.HoldingNPC).Location.Width
                            End If
                        Else
                            .Direction = -1
                            If .State = 1 Then
                                .Frame = 5
                            Else
                                .Frame = 8
                            End If
                            NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                            If .Direction > 0 Then
                                NPC(.HoldingNPC).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State)
                            Else
                                NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width - Physics.PlayerGrabSpotX(.Character, .State) - NPC(.HoldingNPC).Location.Width
                            End If
                        End If
                    Else
                        .Location.SpeedX = -0.5
                        PlayerFrame A
                        .Location.SpeedX = 0
                    End If
                End If
            ElseIf .Effect2 = 3 Then
                If .HoldingNPC > 0 Then
                    If (Warp(.Warp).Direction2 = 2 Or Warp(.Warp).Direction2 = 4) Then
                        If Warp(.Warp).Direction2 = 2 Then
                            .Direction = 1
                        ElseIf Warp(.Warp).Direction2 = 4 Then
                            .Direction = -1
                        End If
                        If .State = 1 Then
                            .Frame = 5
                        Else
                            .Frame = 8
                        End If
                        If .Controls.Run = False Then .Controls.Run = True
                        PlayerGrabCode A
                    End If
                End If
                .Effect = 0
                .Effect2 = 0
                .WarpCD = 20
                .Location.SpeedY = 0
                .CanJump = False
                .CanAltJump = False
                .Location.SpeedX = 0
                .Bumped2 = 0
                If .HoldingNPC > 0 Then
                    NPC(.HoldingNPC).Effect = 0
                End If
                If numPlayers > 2 And nPlay.Online = False Then
                    For B = 1 To numPlayers
                        If B <> A Then
                            If Warp(.Warp).Direction2 <> 1 Then
                                Player(B).Location.Y = Player(A).Location.Y + Player(A).Location.Height - Player(B).Location.Height
                            Else
                                Player(B).Location.Y = Player(A).Location.Y
                            End If
                            Player(B).Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - Player(B).Location.Width / 2
                            Player(B).Location.SpeedY = Rnd * 24 - 12
                            Player(B).Effect = 0
                            Player(B).Effect2 = 0
                            CheckSection B
                        End If
                    Next B
                End If
            End If
        ElseIf .Effect = 7 Then 'Door effect
            If .HoldingNPC > 0 Then
                NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width / 2 - NPC(.HoldingNPC).Location.Width / 2
            End If
            .Effect2 = .Effect2 + 1
            If .Mount = 0 And .Character <> 5 Then .Frame = 13
            If .Character = 5 Then .Frame = 1
            If .Effect2 >= 30 Then
                If Warp(.Warp).NoYoshi = True Then
                    If OwedMount(A) = 0 And .Mount > 0 And .Mount <> 2 Then
                        OwedMount(A) = .Mount
                        OwedMountType(A) = .MountType
                    End If
                    .Mount = 0
                    .MountType = 0
                    SizeCheck A
                    .MountOffsetY = 0
                    .Frame = 1
                End If
                .Location.X = Warp(.Warp).Exit.X + Warp(.Warp).Exit.Width / 2 - .Location.Width / 2
                .Location.Y = Warp(.Warp).Exit.Y + Warp(.Warp).Exit.Height - .Location.Height
                CheckSection A
                If .HoldingNPC > 0 Then
                    If .Controls.Run = False Then .Controls.Run = True
                    PlayerGrabCode A
                End If
                .Effect = 0
                .Effect2 = 0
                .WarpCD = 40
                If Warp(.Warp).level <> "" Then
                    GoToLevel = Warp(.Warp).level
                    .Effect = 8
                    .Effect2 = 3000
                    ReturnWarp = .Warp
                    StartWarp = Warp(.Warp).LevelWarp
                ElseIf Warp(.Warp).MapWarp = True Then
                    .Effect = 8
                    .Effect2 = 2970
                End If
                If numPlayers > 2 And nPlay.Online = False Then
                    For B = 1 To numPlayers
                        If B <> A Then
                            Player(B).Location.Y = Player(A).Location.Y + Player(A).Location.Height - Player(B).Location.Height
                            Player(B).Location.X = Player(A).Location.X + Player(A).Location.Width / 2 - Player(B).Location.Width / 2
                            Player(B).Location.SpeedY = Rnd * 24 - 12
                            CheckSection B
                            If Player(B).HoldingNPC > 0 Then
                                If Player(B).Direction > 0 Then
                                    NPC(Player(B).HoldingNPC).Location.X = Player(B).Location.X + Physics.PlayerGrabSpotX(Player(B).Character, Player(B).State)
                                Else
                                    NPC(Player(B).HoldingNPC).Location.X = Player(B).Location.X + Player(B).Location.Width - Physics.PlayerGrabSpotX(Player(B).Character, Player(B).State) - NPC(.HoldingNPC).Location.Width
                                End If
                                NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
                                NPC(Player(B).HoldingNPC).Section = Player(B).Section
                            End If
                        End If
                    Next B
                End If
            End If
        ElseIf .Effect = 8 Then 'Holding Pattern
            If .Effect2 < 0 Then
                .Location.X = Player(-.Effect2).Location.X
                .Location.Y = Player(-.Effect2).Location.Y
                If Player(-.Effect2).Dead = True Then .Dead = True
            ElseIf .Effect2 <= 30 Then
                .Effect2 = .Effect2 - 1
                If .Effect2 = 0 Then
                    .Effect = 0
                    .Effect2 = 0
                End If
            ElseIf .Effect2 = 131 Then
                tempBool = False
                For B = 1 To numPlayers
                    If B <> A And CheckCollision(.Location, Player(B).Location) Then
                        tempBool = True
                    End If
                Next B
                If tempBool = False Then
                    .Effect2 = 130
                    For C = 1 To numBackground
                        If CheckCollision(Warp(.Warp).Exit, Background(C).Location) Then
                            If Background(C).Type = 88 Then
                                NewEffect 54, Background(C).Location
                            ElseIf Background(C).Type = 87 Then
                                NewEffect 55, Background(C).Location
                            ElseIf Background(C).Type = 107 Then
                                NewEffect 59, Background(C).Location
                            End If
                        End If
                    Next C
                    SoundPause(46) = 0
                    PlaySound 46
                End If
            ElseIf .Effect2 <= 130 Then
                .Effect2 = .Effect2 - 1
                If .Effect2 = 100 Then
                    .Effect = 0
                    .Effect2 = 0
                End If
            ElseIf .Effect2 <= 300 Then
                .Effect2 = .Effect2 - 1
                If .Effect2 = 200 Then
                    .Effect2 = 100
                    .Effect = 3
                End If
            ElseIf .Effect2 <= 1000 Then 'Start Wait
                .Effect2 = .Effect2 - 1
                If .Effect2 = 900 Then
                    .Effect = 3
                    .Effect2 = 100
                    If A = 2 Then
                        .Effect = 8
                        .Effect2 = 300
                    End If
                End If
            ElseIf .Effect2 <= 2000 Then 'Start Wait
                .Effect2 = .Effect2 - 1
                If .Effect2 = 1900 Then
                    For C = 1 To numBackground
                        If CheckCollision(Warp(.Warp).Exit, Background(C).Location) Then
                            If Background(C).Type = 88 Then
                                NewEffect 54, Background(C).Location
                            ElseIf Background(C).Type = 87 Then
                                NewEffect 55, Background(C).Location
                            ElseIf Background(C).Type = 107 Then
                                NewEffect 59, Background(C).Location
                            End If
                        End If
                    Next C
                    SoundPause(46) = 0
                    PlaySound 46
                    .Effect = 8
                    .Effect2 = 30
                    If A = 2 Then
                        .Effect = 8
                        .Effect2 = 131
                    End If
                End If
            ElseIf .Effect2 <= 3000 Then 'warp wait
                .Effect2 = .Effect2 - 1
                If .Effect2 = 2920 Then
                    If Warp(.Warp).MapWarp = True Then
                        LevelBeatCode = 6
                        If Not (Warp(.Warp).MapX = -1 And Warp(.Warp).MapY = -1) Then
                            WorldPlayer(1).Location.X = Warp(.Warp).MapX
                            WorldPlayer(1).Location.Y = Warp(.Warp).MapY
                            For B = 1 To numWorldLevels
                                If CheckCollision(WorldPlayer(1).Location, WorldLevel(B).Location) = True Then
                                    WorldLevel(B).Active = True
                                    curWorldLevel = B
                                End If
                            Next B
                        End If
                    End If
                    EndLevel = True
                    Exit Sub
                End If
            End If
        ElseIf .Effect = 4 Then 'Player got fire power
            If .Duck = True And .Character <> 5 Then
                UnDuck A
                .Frame = 1
            End If
            .Effect2 = .Effect2 + 1
            If .Effect2 / 5 = Int(.Effect2 / 5) Then
                If .State = 1 And .Character <> 5 Then
                    .State = 2
                    If .Mount = 0 Then
                        .Location.X = .Location.X - Physics.PlayerWidth(.Character, 2) * 0.5 + Physics.PlayerWidth(.Character, 1) * 0.5
                        .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, 2) + Physics.PlayerHeight(.Character, 1)
                        .Location.Width = Physics.PlayerWidth(.Character, .State)
                        .Location.Height = Physics.PlayerHeight(.Character, .State)
                    ElseIf .Mount = 3 Then
                        YoshiHeight A
                    ElseIf .Character = 2 And .Mount <> 2 Then
                        .Location.Y = .Location.Y - Physics.PlayerHeight(2, 2) + Physics.PlayerHeight(1, 2)
                        .Location.Height = Physics.PlayerHeight(.Character, .State)
                    End If
                ElseIf Not .State = 3 Then
                    .State = 3
                Else
                    .State = 2
                End If
            End If
            If .Effect2 >= 50 Then
                If .State = 2 Then
                    .State = 3
                End If
                .Immune = .Immune + 50
                .Immune2 = True
                .Effect = 0
                .Effect2 = 0
                .StandUp = True
            End If
        ElseIf .Effect = 41 Then 'Player got ice power
            If .Duck = True And .Character <> 5 Then
                UnDuck A
                .Frame = 1
            End If
            .Effect2 = .Effect2 + 1
            If .Effect2 / 5 = Int(.Effect2 / 5) Then
                If .State = 1 And .Character <> 5 Then
                    .State = 2
                    If .Mount = 0 Then
                        .Location.X = .Location.X - Physics.PlayerWidth(.Character, 2) * 0.5 + Physics.PlayerWidth(.Character, 1) * 0.5
                        .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, 2) + Physics.PlayerHeight(.Character, 1)
                        .Location.Width = Physics.PlayerWidth(.Character, .State)
                        .Location.Height = Physics.PlayerHeight(.Character, .State)
                    ElseIf .Mount = 3 Then
                        YoshiHeight A
                    ElseIf .Character = 2 And .Mount <> 2 Then
                        .Location.Y = .Location.Y - Physics.PlayerHeight(2, 2) + Physics.PlayerHeight(1, 2)
                        .Location.Height = Physics.PlayerHeight(.Character, .State)
                    End If
                ElseIf Not .State = 7 Then
                    .State = 7
                Else
                    .State = 2
                End If
            End If
            If .Effect2 >= 50 Then
                If .State = 2 Then
                    .State = 7
                End If
                .Immune = .Immune + 50
                .Immune2 = True
                .Effect = 0
                .Effect2 = 0
                .StandUp = True
            End If
        ElseIf .Effect = 5 Then 'Player got a leaf
            .Frame = 1
            If .Effect2 = 0 Then
                If .State = 1 And .Mount = 0 Then
                    .Location.X = .Location.X - Physics.PlayerWidth(.Character, 2) * 0.5 + Physics.PlayerWidth(.Character, 1) * 0.5
                    .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, 2) + Physics.PlayerHeight(.Character, 1)
                    .State = 4
                    .Location.Width = Physics.PlayerWidth(.Character, .State)
                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                ElseIf .Mount = 3 Then
                    YoshiHeight A
                ElseIf .Character = 2 And .State = 1 And .Mount = 1 Then
                    .Location.Y = .Location.Y - Physics.PlayerHeight(2, 2) + Physics.PlayerHeight(1, 2)
                    .Location.Height = Physics.PlayerHeight(.Character, 4)
                End If
                .State = 4
                tempLocation.Width = 32
                tempLocation.Height = 32
                tempLocation.X = .Location.X + .Location.Width / 2 - tempLocation.Width / 2
                tempLocation.Y = .Location.Y + .Location.Height / 2 - tempLocation.Height / 2
                NewEffect 131, tempLocation, , , ShadowMode
            End If
            .Effect2 = .Effect2 + 1
            If .Effect2 = 14 Then
                .Immune = .Immune + 50
                .Immune2 = True
                .Effect = 0
                .Effect2 = 0
                .StandUp = True
            End If
        ElseIf .Effect = 11 Then 'Player got a tanooki suit
            .Frame = 1
            .Immune2 = True
            If .Effect2 = 0 Then
                If .State = 1 And .Mount = 0 Then
                    .Location.X = .Location.X - Physics.PlayerWidth(.Character, 2) * 0.5 + Physics.PlayerWidth(.Character, 1) * 0.5
                    .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, 2) + Physics.PlayerHeight(.Character, 1)
                    .State = 5
                    .Location.Width = Physics.PlayerWidth(.Character, .State)
                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                ElseIf .Mount = 3 Then
                    YoshiHeight A
                ElseIf .Character = 2 And .State = 1 And .Mount = 1 Then
                    .Location.Y = .Location.Y - Physics.PlayerHeight(2, 2) + Physics.PlayerHeight(1, 2)
                    .Location.Height = Physics.PlayerHeight(.Character, 4)
                End If
                .State = 5
                tempLocation.Width = 32
                tempLocation.Height = 32
                tempLocation.X = .Location.X + .Location.Width / 2 - tempLocation.Width / 2
                tempLocation.Y = .Location.Y + .Location.Height / 2 - tempLocation.Height / 2
                NewEffect 131, tempLocation, , , ShadowMode
            End If
            .Effect2 = .Effect2 + 1
            If .Effect2 = 14 Then
                .Immune = .Immune + 50
                .Immune2 = True
                .Effect = 0
                .Effect2 = 0
                .StandUp = True
            End If
        ElseIf .Effect = 12 Then 'Player got a hammer suit
            .Frame = 1
            .Immune2 = True
            If .Effect2 = 0 Then
                If .State = 1 And .Mount = 0 Then
                    .Location.X = .Location.X - Physics.PlayerWidth(.Character, 2) * 0.5 + Physics.PlayerWidth(.Character, 1) * 0.5
                    .Location.Y = .Location.Y - Physics.PlayerHeight(.Character, 2) + Physics.PlayerHeight(.Character, 1)
                    .State = 5
                    .Location.Width = Physics.PlayerWidth(.Character, .State)
                    .Location.Height = Physics.PlayerHeight(.Character, .State)
                ElseIf .Mount = 3 Then
                    YoshiHeight A
                ElseIf .Character = 2 And .State = 1 And .Mount = 1 Then
                    .Location.Y = .Location.Y - Physics.PlayerHeight(2, 2) + Physics.PlayerHeight(1, 2)
                    .Location.Height = Physics.PlayerHeight(.Character, 6)
                End If
                .State = 6
                tempLocation.Width = 32
                tempLocation.Height = 32
                tempLocation.X = .Location.X + .Location.Width / 2 - tempLocation.Width / 2
                tempLocation.Y = .Location.Y + .Location.Height / 2 - tempLocation.Height / 2
                NewEffect 131, tempLocation, , , ShadowMode
            End If
            .Effect2 = .Effect2 + 1
            If .Effect2 = 14 Then
                .Immune = .Immune + 50
                .Immune2 = True
                .Effect = 0
                .Effect2 = 0
                .StandUp = True
            End If
        ElseIf .Effect = 500 Then 'Change to / from tanooki
                For B = 1 To 2
                    NewEffect 80, newLoc(.Location.X + Rnd * (.Location.Width + 8) - 8, .Location.Y + Rnd * (.Location.Height + 8) - 4), , , ShadowMode
                    Effect(numEffects).Location.SpeedX = Rnd * 2 - 1
                    Effect(numEffects).Location.SpeedY = Rnd * 2 - 1
                Next B
            If .Effect2 = 0 Then
                UnDuck A
                PlaySound 34
                tempLocation.Width = 32
                tempLocation.Height = 32
                tempLocation.X = .Location.X + .Location.Width / 2 - tempLocation.Width / 2
                tempLocation.Y = .Location.Y + .Location.Height / 2 - tempLocation.Height / 2
                NewEffect 10, tempLocation, , , ShadowMode
                If .Stoned = False Then
                    .Frame = 0
                    .Stoned = True
                    .StonedCD = 15
                Else
                    .StonedCD = 60
                    .Frame = 1
                    .Stoned = False
                End If
            End If
            .Effect2 = .Effect2 + 1
            .Immune = 10
            .Immune2 = True
            .StonedTime = 0
            If .Effect2 >= 5 Then
                .Effect2 = 0
                .Effect = 0
                .Immune = 0
                .Immune2 = 0
            End If
        ElseIf .Effect = 9 Then 'MultiMario
            If .HoldingNPC > numNPCs Then .HoldingNPC = 0 'Can't hold an NPC that is dead
            If .HoldingNPC > 0 Then
                NPC(.HoldingNPC).Effect = 0
                NPC(.HoldingNPC).CantHurt = Physics.NPCCanHurtWait
                NPC(.HoldingNPC).CantHurtPlayer = A
                If .Direction > 0 Then
                    NPC(.HoldingNPC).Location.X = .Location.X + Physics.PlayerGrabSpotX(.Character, .State)
                Else
                    NPC(.HoldingNPC).Location.X = .Location.X + .Location.Width - Physics.PlayerGrabSpotX(.Character, .State) - NPC(.HoldingNPC).Location.Width
                End If
                NPC(.HoldingNPC).Location.Y = .Location.Y + Physics.PlayerGrabSpotY(.Character, .State) + 32 - NPC(.HoldingNPC).Location.Height
            End If
            .MountSpecial = 0
            .YoshiTongueLength = 0
            .Immune = .Immune + 1
            If .Immune >= 5 Then
                .Immune = 0
                If .Immune2 = True Then
                    .Immune2 = False
                Else
                    .Immune2 = True
                End If
            End If
            tempBool = True
            For B = 1 To numPlayers
                If B <> A And (Player(B).Effect = 0 Or B = .Effect2) And Player(B).Dead = False And Player(B).TimeToLive = 0 And CheckCollision(.Location, Player(B).Location) = True Then
                    tempBool = False
                End If
            Next B
            If tempBool = True Then
                .Effect = 0
                .Effect2 = 0
                .Immune = 0
                .Immune2 = 0
                .Location.SpeedY = 0.01
            ElseIf .Effect2 > 0 Then
                D = .Effect2
                If Player(D).Effect = 0 Then
                    .Effect2 = 0
                End If
                .Immune2 = True
                .Location.X = Player(D).Location.X + Player(D).Location.Width / 2 - .Location.Width / 2
                .Location.Y = Player(D).Location.Y + Player(D).Location.Height - .Location.Height
            End If
        ElseIf .Effect = 9 Then 'Yoshi eat
            .HoldingNPC = 0
            .StandingOnNPC = 0
            If Player(.Effect2).YoshiPlayer <> A Then
                .Effect = 0
                .Effect2 = 0
            End If
        ElseIf .Effect = 10 Then 'Yoshi swallow
            .HoldingNPC = 0
            .StandingOnNPC = 0
            .Section = Player(.Effect2).Section
            .Location.X = Player(.Effect2).Location.X + Player(.Effect2).Location.Width / 2 - .Location.Width / 2
            .Location.Y = Player(.Effect2).Location.Y + Player(.Effect2).Location.Height / 2 - .Location.Height / 2
            If Player(.Effect2).YoshiPlayer <> A Then
                .Effect = 0
                .Effect2 = 0
            End If
        ElseIf .Effect = 6 Then 'player stole a heldbonus
            .Immune = .Immune + 1
            If .Immune >= 5 Then
                .Immune = 0
                If .Immune2 = True Then
                    .Immune2 = False
                Else
                    .Immune2 = True
                End If
            End If
            .Location.Y = .Location.Y + 2.2
            If .Location.Y >= .Effect2 Then
                .Location.Y = .Effect2
                tempBool = True
                For B = 1 To numPlayers
                    If B <> A And Player(B).Effect <> 6 And CheckCollision(.Location, Player(B).Location) = True Then tempBool = False
                    'tempBool = False
                Next B
                If tempBool = True Then
                    .Effect = 0
                    .Effect2 = 0
                    .Immune = 50
                    .Immune2 = 0
                    .Location.SpeedY = 0.01
                End If
            End If
            For B = 1 To numPlayers
                If B <> A And CheckCollision(.Location, Player(B).Location) = True Then
                    If Player(B).Mount = 2 Then
                        .Effect = 0
                        .Immune = 50
                        .Immune2 = False
                        .Location.Y = Player(B).Location.Y - .Location.Height
                        .Location.SpeedY = 0.01
                    End If
                End If
            Next B
        End If
        If .Mount = 3 And .Effect <> 9 Then PlayerFrame A
        If .Effect = 0 Then
            If nPlay.Online = True And A = nPlay.MySlot + 1 Then
                Netplay.sendData Netplay.PutPlayerControls(nPlay.MySlot) & "1c" & A & "|" & Player(A).Effect & "|" & Player(A).Effect2 & LB & "1h" & A & "|" & Player(A).State & LB
            End If
        End If
    End With
End Sub
