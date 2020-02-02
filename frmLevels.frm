VERSION 5.00
Begin VB.Form frmLevels 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Levels"
   ClientHeight    =   3735
   ClientLeft      =   1.00050e5
   ClientTop       =   330
   ClientWidth     =   10710
   Icon            =   "frmLevels.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   3735
   ScaleWidth      =   10710
   Visible         =   0   'False
   Begin VB.OptionButton WorldLevel 
      BackColor       =   &H00000000&
      Height          =   540
      Index           =   0
      Left            =   2880
      Picture         =   "frmLevels.frx":628A
      Style           =   1  'Graphical
      TabIndex        =   61
      Top             =   10560
      Width           =   540
   End
   Begin VB.OptionButton WorldLevel 
      BackColor       =   &H00000000&
      Height          =   540
      Index           =   29
      Left            =   3480
      Picture         =   "frmLevels.frx":6ECC
      Style           =   1  'Graphical
      TabIndex        =   60
      Top             =   10560
      Width           =   540
   End
   Begin VB.Frame Frame 
      Caption         =   "Map Warp Location"
      Height          =   975
      Index           =   6
      Left            =   8640
      TabIndex        =   45
      Top             =   1680
      Width           =   1935
      Begin VB.TextBox txtX 
         Height          =   285
         Left            =   360
         TabIndex        =   47
         Top             =   240
         Width           =   1455
      End
      Begin VB.TextBox txtY 
         Height          =   285
         Left            =   360
         TabIndex        =   46
         Top             =   600
         Width           =   1455
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "X:"
         Height          =   195
         Left            =   120
         TabIndex        =   49
         Top             =   240
         Width           =   150
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Y:"
         Height          =   195
         Left            =   120
         TabIndex        =   48
         Top             =   600
         Width           =   150
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Options"
      Height          =   1215
      Left            =   6360
      TabIndex        =   41
      Top             =   2400
      Width           =   2175
      Begin VB.CheckBox chkPath2 
         Caption         =   "Big Background"
         Height          =   255
         Left            =   120
         TabIndex        =   58
         Top             =   180
         Width           =   1575
      End
      Begin VB.CheckBox chkStart 
         Caption         =   "Game Start"
         Height          =   255
         Left            =   120
         TabIndex        =   44
         Top             =   900
         Width           =   1575
      End
      Begin VB.CheckBox chkVisible 
         Caption         =   "Always Visible"
         Height          =   255
         Left            =   120
         TabIndex        =   43
         Top             =   660
         Width           =   1575
      End
      Begin VB.CheckBox chkPath 
         Caption         =   "Path Background"
         Height          =   255
         Left            =   120
         TabIndex        =   42
         Top             =   420
         Width           =   1575
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Entrance"
      Height          =   975
      Index           =   1
      Left            =   8640
      TabIndex        =   32
      Top             =   2640
      Width           =   1935
      Begin VB.HScrollBar scrWarp 
         Height          =   255
         Left            =   120
         Max             =   100
         TabIndex        =   33
         Top             =   240
         Width           =   1335
      End
      Begin VB.Label lblWarp 
         Caption         =   "Normal Entrance"
         Height          =   255
         Left            =   120
         TabIndex        =   34
         Top             =   600
         Width           =   1455
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Location"
      Height          =   735
      Index           =   0
      Left            =   6360
      TabIndex        =   29
      Top             =   1680
      Width           =   2175
      Begin VB.Label lblY 
         Caption         =   "Y - 01231"
         Height          =   200
         Left            =   240
         TabIndex        =   31
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblX 
         Caption         =   "X - 0"
         Height          =   255
         Left            =   240
         TabIndex        =   30
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   5400
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   0
      Top             =   7200
      Width           =   375
   End
   Begin VB.Frame Frame 
      Caption         =   "Level's Name"
      Height          =   855
      Index           =   4
      Left            =   120
      TabIndex        =   19
      Top             =   2760
      Width           =   3015
      Begin VB.TextBox txtLevelName 
         Height          =   375
         Left            =   120
         TabIndex        =   20
         Top             =   240
         Width           =   2775
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Level Exits"
      Height          =   1935
      Index           =   2
      Left            =   3240
      TabIndex        =   6
      Top             =   1680
      Width           =   3015
      Begin VB.ComboBox cmbExit 
         Height          =   315
         Index           =   4
         ItemData        =   "frmLevels.frx":7B0E
         Left            =   960
         List            =   "frmLevels.frx":7B30
         TabIndex        =   14
         Text            =   "0 - None"
         Top             =   1320
         Width           =   1935
      End
      Begin VB.ComboBox cmbExit 
         Height          =   315
         Index           =   3
         ItemData        =   "frmLevels.frx":7BDA
         Left            =   960
         List            =   "frmLevels.frx":7BFC
         TabIndex        =   13
         Text            =   "0 - None"
         Top             =   960
         Width           =   1935
      End
      Begin VB.ComboBox cmbExit 
         Height          =   315
         Index           =   2
         ItemData        =   "frmLevels.frx":7CA6
         Left            =   960
         List            =   "frmLevels.frx":7CC8
         TabIndex        =   12
         Text            =   "0 - None"
         Top             =   600
         Width           =   1935
      End
      Begin VB.ComboBox cmbExit 
         Height          =   315
         Index           =   1
         ItemData        =   "frmLevels.frx":7D72
         Left            =   960
         List            =   "frmLevels.frx":7D94
         TabIndex        =   11
         Text            =   "0 - None"
         Top             =   240
         Width           =   1935
      End
      Begin VB.Label Label4 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Right"
         Height          =   195
         Left            =   120
         TabIndex        =   10
         Top             =   1320
         Width           =   615
      End
      Begin VB.Label Label3 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Bottom"
         Height          =   195
         Left            =   120
         TabIndex        =   9
         Top             =   960
         Width           =   615
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Left"
         Height          =   195
         Left            =   120
         TabIndex        =   8
         Top             =   600
         Width           =   615
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Top"
         Height          =   195
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   645
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Level Filename"
      Height          =   855
      Index           =   3
      Left            =   120
      TabIndex        =   4
      Top             =   1800
      Width           =   3015
      Begin VB.TextBox txtFilename 
         Height          =   375
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   2775
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Level Graphic"
      Height          =   1575
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   10455
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   32
         Left            =   7920
         Picture         =   "frmLevels.frx":7E3E
         Style           =   1  'Graphical
         TabIndex        =   63
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   31
         Left            =   7320
         Picture         =   "frmLevels.frx":825D
         Style           =   1  'Graphical
         TabIndex        =   62
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   30
         Left            =   4320
         Picture         =   "frmLevels.frx":867C
         Style           =   1  'Graphical
         TabIndex        =   59
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   28
         Left            =   4320
         Picture         =   "frmLevels.frx":8A7C
         Style           =   1  'Graphical
         TabIndex        =   57
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   27
         Left            =   4920
         Picture         =   "frmLevels.frx":8F4D
         Style           =   1  'Graphical
         TabIndex        =   56
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   26
         Left            =   4920
         Picture         =   "frmLevels.frx":934D
         Style           =   1  'Graphical
         TabIndex        =   55
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   25
         Left            =   5520
         Picture         =   "frmLevels.frx":975A
         Style           =   1  'Graphical
         TabIndex        =   54
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   24
         Left            =   2520
         Picture         =   "frmLevels.frx":9B5A
         Style           =   1  'Graphical
         TabIndex        =   53
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   23
         Left            =   3120
         Picture         =   "frmLevels.frx":A04C
         Style           =   1  'Graphical
         TabIndex        =   52
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   22
         Left            =   1920
         Picture         =   "frmLevels.frx":A617
         Style           =   1  'Graphical
         TabIndex        =   51
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   21
         Left            =   3720
         Picture         =   "frmLevels.frx":AAAC
         Style           =   1  'Graphical
         TabIndex        =   50
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   20
         Left            =   6120
         Picture         =   "frmLevels.frx":AFB2
         Style           =   1  'Graphical
         TabIndex        =   40
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   19
         Left            =   9120
         Picture         =   "frmLevels.frx":B37F
         Style           =   1  'Graphical
         TabIndex        =   39
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   18
         Left            =   9720
         Picture         =   "frmLevels.frx":B760
         Style           =   1  'Graphical
         TabIndex        =   38
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   17
         Left            =   7920
         Picture         =   "frmLevels.frx":BB21
         Style           =   1  'Graphical
         TabIndex        =   37
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   16
         Left            =   6120
         Picture         =   "frmLevels.frx":BF13
         Style           =   1  'Graphical
         TabIndex        =   36
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   15
         Left            =   8520
         Picture         =   "frmLevels.frx":C310
         Style           =   1  'Graphical
         TabIndex        =   35
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   14
         Left            =   2520
         Picture         =   "frmLevels.frx":C6E5
         Style           =   1  'Graphical
         TabIndex        =   28
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   13
         Left            =   1320
         Picture         =   "frmLevels.frx":CB09
         Style           =   1  'Graphical
         TabIndex        =   27
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   12
         Left            =   120
         Picture         =   "frmLevels.frx":CEBE
         Style           =   1  'Graphical
         TabIndex        =   26
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   11
         Left            =   6720
         Picture         =   "frmLevels.frx":D2E7
         Style           =   1  'Graphical
         TabIndex        =   25
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   10
         Left            =   1320
         Picture         =   "frmLevels.frx":D6D0
         Style           =   1  'Graphical
         TabIndex        =   24
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   9
         Left            =   1920
         Picture         =   "frmLevels.frx":DAAD
         Style           =   1  'Graphical
         TabIndex        =   23
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   8
         Left            =   720
         Picture         =   "frmLevels.frx":DED1
         Style           =   1  'Graphical
         TabIndex        =   22
         Top             =   840
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   7
         Left            =   6720
         Picture         =   "frmLevels.frx":E2A7
         Style           =   1  'Graphical
         TabIndex        =   21
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   6
         Left            =   7320
         Picture         =   "frmLevels.frx":EEE9
         Style           =   1  'Graphical
         TabIndex        =   18
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   5
         Left            =   3120
         Picture         =   "frmLevels.frx":FB2B
         Style           =   1  'Graphical
         TabIndex        =   17
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   4
         Left            =   5520
         Picture         =   "frmLevels.frx":1076D
         Style           =   1  'Graphical
         TabIndex        =   16
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   3
         Left            =   3720
         Picture         =   "frmLevels.frx":113AF
         Style           =   1  'Graphical
         TabIndex        =   15
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   2
         Left            =   720
         Picture         =   "frmLevels.frx":11FF1
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   240
         Width           =   540
      End
      Begin VB.OptionButton WorldLevel 
         BackColor       =   &H00000000&
         Height          =   540
         Index           =   1
         Left            =   120
         Picture         =   "frmLevels.frx":12C33
         Style           =   1  'Graphical
         TabIndex        =   2
         Top             =   240
         Value           =   -1  'True
         Width           =   540
      End
   End
End
Attribute VB_Name = "frmLevels"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmbExit_Change(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub

Private Sub cmbExit_Click(Index As Integer)
    On Error Resume Next
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

Private Sub WorldLevel_Click(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub
