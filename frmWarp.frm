VERSION 5.00
Begin VB.Form frmWarp 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Warps and Doors"
   ClientHeight    =   3825
   ClientLeft      =   1.00050e5
   ClientTop       =   330
   ClientWidth     =   7320
   Icon            =   "frmWarp.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3825
   ScaleWidth      =   7320
   Begin VB.Frame Frame3 
      Caption         =   "Locked"
      Height          =   615
      Left            =   6240
      TabIndex        =   36
      Top             =   3120
      Width           =   975
      Begin VB.CommandButton cmdLocked 
         Caption         =   "No"
         Height          =   255
         Left            =   120
         TabIndex        =   37
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Allow NPC"
      Height          =   615
      Left            =   6240
      TabIndex        =   34
      Top             =   2400
      Width           =   975
      Begin VB.CommandButton cmdNPC 
         Caption         =   "No"
         Height          =   255
         Left            =   120
         TabIndex        =   35
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "No Yoshi"
      Height          =   615
      Left            =   6240
      TabIndex        =   32
      Top             =   1680
      Width           =   975
      Begin VB.CommandButton cmdYoshi 
         Caption         =   "No"
         Height          =   255
         Left            =   120
         TabIndex        =   33
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Stars Needed"
      Height          =   615
      Index           =   7
      Left            =   3720
      TabIndex        =   25
      Top             =   1320
      Width           =   1695
      Begin VB.TextBox txtStars 
         Height          =   285
         Left            =   120
         TabIndex        =   26
         Top             =   240
         Width           =   1455
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Level Exit"
      Height          =   1695
      Index           =   4
      Left            =   120
      TabIndex        =   23
      Top             =   2040
      Width           =   2415
      Begin VB.Frame Frame 
         Caption         =   "Warp To Map Location"
         Height          =   975
         Index           =   6
         Left            =   120
         TabIndex        =   27
         Top             =   600
         Width           =   2175
         Begin VB.TextBox txtX 
            Height          =   285
            Left            =   360
            TabIndex        =   29
            Top             =   240
            Width           =   1695
         End
         Begin VB.TextBox txtY 
            Height          =   285
            Left            =   360
            TabIndex        =   28
            Top             =   600
            Width           =   1695
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "X:"
            Height          =   195
            Left            =   120
            TabIndex        =   31
            Top             =   240
            Width           =   150
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Y:"
            Height          =   195
            Left            =   120
            TabIndex        =   30
            Top             =   600
            Width           =   150
         End
      End
      Begin VB.CheckBox chkMapWarp 
         Caption         =   "Level Exit (Ends the level)"
         Height          =   255
         Left            =   120
         TabIndex        =   24
         Top             =   240
         Width           =   2175
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Warp to Level"
      Height          =   1335
      Index           =   5
      Left            =   2640
      TabIndex        =   18
      Top             =   2040
      Width           =   3495
      Begin VB.CheckBox chkEntrance 
         Caption         =   "Level Entrance (Can not enter)"
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   960
         Width           =   2655
      End
      Begin VB.HScrollBar scrWarp 
         Height          =   255
         Left            =   120
         Max             =   100
         TabIndex        =   20
         Top             =   600
         Width           =   1335
      End
      Begin VB.TextBox txtLevel 
         Height          =   285
         Left            =   120
         TabIndex        =   19
         Top             =   240
         Width           =   3255
      End
      Begin VB.Label lblWarp 
         Caption         =   "Normal Entrance"
         Height          =   255
         Left            =   1560
         TabIndex        =   21
         Top             =   600
         Width           =   1815
      End
   End
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   8880
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   0
      Top             =   240
      Width           =   375
   End
   Begin VB.Frame Frame 
      Caption         =   "Exit Direction"
      Height          =   1815
      Index           =   2
      Left            =   1920
      TabIndex        =   12
      Top             =   120
      Width           =   1695
      Begin VB.OptionButton optDirection2 
         Caption         =   "Moving Right"
         Height          =   255
         Index           =   2
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   16
         Top             =   1080
         Width           =   1215
      End
      Begin VB.OptionButton optDirection2 
         Caption         =   "Moving Left"
         Height          =   255
         Index           =   4
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   15
         Top             =   1440
         Width           =   1215
      End
      Begin VB.OptionButton optDirection2 
         Caption         =   "Moving Down"
         Height          =   255
         Index           =   1
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   14
         Top             =   720
         Width           =   1215
      End
      Begin VB.OptionButton optDirection2 
         Caption         =   "Moving Up"
         Height          =   255
         Index           =   3
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   13
         Top             =   360
         Value           =   -1  'True
         Width           =   1215
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Entrance Direction"
      Height          =   1815
      Index           =   3
      Left            =   120
      TabIndex        =   6
      Top             =   120
      Width           =   1695
      Begin VB.OptionButton optDirection 
         Caption         =   "Moving Down"
         Height          =   255
         Index           =   3
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   360
         Value           =   -1  'True
         Width           =   1215
      End
      Begin VB.OptionButton optDirection 
         Caption         =   "Moving Up"
         Height          =   255
         Index           =   1
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   9
         Top             =   720
         Width           =   1215
      End
      Begin VB.OptionButton optDirection 
         Caption         =   "Moving Right"
         Height          =   255
         Index           =   4
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   1440
         Width           =   1215
      End
      Begin VB.OptionButton optDirection 
         Caption         =   "Moving Left"
         Height          =   255
         Index           =   2
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   7
         Top             =   1080
         Width           =   1215
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Warp Effect"
      Height          =   1455
      Index           =   0
      Left            =   5520
      TabIndex        =   2
      Top             =   120
      Width           =   1695
      Begin VB.OptionButton optEffect 
         Caption         =   "Door"
         Height          =   255
         Index           =   2
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   17
         Top             =   720
         Width           =   1215
      End
      Begin VB.OptionButton optEffect 
         Caption         =   "Pipe"
         Height          =   255
         Index           =   1
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   11
         Top             =   360
         Value           =   -1  'True
         Width           =   1215
      End
      Begin VB.OptionButton optEffect 
         Caption         =   "Instant"
         Height          =   255
         Index           =   0
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   1080
         Width           =   1215
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Warp Placement"
      Height          =   1095
      Index           =   1
      Left            =   3720
      TabIndex        =   1
      Top             =   120
      Width           =   1695
      Begin VB.OptionButton optE 
         Caption         =   "Exit"
         Height          =   255
         Index           =   2
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   720
         Width           =   1215
      End
      Begin VB.OptionButton optE 
         Caption         =   "Entrance"
         Height          =   255
         Index           =   1
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   360
         Value           =   -1  'True
         Width           =   1215
      End
   End
