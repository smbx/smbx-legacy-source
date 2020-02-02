VERSION 5.00
Begin VB.Form frmPaths 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Paths"
   ClientHeight    =   1350
   ClientLeft      =   1.00050e5
   ClientTop       =   330
   ClientWidth     =   8580
   Icon            =   "frmPaths.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   1350
   ScaleWidth      =   8580
   Visible         =   0   'False
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   32
      Left            =   7920
      Picture         =   "frmPaths.frx":628A
      Style           =   1  'Graphical
      TabIndex        =   32
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   31
      Left            =   7920
      Picture         =   "frmPaths.frx":65F7
      Style           =   1  'Graphical
      TabIndex        =   31
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   30
      Left            =   6720
      Picture         =   "frmPaths.frx":696D
      Style           =   1  'Graphical
      TabIndex        =   30
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   29
      Left            =   6720
      Picture         =   "frmPaths.frx":6D05
      Style           =   1  'Graphical
      TabIndex        =   29
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   28
      Left            =   7320
      Picture         =   "frmPaths.frx":70A4
      Style           =   1  'Graphical
      TabIndex        =   28
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   27
      Left            =   7320
      Picture         =   "frmPaths.frx":7443
      Style           =   1  'Graphical
      TabIndex        =   27
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   26
      Left            =   6120
      Picture         =   "frmPaths.frx":77DB
      Style           =   1  'Graphical
      TabIndex        =   26
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   25
      Left            =   5520
      Picture         =   "frmPaths.frx":7BA9
      Style           =   1  'Graphical
      TabIndex        =   25
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   24
      Left            =   5520
      Picture         =   "frmPaths.frx":7F34
      Style           =   1  'Graphical
      TabIndex        =   24
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   23
      Left            =   4920
      Picture         =   "frmPaths.frx":82C3
      Style           =   1  'Graphical
      TabIndex        =   23
      Top             =   120
      Width           =   540
   End
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   10080
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   0
      Top             =   240
      Width           =   375
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   22
      Left            =   6120
      Picture         =   "frmPaths.frx":8639
      Style           =   1  'Graphical
      TabIndex        =   22
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   21
      Left            =   4320
      Picture         =   "frmPaths.frx":89AB
      Style           =   1  'Graphical
      TabIndex        =   21
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   20
      Left            =   4920
      Picture         =   "frmPaths.frx":8D36
      Style           =   1  'Graphical
      TabIndex        =   20
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   19
      Left            =   3720
      Picture         =   "frmPaths.frx":90BF
      Style           =   1  'Graphical
      TabIndex        =   19
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   18
      Left            =   3720
      Picture         =   "frmPaths.frx":9D01
      Style           =   1  'Graphical
      TabIndex        =   18
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   16
      Left            =   720
      Picture         =   "frmPaths.frx":A943
      Style           =   1  'Graphical
      TabIndex        =   17
      Top             =   6600
      Visible         =   0   'False
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   15
      Left            =   1320
      Picture         =   "frmPaths.frx":B585
      Style           =   1  'Graphical
      TabIndex        =   16
      Top             =   6600
      Visible         =   0   'False
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   14
      Left            =   120
      Picture         =   "frmPaths.frx":C1C7
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   6600
      Visible         =   0   'False
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   13
      Left            =   120
      Picture         =   "frmPaths.frx":CE09
      Style           =   1  'Graphical
      TabIndex        =   14
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   12
      Left            =   720
      Picture         =   "frmPaths.frx":DA4B
      Style           =   1  'Graphical
      TabIndex        =   13
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   11
      Left            =   120
      Picture         =   "frmPaths.frx":E68D
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   10
      Left            =   720
      Picture         =   "frmPaths.frx":F2CF
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   9
      Left            =   1920
      Picture         =   "frmPaths.frx":FF11
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   8
      Left            =   1320
      Picture         =   "frmPaths.frx":10B53
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   7
      Left            =   1920
      Picture         =   "frmPaths.frx":11795
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   6
      Left            =   1320
      Picture         =   "frmPaths.frx":123D7
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   5
      Left            =   3120
      Picture         =   "frmPaths.frx":13019
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   17
      Left            =   1920
      Picture         =   "frmPaths.frx":13C5B
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   6600
      Visible         =   0   'False
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   4
      Left            =   4320
      Picture         =   "frmPaths.frx":1489D
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   120
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   2
      Left            =   2520
      Picture         =   "frmPaths.frx":154DF
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   720
      Value           =   -1  'True
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   3
      Left            =   3120
      Picture         =   "frmPaths.frx":16121
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   720
      Width           =   540
   End
   Begin VB.OptionButton WorldPath 
      Height          =   540
      Index           =   1
      Left            =   2520
      Picture         =   "frmPaths.frx":16D63
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   120
      Width           =   540
   End
End
Attribute VB_Name = "frmPaths"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub WorldPath_Click(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub
