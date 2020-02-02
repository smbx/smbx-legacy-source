VERSION 5.00
Begin VB.Form frmSave 
   Caption         =   "Super Mario Bros. X - Save Level"
   ClientHeight    =   4275
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6975
   Icon            =   "frmSave.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4275
   ScaleWidth      =   6975
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtFileName 
      Height          =   375
      Left            =   3120
      TabIndex        =   0
      Top             =   3240
      Width           =   3735
   End
   Begin VB.FileListBox File1 
      Height          =   3015
      Left            =   3120
      Pattern         =   "*.lvl"
      TabIndex        =   3
      Top             =   120
      Width           =   3735
   End
   Begin VB.DirListBox Dir1 
      Height          =   3690
      Left            =   120
      TabIndex        =   5
      Top             =   480
      Width           =   2895
   End
   Begin VB.DriveListBox Drive1 
      Height          =   315
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   2895
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save"
      Height          =   495
      Left            =   3120
      TabIndex        =   1
      Top             =   3720
      Width           =   1815
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   495
      Left            =   5040
      TabIndex        =   2
      Top             =   3720
      Width           =   1815
   End
End
Attribute VB_Name = "frmSave"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdSave_Click()
    SaveIt
End Sub

Private Sub Dir1_Change()
    File1.Path = Dir1.Path
End Sub

Private Sub Drive1_Change()
    On Error Resume Next
    Dir1.Path = Drive1.Drive
End Sub

Private Sub File1_Click()
    If File1.ListIndex >= 0 Then
        txtFilename.Text = File1.List(File1.ListIndex)
    Else
    End If
End Sub

Private Sub Form_Load()
    On Error Resume Next
    If WorldEditor = True Then
        File1.Pattern = "*.wld"
    End If
    If FileName <> "" Then txtFilename.Text = FileName
    Dir1.Path = Dir1.Path & "\worlds"
    If FileNamePath <> "" Then Dir1.Path = FileNamePath
End Sub

Private Sub Form_Unload(Cancel As Integer)
    frmLevelEditor.Enabled = True
End Sub

Private Sub txtFileName_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then SaveIt
End Sub

Private Sub SaveIt()
    Dim tempName As String
    Dim A As Integer
    Dim tempChr As String
    Dim badChr As Boolean
    If txtFilename.Text = "" Then
        MsgBox "File name cannot be blank.", vbOKOnly, "Sorry.", 0, 0
    ElseIf Left(txtFilename.Text, 1) = " " Then
        MsgBox "No spaces in the front of the file name.", vbOKOnly, "Sorry.", 0, 0
    Else
        badChr = False
        For A = 1 To Len(txtFilename.Text)
            tempChr = Mid(txtFilename.Text, A, 1)
            If tempChr = "?" Or tempChr = "[" Or tempChr = "]" Or tempChr = "/" Or tempChr = "\" Or tempChr = "=" Or tempChr = "+" Or tempChr = "<" Or tempChr = ">" Or tempChr = ":" Or tempChr = ";" Or tempChr = "," Or tempChr = "*" Or tempChr = Chr(34) Then
                badChr = True
                Exit For
            End If
        Next A
        If badChr = True Then
            MsgBox "Illegal characters in file name.", vbOKOnly, "Sorry.", 0, 0
        Else
            If WorldEditor = True Then
                If Right(txtFilename.Text, 4) = ".wld" Then
                    tempName = txtFilename.Text
                Else
                    tempName = txtFilename.Text & ".wld"
                End If
                SaveWorld File1.Path & "\" & tempName
            Else
                If Right(txtFilename.Text, 4) = ".lvl" Then
                    tempName = txtFilename.Text
                Else
                    tempName = txtFilename.Text & ".lvl"
                End If
                SaveLevel File1.Path & "\" & tempName
            End If
            Unload Me
        End If
    End If
End Sub
