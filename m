Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KgQxA-0000lE-3b
	for kexec@lists.infradead.org; Thu, 18 Sep 2008 21:22:21 +0000
From: "Worth, Kevin" <kevin.worth@hp.com>
Date: Thu, 18 Sep 2008 21:20:59 +0000
Subject: Problems writing ELF dumps with makedumpfile 1.2.9
Message-ID: <28113A0489833849A1CF9EC16F42154340494D5BA0@GVW1097EXB.americas.hpqcorp.net>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1708840964=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

--===============1708840964==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_004_28113A0489833849A1CF9EC16F42154340494D5BA0GVW1097EXBame_";
	type="multipart/alternative"

--_004_28113A0489833849A1CF9EC16F42154340494D5BA0GVW1097EXBame_
Content-Type: multipart/alternative;
	boundary="_000_28113A0489833849A1CF9EC16F42154340494D5BA0GVW1097EXBame_"

--_000_28113A0489833849A1CF9EC16F42154340494D5BA0GVW1097EXBame_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a couple errors that also happened on 1.2.6 and I wondered if anyone=
 might have a suggestion why.

The one thing I know might be strange about my system is that my first kern=
el (the one that panics) is compiled with CONFIG_VMSPLIT_1G, meaning that i=
t is set to have 3GB of kernel space and 1GB of user space. I believe this =
does things to CONFIG_PAGE_OFFSET, but the depth of my kernel knowledge is =
not so great.


# makedumpfile -E -d 31 -i /boot/vmcoreinfo vmcore dumpoutput2
check_release: /boot/vmcoreinfo and vmcore don't match.

makedumpfile Failed.

The release numbers of the vmcore and vmcoreinfo files should be identical.=
 This happens if I specify anything greater than "-d 1".

I tried a quick addition to the printf to include the values that generate =
the above error. It looks like "system_utsname.release" is NULL coming into=
 the strcmp on line 340 of makedumpfile.c . Unfortunately I don't know enou=
gh about the kernel to go further than this.


Additionally (potentially a separate issue), on an identical piece of hardw=
are, but with 4GB of memory instead of 2GB, using "-d 1", I get the followi=
ng error:

Excluding zero pages               : [ 38 %] readmem: Can't seek the dump m=
emory(/proc/vmcore). Invalid argument
create_2nd_bitmap: Can't exclude pages filled with zerocreate_2nd_bitmap: f=
or creating an ELF dumpfile.

makedumpfile Failed.

I can cp the file just fine and it loads up in crash, but I can't seem to u=
se makedumpfile to trim the vmcore down at all on this system with more mem=
ory.

Any suggestions? Thanks!


Kevin Worth
Network Security
Software Engineer
kevin.worth@hp.com<mailto:kevin.worth@hp.com>
ph 916.785.4528
fx 916.785.1196

[cid:image003.jpg@01C91999.C5AF4AE0]




--_000_28113A0489833849A1CF9EC16F42154340494D5BA0GVW1097EXBame_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Tw Cen MT";
	panose-1:2 11 6 2 2 1 4 2 6 3;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"2050" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hello,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I have a couple errors that also happened on 1.2.6 and=
 I
wondered if anyone might have a suggestion why.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The one thing I know might be strange about my system =
is
that my first kernel (the one that panics) is compiled with CONFIG_VMSPLIT_=
1G,
meaning that it is set to have 3GB of kernel space and 1GB of user space. I
believe this does things to CONFIG_PAGE_OFFSET, but the depth of my kernel
knowledge is not so great.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal># makedumpfile -E -d 31 -i /boot/vmcoreinfo vmcore
dumpoutput2<o:p></o:p></p>

<p class=3DMsoNormal>check_release: /boot/vmcoreinfo and vmcore don't match=
.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>makedumpfile Failed.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The release numbers of the vmcore and vmcoreinfo files
should be identical. This happens if I specify anything greater than &#8220=
;&#8211;d
1&#8221;.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I tried a quick addition to the printf to include the =
values
that generate the above error. It looks like &#8220;system_utsname.release&=
#8221;
is NULL coming into the strcmp on line 340 of makedumpfile.c . Unfortunatel=
y I
don&#8217;t know enough about the kernel to go further than this.<o:p></o:p=
></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Additionally (potentially a separate issue), on an ide=
ntical
piece of hardware, but with 4GB of memory instead of 2GB, using &#8220;-d 1=
&#8221;,
I get the following error:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Excluding zero
pages&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
: [ 38 %] readmem: Can't seek the dump memory(/proc/vmcore). Invalid argume=
nt<o:p></o:p></p>

