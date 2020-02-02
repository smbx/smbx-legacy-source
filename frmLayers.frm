VERSION 5.00
Begin VB.Form frmLayers 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Layers"
   ClientHeight    =   3510
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   3375
   Icon            =   "frmLayers.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3510
   ScaleWidth      =   3375
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Height          =   375
      Left            =   1800
      TabIndex        =   3
      Top             =   3000
      Width           =   1335
   End
   Begin VB.CommandButton cmdAdd 
      Caption         =   "Add"
      Height          =   375
      Left            =   240
      TabIndex        =   2
      Top             =   3000
      Width           =   1335
   End
   Begin VB.ListBox lstLayer 
      Height          =   2310
      ItemData        =   "frmLayers.frx":628A
      Left            =   120
      List            =   "frmLayers.frx":6297
      Style           =   1  'Checkbox
      TabIndex        =   1
      Top             =   600
      Width           =   3135
   End
   Begin VB.TextBox txtLayer 
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3135
   End
End
Attribute VB_Name = "frmLayers"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private LayerToggle As Boolean

Private Sub cmdAdd_Click()
    On Error Resume Next
    Dim A As Integer
    Dim B As Integer
    Dim tempBool As Boolean
    Dim newLayer As String
    newLayer = "New Layer"
    B = 1
    Do
        tempBool = False
        For A = 0 To lstLayer.ListCount - 1
            If LCase(newLayer) = LCase(lstLayer.List(A)) Then
                tempBool = True
                Exit For
            End If
        Next A
        If tempBool = True Then
            B = B + 1
            newLayer = "New Layer " & B
        End If
    Loop While tempBool = True
    lstLayer.AddItem newLayer
    lstLayer.Selected(lstLayer.ListCount - 1) = True
    noUpdate = True
    frmEvents.RefreshEvents
    noUpdate = False
    UpdateLayers
    txtLayer.SelStart = 0
    txtLayer.SelLength = Len(txtLayer.Text)
    txtLayer.SetFocus
End Sub

Private Sub cmdDelete_Click()
    Dim LayerName As String
    Dim A As Integer
    Dim B As Integer
    If MsgBox("Are you sure you want to delete this layer?", vbYesNo, "Delete Layer") = 6 Then
        LayerName = LCase(lstLayer.List(lstLayer.ListIndex))
        For A = numNPCs To 1 Step -1
            If LCase(NPC(A).Layer) = LayerName Then KillNPC A, 9
        Next A
        For A = numBlock To 1 Step -1
            If LCase(Block(A).Layer) = LayerName Then KillBlock A, False
        Next A
        For A = numWarps To 1 Step -1
            If LCase(Warp(A).Layer) = LayerName Then KillWarp A
        Next A
        For A = numBackground To 1 Step -1
            If LCase(Background(A).Layer) = LayerName Then
                Background(A) = Background(numBackground)
                numBackground = numBackground - 1
            End If
        Next A
        For A = 0 To 100
            If Events(A).Name = "" Then
                Exit For
            Else
                For B = 0 To 20
                    If LCase(Events(A).HideLayer(B)) = LayerName Then
                        For C = B To 19
                            Events(A).HideLayer(C) = Events(A).HideLayer(C + 1)
                        Next C
                        Events(A).HideLayer(20) = ""
                        Exit Sub
                    End If
                Next B
            End If
        Next A
        lstLayer.RemoveItem lstLayer.ListIndex
        If lstLayer.ListIndex = 0 Then
            cmdDelete.Enabled = False
            txtLayer.Enabled = False
        End If
        If lstLayer.ListIndex >= 0 Then txtLayer.Text = lstLayer.List(lstLayer.ListIndex)
        noUpdate = True
        frmEvents.RefreshEvents
        noUpdate = False
    End If
    UpdateLayers
End Sub

Private Sub Form_Load()
    lstLayer.ListIndex = 0
    lstLayer.Selected(0) = True
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
End Sub

