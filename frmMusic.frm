VERSION 5.00
Begin VB.Form frmMusic 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "World Music"
   ClientHeight    =   2085
   ClientLeft      =   1.00050e5
   ClientTop       =   330
   ClientWidth     =   7935
   Icon            =   "frmMusic.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2085
   ScaleWidth      =   7935
   Visible         =   0   'False
   Begin VB.OptionButton optMusic 
      Caption         =   "SMW Cave"
      Height          =   375
      Index           =   16
      Left            =   1680
      Style           =   1  'Graphical
      TabIndex        =   17
      Top             =   1080
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMW Island"
      Height          =   375
      Index           =   15
      Left            =   6360
      Style           =   1  'Graphical
      TabIndex        =   16
      Top             =   600
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMW Star Road"
      Height          =   375
      Index           =   14
      Left            =   6360
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   1080
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMW Bowser"
      Height          =   375
      Index           =   13
      Left            =   4800
      Style           =   1  'Graphical
      TabIndex        =   14
      Top             =   1080
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMW Special"
      Height          =   375
      Index           =   12
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   13
      Top             =   1560
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMB3 World 5"
      Height          =   375
      Index           =   11
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   600
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMB3 World 6"
      Height          =   375
      Index           =   10
      Left            =   1680
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   600
      Width           =   1455
   End
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   11160
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   0
      Top             =   360
      Width           =   375
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMB3 World 8"
      Height          =   375
      Index           =   9
      Left            =   4800
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   600
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMB3 World 3"
      Height          =   375
      Index           =   8
      Left            =   4800
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   120
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMW Forest"
      Height          =   375
      Index           =   7
      Left            =   3240
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   1080
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMB3 World 2"
      Height          =   375
      Index           =   6
      Left            =   3240
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   120
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "NSMB Theme"
      Height          =   375
      Index           =   5
      Left            =   1680
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   1560
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMW Theme"
      Height          =   375
      Index           =   4
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   1080
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMB3 World 7"
      Height          =   375
      Index           =   3
      Left            =   3240
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   600
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "None"
      Height          =   375
      Index           =   0
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   120
      Value           =   -1  'True
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMB3 World 1"
      Height          =   375
      Index           =   1
      Left            =   1680
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   120
      Width           =   1455
   End
   Begin VB.OptionButton optMusic 
      Caption         =   "SMB3 World 4"
      Height          =   375
      Index           =   2
      Left            =   6360
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   120
      Width           =   1455
   End
End
Attribute VB_Name = "frmMusic"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub optMusic_Click(Index As Integer)
    On Error Resume Next
    If Me.Visible = True Then FocusNinja.SetFocus
End Sub
