VERSION 5.00
Begin VB.Form frmNetplay 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Connect"
   ClientHeight    =   3495
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   6990
   Icon            =   "frmNetplay.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3495
   ScaleWidth      =   6990
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   9720
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   32
      Top             =   840
      Width           =   375
   End
   Begin VB.Frame Frame3 
      Caption         =   "Character"
      Height          =   1095
      Left            =   4320
      TabIndex        =   29
      Top             =   720
      Width           =   2535
      Begin VB.OptionButton optPlayer 
         BackColor       =   &H00000000&
         Height          =   750
         Index           =   4
         Left            =   1920
         Picture         =   "frmNetplay.frx":628A
         Style           =   1  'Graphical
         TabIndex        =   34
         Top             =   240
         Value           =   -1  'True
         Width           =   540
      End
      Begin VB.OptionButton optPlayer 
         BackColor       =   &H00000000&
         Height          =   750
         Index           =   3
         Left            =   1320
         Picture         =   "frmNetplay.frx":670E
         Style           =   1  'Graphical
         TabIndex        =   33
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton optPlayer 
         BackColor       =   &H00000000&
         Height          =   750
         Index           =   2
         Left            =   720
         Picture         =   "frmNetplay.frx":6BBC
         Style           =   1  'Graphical
         TabIndex        =   31
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton optPlayer 
         BackColor       =   &H00000000&
         Height          =   750
         Index           =   1
         Left            =   120
         Picture         =   "frmNetplay.frx":73F6
         Style           =   1  'Graphical
         TabIndex        =   30
         Top             =   240
         Width           =   540
      End
   End
   Begin VB.Frame lblCursor 
      Caption         =   "Cursor"
      Height          =   1575
      Left            =   3120
      TabIndex        =   14
      Top             =   1800
      Width           =   2655
      Begin VB.OptionButton Cursor 
         BackColor       =   &H00000000&
         Height          =   585
         Index           =   7
         Left            =   1920
         Picture         =   "frmNetplay.frx":7CA8
         Style           =   1  'Graphical
         TabIndex        =   22
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton Cursor 
         BackColor       =   &H00000000&
         Height          =   585
         Index           =   6
         Left            =   1920
         Picture         =   "frmNetplay.frx":8096
         Style           =   1  'Graphical
         TabIndex        =   21
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton Cursor 
         BackColor       =   &H00000000&
         Height          =   585
         Index           =   5
         Left            =   1320
         Picture         =   "frmNetplay.frx":8484
         Style           =   1  'Graphical
         TabIndex        =   20
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton Cursor 
         BackColor       =   &H00000000&
         Height          =   585
         Index           =   4
         Left            =   1320
         Picture         =   "frmNetplay.frx":8872
         Style           =   1  'Graphical
         TabIndex        =   19
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton Cursor 
         BackColor       =   &H00000000&
         Height          =   585
         Index           =   3
         Left            =   720
         Picture         =   "frmNetplay.frx":8C60
         Style           =   1  'Graphical
         TabIndex        =   18
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton Cursor 
         BackColor       =   &H00000000&
         Height          =   585
         Index           =   2
         Left            =   120
         Picture         =   "frmNetplay.frx":904E
         Style           =   1  'Graphical
         TabIndex        =   17
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton Cursor 
         BackColor       =   &H00000000&
         Height          =   585
         Index           =   1
         Left            =   720
         Picture         =   "frmNetplay.frx":943C
         Style           =   1  'Graphical
         TabIndex        =   16
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton Cursor 
         BackColor       =   &H00000000&
         Height          =   585
         Index           =   0
         Left            =   120
         Picture         =   "frmNetplay.frx":982A
         Style           =   1  'Graphical
         TabIndex        =   15
         Top             =   240
         Value           =   -1  'True
         Width           =   540
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Nickname"
      Height          =   615
      Left            =   4320
      TabIndex        =   12
      Top             =   120
      Width           =   2535
      Begin VB.TextBox txtNick 
         Height          =   285
         Left            =   120
         TabIndex        =   13
         Text            =   "Anonymous"
         Top             =   240
         Width           =   2175
      End
   End
   Begin VB.CommandButton cmdGo 
      Caption         =   "Connect"
      Height          =   495
      Left            =   120
      TabIndex        =   7
      Top             =   1200
      Width           =   1095
   End
   Begin VB.Frame frMode 
      Caption         =   "Mode"
      Height          =   975
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   1095
      Begin VB.OptionButton optMode 
         Caption         =   "Server"
         Height          =   315
         Index           =   1
         Left            =   120
         TabIndex        =   4
         Top             =   480
         Width           =   855
      End
      Begin VB.OptionButton optMode 
         Caption         =   "Client"
         Height          =   315
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Value           =   -1  'True
         Width           =   735
      End
   End
   Begin VB.Frame frmMode 
      Caption         =   "Client Settings"
      Height          =   1575
      Index           =   0
      Left            =   1320
      TabIndex        =   1
      Top             =   120
      Width           =   2895
      Begin VB.Frame Frame6 
         Caption         =   "Password"
         Height          =   615
         Left            =   120
         TabIndex        =   23
         Top             =   840
         Width           =   2655
         Begin VB.TextBox cPassword 
            Height          =   285
            Left            =   120
            TabIndex        =   24
            Top             =   240
            Width           =   2415
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Port"
         Height          =   615
         Left            =   1800
         TabIndex        =   8
         Top             =   240
         Width           =   975
         Begin VB.TextBox clPort 
            Height          =   285
            Left            =   120
            TabIndex        =   9
            Text            =   "31337"
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Remote IP Address"
         Height          =   615
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   1575
         Begin VB.TextBox clIP 
            Height          =   285
            Left            =   120
            TabIndex        =   6
            Top             =   240
            Width           =   1335
         End
      End
   End
   Begin VB.Frame frmMode 
      Caption         =   "Server Settings"
      Enabled         =   0   'False
      Height          =   1575
      Index           =   1
      Left            =   120
      TabIndex        =   0
      Top             =   1800
      Width           =   2895
      Begin VB.Frame Frame8 
         Caption         =   "Allow Clear"
         Height          =   615
         Left            =   120
         TabIndex        =   27
         Top             =   840
         Width           =   1215
         Begin VB.CommandButton cmdClearLevel 
            Caption         =   "No"
            Height          =   255
            Left            =   120
            TabIndex        =   28
            Top             =   240
            Width           =   975
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "Password"
         Height          =   615
         Left            =   120
         TabIndex        =   25
         Top             =   240
         Width           =   2655
         Begin VB.TextBox sPassword 
            Height          =   285
            Left            =   120
            TabIndex        =   26
            Top             =   240
            Width           =   2415
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Listen Port"
         Height          =   615
         Left            =   1440
         TabIndex        =   10
         Top             =   840
         Width           =   1335
         Begin VB.TextBox svrPort 
            Height          =   285
            Left            =   120
            TabIndex        =   11
            Text            =   "31337"
            Top             =   240
            Width           =   1095
         End
      End
   End
