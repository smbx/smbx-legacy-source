VERSION 5.00
Begin VB.Form frmGenerator 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "NPC Generator"
   ClientHeight    =   2220
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   2940
   Icon            =   "frmGenerator.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2220
   ScaleWidth      =   2940
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   5760
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   13
      Top             =   120
      Width           =   375
   End
   Begin VB.Frame Frame2 
      Caption         =   "Effect"
      Height          =   1095
      Left            =   1440
      TabIndex        =   9
      Top             =   1080
      Width           =   1335
      Begin VB.OptionButton optEffect 
         Caption         =   "Projectile"
         Height          =   375
         Index           =   2
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   11
         Top             =   600
         Width           =   1095
      End
      Begin VB.OptionButton optEffect 
         Caption         =   "Warp"
         Height          =   375
         Index           =   1
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   240
         Value           =   -1  'True
         Width           =   1095
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Direction"
      Height          =   1335
      Left            =   120
      TabIndex        =   4
      Top             =   840
      Width           =   1215
      Begin VB.OptionButton optSpawnDirection 
         Caption         =   "Right"
         Height          =   255
         Index           =   4
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   960
         Width           =   975
      End
      Begin VB.OptionButton optSpawnDirection 
         Caption         =   "Left"
         Height          =   255
         Index           =   2
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   7
         Top             =   720
         Width           =   975
      End
      Begin VB.OptionButton optSpawnDirection 
         Caption         =   "Down"
         Height          =   255
         Index           =   3
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   480
         Width           =   975
      End
      Begin VB.OptionButton optSpawnDirection 
         Caption         =   "Up"
         Height          =   255
         Index           =   1
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   240
         Value           =   -1  'True
         Width           =   975
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Delay"
      Height          =   855
      Left            =   1440
      TabIndex        =   1
      Top             =   120
      Width           =   1335
      Begin VB.HScrollBar scrDelay 
         Height          =   255
         Left            =   120
         Max             =   600
         Min             =   1
         TabIndex        =   2
         Top             =   480
         Value           =   10
         Width           =   1095
      End
      Begin VB.Label lblDelay 
         Caption         =   "1 Second"
         Height          =   255
         Left            =   45
         TabIndex        =   3
         Top             =   240
         Width           =   1170
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Generator"
      Height          =   615
      Index           =   1
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1215
      Begin VB.CommandButton Spawn 
         Caption         =   "No"
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   240
         Width           =   975
      End
   End
End
Attribute VB_Name = "frmGenerator"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Load()
    CheckSpawn
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
    Spawn.Caption = "No"
End Sub

Private Sub optEffect_Click(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub Spawn_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If Spawn.Caption = "Yes" Then
        Spawn.Caption = "No"
    Else
        Spawn.Caption = "Yes"
    End If
    CheckSpawn
End Sub

Public Sub CheckSpawn()
    If Spawn.Caption = "Yes" Then
        Frame1.Enabled = True
        Frame2.Enabled = True
        Frame3.Enabled = True
        optSpawnDirection(1).Enabled = True
        optSpawnDirection(2).Enabled = True
        optSpawnDirection(3).Enabled = True
        optSpawnDirection(4).Enabled = True
        lblDelay.Enabled = True
        scrDelay.Enabled = True
        optEffect(1).Enabled = True
        optEffect(2).Enabled = True
    Else
        Frame1.Enabled = False
        Frame2.Enabled = False
        Frame3.Enabled = False
        optSpawnDirection(1).Enabled = False
        optSpawnDirection(2).Enabled = False
        optSpawnDirection(3).Enabled = False
        optSpawnDirection(4).Enabled = False
        lblDelay.Enabled = False
        scrDelay.Enabled = False
        optEffect(1).Enabled = False
        optEffect(2).Enabled = False
    End If
End Sub

Private Sub optSpawnDirection_Click(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub scrDelay_Change()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If scrDelay.Value = 10 Then
        lblDelay.Caption = scrDelay.Value / 10 & " Second"
    Else
        lblDelay.Caption = scrDelay.Value / 10 & " Seconds"
    End If
End Sub
