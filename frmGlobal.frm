VERSION 5.00
Begin VB.Form frmGlobal 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Global Variables"
   ClientHeight    =   6315
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4230
   Icon            =   "frmGlobal.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6315
   ScaleWidth      =   4230
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame2 
      Caption         =   "Switch Blocks"
      Height          =   1455
      Left            =   2760
      TabIndex        =   5
      Top             =   120
      Width           =   1335
      Begin VB.CheckBox SwitchBlock 
         Caption         =   "Red"
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   9
         Top             =   1080
         Width           =   975
      End
      Begin VB.CheckBox SwitchBlock 
         Caption         =   "Green"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   8
         Top             =   840
         Width           =   975
      End
      Begin VB.CheckBox SwitchBlock 
         Caption         =   "Blue"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   7
         Top             =   600
         Width           =   975
      End
      Begin VB.CheckBox SwitchBlock 
         Caption         =   "Yellow"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   6
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Saved Events"
      Height          =   4095
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2535
      Begin VB.CommandButton cmdRemove 
         Caption         =   "Remove"
         Height          =   375
         Left            =   1320
         TabIndex        =   4
         Top             =   3600
         Width           =   1095
      End
      Begin VB.CommandButton cmdAdd 
         Caption         =   "Add"
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   3600
         Width           =   1095
      End
      Begin VB.TextBox txtSavedEvent 
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Top             =   3120
         Width           =   2295
      End
      Begin VB.ListBox lstSavedEvent 
         Height          =   2790
         ItemData        =   "frmGlobal.frx":628A
         Left            =   120
         List            =   "frmGlobal.frx":628C
         TabIndex        =   1
         Top             =   240
         Width           =   2295
      End
   End
End
Attribute VB_Name = "frmGlobal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAdd_Click()
    Dim dontAdd As Boolean
    Dim A As Integer
    If txtSavedEvent.Text <> "" Then
        For A = 1 To numSavedEvents
            If LCase(txtSavedEvent.Text) = LCase(SavedEvents(A)) Then
                dontAdd = True
                Exit For
            End If
        Next A
        If dontAdd = False Then
            numSavedEvents = numSavedEvents + 1
            SavedEvents (numSavedEvents)
            RefreshSavedEvents
        End If
        txtSavedEvent.Text = ""
    End If
End Sub

Private Sub cmdRemove_Click()
    Dim A As Integer
    A = lstSavedEvent.ListCount
    If A >= 0 Then
        SavedEvents(A) = SavedEvents(numSavedEvents)
        SavedEvents(numSavedEvents) = ""
        numSavedEvents = numSavedEvents - 1
        RefreshSavedEvents
    End If
End Sub

Private Sub Form_Load()
    RefreshSavedEvents
End Sub

Public Sub RefreshSavedEvents()
    Dim A As Integer
    lstSavedEvent.Clear
    For A = 1 To numSavedEvents
        lstSavedEvent.List(A) = SavedEvents(A)
    Next A
End Sub

Private Sub SwitchBlock_Click(Index As Integer)
    If SwitchBlock(Index).Value = 0 Then
        BlockSwitch(Index) = False
    Else
        BlockSwitch(Index) = True
    End If
End Sub

Public Sub RefreshSwitchBlocks()
    Dim A As Integer
    For A = 1 To 4
        If BlockSwitch(A) = True Then
            SwitchBlock(A).Value = 1
        Else
            SwitchBlock(A).Value = 0
        End If
    Next A
End Sub
