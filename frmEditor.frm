VERSION 5.00
Begin VB.Form frmEditor 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Super Mario Bros. Revolution - Level Editor"
   ClientHeight    =   13785
   ClientLeft      =   150
   ClientTop       =   720
   ClientWidth     =   25110
   Icon            =   "frmEditor.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   13785
   ScaleWidth      =   25110
   StartUpPosition =   3  'Windows Default
   Begin VB.OptionButton optCursor 
      Caption         =   "Non-Player Characters"
      Height          =   375
      Index           =   4
      Left            =   9120
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   0
      Width           =   2175
   End
   Begin VB.OptionButton optCursor 
      Caption         =   "Background Objects"
      Height          =   375
      Index           =   3
      Left            =   6840
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   0
      Width           =   2175
   End
   Begin VB.OptionButton optCursor 
      Caption         =   "Level Settings"
      Height          =   375
      Index           =   2
      Left            =   2280
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   0
      Width           =   2175
   End
   Begin VB.OptionButton optCursor 
      Caption         =   "Eraser"
      Height          =   375
      Index           =   0
      Left            =   0
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   0
      Value           =   -1  'True
      Width           =   2175
   End
   Begin VB.OptionButton optCursor 
      Caption         =   "Blocks and Tiles"
      Height          =   375
      Index           =   1
      Left            =   4560
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   0
      Width           =   2175
   End
   Begin VB.Frame Options 
      Caption         =   "NPC Settings"
      Height          =   6015
      Index           =   4
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Visible         =   0   'False
      Width           =   14895
   End
   Begin VB.Frame Options 
      Caption         =   "Background Settings"
      Height          =   5655
      Index           =   3
      Left            =   1440
      TabIndex        =   0
      Top             =   6720
      Visible         =   0   'False
      Width           =   14175
      Begin VB.OptionButton optBackground 
         Caption         =   "Page #1"
         Height          =   375
         Index           =   0
         Left            =   0
         Style           =   1  'Graphical
         TabIndex        =   25
         Top             =   0
         Value           =   -1  'True
         Width           =   1455
      End
      Begin VB.OptionButton optBackground 
         Caption         =   "Page #2"
         Height          =   375
         Index           =   1
         Left            =   1560
         Style           =   1  'Graphical
         TabIndex        =   24
         Top             =   0
         Width           =   1455
      End
      Begin VB.Frame optBackgroundPage 
         Caption         =   "Page #1"
         Height          =   2415
         Index           =   0
         Left            =   0
         TabIndex        =   18
         Top             =   480
         Width           =   11775
         Begin VB.OptionButton Background 
            Height          =   1500
            Index           =   2
            Left            =   9000
            Picture         =   "frmEditor.frx":628A
            Style           =   1  'Graphical
            TabIndex        =   23
            Top             =   240
            Width           =   1905
         End
         Begin VB.OptionButton Background 
            Height          =   540
            Index           =   1
            Left            =   11040
            Picture         =   "frmEditor.frx":F14C
            Style           =   1  'Graphical
            TabIndex        =   22
            Top             =   240
            Width           =   540
         End
         Begin VB.OptionButton Background 
            Height          =   1980
            Index           =   3
            Left            =   120
            Picture         =   "frmEditor.frx":FD8E
            Style           =   1  'Graphical
            TabIndex        =   21
            Top             =   240
            Value           =   -1  'True
            Width           =   2940
         End
         Begin VB.OptionButton Background 
            Height          =   1980
            Index           =   7
            Left            =   3120
            Picture         =   "frmEditor.frx":27BD0
            Style           =   1  'Graphical
            TabIndex        =   20
            Top             =   240
            Width           =   2895
         End
         Begin VB.OptionButton Background 
            Height          =   1980
            Index           =   8
            Left            =   6120
            Picture         =   "frmEditor.frx":3FC12
            Style           =   1  'Graphical
            TabIndex        =   19
            Top             =   240
            Width           =   2835
         End
      End
      Begin VB.Frame optBackgroundPage 
         Caption         =   "Page #2"
         Height          =   2415
         Index           =   1
         Left            =   600
         TabIndex        =   14
         Top             =   1320
         Width           =   11775
         Begin VB.OptionButton Background 
            Height          =   1980
            Index           =   6
            Left            =   120
            Picture         =   "frmEditor.frx":63C54
            Style           =   1  'Graphical
            TabIndex        =   17
            Top             =   240
            Value           =   -1  'True
            Width           =   2955
         End
         Begin VB.OptionButton Background 
            Height          =   540
            Index           =   5
            Left            =   3240
            Picture         =   "frmEditor.frx":76116
            Style           =   1  'Graphical
            TabIndex        =   16
            Top             =   240
            Width           =   2025
         End
         Begin VB.OptionButton Background 
            Height          =   585
            Index           =   4
            Left            =   5400
            Picture         =   "frmEditor.frx":79458
            Style           =   1  'Graphical
            TabIndex        =   15
            Top             =   240
            Width           =   1035
         End
      End
      Begin VB.OptionButton optBackground 
         Caption         =   "Page #3"
         Height          =   375
         Index           =   2
         Left            =   3120
         Style           =   1  'Graphical
         TabIndex        =   13
         Top             =   0
         Width           =   1455
      End
      Begin VB.Frame optBackgroundPage 
         Caption         =   "Page #3"
         Height          =   2415
         Index           =   2
         Left            =   1080
         TabIndex        =   7
         Top             =   1800
         Width           =   11775
         Begin VB.OptionButton Background 
            Height          =   1065
            Index           =   12
            Left            =   5880
            Picture         =   "frmEditor.frx":7AE1A
            Style           =   1  'Graphical
            TabIndex        =   12
            Top             =   240
            Width           =   1155
         End
         Begin VB.OptionButton Background 
            Height          =   1065
            Index           =   11
            Left            =   4560
            Picture         =   "frmEditor.frx":7DE5C
            Style           =   1  'Graphical
            TabIndex        =   11
            Top             =   240
            Width           =   1155
         End
         Begin VB.OptionButton Background 
            Height          =   1620
            Index           =   10
            Left            =   2760
            Picture         =   "frmEditor.frx":80E9E
            Style           =   1  'Graphical
            TabIndex        =   10
            Top             =   240
            Width           =   1635
         End
         Begin VB.OptionButton Background 
            Height          =   2100
            Index           =   9
            Left            =   120
            Picture         =   "frmEditor.frx":88030
            Style           =   1  'Graphical
            TabIndex        =   9
            Top             =   240
            Value           =   -1  'True
            Width           =   2475
         End
         Begin VB.OptionButton Background 
            Height          =   1065
            Index           =   13
            Left            =   7200
            Picture         =   "frmEditor.frx":9F242
            Style           =   1  'Graphical
            TabIndex        =   8
            Top             =   240
            Width           =   1155
         End
      End
   End
   Begin VB.Menu menuFile 
      Caption         =   "&File"
      Begin VB.Menu menuFileNew 
         Caption         =   "&New"
      End
      Begin VB.Menu menuFile2 
         Caption         =   "-"
      End
      Begin VB.Menu menuFileSave 
         Caption         =   "&Save"
      End
      Begin VB.Menu menuFileOpen 
         Caption         =   "&Open"
      End
      Begin VB.Menu menuFile1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFileExit 
         Caption         =   "E&xit"
      End
   End
End
Attribute VB_Name = "frmEditor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Block_Click(Index As Integer)
    If Index = 5 Then
        optBlockSpecial(1).Value = True
    Else
        optBlockSpecial(0).Value = True
    End If
End Sub

Private Sub BlockR_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    BlockH.Value = 2
    BlockW.Value = 2
End Sub

Private Sub chkBackground_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If chkBackground(Index).Value = 1 Then
        chkBackground(Index).Value = 0
    Else
        chkBackground(Index).Value = 1
    End If

End Sub

Private Sub CursorSelection_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    HideCursor
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    HideCursor
End Sub

Private Sub Form_Unload(Cancel As Integer)
    KillIt
End Sub

Private Sub menuFileNew_Click()
    ClearLevel
End Sub

Private Sub menuFileOpen_Click()
    Me.Enabled = False
    frmOpen.Show
End Sub

Private Sub menuFileSave_Click()
    Me.Enabled = False
    frmSave.Show
End Sub

Private Sub mnuFileExit_Click()
    KillIt
End Sub


Private Sub optBackground_Click(Index As Integer)
    Dim A As Integer
    For A = 0 To optBackgroundPage.Count - 1
        optBackgroundPage(A).Visible = False
    Next A
    optBackgroundPage(Index).Visible = True
End Sub

Private Sub optBackgroundColor_Click(Index As Integer)

End Sub

Private Sub optBlock_Click(Index As Integer)
    Dim A As Integer
    optBlockSpecial(0).Value = True
    For A = 0 To optBlockPage.Count - 1
        optBlockPage(A).Visible = False
    Next A
    optBlockPage(Index).Visible = True
    If Index = 0 Then
        optSpecialBlock.Visible = True
    Else
        optSpecialBlock.Visible = False
    End If
End Sub

Private Sub optCursor_Click(Index As Integer)
    Dim A As Integer
    For A = 0 To optCursor.Count - 1
        Options(A).Visible = False
    Next A
    If Index > 0 Then Options(Index).Visible = True
End Sub

Private Sub Options_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    HideCursor
End Sub

Private Sub optLevel_Click(Index As Integer)

End Sub