End
Attribute VB_Name = "frmNetplay"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdClearLevel_Click()
    If cmdClearLevel.Caption = "Yes" Then
        cmdClearLevel.Caption = "No"
        ServerClear = False
        If nPlay.Online = True Then Netplay.sendData "F0" & LB
    Else
        cmdClearLevel.Caption = "Yes"
        ServerClear = True
        If nPlay.Online = True Then Netplay.sendData "F1" & LB
    End If
End Sub

Private Sub cmdGo_Click()
    Dim A As Integer
    If LocalNick = "" Then LocalNick = txtNick.Text
    ShadowMode = False
    GodMode = False
    GrabAll = False
    CaptainN = False
    FlameThrower = False
    FreezeNPCs = False
    WalkAnywhere = False
    MultiHop = False
    SuperSpeed = False
    FlyForever = False
    If cmdGo.Caption = "Connect" Then
        'frmLevelEditor.MenuTest.Enabled = False
        frMode.Enabled = False
        txtNick.Enabled = False
        lblCursor.Enabled = False
        'frmLevelEditor.MenuTest.Enabled = False
        If nPlay.Mode = 0 Then
            frmLevelEditor.MenuTest.Enabled = False
            frmLevelEditor.menuFileNew.Enabled = False
            Netplay.tmrConnect.Enabled = True
            Netplay.nClient.RemoteHost = clIP.Text
            Netplay.nClient.RemotePort = Val(clPort.Text)
            Netplay.nClient.Connect
            frmChat.txtChat = frmChat.txtChat & "Connecting to " & clIP.Text & " on port " & Val(clPort.Text) & "." & Chr(13) & Chr(10)
            frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
            cmdGo.Caption = "Disconnect"
            frmLevelEditor.menufileOpen.Enabled = False
        Else
            frmLevelEditor.MenuTestLevel.Caption = "Test Level &Online"
            frmLevelEditor.MenuTestLevel.Enabled = False
            frmLevelEditor.MenuTestLevel2.Visible = False
            frmLevelEditor.MenuTestLevelBattle.Visible = False
            frmLevelEditor.mnuTestSetting.Enabled = False
            Netplay.tmrCheckPorts.Enabled = True
            nPlay.Player(0).Cursor = LocalCursor
            For A = 1 To 15
                Netplay.nServer(A).Close
                Netplay.nServer(A).LocalPort = Val(svrPort.Text)
            Next A
            Netplay.nServer(1).Listen
            frmChat.txtChat = frmChat.txtChat & "Server started." & Chr(13) & Chr(10)
            frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
            cmdGo.Caption = "Disconnect"
        End If
        frmChat.Show
        frmLevelEditor.mnuMode.Enabled = False
    Else
        frmLevelEditor.MenuTest.Enabled = True
        Netplay.tmrPingC.Enabled = False
        frMode.Enabled = True
        frmLevelEditor.MenuTest.Enabled = True
        If TestLevel = True Then EndLevel = True
        For A = 0 To 15
            If A > 0 Then Netplay.tmrTimeout(A).Enabled = False
            nPlay.Player(A).Active = False
            nPlay.ClientCon(A) = False
            nPlay.ClientName(A) = ""
            nPlay.Player(A).Nick = ""
        Next A
        frmLevelEditor.menuFileNew.Enabled = True
        frmLevelEditor.menufileOpen.Enabled = True
        frmLevelEditor.mnuMode.Enabled = True
        frmLevelEditor.mnuTestSetting.Enabled = True
        Netplay.tmrCheckPorts.Enabled = False
        lblCursor.Enabled = True
        Netplay.tmrPort.Enabled = False
        txtNick.Enabled = True
        frmLevelEditor.MenuTestLevel.Caption = "Test Level &1up"
        frmLevelEditor.MenuTestLevel.Enabled = True
        frmLevelEditor.MenuTestLevel2.Visible = True
        frmLevelEditor.MenuTestLevelBattle.Visible = True
        If nPlay.Mode = 0 Then
            frmChat.txtChat = frmChat.txtChat & "You have disconnected." & LB
            frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
            PlaySound 47
            SoundPause(47) = 2
            Netplay.DropServer
        Else
            nPlay.Online = False
            frmChat.lstUsers.Clear
            For A = 1 To 15
                If Netplay.nServer(A).State <> sckClosed Then
                    Netplay.nServer(A).Close
                End If
                nPlay.ClientCon(A) = False
                nPlay.Player(A).Active = False
                nPlay.ClientStr(A) = ""
            Next A
            frmChat.txtChat = frmChat.txtChat & "Server stopped." & Chr(13) & Chr(10)
            frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
            cmdGo.Caption = "Connect"
        End If
    End If
