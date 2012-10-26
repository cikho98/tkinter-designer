VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsScale"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'��ֵѡ�����࣬�������úͱ�����Ӧ�����Ժ�ֵ�������ɶ�ӦPYTHON��TKinter����

Private m_dicTotal As Dictionary                                                '����ȫ�������ԣ�����Ĭ��ֵ
Private m_Base As clsBaseControl                                                '�����ؼ���

'���PYTHON����,
'sCmdFunc: ����������¼������ص�����;
'rel:�Ƿ�ʹ���������,
'oop:�Ƿ�ʹ�����������
'usettk:�Ƿ�ʹ��TTK������չ
Public Function toString(ByRef sCmdFunc As cStrBuilder, rel As Boolean, oop As Boolean, usettk As Boolean) As String
    
    Dim s As String
    If usettk And Len(m_Base("label")) Then
        s = m_Base("label")
        m_Base("label") = ""
    End If
    
    toString = m_Base.toString(sCmdFunc, rel, oop, usettk)
    
    If usettk And Len(s) Then
        m_Base("label") = s
    End If
    
End Function

'���������Ҫ���ϵ������������ʼ��������
Public Sub InitConfig(o As Object, parentWidth As Long, parentHeight As Long)
    
    Dim nIdx As Variant
    
    m_Base.Name = o.Properties("Name")
    m_Base.StyleName = IIf(o.Properties("Orientation"), "Vertical", "Horizontal") & ".TScale"
    
    m_dicTotal("x") = m_Base.toPixelX(o.Properties("Left"))
    m_dicTotal("y") = m_Base.toPixelY(o.Properties("Top"))
    m_dicTotal("width") = m_Base.toPixelX(o.Properties("Width"))
    m_dicTotal("height") = m_Base.toPixelY(o.Properties("Height"))
    m_dicTotal("relx") = Format(o.Properties("Left") / parentWidth, "0.###")
    m_dicTotal("rely") = Format(o.Properties("Top") / parentHeight, "0.###")
    m_dicTotal("relwidth") = Format(o.Properties("Width") / parentWidth, "0.###")
    m_dicTotal("relheight") = Format(o.Properties("Height") / parentHeight, "0.###")
    m_dicTotal("label") = ""
    m_dicTotal("fg") = ""
    m_dicTotal("bg") = ""
    m_dicTotal("bd") = ""
    m_dicTotal("from_") = o.Properties("Min")
    m_dicTotal("to") = o.Properties("Max")
    m_dicTotal("resolution") = o.Properties("SmallChange")
    m_dicTotal("relief") = "FLAT"
    m_dicTotal("digits") = 0
    m_dicTotal("orient") = IIf(o.Properties("Orientation"), "'vertical'", "'horizontal'")
    m_dicTotal("showvalue") = 1
    m_dicTotal("variable") = ""
    m_dicTotal("sliderlength") = 30
    m_dicTotal("sliderrelief") = "RAISED"
    m_dicTotal("tickinterval") = 0
    m_dicTotal("font") = ""
    m_dicTotal("takefocus") = IIf(o.Properties("TabStop"), 1, 0)
    m_dicTotal("command") = o.Properties("Name") & "_Cmd"
    m_dicTotal("bindcommand") = ""
    
    '��Щ��Ĭ��ѡ���
    m_Base("x") = m_dicTotal("x")
    m_Base("y") = m_dicTotal("y")
    m_Base("width") = m_dicTotal("width")
    m_Base("height") = m_dicTotal("height")
    m_Base("relx") = m_dicTotal("relx")
    m_Base("rely") = m_dicTotal("rely")
    m_Base("relwidth") = m_dicTotal("relwidth")
    m_Base("relheight") = m_dicTotal("relheight")
    m_Base("label") = m_dicTotal("label")
    'm_Base("command") = m_dicTotal("command")
    m_Base("orient") = m_dicTotal("orient")
    m_Base("from_") = m_dicTotal("from_")
    m_Base("to") = m_dicTotal("to")
    m_Base("resolution") = m_dicTotal("resolution")
    If m_dicTotal("takefocus") = 0 Then m_Base("takefocus") = m_dicTotal("takefocus")
    
End Sub

