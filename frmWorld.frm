VERSION 5.00
Begin VB.Form frmWorld 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "World Options"
   ClientHeight    =   3225
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6225
   Icon            =   "frmWorld.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   3225
   ScaleWidth      =   6225
   Begin VB.Frame Frame3 
      Caption         =   "Block Characters"
      Height          =   855
      Left            =   1800
      TabIndex        =   15
      Top             =   2280
      Width           =   2655
      Begin VB.CheckBox chkChar 
         Caption         =   "Link"
         Height          =   255
         Index           =   5
         Left            =   1920
         TabIndex        =   20
         Top             =   240
         Width           =   615
      End
      Begin VB.CheckBox chkChar 
         Caption         =   "Toad"
         Height          =   255
         Index           =   4
         Left            =   1080
         TabIndex        =   19
         Top             =   480
         Width           =   735
      End
      Begin VB.CheckBox chkChar 
         Caption         =   "Peach"
         Height          =   255
         Index           =   3
         Left            =   1080
         TabIndex        =   18
         Top             =   240
         Width           =   855
      End
      Begin VB.CheckBox chkChar 
         Caption         =   "Luigi"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   17
         Top             =   480
         Width           =   735
      End
      Begin VB.CheckBox chkChar 
         Caption         =   "Mario"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   16
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Number of Stars"
      Height          =   615
      Left            =   120
      TabIndex        =   13
      Top             =   2280
      Width           =   1575
      Begin VB.TextBox txtStars 
         Height          =   285
         Left            =   120
         TabIndex        =   14
         Top             =   240
         Width           =   1335
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Credits"
      Height          =   2055
      Left            =   3480
      TabIndex        =   7
      Top             =   120
      Width           =   2655
      Begin VB.TextBox txtCredits 
         Height          =   285
         Index           =   5
         Left            =   120
         TabIndex        =   12
         Top             =   1680
         Width           =   2415
      End
      Begin VB.TextBox txtCredits 
         Height          =   285
         Index           =   4
         Left            =   120
         TabIndex        =   11
         Top             =   1320
         Width           =   2415
      End
      Begin VB.TextBox txtCredits 
         Height          =   285
         Index           =   3
         Left            =   120
         TabIndex        =   10
         Top             =   960
         Width           =   2415
      End
      Begin VB.TextBox txtCredits 
         Height          =   285
         Index           =   2
         Left            =   120
         TabIndex        =   9
         Top             =   600
         Width           =   2415
      End
      Begin VB.TextBox txtCredits 
         Height          =   285
         Index           =   1
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   2415
      End
   End
   Begin VB.PictureBox FocusNinja 
      Height          =   375
      Left            =   3240
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   6
      Top             =   4080
      Width           =   375
   End
   Begin VB.Frame Frame 
      Caption         =   "Auto Start Level"
      Height          =   1335
      Index           =   1
      Left            =   120
      TabIndex        =   2
      Top             =   840
      Width           =   3255
      Begin VB.CheckBox chkRestartLevel 
         Caption         =   "Restart Last Level on Death"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   960
         Width           =   2295
      End
      Begin VB.CheckBox chkNoMap 
         Caption         =   "No World Map"
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   600
         Width           =   1455
      End
      Begin VB.TextBox txtStartLevel 
         Height          =   285
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   3015
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "World Name"
      Height          =   615
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3255
      Begin VB.TextBox txtWorldName 
         Height          =   285
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   3015
      End
   End
End
Attribute VB_Name = "frmWorld"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub chkChar_Click(Index As Integer)
    Dim A As Integer
    Dim B As Integer
    If chkChar(Index).Value = 1 Then
        blockCharacter(Index) = True
    Else
        blockCharacter(Index) = False
    End If
    For A = 1 To numCharacters
        If blockCharacter(A) = False Then B = B + 1
    Next A
    If B <= 0 Then
        blockCharacter(Index) = False
        chkChar(Index).Value = 0
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
End Sub

Private Sub txtStars_Change()
    txtStars.Text = Int(Val(txtStars.Text))
    MaxWorldStars = Int(Val(txtStars.Text))
End Sub
