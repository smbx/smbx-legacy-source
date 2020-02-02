VERSION 5.00
Begin VB.Form frmOpen 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Super Mario Bros. X - Open Level"
   ClientHeight    =   4155
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6960
   Icon            =   "frmOpen.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4155
   ScaleWidth      =   6960
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   495
      Left            =   5040
      TabIndex        =   2
      Top             =   3600
      Width           =   1815
   End
   Begin VB.CommandButton cmdOpen 
      Caption         =   "Open"
      Height          =   495
      Left            =   3120
      TabIndex        =   1
      Top             =   3600
      Width           =   1815
   End
   Begin VB.DriveListBox Drive1 
      Height          =   315
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   2895
   End
   Begin VB.DirListBox Dir1 
      Height          =   3465
      Left            =   120
      TabIndex        =   4
      Top             =   480
      Width           =   2895
   End
   Begin VB.FileListBox File1 
      Height          =   3405
      Left            =   3120
      Pattern         =   "*.lvl"
      TabIndex        =   0
      Top             =   120
      Width           =   3735
   End
End
Attribute VB_Name = "frmOpen"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdOpen_Click()
    OpenIt
End Sub

Private Sub Dir1_Change()
    File1.Path = Dir1.Path
End Sub

Private Sub Drive1_Change()
    Dir1.Path = Drive1.Drive
End Sub

Private Sub File1_DblClick()
    OpenIt
End Sub

Private Sub File1_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then OpenIt
End Sub

Private Sub Form_Load()
    On Error GoTo Handler
    If WorldEditor = True Then
        File1.Pattern = "*.wld"
    End If
    Dir1.Path = Dir1.Path & "\worlds"
    If FileNamePath <> "" Then Dir1.Path = FileNamePath
    Exit Sub
Handler:
    Dir1.Path = Dir1.Path
    If FileNamePath <> "" Then Dir1.Path = FileNamePath
    Exit Sub
End Sub

Private Sub Form_Unload(Cancel As Integer)
    frmLevelEditor.Enabled = True
End Sub

Private Sub OpenIt()
    If File1.ListIndex > 0 Then
        If WorldEditor = True Then
            frmLevelEditor.optCursor(14).Value = True
            OpenWorld File1.Path & "\" & File1.List(File1.ListIndex)
        Else
            frmLevelEditor.optCursor(13).Value = True
            ClearLevel
            OpenLevel File1.Path & "\" & File1.List(File1.ListIndex)
        End If
        Unload Me
    ElseIf File1.ListCount > 0 Then
        If WorldEditor = True Then
            frmLevelEditor.optCursor(6).Value = True
            OpenWorld File1.Path & "\" & File1.List(0)
        Else
            frmLevelEditor.optCursor(0).Value = True
            ClearLevel
            OpenLevel File1.Path & "\" & File1.List(0)
        End If
        Unload Me
    Else
        MsgBox "No level file was found in that directory.", vbOKOnly, "Sorry.", 0, 0
    End If
End Sub