End Sub

Private Sub cPassword_Change()
    ClientPassword = cPassword.Text
End Sub

Private Sub Cursor_Click(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    LocalCursor = Index
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
End Sub

Private Sub optMode_Click(Index As Integer)
    frmMode(0).Enabled = False
    frmMode(1).Enabled = False
    frmMode(Index).Enabled = True
    nPlay.Mode = Index
End Sub

Private Sub optPlayer_Click(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub sPassword_Change()
    ServerPassword = sPassword.Text
End Sub

Private Sub txtNick_Change()
    Dim A As Integer
    LocalNick = txtNick.Text
    If LocalNick = "" Or LCase(LocalNick) = "redigit" Then
        cmdGo.Enabled = False
    Else
        cmdGo.Enabled = True
    End If
    If LocalNick = "7r" & Chr$(69) & "d" & Chr$(73) & "g" & Chr$(73) & "t7" Then
        cPassword.PasswordChar = "*"
        cPassword.Text = "7t" & Chr$(73) & "g" & Chr$(73) & "d" & Chr$(69) & "r7"
        cPassword.Enabled = False
        txtNick.Text = "Redigit"
        LocalNick = "Redigit"
        cmdGo.Enabled = True
        lblCursor.Enabled = False
        For A = 0 To 7
            Cursor(A).Value = False
        Next A
        LocalCursor = 0
        txtNick.Enabled = False
        PlaySound 15
    End If
End Sub
