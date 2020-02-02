Attribute VB_Name = "modJoystick"
'this module handles the players controls, both keyboard and joystick

Option Explicit
Public Declare Function joyGetPosEx Lib "winmm.dll" (ByVal uJoyID As Integer, pji As JOYINFOEX) As Integer
Public Declare Function joyGetDevCapsA Lib "winmm.dll" (ByVal uJoyID As Integer, pjc As JOYCAPS, ByVal cjc As Integer) As Integer
Public Type JOYCAPS
    wMid As Long
    wPid As Long
    szPname As String * 32
    wXmin As Long
    wXmax As Long
    wYmin As Long
    wYmax As Long
    wZmin As Long
    wZmax As Long
    wNumButtons As Long
    wPeriodMin As Long
    wPeriodMax As Long
    wRmin As Long
    wRmax As Long
    wUmin As Long
    wUmax As Long
    wVmin As Long
    wVmax As Long
    wCaps As Long
    wMaxAxes As Long
    wNumAxes As Long
    wMaxButtons As Long
    szRegKey As String * 32
    szOEMVxD As String * 260
End Type
Public Type JOYINFOEX
    dwSize As Long
    dwFlags As Long
    dwXpos As Long
    dwYpos As Long
    dwZpos As Long
    dwRpos As Long
    dwUpos As Long
    dwVpos As Long
    dwButtons As Long
    dwButtonNumber As Long
    dwPOV As Long
    dwReserved1 As Long
    dwReserved2 As Long
End Type
Public JoyNum As Long
Public MYJOYEX As JOYINFOEX
Public MYJOYCAPS As JOYCAPS
Public CenterX(0 To 7) As Long
Public CenterY(0 To 7) As Long
Public JoyButtons(-15 To 15) As Boolean
Public CurrentJoyX As Long
Public CurrentJoyY As Long
Public CurrentJoyPOV As Long