'��������ֵ�Ŀ���ֵ�б�
'����ֵ��0-û�п�ѡֵ��1-��һ���ϸ����ƵĿ�ѡֵ�б���2-���ṩ�Ŀ�ѡֵ�б��⣬�������ֶ���������ֵ
'�����sa()��ѡֵ�б�����
Public Function GetAttrValueList(sAttr As String, ByRef sa() As String) As Long
    GetAttrValueList = 1
    If sAttr = "showvalue" Then
        sa = Split("1,0", ",")
    ElseIf sAttr = "digits" Then
        sa = Split("0,1,2,3,4", ",")
    ElseIf sAttr = "sliderrelief" Then
        sa = Split("FLAT,GROOVE,RAISED,RIDGE,SOLID,SUNKEN", ",")
    Else
        GetAttrValueList = m_Base.GetAttrValueList(sAttr, sa)
    End If
End Function

Public Function Tips(sAttr As String) As String
    Tips = sAttr & vbCrLf
    Select Case sAttr:
    Case "from_":
        Tips = Tips & L("l_TipFrom", "������Сֵ��")
    Case "to":
        Tips = Tips & L("l_TipTo", "�������ֵ��")
    Case "resolution":
        Tips = Tips & L("l_TipResolution", "���ò���ֵ��")
    Case "showvalue":
        Tips = Tips & L("l_TipShowValue", "�Ƿ񽫵�ǰֵ��������ʽ��ʾ���Ϸ���Ĭ��Ϊ1��")
    Case "digits":
        Tips = Tips & L("l_TipDigits", "���Ƹ���������ʾλ����")
    Case "sliderlength":
        Tips = Tips & L("l_TipSliderLen", "����ָʾ��ĳ��ȣ�Ĭ��Ϊ30���ء�")
    Case "sliderrelief":
        Tips = Tips & L("l_TipSliderRelief", "����ָʾ������Ч������ѡֵ�У�FLAT, GROOVE, RAISED, RIDGE, SOLID, SUNKEN��")
    Case "tickinterval":
        Tips = Tips & L("l_TipTickInterval", "���������Ƿ���ʾ���ڶ�λ�㣬Ĭ�ϲ���ʾ�����Ҫ��ʾ�����ֵ����Ϊ���ٲ���һ���㣬����ΪС����")
    Case Else:
        Tips = m_Base.Tips(sAttr)
    End Select
End Function

Private Sub Class_Initialize()
    
    Set m_dicTotal = New Dictionary
    Set m_Base = New clsBaseControl
    m_Base.ctlType = "Scale"
    m_Base.StyleName = "TScale"
    
End Sub

'����һ�����ϣ�ÿ����Ŀ��Ԫ��"������|ֵ|�Ƿ�Ĭ��ѡ��"
'�����������������������Բ����б���
Public Function Allitems() As Collection
    Dim re As Collection, k As Variant, ks As Collection
    
    Set re = New Collection
    
    '��׼����
    Set ks = m_dicTotal.Keys
    For Each k In ks
        If Len(m_Base(k)) Then
            re.Add k & "|" & m_Base(k) & "|1"
        Else
            re.Add k & "|" & m_dicTotal(k) & "|0"
        End If
    Next
    
    '�û����ӵ��Զ������������еĻ���
    Set ks = m_Base.Keys
    For Each k In ks
        If Not m_dicTotal.Exists(k) Then
            re.Add k & "|" & m_Base(k) & "|1"
        End If
    Next
    
    Set Allitems = re
    
End Function

'���û�ѡ������ø��µ������У�����Ϊʹ��"|"�ָ�ĺܶ������/ֵ��
Public Sub SetConfig(sAttrs As String)
    m_Base.SetConfig sAttrs
End Sub

'�޸Ļ����ӵ������������/ֵ��"|"�ָ�
Public Sub SetSingleConfig(sAttr As String)
    m_Base.SetSingleConfig sAttr
End Sub

Private Sub Class_Terminate()
    Set m_dicTotal = Nothing
    Set m_Base = Nothing
End Sub


Public Property Let Parent(s As String)
    m_Base.Parent = s
End Property

Public Property Get Parent() As String
    Parent = m_Base.Parent
End Property

Public Property Get Name() As String
    Name = m_Base.Name
End Property

'�������л�����
Public Function Serializer(vSer As clsSerialization)
    vSer.Serializer m_Base
End Function

Public Function Deserializer(vSer As clsSerialization)
    vSer.Deserializer m_Base
End Function

Public Property Get Description() As String
    Description = L("l_DescScale", "���������󣬶�Ӧ��Tkinter��Scale�ؼ���")
End Property

Public Property Let ScaleMode(nV As Long)
    m_Base.ScaleMode = nV
End Property

