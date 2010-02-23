Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lion.reldata.com ([209.123.188.11] helo=reldata.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NjxLA-00049v-Kn
	for kexec@lists.infradead.org; Tue, 23 Feb 2010 16:10:32 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: 2.6.18 Fedora core kernel gives: "Overlapping memory segments at"
	error
Date: Tue, 23 Feb 2010 11:10:26 -0500
Message-ID: <32AB6BC050DF9E4E91868C4C3B7B6ABBB5688E@lion.reldatainc.local>
From: "Soumendu Satapathy" <soumendu.satapathy@reldata.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1966934851=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kexec Mailing List <kexec@lists.infradead.org>

This is a multi-part message in MIME format.

--===============1966934851==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CAB4A2.B6D2698E"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CAB4A2.B6D2698E
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This is my .config  for the capture kernel.

=20

CONFIG_KEXEC=3Dy

CONFIG_CRASH_DUMP=3Dy

CONFIG_PHYSICAL_START=3D0x2000000

=20

I use crashkernel=3D64M@32M.

=20

Thanks

Soumendu

=20

From: Soumendu Satapathy=20
Sent: Tuesday, February 23, 2010 11:07 AM
To: Kexec Mailing List
Subject: 2.6.18 Fedora core kernel gives: "Overlapping memory segments
at" error

=20

Hi there,

=20

When I use a 2.6.27 Fedora core I am able to load a capture kernel
properly and it boots when the first kernel crashes.

I am using a x86_64 platform and 2.6.27 Fedora core.

=20

I use crashkernel=3D64M@32M.

=20

But when I use a 2.6.18 in the same environment and settings as above, I
get the following error when I load a capture kernel:-

=20

"Overlapping memory segments at"  error

"Sort segments failed"

=20

I found that the kernel segments overlap when loading them in the 64M
memory reserved for the capture kernel. My system memory is MemTotal:
8037944 kB

=20

I am using kexec-tools-2.0.1 and the "cat /proc/iomem"  o/p is as
follows.

=20

00000000-0009b3ff : System RAM

0009b400-0009ffff : reserved

000e4000-000fffff : reserved

00100000-cff6ffff : System RAM

  00200000-006f0747 : Kernel code

  006f0748-009b9b3f : Kernel data

  00be2000-01219ea7 : Kernel bss

  02000000-05ffffff : Crash kernel

cff70000-cff77fff : ACPI Tables

cff78000-cff7ffff : ACPI Non-volatile Storage

cff80000-cfffffff : reserved

d1000000-d11fffff : PCI Bus 0000:01

  d1000000-d10fffff : PCI Bus 0000:02

    d1000000-d107ffff : 0000:02:03.0

    d1080000-d10fffff : 0000:02:03.1

  d1100000-d11fffff : PCI Bus 0000:03

    d1100000-d113ffff : 0000:03:02.0

    d1140000-d117ffff : 0000:03:02.1

d1200000-d12fffff : PCI Bus 0000:04

  d1200000-d12fffff : PCI Bus 0000:05

    d1200000-d120ffff : 0000:05:04.0

d1300000-d13fffff : PCI Bus 0000:06

  d1300000-d13fffff : PCI Bus 0000:07

    d1300000-d130ffff : 0000:07:04.0

d1400000-d14fffff : PCI Bus 0000:09

  d1400000-d141ffff : 0000:09:01.0

d1500000-d15003ff : 0000:00:1f.1

dd000000-dd000fff : 0000:00:01.0

dd001000-dd00100f : 0000:00:1d.4

dd001400-dd0017ff : 0000:00:1d.7

  dd001400-dd0017ff : ehci_hcd

dd100000-dd3fffff : PCI Bus 0000:01

  dd100000-dd100fff : 0000:01:00.1

  dd101000-dd101fff : 0000:01:00.3

  dd200000-dd2fffff : PCI Bus 0000:02

    dd200000-dd201fff : 0000:02:03.0

    dd202000-dd203fff : 0000:02:03.1

  dd300000-dd3fffff : PCI Bus 0000:03

    dd300000-dd300fff : 0000:03:02.0

    dd301000-dd301fff : 0000:03:02.1

dd400000-dd4fffff : PCI Bus 0000:04

  dd400000-dd4fffff : PCI Bus 0000:05

    dd400000-dd40ffff : 0000:05:04.0

      dd400000-dd40ffff : tg3

    dd410000-dd41ffff : 0000:05:04.0

      dd410000-dd41ffff : tg3

    dd420000-dd42ffff : 0000:05:04.1

      dd420000-dd42ffff : tg3

    dd430000-dd43ffff : 0000:05:04.1

      dd430000-dd43ffff : tg3

dd500000-dd5fffff : PCI Bus 0000:06

  dd500000-dd5fffff : PCI Bus 0000:07

    dd500000-dd50ffff : 0000:07:04.0

      dd500000-dd50ffff : tg3

    dd510000-dd51ffff : 0000:07:04.0

      dd510000-dd51ffff : tg3

    dd520000-dd52ffff : 0000:07:04.1

      dd520000-dd52ffff : tg3

    dd530000-dd53ffff : 0000:07:04.1

      dd530000-dd53ffff : tg3

dd600000-dd6fffff : PCI Bus 0000:08

  dd600000-dd61ffff : 0000:08:01.0

    dd600000-dd61ffff : e1000

  dd620000-dd63ffff : 0000:08:02.0

    dd620000-dd63ffff : e1000

dd700000-deffffff : PCI Bus 0000:09

  dd700000-dd700fff : 0000:09:01.0

  de000000-deffffff : 0000:09:01.0

e0000000-efffffff : PCI MMCONFIG 0

  e0000000-efffffff : reserved

fec00000-fec0ffff : reserved

  fec00000-fec00fff : IOAPIC 0

fec10000-fec10fff : IOAPIC 1

fec80000-fec80fff : IOAPIC 2

fee00000-fee00fff : Local APIC

  fee00000-fee00fff : reserved

ff800000-ffbfffff : reserved

fffffc00-ffffffff : reserved

100000000-22fffffff : System RAM

=20

Could it be a bug in the Kexec?=20

=20

thanks

Soumendu S Satapathy

Senior Software Developer

RELDATA Inc.

1719 Route 10, Suite 209

Parsippany, NJ 07054

(973) 644-2770  ext. 139  office

732-692-7230 mobile

(973) 644-3385 fax

soumendu.satapathy@reldata.com

www.reldata.com <http://www.reldata.com/>=20

=20

=20

=20

Soumendu S Satapathy

Senior Software Developer

RELDATA Inc.

1719 Route 10, Suite 209

Parsippany, NJ 07054

(973) 644-2770  ext. 139  office

732-692-7230 mobile

(973) 644-3385 fax

soumendu.satapathy@reldata.com

www.reldata.com <http://www.reldata.com/>=20

=20


------_=_NextPart_001_01CAB4A2.B6D2698E
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
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
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
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

<div class=3DSection1>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>This is my .config =
&nbsp;for the
capture kernel.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'>CONFIG_KEXEC=3Dy<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'>CONFIG_CRASH_DUMP=3Dy<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'>CONFIG_PHYSICAL_START=3D0x2000000<o:p></o:p></spa=
n></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal>I use crashkernel=3D64M@32M.<o:p></o:p></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Thanks<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'>Soumendu<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0in 0in 0in'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Soumendu =
Satapathy <br>
<b>Sent:</b> Tuesday, February 23, 2010 11:07 AM<br>
<b>To:</b> Kexec Mailing List<br>
<b>Subject:</b> 2.6.18 Fedora core kernel gives: &quot;Overlapping =
memory
segments at&quot; error<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Hi there,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>When I use a 2.6.27 Fedora core I am able to load a =
capture
kernel properly and it boots when the first kernel =
crashes.<o:p></o:p></p>

<p class=3DMsoNormal>I am using a x86_64 platform and 2.6.27 Fedora =
core.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I use crashkernel=3D64M@32M.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>But when I use a 2.6.18 in the same environment and =
settings
as above, I get the following error when I load a capture =
kernel:-<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>&#8220;Overlapping memory segments at&quot; =
&nbsp;error<o:p></o:p></p>

<p class=3DMsoNormal>&#8220;Sort segments failed&#8221;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I found that the kernel segments overlap when =
loading them
in the 64M memory reserved for the capture kernel. My system memory is
MemTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8037944 kB<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I am using kexec-tools-2.0.1 and the &#8220;cat =
/proc/iomem&#8221;
&nbsp;o/p is as follows.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>00000000-0009b3ff : System RAM<o:p></o:p></p>

<p class=3DMsoNormal>0009b400-0009ffff : reserved<o:p></o:p></p>

<p class=3DMsoNormal>000e4000-000fffff : reserved<o:p></o:p></p>

<p class=3DMsoNormal>00100000-cff6ffff : System RAM<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 00200000-006f0747 : Kernel =
code<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 006f0748-009b9b3f : Kernel =
data<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; 00be2000-01219ea7 : Kernel =
bss<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; <b>02000000-05ffffff : Crash =
kernel<o:p></o:p></b></p>

<p class=3DMsoNormal>cff70000-cff77fff : ACPI Tables<o:p></o:p></p>

<p class=3DMsoNormal>cff78000-cff7ffff : ACPI Non-volatile =
Storage<o:p></o:p></p>

<p class=3DMsoNormal>cff80000-cfffffff : reserved<o:p></o:p></p>

<p class=3DMsoNormal>d1000000-d11fffff : PCI Bus 0000:01<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; d1000000-d10fffff : PCI Bus =
0000:02<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; d1000000-d107ffff : =
0000:02:03.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; d1080000-d10fffff : =
0000:02:03.1<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; d1100000-d11fffff : PCI Bus =
0000:03<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; d1100000-d113ffff : =
0000:03:02.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; d1140000-d117ffff : =
0000:03:02.1<o:p></o:p></p>

<p class=3DMsoNormal>d1200000-d12fffff : PCI Bus 0000:04<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; d1200000-d12fffff : PCI Bus =
0000:05<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; d1200000-d120ffff : =
0000:05:04.0<o:p></o:p></p>

<p class=3DMsoNormal>d1300000-d13fffff : PCI Bus 0000:06<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; d1300000-d13fffff : PCI Bus =
0000:07<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; d1300000-d130ffff : =
0000:07:04.0<o:p></o:p></p>

<p class=3DMsoNormal>d1400000-d14fffff : PCI Bus 0000:09<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; d1400000-d141ffff : =
0000:09:01.0<o:p></o:p></p>

<p class=3DMsoNormal>d1500000-d15003ff : 0000:00:1f.1<o:p></o:p></p>

<p class=3DMsoNormal>dd000000-dd000fff : 0000:00:01.0<o:p></o:p></p>

<p class=3DMsoNormal>dd001000-dd00100f : 0000:00:1d.4<o:p></o:p></p>

<p class=3DMsoNormal>dd001400-dd0017ff : 0000:00:1d.7<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; dd001400-dd0017ff : ehci_hcd<o:p></o:p></p>

<p class=3DMsoNormal>dd100000-dd3fffff : PCI Bus 0000:01<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; dd100000-dd100fff : =
0000:01:00.1<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; dd101000-dd101fff : =
0000:01:00.3<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; dd200000-dd2fffff : PCI Bus =
0000:02<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd200000-dd201fff : =
0000:02:03.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd202000-dd203fff : =
0000:02:03.1<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; dd300000-dd3fffff : PCI Bus =
0000:03<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd300000-dd300fff : =
0000:03:02.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd301000-dd301fff : =
0000:03:02.1<o:p></o:p></p>

<p class=3DMsoNormal>dd400000-dd4fffff : PCI Bus 0000:04<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; dd400000-dd4fffff : PCI Bus =
0000:05<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd400000-dd40ffff : =
0000:05:04.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd400000-dd40ffff : =
tg3<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd410000-dd41ffff : =
0000:05:04.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd410000-dd41ffff : =
tg3<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd420000-dd42ffff : =
0000:05:04.1<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd420000-dd42ffff : =
tg3<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd430000-dd43ffff : =
0000:05:04.1<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd430000-dd43ffff : =
tg3<o:p></o:p></p>

<p class=3DMsoNormal>dd500000-dd5fffff : PCI Bus 0000:06<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; dd500000-dd5fffff : PCI Bus =
0000:07<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd500000-dd50ffff : =
0000:07:04.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd500000-dd50ffff : =
tg3<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd510000-dd51ffff : =
0000:07:04.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd510000-dd51ffff : =
tg3<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd520000-dd52ffff : =
0000:07:04.1<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd520000-dd52ffff : =
tg3<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd530000-dd53ffff : =
0000:07:04.1<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd530000-dd53ffff : =
tg3<o:p></o:p></p>

<p class=3DMsoNormal>dd600000-dd6fffff : PCI Bus 0000:08<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; dd600000-dd61ffff : =
0000:08:01.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd600000-dd61ffff : =
e1000<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; dd620000-dd63ffff : =
0000:08:02.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; dd620000-dd63ffff : =
e1000<o:p></o:p></p>

<p class=3DMsoNormal>dd700000-deffffff : PCI Bus 0000:09<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; dd700000-dd700fff : =
0000:09:01.0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; de000000-deffffff : =
0000:09:01.0<o:p></o:p></p>

<p class=3DMsoNormal>e0000000-efffffff : PCI MMCONFIG 0<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; e0000000-efffffff : reserved<o:p></o:p></p>

<p class=3DMsoNormal>fec00000-fec0ffff : reserved<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; fec00000-fec00fff : IOAPIC 0<o:p></o:p></p>

<p class=3DMsoNormal>fec10000-fec10fff : IOAPIC 1<o:p></o:p></p>

<p class=3DMsoNormal>fec80000-fec80fff : IOAPIC 2<o:p></o:p></p>

<p class=3DMsoNormal>fee00000-fee00fff : Local APIC<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp; fee00000-fee00fff : reserved<o:p></o:p></p>

<p class=3DMsoNormal>ff800000-ffbfffff : reserved<o:p></o:p></p>

<p class=3DMsoNormal>fffffc00-ffffffff : reserved<o:p></o:p></p>

<p class=3DMsoNormal>100000000-22fffffff : System RAM<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Could it be a bug in the Kexec? <o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:navy'>thanks<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:navy'>Soumendu S
Satapathy<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'>Senior =
Software
Developer<o:p></o:p></span></p>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;color:navy'>RELDATA =
Inc.<o:p></o:p></span></b></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'>1719 =
Route 10,
Suite 209<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:navy'>Parsippany, NJ
07054<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'>(973)
644-2770&nbsp; ext. 139&nbsp; office<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:navy'>732-692-7230
mobile<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'>(973) =
644-3385 fax<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'><a
href=3D"mailto:soumendu.satapathy@reldata.com">soumendu.satapathy@reldata=
.com</a><o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'><a
href=3D"http://www.reldata.com/">www.reldata.com</a></span><span
style=3D'color:navy'><o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:navy'>Soumendu S
Satapathy<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'>Senior =
Software
Developer<o:p></o:p></span></p>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;color:navy'>RELDATA =
Inc.<o:p></o:p></span></b></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'>1719 =
Route 10,
Suite 209<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:navy'>Parsippany, NJ
07054<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'>(973)
644-2770&nbsp; ext. 139&nbsp; office<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:navy'>732-692-7230
mobile<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'>(973) =
644-3385 fax<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;color:navy'>soumendu.satapathy@reldata.com<o:p>=
</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;color:navy'><a
href=3D"http://www.reldata.com/">www.reldata.com</a></span><span
style=3D'color:navy'><o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_001_01CAB4A2.B6D2698E--


--===============1966934851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1966934851==--

