Attribute VB_Name = "modCollision"
Option Explicit

Public Function CheckCollision(Loc1 As Location, Loc2 As Location) As Boolean 'Normal collisions
    If Loc1.Y + Loc1.Height >= Loc2.Y Then
        If Loc1.Y <= Loc2.Y + Loc2.Height Then
            If Loc1.X <= Loc2.X + Loc2.Width Then
                If Loc1.X + Loc1.Width >= Loc2.X Then
                    CheckCollision = True
                End If
            End If
        End If
    End If
End Function

Public Function n00bCollision(Loc1 As Location, Loc2 As Location) As Boolean 'Make the game easier for the people who whine about the detection being 'off'
    Dim EZ As Single
    EZ = 2
    If Loc2.Width >= 32 - EZ * 2 And Loc2.Height >= 32 - EZ * 2 Then
        If Loc1.Y + Loc1.Height - EZ >= Loc2.Y Then
            If Loc1.Y + EZ <= Loc2.Y + Loc2.Height Then
                If Loc1.X + EZ <= Loc2.X + Loc2.Width Then
                    If Loc1.X + Loc1.Width - EZ >= Loc2.X Then
                        n00bCollision = True
                    End If
                End If
            End If
        End If
    Else
        If Loc1.Y + Loc1.Height >= Loc2.Y Then
            If Loc1.Y <= Loc2.Y + Loc2.Height Then
                If Loc1.X <= Loc2.X + Loc2.Width Then
                    If Loc1.X + Loc1.Width >= Loc2.X Then
                        n00bCollision = True
                    End If
                End If
            End If
        End If
    End If
End Function

Public Function NPCStartCollision(Loc1 As Location, Loc2 As Location) As Boolean 'Used when a NPC is activated to see if it should spawn
    If Loc1.X < Loc2.X + Loc2.Width Then
        If Loc1.X + Loc1.Width > Loc2.X Then
            If Loc1.Y < Loc2.Y + Loc2.Height Then
                If Loc1.Y + Loc1.Height > Loc2.Y Then
                    NPCStartCollision = True
                End If
            End If
        End If
    End If
End Function
Public Function WarpCollision(Loc1 As Location, A As Integer) As Boolean  'Warp point collisions
    Dim X2 As Single
    Dim Y2 As Single
    With Warp(A)
        If .Direction = 3 Then
            X2 = 0
            Y2 = 32
        ElseIf .Direction = 1 Then
            X2 = 0
            Y2 = -30
        ElseIf .Direction = 2 Then
            X2 = -31
            Y2 = 32
        ElseIf .Direction = 4 Then
            X2 = 31
            Y2 = 32
        End If
        If Loc1.X <= .Entrance.X + .Entrance.Width + X2 Then
            If Loc1.X + Loc1.Width >= .Entrance.X + X2 Then
                If Loc1.Y <= .Entrance.Y + .Entrance.Height + Y2 Then
                    If Loc1.Y + Loc1.Height >= .Entrance.Y + Y2 Then
                        WarpCollision = True
                    End If
                End If
            End If
        End If
    End With
End Function

Public Function FindCollision(Loc1 As Location, Loc2 As Location) As Integer 'Whats side the collision happened
    If Loc1.Y + Loc1.Height - Loc1.SpeedY <= Loc2.Y - Loc2.SpeedY Then
        FindCollision = 1
    ElseIf Loc1.X - Loc1.SpeedX >= Loc2.X + Loc2.Width - Loc2.SpeedX Then FindCollision = 2
    ElseIf Loc1.X + Loc1.Width - Loc1.SpeedX <= Loc2.X - Loc2.SpeedX Then FindCollision = 4
    ElseIf Loc1.Y - Loc1.SpeedY > Loc2.Y + Loc2.Height - Loc2.SpeedY - 0.1 Then FindCollision = 3
    Else
        FindCollision = 5
    End If
End Function

Public Function FindCollisionBelt(Loc1 As Location, Loc2 As Location, BeltSpeed As Single) As Integer  'Whats side the collision happened for belts
    If Loc1.Y + Loc1.Height - Loc1.SpeedY <= Loc2.Y - Loc2.SpeedY Then
        FindCollisionBelt = 1
    ElseIf Loc1.X - Loc1.SpeedX - BeltSpeed >= Loc2.X + Loc2.Width - Loc2.SpeedX Then FindCollisionBelt = 2
    ElseIf Loc1.X + Loc1.Width - Loc1.SpeedX <= Loc2.X - Loc2.SpeedX Then FindCollisionBelt = 4
    ElseIf Loc1.Y - Loc1.SpeedY - BeltSpeed > Loc2.Y + Loc2.Height - Loc2.SpeedY - 0.1 Then FindCollisionBelt = 3
    Else
        FindCollisionBelt = 5
    End If
End Function

