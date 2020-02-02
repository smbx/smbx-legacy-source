VERSION 5.00
Begin VB.Form frmSplash 
   BackColor       =   &H80000007&
   BorderStyle     =   0  'None
   Caption         =   "Super Mario Bros. X"
   ClientHeight    =   4215
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6840
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmSplash.frx":0000
   ScaleHeight     =   281
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   456
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox LoadCoin 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   480
      Left            =   6240
      Picture         =   "frmSplash.frx":2A7A
      ScaleHeight     =   32
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   28
      TabIndex        =   0
      Top             =   3600
      Visible         =   0   'False
      Width           =   420
   End
   Begin VB.Image Image1 
      Height          =   240
      Left            =   4320
      Picture         =   "frmSplash.frx":2E8E
      Top             =   3840
      Width           =   1770
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    Me.Refresh
    Me.Show
    DoEvents
    BitBlt GFX.BgHolder.hdc, 0, 0, LoadCoin.Width, LoadCoin.Height, Me.hdc, LoadCoin.Left, LoadCoin.Top, vbSrcCopy
    GFX.BgHolder.Refresh
    BitBlt LoadCoin.hdc, 0, 0, LoadCoin.Width, LoadCoin.Height, GFX.BgHolder.hdc, 0, 0, vbSrcCopy
    BitBlt frmSplash.LoadCoin.hdc, 0, 0, GFX.LoadCoin.ScaleWidth, 32, GFX.LoadCoinMask.hdc, 0, 32 * LoadCoins, vbSrcAnd
    BitBlt frmSplash.LoadCoin.hdc, 0, 0, GFX.LoadCoin.ScaleWidth, 32, GFX.LoadCoin.hdc, 0, 32 * LoadCoins, vbSrcPaint
    frmSplash.LoadCoin.Refresh
    LoadCoin.Visible = True
    LoadCoin.Refresh
End Sub
