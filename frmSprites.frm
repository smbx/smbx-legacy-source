VERSION 5.00
Begin VB.Form frmSprites 
   Caption         =   "Sprites"
   ClientHeight    =   13185
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   18525
   LinkTopic       =   "Form1"
   ScaleHeight     =   13185
   ScaleWidth      =   18525
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox pic 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   12975
      Left            =   120
      ScaleHeight     =   12975
      ScaleWidth      =   18255
      TabIndex        =   0
      Top             =   120
      Width           =   18255
   End
End
Attribute VB_Name = "frmSprites"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Resize()
    pic.Top = 0
    pic.Left = 0
    pic.Width = Me.Width
    pic.Height = Me.Height
End Sub