Public Function NPCFindCollision(Loc1 As Location, Loc2 As Location) As Integer 'Whats side the collision happened for NPCs
    If Loc1.Y + Loc1.Height - Loc1.SpeedY <= Loc2.Y - Loc2.SpeedY + 4 Then
        NPCFindCollision = 1
    ElseIf Loc1.X - Loc1.SpeedX >= Loc2.X + Loc2.Width - Loc2.SpeedX Then NPCFindCollision = 2
    ElseIf Loc1.X + Loc1.Width - Loc1.SpeedX <= Loc2.X - Loc2.SpeedX Then NPCFindCollision = 4
    ElseIf Loc1.Y - Loc1.SpeedY > Loc2.Y + Loc2.Height - Loc2.SpeedY - 0.1 Then NPCFindCollision = 3
    Else
        NPCFindCollision = 5
    End If
End Function

Public Function EasyModeCollision(Loc1 As Location, Loc2 As Location, Optional StandOn As Boolean = False) As Integer  'Easy mode collision for jumping on NPCs
    If FreezeNPCs = False Then
        If Loc1.Y + Loc1.Height - Loc1.SpeedY <= Loc2.Y - Loc2.SpeedY + 10 Then
            If (Loc1.SpeedY > Loc2.SpeedY Or StandOn = True) Then
                EasyModeCollision = 1
            Else
                EasyModeCollision = 0
            End If
        ElseIf Loc1.X - Loc1.SpeedX >= Loc2.X + Loc2.Width - Loc2.SpeedX Then EasyModeCollision = 2
        ElseIf Loc1.X + Loc1.Width - Loc1.SpeedX <= Loc2.X - Loc2.SpeedX Then EasyModeCollision = 4
        ElseIf Loc1.Y - Loc1.SpeedY >= Loc2.Y + Loc2.Height - Loc2.SpeedY Then EasyModeCollision = 3
        Else
            EasyModeCollision = 5
        End If
    Else
        If Loc1.Y + Loc1.Height - Loc1.SpeedY <= Loc2.Y + 10 Then
            EasyModeCollision = 1
        ElseIf Loc1.X - Loc1.SpeedX >= Loc2.X + Loc2.Width Then EasyModeCollision = 2
        ElseIf Loc1.X + Loc1.Width - Loc1.SpeedX <= Loc2.X Then EasyModeCollision = 4
        ElseIf Loc1.Y - Loc1.SpeedY >= Loc2.Y + Loc2.Height Then EasyModeCollision = 3
        Else
            EasyModeCollision = 5
        End If
    End If
End Function

Public Function BootCollision(Loc1 As Location, Loc2 As Location, Optional StandOn As Boolean = False) As Integer 'Easy mode collision for jumping on NPCs while on yoshi/boot
    If FreezeNPCs = False Then
        If Loc1.Y + Loc1.Height - Loc1.SpeedY <= Loc2.Y - Loc2.SpeedY + 16 Then
            If (Loc1.SpeedY > Loc2.SpeedY Or StandOn = True) Then
                BootCollision = 1
            Else
                BootCollision = 0
            End If
        ElseIf Loc1.X - Loc1.SpeedX >= Loc2.X + Loc2.Width - Loc2.SpeedX Then BootCollision = 2
        ElseIf Loc1.X + Loc1.Width - Loc1.SpeedX <= Loc2.X - Loc2.SpeedX Then BootCollision = 4
        ElseIf Loc1.Y - Loc1.SpeedY >= Loc2.Y + Loc2.Height - Loc2.SpeedY Then BootCollision = 3
        Else
            BootCollision = 5
        End If
    Else
        If Loc1.Y + Loc1.Height - Loc1.SpeedY <= Loc2.Y + 16 Then
            BootCollision = 1
        ElseIf Loc1.X - Loc1.SpeedX >= Loc2.X + Loc2.Width Then BootCollision = 2
        ElseIf Loc1.X + Loc1.Width - Loc1.SpeedX <= Loc2.X Then BootCollision = 4
        ElseIf Loc1.Y - Loc1.SpeedY >= Loc2.Y + Loc2.Height Then BootCollision = 3
        Else
            BootCollision = 5
        End If
    End If
End Function

Public Function CursorCollision(Loc1 As Location, Loc2 As Location) As Boolean 'Cursor collision
    If Loc1.X <= Loc2.X + Loc2.Width - 1 Then
        If Loc1.X + Loc1.Width >= Loc2.X + 1 Then
            If Loc1.Y <= Loc2.Y + Loc2.Height - 1 Then
                If Loc1.Y + Loc1.Height >= Loc2.Y + 1 Then
                    CursorCollision = True
                End If
            End If
        End If
    End If
End Function

Public Function ShakeCollision(Loc1 As Location, Loc2 As Location, ShakeY3 As Integer) As Boolean 'Shakey block collision
    If Loc1.X + 1 <= Loc2.X + Loc2.Width Then
        If Loc1.X + Loc1.Width - 1 >= Loc2.X Then
            If Loc1.Y <= Loc2.Y + Loc2.Height + ShakeY3 Then
                If Loc1.Y + Loc1.Height >= Loc2.Y + ShakeY3 Then
                    ShakeCollision = True
                End If
            End If
        End If
    End If