<p class=3DMsoNormal>create_2nd_bitmap: Can't exclude pages filled with
zerocreate_2nd_bitmap: for creating an ELF dumpfile.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>makedumpfile Failed.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I can cp the file just fine and it loads up in crash, =
but I
can&#8217;t seem to use makedumpfile to trim the vmcore down at all on this
system with more memory.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Any suggestions? Thanks!<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<table class=3DMsoNormalTable border=3D0 cellspacing=3D0 cellpadding=3D0 al=
ign=3Dleft
 style=3D'border-collapse:collapse'>
 <tr>
  <td valign=3Dtop style=3D'padding:0in 5.75pt 0in 5.75pt'>
  <p class=3DMsoNormal style=3D'mso-element:frame;mso-element-frame-hspace:=
2.25pt;
  mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element=
-anchor-horizontal:
  column;mso-height-rule:exactly'><span style=3D'font-size:12.0pt;font-fami=
ly:
  "Tw Cen MT","sans-serif"'>Kevin Worth<br>
  Network Security <br>
  Software Engineer<br>
  </span><a href=3D"mailto:kevin.worth@hp.com"><span style=3D'font-size:12.=
0pt;
  font-family:"Tw Cen MT","sans-serif";color:blue'>kevin.worth@hp.com</span=
></a><span
  style=3D'font-size:12.0pt;font-family:"Tw Cen MT","sans-serif"'> <br>
  ph 916.785.4528<br>
  fx 916.785.1196<o:p></o:p></span></p>
  </td>
  <td style=3D'padding:0in 5.75pt 0in 5.75pt'>
  <p class=3DMsoNormal style=3D'mso-element:frame;mso-element-frame-hspace:=
2.25pt;
  mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element=
-anchor-horizontal:
  column;mso-height-rule:exactly'><span style=3D'font-size:10.0pt;font-fami=
ly:
  "Tw Cen MT","sans-serif"'><img border=3D0 width=3D145 height=3D79
  id=3D"Picture_x0020_1" src=3D"cid:image003.jpg@01C91999.C5AF4AE0"
  alt=3DProCurve-RGB-logo-small></span><span style=3D'font-size:12.0pt;font=
-family:
  "Times New Roman","serif"'><o:p></o:p></span></p>
  </td>
 </tr>
</table>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_28113A0489833849A1CF9EC16F42154340494D5BA0GVW1097EXBame_--

--_004_28113A0489833849A1CF9EC16F42154340494D5BA0GVW1097EXBame_
Content-Type: image/jpeg; name="image003.jpg"
Content-Description: image003.jpg
Content-Disposition: inline; filename="image003.jpg"; size=3394;
	creation-date="Thu, 18 Sep 2008 21:21:05 GMT";
	modification-date="Thu, 18 Sep 2008 21:21:05 GMT"
Content-ID: <image003.jpg@01C91999.C5AF4AE0>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwgHBgoICAgLCgoLDhgQDg0NDh0VFhEYIx8lJCIf
IiEmKzcvJik0KSEiMEExNDk7Pj4+JS5ESUM8SDc9Pjv/2wBDAQoLCw4NDhwQEBw7KCIoOzs7Ozs7
Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozv/wAARCABPAJEDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwBfiv45
8R+HPFiWWlagbe3Nsj7PLU8knJ5HtWU+v/F+Cx/tB4rs2wQSbxbxsNuM5wBnGKqfHP8A5HqP/rzT
+bV08fxv0Wz0CK1g067muYrZYgHChCwXHJz0zQBofDL4n3Him7bR9YSNb4IXimjG0SgdQR2Nemgj
HUV89fBnR7vUPGn9rrEy2tkjs8gGF3MCAo/PP4Vz2nX3iC51y70vSp7iW51Bnt1XzT90tk4544HX
0zQB9TKysMqQR6ik3pu27hu9M814l4k1nWvh18P9K8MLMIdTuPNeaaJ9xjj3HAB9Tnr7VSPw0v18
BHxb/bdyNRFv9r8rJ+51xuznOOc0Ae9kgcmvFPGHxd1e81ptG8IrtUSeUJ1TfJM2cfKD0FWPCHxA
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

--_004_28113A0489833849A1CF9EC16F42154340494D5BA0GVW1097EXBame_--


--===============1708840964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1708840964==--

