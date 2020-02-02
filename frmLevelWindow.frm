VERSION 5.00
Begin VB.Form frmLevelWindow 
   BackColor       =   &H00000000&
   Caption         =   "Level Window"
   ClientHeight    =   9060
   ClientLeft      =   120
   ClientTop       =   405
   ClientWidth     =   12060
   Icon            =   "frmLevelWindow.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   9060
   ScaleWidth      =   12060
   Begin VB.PictureBox vScreen 
      BackColor       =   &H00000000&
      Height          =   9060
      Index           =   1
      Left            =   0
      MouseIcon       =   "frmLevelWindow.frx":628A
      MousePointer    =   99  'Custom
      ScaleHeight     =   600
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   800
      TabIndex        =   0
      Top             =   0
      Width           =   12059
   End
End
Attribute VB_Name = "frmLevelWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_KeyPress(KeyAscii As Integer)
    Stop
End Sub

Private Sub Form_Load()
    GFX.Split(1).Width = vScreen(1).Width
    GFX.Split(1).Height = vScreen(1).Height
    level(0).Height = 600
    level(0).Width = 800
    Me.Width = 12240
    Me.Height = 9570
    Do While vScreen(1).ScaleWidth > 800
        Me.Width = Me.Width - 5
        vScreen(1).Width = Me.ScaleWidth
        DoEvents
    Loop
    Do While vScreen(1).ScaleHeight > 600
        Me.Height = Me.Height - 5
        vScreen(1).Height = Me.ScaleHeight
        DoEvents
    Loop
    Do While vScreen(1).ScaleWidth < 800
        Me.Width = Me.Width + 5
        vScreen(1).Width = Me.ScaleWidth
        DoEvents
    Loop
    Do While vScreen(1).ScaleHeight < 600
        Me.Height = Me.Height + 5
        vScreen(1).Height = Me.ScaleHeight
        DoEvents
    Loop
End Sub

Private Sub Form_LostFocus()
    HideCursor
End Sub

Private Sub Form_Resize()
    vScreen(1).Width = Me.ScaleWidth
    vScreen(1).Height = Me.ScaleHeight
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
End Sub

Private Sub vScreen_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF12 Then
        TakeScreen = True
    End If
End Sub

Private Sub vScreen_KeyPress(Index As Integer, KeyAscii As Integer)
    CheatCode Chr(KeyAscii)
End Sub

Private Sub vScreen_LostFocus(Index As Integer)
    HideCursor
End Sub

Private Sub vScreen_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = 1 Then
        EditorControls.Mouse1 = True
    ElseIf Button = 2 Then
        If WorldEditor = True Then
            frmLevelEditor.optCursor(14).Value = True
        Else
            frmLevelEditor.optCursor(13).Value = True
        End If
        frmLayers.lstLayer.ListIndex = 0
        MouseMove X, Y
        SetCursor
    End If
End Sub

Private Sub vScreen_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error Resume Next
    With EditorCursor
        .X = Int(X * ScreenW / vScreen(Index).ScaleWidth)
        .Y = Int(Y * ScreenH / vScreen(Index).ScaleHeight)
    End With
    MouseMove Int(X * ScreenW / vScreen(Index).ScaleWidth), Int(Y * ScreenH / vScreen(Index).ScaleHeight), True
    MouseRelease = True
End Sub

Private Sub vScreen_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Index = 1 Then
        EditorControls.Mouse1 = False
    End If
End Sub