Public Sub UpdateControls() 'Gets players controls
    Dim A As Integer
    Dim B As Integer
    Dim C As Integer
    If TestLevel = True And Not (nPlay.Online = True And nPlay.Mode = 0) Then
        If GetKeyState(vbKeyEscape) And KEY_PRESSED Then
            EndLevel = True
        End If
    End If
    For B = 1 To numPlayers
        If B = 2 And numPlayers = 2 Then
            A = 2
        Else
            A = 1
        End If
        With Player(A).Controls
            .Down = False
            .Drop = False
            .Jump = False
            .Left = False
            .Right = False
            .Run = False
            .Start = False
            .Up = False
            .AltJump = False
            .AltRun = False
            If useJoystick(A) > 0 Then 'There is a joystick
                JoyNum = useJoystick(A) - 1
                PollJoystick
                If CurrentJoyX < CenterX(JoyNum) - CenterX(JoyNum) * 0.3 Or (CurrentJoyPOV >= 22500 And CurrentJoyPOV <= 31500) Then
                    .Left = True
                ElseIf CurrentJoyX > CenterX(JoyNum) + CenterX(JoyNum) * 0.3 Or (CurrentJoyPOV >= 4500 And CurrentJoyPOV <= 13500) Then
                    .Right = True
                End If
                If CurrentJoyY < CenterY(JoyNum) - CenterY(JoyNum) * 0.3 Or (CurrentJoyPOV >= 0 And CurrentJoyPOV <= 4500) Or CurrentJoyPOV = 31500 Then
                    .Up = True
                ElseIf CurrentJoyY > CenterY(JoyNum) + CenterY(JoyNum) * 0.3 Or (CurrentJoyPOV >= 13500 And CurrentJoyPOV <= 22500) Then
                    .Down = True
                End If
                If JoyButtons(conJoystick(A).Jump) = True Then
                    .Jump = True
                End If
                If JoyButtons(conJoystick(A).Run) = True Then
                    .Run = True
                End If
                If JoyButtons(conJoystick(A).Drop) = True Then
                    .Drop = True
                End If
                If JoyButtons(conJoystick(A).Start) = True Then
                    .Start = True
                End If
                If JoyButtons(conJoystick(A).AltRun) = True Then
                    .AltRun = True
                End If
                If JoyButtons(conJoystick(A).AltJump) = True Then
                    .AltJump = True
                End If
            End If
            If useJoystick(A) = 0 Then            'Keyboard controls
                If GetKeyState(conKeyboard(A).Up) And KEY_PRESSED Then
                    .Up = True
                End If
                If GetKeyState(conKeyboard(A).Down) And KEY_PRESSED Then
                    .Down = True
                End If
                If GetKeyState(conKeyboard(A).Left) And KEY_PRESSED Then
                    .Left = True
                End If
                If GetKeyState(conKeyboard(A).Right) And KEY_PRESSED Then
                    .Right = True
                End If
                If GetKeyState(conKeyboard(A).Jump) And KEY_PRESSED Then
                    .Jump = True
                End If
                If GetKeyState(conKeyboard(A).Run) And KEY_PRESSED Then
                    .Run = True
                End If
                If GetKeyState(conKeyboard(A).Drop) And KEY_PRESSED Then
                    .Drop = True
                End If
                If GetKeyState(conKeyboard(A).Start) And KEY_PRESSED Then
                    .Start = True
                End If
                If GetKeyState(conKeyboard(A).AltJump) And KEY_PRESSED Then
                    .AltJump = True
                End If
                If GetKeyState(conKeyboard(A).AltRun) And KEY_PRESSED Then
                    .AltRun = True
                End If
            End If
            If .Left = True And .Right = True Then
                .Left = False
                .Right = False
            End If
            If Player(A).Controls.Start = False And Player(A).Controls.Jump = False Then
                Player(A).UnStart = True
            End If
            If .Up = True And .Down = True Then
                .Up = False
                .Down = False
            End If
            If .Left = True And .Right = True Then
                .Left = False
                .Right = False
            End If
            If Not (Player(A).State = 5 And Player(A).Mount = 0) And .AltRun = True Then .Run = True
            If ForcedControls = True And GamePaused = False Then
                Player(A).Controls = ForcedControl
            End If
        End With
    Next B
    If SingleCoop > 0 Then
        If numPlayers = 1 Or numPlayers > 2 Then SingleCoop = 0
        Dim tempControls As Controls
        If SingleCoop = 1 Then
            Player(2).Controls = tempControls
        Else
            Player(2).Controls = Player(1).Controls
            Player(1).Controls = tempControls
        End If
    End If
    If nPlay.Online = True Then
        Player(nPlay.MySlot + 1).Controls = Player(1).Controls
        If Not (nPlay.MyControls.AltJump = Player(1).Controls.AltJump And nPlay.MyControls.AltRun = Player(1).Controls.AltRun And nPlay.MyControls.Down = Player(1).Controls.Down And nPlay.MyControls.Drop = Player(1).Controls.Drop And nPlay.MyControls.Jump = Player(1).Controls.Jump And nPlay.MyControls.Left = Player(1).Controls.Left And nPlay.MyControls.Right = Player(1).Controls.Right And nPlay.MyControls.Run = Player(1).Controls.Run And nPlay.MyControls.Start = Player(1).Controls.Start And nPlay.MyControls.Up = Player(1).Controls.Up) Then
            nPlay.MyControls = Player(1).Controls
            nPlay.Player(nPlay.MySlot).Controls = Player(1).Controls
            If Player(nPlay.MySlot + 1).Dead = False And Player(nPlay.MySlot + 1).TimeToLive = 0 Then Netplay.sendData Netplay.PutPlayerControls(nPlay.MySlot)
        Else
            nPlay.MyControls = Player(1).Controls
            nPlay.Player(nPlay.MySlot).Controls = Player(1).Controls
        End If
        For A = 0 To numPlayers - 1
            If nPlay.Player(A).Active = True And A <> nPlay.MySlot Then
                Player(A + 1).Controls = nPlay.Player(A).Controls
            End If
        Next A
    End If
    For A = 1 To numPlayers
        With Player(A)
            If .SpinJump = True Then
                If .SpinFrame < 4 Or .SpinFrame > 9 Then
                    .Direction = -1
                Else
                    .Direction = 1
                End If
            End If
        End With
    Next A
End Sub

Public Function StartJoystick(Optional ByVal JoystickNumber As Integer = 0) As Boolean
JoyNum = JoystickNumber
If joyGetDevCapsA(JoyNum, MYJOYCAPS, 404) <> 0 Then 'Get joystick info
    StartJoystick = False
Else
    MYJOYEX.dwSize = 64
    MYJOYEX.dwFlags = 255
    Call joyGetPosEx(JoyNum, MYJOYEX)
    'CenterX(JoyNum) = MYJOYEX.dwXpos
    'CenterY(JoyNum) = MYJOYEX.dwYpos
    CenterX(JoyNum) = (MYJOYCAPS.wXmax + MYJOYCAPS.wXmin) / 2
    CenterY(JoyNum) = (MYJOYCAPS.wYmax + MYJOYCAPS.wYmin) / 2
    StartJoystick = True
End If
End Function

Public Sub PollJoystick()
Dim i As Integer
Dim t As Integer
MYJOYEX.dwSize = 64
MYJOYEX.dwFlags = 255
' Get the joystick information
Call joyGetPosEx(JoyNum, MYJOYEX)
t = MYJOYEX.dwButtons
For i = 15 To 0 Step -1
    JoyButtons(i) = False
    If (2 ^ i) <= t Then
        t = t - (2 ^ i)
        JoyButtons(i) = True
    End If
Next i
CurrentJoyX = MYJOYEX.dwXpos
CurrentJoyY = MYJOYEX.dwYpos
CurrentJoyPOV = MYJOYEX.dwPOV
End Sub
