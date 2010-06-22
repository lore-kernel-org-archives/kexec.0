Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail2.verdico.com ([208.228.181.118] helo=diebold.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OR8We-0005mE-HW
	for kexec@lists.infradead.org; Tue, 22 Jun 2010 18:48:50 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: FW: kexec to launch second kernel
Date: Tue, 22 Jun 2010 14:32:36 -0400
Message-ID: <1B6842FB45272B4E8E927594DA0D1CB70D0BA032@usncex18.ad.diebold.com>
From: "Kagathara, Satish" <satish.kagathara@diebold.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0852573114=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multi-part message in MIME format.

--===============0852573114==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB1239.4ACDA735"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB1239.4ACDA735
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20

=20

From: Kagathara, Satish=20
Sent: Tuesday, June 22, 2010 9:22 AM
To: 'Simon Horman'
Subject: kexec to launch second kernel

=20

Hi,

=20

I found your email id from kexec site. I am using kexec to start a =
second kernel (grub4dos and then windows). I have installed Fedora Core =
13 first and Windows XP later on disk. I am using =
kexec-tools-2.0.1.tar.bz2 and I just extracted it and ran ./configure =
and make commands.

=20

I am using following commands to launch a second kernel -

=20

Kexec -l /sbin/grub.exe

Kexec -e

=20

First I tried grub4dos 0.4.4 but did not work then tried grub4dos 0.4.2 =
but that too isn't working. I have copied grub.exe to /sbin. Also, =
copied menu.lst on windows partition. I am facing following problems =
with them -

=20

Stuck at Launching GRUB when I use grub4dos 0.4.4 - It just stuck at =
Launching GRUB screen.=20

=20

Keyboard not working when I use grub4dos 0.4.2 - With 0.4.2 version, =
grub4dos starts, shows some entries on screen then says failure. Then it =
tries to find /menu.lst but it doesn't (I don't know why as I have =
copied menu.lst in Windows partition (hd0,1). Then it neither finds =
menu.lst at /boot/grub/ or /grub. So it gives grub4dos command prompt =
but I can't enter any thing as keyboard is not at all responding. Even =
Caps Lock, Num Lock LED not blinking.

=20

In both cases, I also tried using -command-line option in kexec -l =
/sbin/grub.exe and given -config-file but did not work.

=20

Menu.lst -

Color black/cyan yellow/cyan

                Timeout=3D0

                Default=3D0

=20

Title Start Windows

                Rootnoverify (hd0,1)

                Chainloader +1

                boot

=20

Sequence is - Fron GNU GRUB start FC13 =E0 Run kexec commands from =
terminal =E0 Should start grub.exe (grub4dos) =E0 grub4dos should find =
menu.lst and launch Windows XP.=20

=20

Please note that I can boot Windows XP from GNU GRUB with same menu.lst =
as above and also when I launch grub4dos as kernel from GNU GRUB and =
then grub4dos finds menu.lst and start Windows XP. I can't launch =
Windows XP using kexec.

=20

Please let me know whether I am following correct steps and using right =
versions or not and a possible solution for this problem.=20

=20

Thanks,

SATISH KAGATHARA

=20


------_=_NextPart_001_01CB1239.4ACDA735
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>

<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DWordSection1>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0in 0in 0in'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Kagathara, =
Satish <br>
<b>Sent:</b> Tuesday, June 22, 2010 9:22 AM<br>
<b>To:</b> 'Simon Horman'<br>
<b>Subject:</b> kexec to launch second kernel<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Hi,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I found your email id from kexec site. I am using =
kexec to
start a second kernel (grub4dos and then windows). I have installed =
Fedora Core
13 first and Windows XP later on disk. I am using =
kexec-tools-2.0.1.tar.bz2 and
I just extracted it and ran ./configure and make =
commands.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I am using following commands to launch a second =
kernel &#8211;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Kexec &#8211;l /sbin/grub.exe<o:p></o:p></p>

<p class=3DMsoNormal>Kexec &#8211;e<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>First I tried grub4dos 0.4.4 but did not work then =
tried
grub4dos 0.4.2 but that too isn&#8217;t working. I have copied grub.exe =
to /sbin.
Also, copied menu.lst on windows partition. I am facing following =
problems with
them -<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Stuck at Launching GRUB when I use grub4dos 0.4.4 =
&#8211; It just
stuck at Launching GRUB screen. <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Keyboard not working when I use grub4dos 0.4.2 =
&#8211; With 0.4.2
version, grub4dos starts, shows some entries on screen then says =
failure. Then
it tries to find /menu.lst but it doesn&#8217;t (I don&#8217;t know why =
as I have copied
menu.lst in Windows partition (hd0,1). Then it neither finds menu.lst at
/boot/grub/ or /grub. So it gives grub4dos command prompt but I =
can&#8217;t enter any
thing as keyboard is not at all responding. Even Caps Lock, Num Lock LED =
not
blinking.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>In both cases, I also tried using =
&#8211;command-line option in
kexec &#8211;l /sbin/grub.exe and given &#8211;config-file but did not =
work.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Menu.lst -<o:p></o:p></p>

<p class=3DMsoNormal>Color black/cyan yellow/cyan<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Timeout=3D0<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Default=3D0<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Title Start Windows<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Rootnoverify (hd0,1)<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Chainloader +1<o:p></o:p></p>

<p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
boot<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Sequence is &#8211; Fron GNU GRUB start FC13 <span
style=3D'font-family:Wingdings'>=E0</span> Run kexec commands from =
terminal <span
style=3D'font-family:Wingdings'>=E0</span> Should start grub.exe =
(grub4dos) <span
style=3D'font-family:Wingdings'>=E0</span> grub4dos should find menu.lst =
and launch
Windows XP. <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Please note that I can boot Windows XP from GNU =
GRUB with
same menu.lst as above and also when I launch grub4dos as kernel from =
GNU GRUB
and then grub4dos finds menu.lst and start Windows XP. I can&#8217;t =
launch Windows
XP using kexec.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Please let me know whether I am following correct =
steps and using
right versions or not and a possible solution for this problem. =
<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks,<o:p></o:p></p>

<p class=3DMsoNormal><b><span =
style=3D'font-size:8.0pt;font-family:"Arial","sans-serif";
color:#3333CC'>SATISH </span></b><b><span =
style=3D'font-size:8.0pt;font-family:
"Arial","sans-serif";color:#3333FF'>KAGATHARA</span></b><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CB1239.4ACDA735--


--===============0852573114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0852573114==--

