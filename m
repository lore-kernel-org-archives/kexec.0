Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from emailgateway.hillcrestlabs.com ([12.173.51.132])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nk3Xu-0003lv-Hp
	for kexec@lists.infradead.org; Tue, 23 Feb 2010 22:48:07 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Kexec on ARM?
Date: Tue, 23 Feb 2010 17:32:55 -0500
Message-ID: <36E4692623C5974BA6661C0B18EE8EDF0173493B@MAILSERV.hcrest.com>
From: "Phil Black" <Phil.Black@hillcrestlabs.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1079068799=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multi-part message in MIME format.

--===============1079068799==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAB4D8.24E3867C"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CAB4D8.24E3867C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, I've been trying to kexec a kernel on an arm platform.  I've
successfully compiled the userland kexec-tools both from the git repo,
and the latest 2.0.1 release.  I've tried the latest official kernel
(2.6.33-rc8) as well as from the arago project (a patched 2.6.32
kernel), but have yet to see anything happen.

=20

I'm trying this on a Ti DM365 EVM board, which is an ARM926EJ-S core

 Kexec seems to be able to load the kernel, but just hangs after
decompression.... My terminal output looks like:

=20

root@10.9.5.34:~# kexec -l uImage

root@10.9.5.34:~# kexec -e

Starting new kernel

Bye!

Uncompressing Linux... done, booting the kernel.

=20

=20

After this, it just sits there....

=20

I haven't done a whole lot of kernel debugging, so any
suggestions/advice would be appreciated.  I'm not really sure where to
start.  I've also tried zImage files which don't work either.

=20

I don't know if it matters, but uBoot (the bootloader) loads the kernel
at 0x80008000 with kernel entry point at 0x80008000.

=20

=20

Thanks,

Phil


------_=_NextPart_001_01CAB4D8.24E3867C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi, I&#8217;ve been trying to kexec a kernel on an =
arm
platform.&nbsp; I&#8217;ve successfully compiled the userland =
kexec-tools both
from the git repo, and the latest 2.0.1 release.&nbsp; I&#8217;ve tried =
the
latest official kernel (2.6.33-rc8) as well as from the arago project (a
patched 2.6.32 kernel), but have yet to see anything =
happen.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m trying this on a Ti DM365 EVM board, which =
is an ARM926EJ-S
core<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;Kexec seems to be able to load the kernel, but =
just
hangs after decompression&#8230;. My terminal output looks =
like:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>root@10.9.5.34:~# kexec -l =
uImage<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>root@10.9.5.34:~# kexec =
-e<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Starting new kernel<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Bye!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Uncompressing Linux... done, booting the =
kernel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>After this, it just sits =
there&#8230;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I haven&#8217;t done a whole lot of kernel debugging, =
so any
suggestions/advice would be appreciated.&nbsp; I&#8217;m not really sure =
where
to start.&nbsp; I&#8217;ve also tried zImage files which don&#8217;t =
work
either.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I don&#8217;t know if it matters, but uBoot (the =
bootloader)
loads the kernel at 0x80008000 with kernel entry point at =
0x80008000.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Phil<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01CAB4D8.24E3867C--


--===============1079068799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1079068799==--

