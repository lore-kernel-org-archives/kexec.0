Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L3TQb-0004MW-Qg
	for kexec@lists.infradead.org; Fri, 21 Nov 2008 10:39:58 +0000
Received: from natsuko.kent.sydney.vergenet.net
	(210-227-008-083.jp.fiberbit.net [210.227.8.83])
	by koto.vergenet.net (Postfix) with ESMTP id D2D8834067
	for <kexec@lists.infradead.org>; Fri, 21 Nov 2008 19:39:53 +0900 (JST)
Resent-Message-ID: <20081121103953.GA6686@verge.net.au>
Resent-To: kexec@lists.infradead.org
Received: from imx9.toshiba.co.jp ([202.33.96.51])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L3K69-0000kQ-Tv
	for kexec@lists.infradead.org; Fri, 21 Nov 2008 00:42:14 +0000
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id mAL0Rq70014698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <kexec@lists.infradead.org>; Fri, 21 Nov 2008 09:27:53 +0900 (JST)
Received: from arc11.toshiba.co.jp ([133.199.90.127])
	by imx12.toshiba.co.jp  with ESMTP id mAL0RYee019372
	for <kexec@lists.infradead.org>; Fri, 21 Nov 2008 09:27:34 +0900 (JST)
Received: (from root@localhost) by arc11.toshiba.co.jp  id mAL0RY7Z025116
	for kexec@lists.infradead.org; Fri, 21 Nov 2008 09:27:34 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id mAL0RYYJ023162
	for <kexec@lists.infradead.org>; Fri, 21 Nov 2008 09:27:34 +0900 (JST)
From: "gib" <suchada.pitchayasamanya@toshiba.co.jp>
Subject: Question about Kexec based hibernation in linux-2.6.27
Date: Fri, 21 Nov 2008 09:27:26 +0900
Message-Id: <200811210027.mAL0RXaJ018563@toshiba.co.jp>
MIME-Version: 1.0
Content-Language: ja
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0263740048=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

1jM MIME `.L}`p[g bZ[WE7B

--===============0263740048==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0004_01C94BBB.5E1A4FC0"
Content-Language: ja

1jM MIME `.L}`p[g bZ[WE7B

------=_NextPart_000_0004_01C94BBB.5E1A4FC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello all,

 

I have tried the Kexec based hibernation feature in linux-2.6.27 kernel,
everything work fine, I could resume the 1st kernel. 

But after I shutdown or restarted the system and before booting up the new
kernel the system required file system checking manually and took very long
time for that.

The following is the error message I got while booting up the new kernel.

 

Checking filesystems

/1 contains a file system with errors, check forced.

/1:   | ===================

Inode 11282887 has a bad extended attribute block 11306367.

/1: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.

           (i.e., without   -a or -p  options)

                        [FAILDED]

*** An error occured during the file sysem check.

*** Dropping you to a shell;  the system will reboot

*** when you leave the shell.

*** Warning  -- SELinux is active

*** Disabling security enforcement for system recovery.

*** Run 'setenforce 1' to reenable.

Give root password for maintenance

(of type Control-D to continue):

 

Does anybody know about this issue? It would be very helpful for me.

 

Thanks in advance.

Suchada Pitchayasamanya


------=_NextPart_000_0004_01C94BBB.5E1A4FC0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Gothic";
	panose-1:2 11 6 9 7 2 5 8 2 4;}
@font-face
	{font-family:"Cordia New";
	panose-1:2 11 3 4 2 2 2 2 2 4;}
@font-face
	{font-family:"Cordia New";
	panose-1:2 11 3 4 2 2 2 2 2 4;}
@font-face
	{font-family:"MS Gothic";
	panose-1:2 11 6 9 7 2 5 8 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0mm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.0pt;
	font-family:"Arial","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML \66F8\5F0F\4ED8\304D \(\6587\5B57\)";
	margin:0mm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"MS Gothic";}
span.HTML
	{mso-style-name:"HTML \66F8\5F0F\4ED8\304D \(\6587\5B57\)";
	mso-style-priority:99;
	mso-style-link:"HTML \66F8\5F0F\4ED8\304D";
	font-family:"MS Gothic";}
span.19
	{mso-style-type:personal;
	font-family:"Arial","sans-serif";
	color:windowtext;}
span.20
	{mso-style-type:personal-reply;
	font-family:"Arial","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:99.25pt 30.0mm 30.0mm 30.0mm;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026">
  <v:textbox inset=3D"5.85pt,.7pt,5.85pt,.7pt" />
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DJA link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>Hello all,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>I have
tried the Kexec based hibernation feature in linux-2.6.27 kernel, =
everything
work fine, I could resume the 1<sup>st</sup> kernel. =
<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>But after I
shutdown or restarted the system and before booting up the new kernel =
the
system required file system checking manually and took very long time =
for that.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>The
following is the error message I got while booting up the new =
kernel.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>Checking
filesystems<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>/1 contains
a file system with errors, check forced.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>/1:&nbsp;&nbsp;
| =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></spa=
n></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>Inode
11282887 has a bad extended attribute block =
11306367.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>/1:
UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
(i.e., without&nbsp;&nbsp; -a or -p&nbsp; options)<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; [FAILDED]<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>*** An
error occured during the file sysem check.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>***
Dropping you to a shell;&nbsp; the system will =
reboot<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>*** when
you leave the shell.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>***
Warning&nbsp; -- SELinux is active<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>***
Disabling security enforcement for system =
recovery.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>*** Run
'setenforce 1' to reenable.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>Give root
password for maintenance<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>(of type
Control-D to continue):<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>Does
anybody know about this issue? It would be very helpful for =
me.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>Thanks in
advance.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>Suchada
Pitchayasamanya<o:p></o:p></span></p>

</div>

</body>

</html>

------=_NextPart_000_0004_01C94BBB.5E1A4FC0--




--===============0263740048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0263740048==--



