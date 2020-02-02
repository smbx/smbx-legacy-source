VERSION 5.00
Begin VB.Form frmMain 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H00000000&
   Caption         =   "Super Mario Bros. X - Version 1.2.2 - www.SuperMarioBrothers.org"
   ClientHeight    =   9000
   ClientLeft      =   120
   ClientTop       =   510
   ClientWidth     =   12000
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MouseIcon       =   "frmMain.frx":628A
   Picture         =   "frmMain.frx":6594
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox LoadCoin 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   480
      Left            =   11400
      Picture         =   "frmMain.frx":EFBF
      ScaleHeight     =   32
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   28
      TabIndex        =   0
      Top             =   8400
      Width           =   420
   End
   Begin VB.Image Loader 
      Height          =   240
      Left            =   9480
      Picture         =   "frmMain.frx":F3D3
      Top             =   8640
      Width           =   1770
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public LockSize As Boolean

Private Sub Form_DblClick()
    If Me.WindowState = 0 Then Exit Sub
    LockSize = True
        If resChanged = False Then
            If Me.WindowState = 2 Then
                Me.WindowState = 0
                Me.BorderStyle = 2
                Me.Caption = "Super Mario Bros. X - Version 1.3 - www.SuperMarioBrothers.org"
            Else
                Me.BorderStyle = 0
                Me.Caption = ""
                DoEvents
                Me.WindowState = 2
            End If
        End If
    LockSize = False
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    inputKey = KeyCode
    If KeyCode = 13 Then
        keyDownEnter = True
    ElseIf KeyCode = 18 Then
        keyDownAlt = True
    End If
    If keyDownEnter = True And keyDownAlt = True And TestLevel = False Then
        keyDownAlt = False
        keyDownEnter = False
        ChangeScreen
    End If
    If KeyCode = vbKeyF12 Then TakeScreen = True
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    CheatCode Chr(KeyAscii)
End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        keyDownEnter = False
    ElseIf KeyCode = 18 Then
        keyDownAlt = False
    End If
End Sub

Private Sub Form_Load()
    LockSize = True
        Do While frmMain.ScaleWidth > 800
            Me.Width = Me.Width - 5
        Loop
        Do While frmMain.ScaleHeight > 600
            Me.Height = Me.Height - 5
        Loop
        Do While frmMain.ScaleWidth < 800
            Me.Width = Me.Width + 5
        Loop
        Do While frmMain.ScaleHeight < 600
            Me.Height = Me.Height + 5
        Loop
    LockSize = False
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = 1 Then
        MenuMouseDown = True
        MenuMouseMove = True
    Else
        MenuMouseBack = True
    End If
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    MenuMouseX = Int(X * ScreenW / frmMain.ScaleWidth)
    MenuMouseY = Int(Y * ScreenH / frmMain.ScaleHeight)
    MenuMouseMove = True
End Sub

Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    MenuMouseDown = False
    MenuMouseRelease = True
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    ShowCursor True
    ShowCursor True
    ShowCursor True
    ShowCursor True
    ShowCursor True
End Sub

Private Sub Form_Resize()
    If LockSize = True Or resChanged = True Then Exit Sub
    LockSize = True
        If Me.WindowState = 0 Then
            Me.BorderStyle = 2
            Me.Caption = "Super Mario Bros. X - Version 1.3 - www.SuperMarioBrothers.org"
        ElseIf Me.WindowState = 2 Then
            Me.WindowState = 0
            Me.BorderStyle = 0
            Me.Caption = ""
            DoEvents
            DoEvents
            Me.WindowState = 2
            DoEvents
        End If
        SetupScreens
    LockSize = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    ShowCursor True
    ShowCursor True
    ShowCursor True
    ShowCursor True
    ShowCursor True
    KillIt
End Sub
