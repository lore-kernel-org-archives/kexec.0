Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from imx9.toshiba.co.jp ([202.33.96.51])
	by pentafluge.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JnoZM-0003RZ-Ki
	for kexec@lists.infradead.org; Mon, 21 Apr 2008 05:28:03 +0000
Received: from imx2.toshiba.co.jp (imx2 [202.33.96.24])
	by imx9.toshiba.co.jp  with ESMTP id m3L5KFwZ007557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <kexec@lists.infradead.org>; Mon, 21 Apr 2008 14:20:15 +0900 (JST)
Received: from arc1.toshiba.co.jp ([133.199.194.235])
	by imx2.toshiba.co.jp  with ESMTP id m3L5Hrso008039
	for <kexec@lists.infradead.org>; Mon, 21 Apr 2008 14:17:53 +0900 (JST)
Received: (from root@localhost) by arc1.toshiba.co.jp  id m3L5HrgN009847
	for kexec@lists.infradead.org; Mon, 21 Apr 2008 14:17:53 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp2.toshiba.co.jp  with ESMTP id m3L5HqDV018919
	for <kexec@lists.infradead.org>; Mon, 21 Apr 2008 14:17:52 +0900 (JST)
From: "gib" <suchada.pitchayasamanya@toshiba.co.jp>
Subject: Question about forcing kernel panic on PowerMac G5 by kexec command
Date: Mon, 21 Apr 2008 14:17:54 +0900
Message-Id: <200804210517.m3L5Hq61011769@toshiba.co.jp>
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
Content-Type: multipart/mixed; boundary="===============0311674094=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

1jM MIME `.L}`p[g bZ[WE7B

--===============0311674094==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000A_01C8A3BA.7D74A4A0"
Content-Language: ja

1jM MIME `.L}`p[g bZ[WE7B

------=_NextPart_000_000A_01C8A3BA.7D74A4A0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello all,

 

I'm working on PowerMac G5 complied with CONFIG_KEXEC = y.

It's work fine with Kexec command option l ( kexec -l /boot/vmlinux. ) but
after the capture kernel pre-loading ( by kexec -p /boot/vmlinux. ), 

when I forced kernel panic by "echo c > /proc/sysrq-trigger" the console
kept showing "Sending IPI to other CPU" and did not go to the next step.

 

According to this list there was some problem about kdump in ppc970 based
CPU which PowerMac's CPU are.

Does anybody know about this issue? It would be very helpful for me.

 

Thanks in advance.

Suchada


------=_NextPart_000_000A_01C8A3BA.7D74A4A0
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
span.17
	{mso-style-type:personal-compose;
	font-family:"Arial","sans-serif";
	color:windowtext;}
span.HTML
	{mso-style-name:"HTML \66F8\5F0F\4ED8\304D \(\6587\5B57\)";
	mso-style-priority:99;
	mso-style-link:"HTML \66F8\5F0F\4ED8\304D";
	font-family:"MS Gothic";}
.MsoChpDefault
	{mso-style-type:export-only;}
 /* Page Definitions */
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
Gothic"'>I&#8217;m
working on PowerMac G5 complied with CONFIG_KEXEC =3D =
y.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>It&#8217;s
work fine with Kexec command option l ( kexec &#8211;l =
/boot/vmlinux&#8230; )
but after the capture kernel pre-loading ( by kexec &#8211;p =
/boot/vmlinux&#8230;
), <o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'>when I forced
kernel panic by &#8220;echo c &gt; /proc/sysrq-trigger&#8221; the =
console kept
showing &#8220;Sending IPI to other CPU&#8221; and did not go to the =
next step.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"MS =
Gothic"'><o:p>&nbsp;</o:p></span></p>

<pre><span lang=3DEN-US style=3D'font-size:10.0pt'>According to this =
list there was some problem about kdump in ppc970 based CPU which =
PowerMac&#8217;s CPU are.<o:p></o:p></span></pre>

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
Gothic"'>Suchada<o:p></o:p></span></p>

</div>

</body>

</html>

------=_NextPart_000_000A_01C8A3BA.7D74A4A0--



--===============0311674094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0311674094==--


