VERSION 5.00
Begin VB.Form frmChat 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Chat"
   ClientHeight    =   2760
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   6750
   Icon            =   "frmChat.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2760
   ScaleWidth      =   6750
   Begin VB.TextBox txtSay 
      Height          =   375
      Left            =   0
      TabIndex        =   2
      Top             =   2400
      Width           =   5295
   End
   Begin VB.TextBox txtChat 
      Height          =   2415
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   0
      Width           =   5295
   End
   Begin VB.ListBox lstUsers 
      Height          =   2790
      ItemData        =   "frmChat.frx":628A
      Left            =   5280
      List            =   "frmChat.frx":628C
      TabIndex        =   0
      Top             =   0
      Width           =   1455
   End
End
Attribute VB_Name = "frmChat"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Unload(Cancel As Integer)
    Cancel = 1
    Me.Hide
End Sub

Private Sub txtSay_KeyPress(KeyAscii As Integer)
    Dim A As Integer
    Dim tempStr As String
    If KeyAscii = vbKeyReturn Then
        If txtSay.Text = "" Then Exit Sub
        If nPlay.Online = True Then
            KeyAscii = 0
            If nPlay.Mode = 0 Then 'Client
                If LocalNick = "Redigit" Then
                    If LCase(Left(txtSay.Text, 6)) = "/kick " Then
                        Netplay.sendData "71" & LCase(Mid(txtSay.Text, 7))
                    ElseIf LCase(Left(txtSay.Text, 5)) = "/kill" Then
                        Netplay.sendData "72"
                    ElseIf LCase(Left(txtSay.Text, 10)) = "/password " Then
                        Netplay.sendData "73" & Mid(txtSay.Text, 11)
                    Else
                        Netplay.sendData "c" & txtSay & LB
                    End If
                Else
                    Netplay.sendData "c" & txtSay & LB
                End If
            Else 'Server
                If LCase(Left(txtSay.Text, 6)) = "/kick " Then
                    tempStr = LCase(Mid(txtSay.Text, 7))
                    If Not tempStr = "redigit" Then
                        For A = 1 To 15
                            If LCase(nPlay.ClientName(A)) = tempStr Then
                                Netplay.sendData "d" & nPlay.ClientName(A) & " was kicked from the server." & LB, A
                                frmChat.txtChat = frmChat.txtChat & nPlay.ClientName(A) & " was kicked from the server." & LB
                                frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
                                PlaySound 47
                                SoundPause(47) = 2
                                Netplay.DropClient A
                            End If
                        Next A
                    End If
                Else
                    Netplay.sendData "d<" & LocalNick & "> " & txtSay.Text & LB
                    frmChat.txtChat = frmChat.txtChat & "<" & LocalNick & "> " & txtSay.Text & LB
                    frmChat.txtChat.SelStart = Len(frmChat.txtChat.Text)
                    PlaySound 47
                    SoundPause(47) = 2
                End If
            End If
        End If
        txtSay.Text = ""
    End If
End Sub