End
Attribute VB_Name = "frmWarp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub chkEntrance_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub chkMapWarp_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub cmdLocked_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If cmdLocked.Caption = "Yes" Then
        cmdLocked.Caption = "No"
    Else
        cmdLocked.Caption = "Yes"
    End If
End Sub

Private Sub cmdNPC_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If cmdNPC.Caption = "Yes" Then
        cmdNPC.Caption = "No"
    Else
        cmdNPC.Caption = "Yes"
    End If
End Sub

Private Sub cmdYoshi_Click()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If cmdYoshi.Caption = "Yes" Then
        cmdYoshi.Caption = "No"
    Else
        cmdYoshi.Caption = "Yes"
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    frmLevelEditor.optCursor(13).Value = True
End Sub

Private Sub optDirection_Click(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub optDirection2_Click(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub optE_Click(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub optEffect_Click(Index As Integer)
    On Error Resume Next
    Dim A As Integer
    If Index = 2 Then
        optDirection(1).Value = True
        For A = 1 To 4
            optDirection(A).Enabled = False
            optDirection2(A).Enabled = False
        Next A
    Else
        For A = 1 To 4
            optDirection(A).Enabled = True
            optDirection2(A).Enabled = True
        Next A
    End If
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub scrWarp_Change()
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
    If scrWarp.Value = 0 Then
        lblWarp.Caption = "Normal Entrance"
    Else
        lblWarp.Caption = "To Warp " & scrWarp.Value
    End If
End Sub

