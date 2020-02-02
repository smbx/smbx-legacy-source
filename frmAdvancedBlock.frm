VERSION 5.00
Begin VB.Form frmAdvancedBlock 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Block Event Settings"
   ClientHeight    =   3030
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4335
   Icon            =   "frmAdvancedBlock.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3030
   ScaleWidth      =   4335
   Begin VB.Frame Frame1 
      Caption         =   "Event Triggers"
      Height          =   2775
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4095
      Begin VB.Frame Frame2 
         Caption         =   "Death"
         Height          =   735
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   3855
         Begin VB.ComboBox TriggerDeath 
            Height          =   315
            Left            =   120
            TabIndex        =   6
            Text            =   "TriggerDeath"
            Top             =   240
            Width           =   3615
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Hit"
         Height          =   735
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Top             =   1080
         Width           =   3855
         Begin VB.ComboBox TriggerHit 
            Height          =   315
            Left            =   120
            TabIndex        =   4
            Text            =   "TriggerHit"
            Top             =   240
            Width           =   3615
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "No More Objects in Layer"
         Height          =   735
         Index           =   2
         Left            =   120
         TabIndex        =   1
         Top             =   1920
         Width           =   3855
         Begin VB.ComboBox TriggerLast 
            Height          =   315
            Left            =   120
            TabIndex        =   2
            Text            =   "TriggerLast"
            Top             =   240
            Width           =   3615
         End
      End
   End
End
Attribute VB_Name = "frmAdvancedBlock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
End Sub