Private Sub lstLayer_Click()
    On Error Resume Next
    If LayerToggle = True Or noUpdate = True Then
        Exit Sub
    End If
    txtLayer.Text = lstLayer.List(lstLayer.ListIndex)
    If lstLayer.List(lstLayer.ListIndex) = "Default" Or lstLayer.List(lstLayer.ListIndex) = "Destroyed Blocks" Or lstLayer.List(lstLayer.ListIndex) = "Spawned NPCs" Then
        txtLayer.Enabled = False
        cmdDelete.Enabled = False
    Else
        txtLayer.Enabled = True
        cmdDelete.Enabled = True
    End If
    If lstLayer.Selected(lstLayer.ListIndex) = True Then
        ShowLayer lstLayer.List(lstLayer.ListIndex)
    Else
        HideLayer lstLayer.List(lstLayer.ListIndex)
    End If
    If lstLayer.List(lstLayer.ListIndex) = "Spawned NPCs" Then
        LayerToggle = True
        lstLayer.Selected(lstLayer.ListIndex) = True
        LayerToggle = False
    End If
    If lstLayer.List(lstLayer.ListIndex) = "Destroyed Blocks" Then
        LayerToggle = True
        lstLayer.Selected(lstLayer.ListIndex) = False
        LayerToggle = False
    End If
    txtLayer.SetFocus
    UpdateLayers
End Sub

Private Sub lstLayer_DblClick()
    If lstLayer.List(lstLayer.ListIndex) = "Spawned NPCs" Then
        LayerToggle = True
        lstLayer.Selected(lstLayer.ListIndex) = True
        LayerToggle = False
    End If
    If lstLayer.List(lstLayer.ListIndex) = "Destroyed Blocks" Then
        LayerToggle = True
        lstLayer.Selected(lstLayer.ListIndex) = False
        LayerToggle = False
    End If
End Sub

Private Sub txtLayer_KeyPress(KeyAscii As Integer)
    Dim A As Integer
    Dim B As Integer
    Dim oldLayer As String
    Dim newLayer As String
    If noUpdate = True Then Exit Sub
    If KeyAscii = vbKeyReturn Then
        Do While Right(txtLayer.Text, 1) = " "
            txtLayer.Text = Left(txtLayer.Text, Len(txtLayer.Text) - 1)
        Loop
        If txtLayer.Text = "" Then
            txtLayer.Text = lstLayer.List(lstLayer.ListIndex)
            Exit Sub
        End If
        For A = 0 To lstLayer.ListCount - 1
            If LCase(txtLayer.Text) = LCase(lstLayer.List(A)) Then
                txtLayer.Text = lstLayer.List(lstLayer.ListIndex)
                Exit For
            End If
        Next A
        newLayer = txtLayer.Text
        oldLayer = lstLayer.List(lstLayer.ListIndex)
        For A = numNPCs To 1 Step -1
            If LCase(NPC(A).Layer) = LCase(oldLayer) Then NPC(A).Layer = newLayer
        Next A
        For A = numBlock To 1 Step -1
            If LCase(Block(A).Layer) = LCase(oldLayer) Then Block(A).Layer = newLayer
        Next A
        For A = numWarps To 1 Step -1
            If LCase(Warp(A).Layer) = LCase(oldLayer) Then Warp(A).Layer = newLayer
        Next A
        For A = numBackground To 1 Step -1
            If LCase(Background(A).Layer) = LCase(oldLayer) Then Background(A).Layer = newLayer
        Next A
        lstLayer.List(lstLayer.ListIndex) = txtLayer.Text
        For A = 0 To 100
            For B = 0 To 20
                If LCase(Events(A).HideLayer(B)) = LCase(oldLayer) Then Events(A).HideLayer(B) = newLayer
                If LCase(Events(A).ShowLayer(B)) = LCase(oldLayer) Then Events(A).ShowLayer(B) = newLayer
            Next B
        Next A
        noUpdate = True
        frmEvents.RefreshEvents
        noUpdate = False
        UpdateLayers
    End If
End Sub

Public Sub UpdateLayers()
    Dim tempStr As String
    Dim lyrStr As String
    Dim A As Integer
    If noUpdate = True Then Exit Sub
    lyrStr = frmAdvanced.AttLayer.Text
    frmAdvanced.AttLayer.Clear
    For A = 0 To 100
        If A <= lstLayer.ListCount - 1 Then
            Layer(A).Name = lstLayer.List(A)
            frmAdvanced.AttLayer.List(A) = lstLayer.List(A)
            If lstLayer.Selected(A) = True Then
                Layer(A).Hidden = False
            Else
                Layer(A).Hidden = True
            End If
        Else
            Layer(A).Name = lstLayer.List(A)
            Layer(A).Hidden = False
        End If
    Next A
    frmAdvanced.AttLayer.Text = lyrStr
    If noUpdate = False And nPlay.Online = True Then
        For A = 0 To 100
            tempStr = tempStr & Netplay.ModLayer(A)
            If Layer(A).Name = "" Then Exit For
        Next A
        Netplay.sendData tempStr
    End If
End Sub