End Function

Public Function vScreenCollision(A As Integer, Loc2 As Location) As Boolean  'vScreen collisions
    If A = 0 Then
        vScreenCollision = True
        Exit Function
    End If
    If -vScreenX(A) <= Loc2.X + Loc2.Width Then
        If -vScreenX(A) + vScreen(A).Width >= Loc2.X Then
            If -vScreenY(A) <= Loc2.Y + Loc2.Height Then
                If -vScreenY(A) + vScreen(A).Height >= Loc2.Y Then
                    vScreenCollision = True
                End If
            End If
        End If
    End If
End Function

Public Function vScreenCollision2(A As Integer, Loc2 As Location) As Boolean  'vScreen collisions 2
    If -vScreenX(A) + 64 <= Loc2.X + Loc2.Width Then
        If -vScreenX(A) + vScreen(A).Width - 64 >= Loc2.X Then
            If -vScreenY(A) + 96 <= Loc2.Y + Loc2.Height Then
                If -vScreenY(A) + vScreen(A).Height - 64 >= Loc2.Y Then
                    vScreenCollision2 = True
                End If
            End If
        End If
    End If
End Function

Public Function WalkingCollision(Loc1 As Location, Loc2 As Location) As Boolean 'Collision detection for blocks. Prevents walking on walls.
    If Loc1.X <= Loc2.X + Loc2.Width + Loc1.SpeedX Then
        If Loc1.X + Loc1.Width >= Loc2.X + Loc1.SpeedX Then
            WalkingCollision = True
        End If
    End If
End Function

Public Function WalkingCollision2(Loc1 As Location, Loc2 As Location) As Boolean 'Collision detection for blocks. Lets NPCs fall through cracks.
    If Loc1.X <= Loc2.X + Loc2.Width - Loc1.SpeedX - 1 Then
        If Loc1.X + Loc1.Width >= Loc2.X - Loc1.SpeedX + 1 Then
            WalkingCollision2 = True
        End If
    End If
End Function

Public Function WalkingCollision3(Loc1 As Location, Loc2 As Location, BeltSpeed As Single) As Boolean 'Factors in beltspeed
    If Loc1.X <= Loc2.X + Loc2.Width - (Loc1.SpeedX + BeltSpeed) - 1 Then
        If Loc1.X + Loc1.Width >= Loc2.X - (Loc1.SpeedX + BeltSpeed) + 1 Then
            WalkingCollision3 = True
        End If
    End If
End Function


Public Function FindRunningCollision(Loc1 As Location, Loc2 As Location) As Integer 'Helps the player to walk over 1 unit cracks
    If Loc1.Y + Loc1.Height - Loc1.SpeedY - 2.5 <= Loc2.Y - Loc2.SpeedY Then
        FindRunningCollision = 1
    ElseIf Loc1.X - Loc1.SpeedX >= Loc2.X + Loc2.Width - Loc2.SpeedX Then FindRunningCollision = 2
    ElseIf Loc1.X + Loc1.Width - Loc1.SpeedX <= Loc2.X - Loc2.SpeedX Then FindRunningCollision = 4
    ElseIf Loc1.Y - Loc1.SpeedY >= Loc2.Y + Loc2.Height - Loc2.SpeedY Then FindRunningCollision = 3
    Else
        FindRunningCollision = 5
    End If
End Function

Public Function ShouldTurnAround(Loc1 As Location, Loc2 As Location, Direction As Single) As Boolean  'Determines if an NPC should turnaround
    ShouldTurnAround = True
    If Loc1.Y + Loc1.Height + 8 <= Loc2.Y + Loc2.Height Then
        If Loc1.Y + Loc1.Height + 8 >= Loc2.Y Then
            If Loc1.X + Loc1.Width * 0.5 + (8 * Direction) <= Loc2.X + Loc2.Width Then
                If Loc1.X + Loc1.Width * 0.5 + (8 * Direction) >= Loc2.X Then
                    If Loc2.Y > Loc1.Y + Loc1.Height - 8 Then
                        ShouldTurnAround = False
                    End If
                End If
            End If
        End If
    End If
End Function

Public Function CanComeOut(Loc1 As Location, Loc2 As Location) As Boolean  'Determines if an NPC can come out of a pipe
    CanComeOut = True
    If Loc1.X <= Loc2.X + Loc2.Width + 32 Then
        If Loc1.X + Loc1.Width >= Loc2.X - 32 Then
            If Loc1.Y <= Loc2.Y + Loc2.Height + 300 Then
                If Loc1.Y + Loc1.Height >= Loc2.Y - 300 Then
                    CanComeOut = False
                End If
            End If
        End If
    End If
End Function

Public Function CheckHitSpot1(Loc1 As Location, Loc2 As Location) As Boolean  'Fixes NPCs sinking through the ground
    If Loc1.Y + Loc1.Height - Loc1.SpeedY - Physics.NPCGravity <= Loc2.Y - Loc2.SpeedY Then CheckHitSpot1 = True
End Function

