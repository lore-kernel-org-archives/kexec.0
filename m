Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kl7Fa-0005tT-8z
	for kexec@lists.infradead.org; Wed, 01 Oct 2008 19:20:44 +0000
From: "Worth, Kevin" <kevin.worth@hp.com>
Date: Wed, 1 Oct 2008 19:19:56 +0000
Subject: "cannot access vmalloc'd module memory" when loading kdump'ed
	vmcore in crash
Message-ID: <28113A0489833849A1CF9EC16F4215434376E9C97F@GVW1097EXB.americas.hpqcorp.net>
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
Content-Type: multipart/mixed; boundary="===============1377081630=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec-ml <kexec@lists.infradead.org>, "crash-utility@redhat.com" <crash-utility@redhat.com>

--===============1377081630==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_28113A0489833849A1CF9EC16F4215434376E9C97FGVW1097EXBame_"

--_000_28113A0489833849A1CF9EC16F4215434376E9C97FGVW1097EXBame_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello kexec and crash mailing lists,

Sorry to spam whoever's code this ISN'T an issue with, but I really am unsu=
re of whether is a kdump or a crash issue. I am running an Ubuntu 7.04 with=
 a 2.6.20 kernel (includes Ubuntus patches- source at http://packages.ubunt=
u.com/feisty/linux-source-2.6.20 ) and a modified VMSPLIT/PAGE_OFFSET value=
 (see bottom for details) on an i386 machine with 4GB of memory. At first I=
 thought this could be an issue with makedumpfile stripping out things it s=
houldn't, but I've found that setting up my initrd script so that it simply=
 performs "cp /proc/vmcore /var/crash/vmcore" results in the same issue.

I've tried this with both crash 4.0-6.3 and 4.0-7.2 and get the same result=
. Unfortunately I'm locked at kernel 2.6.20 for other reasons, or else I wo=
uld try that.

If anyone can offer suggestions of what to try, please let me know. If this=
 is something that has already been resolved elsewhere, sorry to waste time=
, and if someone can point me to what resolved it, perhaps I can look at ba=
ckporting the fix myself. Thanks for your time.

crash-4.0-7.2$ ./crash ~/vmcore ~/targetfiles/vmlinux-2.6.20-17.39-custom2

crash 4.0-7.2
<snip>Copyright notices...</snip>
GNU gdb 6.1
<snip>Copyright notices...</snip>
This GDB was configured as "i686-pc-linux-gnu"...

please wait... (gathering module symbol data)
WARNING: cannot access vmalloc'd module memory

      KERNEL: /home/worthk/targetfiles/vmlinux-2.6.20-17.39-custom2
    DUMPFILE: /home/worthk/vmcore
        CPUS: 2
        DATE: Wed Oct  1 12:30:50 2008
      UPTIME: 00:35:11
LOAD AVERAGE: 0.07, 0.09, 0.08
       TASKS: 94
    NODENAME: test-module
     RELEASE: 2.6.20-17.39-custom2
     VERSION: #3 SMP Wed Sep 24 10:11:03 PDT 2008
     MACHINE: i686  (2200 Mhz)
      MEMORY: 5 GB
<6>SysRq : Trigger a crashdump"
         PID: 4304
     COMMAND: "bash"
        TASK: 5d7e9030  [THREAD_INFO: f4b70000]
         CPU: 0
       STATE: TASK_RUNNING (SYSRQ)

crash> mod -s test
mod: cannot access vmalloc'd module memory


My kernel config is a bit outside the norm, in that the VMSPLIT value has b=
een modified to give 3GB of memory the kernelspace and 1GB of memory to use=
rspace. Below is a diff between the default Ubuntu "generic" config and min=
e:

diff /boot/config-2.6.20-17-generic /boot/config-2.6.20-17.37-custom2
3,4c3,4
< # Linux kernel version: 2.6.20-17-generic < # Wed Aug 20 14:43:36 2008
---
> # Linux kernel version: 2.6.20-17.37-custom2 # Tue Aug 19 18:50:53
> 2008
33c33
< CONFIG_VERSION_SIGNATURE=3D"Ubuntu 2.6.20-17.39-generic"
---
> CONFIG_VERSION_SIGNATURE=3D"Ubuntu 2.6.20-17.37-generic"
51c51
< # CONFIG_EMBEDDED is not set
---
> CONFIG_EMBEDDED=3Dy
188,190c188,194
< CONFIG_HIGHMEM4G=3Dy
< # CONFIG_HIGHMEM64G is not set
< CONFIG_PAGE_OFFSET=3D0xC0000000
---
> # CONFIG_HIGHMEM4G is not set
> CONFIG_HIGHMEM64G=3Dy
> # CONFIG_VMSPLIT_3G is not set
> # CONFIG_VMSPLIT_3G_OPT is not set
> # CONFIG_VMSPLIT_2G is not set
> CONFIG_VMSPLIT_1G=3Dy
> CONFIG_PAGE_OFFSET=3D0x40000000
191a196
> CONFIG_X86_PAE=3Dy
204c209
< # CONFIG_RESOURCES_64BIT is not set
---
> CONFIG_RESOURCES_64BIT=3Dy
1161a1167
> CONFIG_IDE_MAX_HWIFS=3D4
1443a1450
> # CONFIG_PATA_PLATFORM is not set
1525a1533
> CONFIG_I2O_EXT_ADAPTEC_DMA64=3Dy


Kevin Worth
Network Security Software Engineer
ProCurve networking by HP
kevin.worth@hp.com<mailto:kevin.worth@hp.com>
ph 916.785.4528
fx 916.785.1196

--_000_28113A0489833849A1CF9EC16F4215434376E9C97FGVW1097EXBame_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
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
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:Consolas;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle22
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

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Hello kexec and crash ma=
iling
lists,<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Sorry to spam whoever&#8=
217;s
code this ISN&#8217;T an issue with, but I really am unsure of whether is a
kdump or a crash issue. I am running an Ubuntu 7.04 with a 2.6.20 kernel
(includes Ubuntus patches- source at <a
href=3D"http://packages.ubuntu.com/feisty/linux-source-2.6.20">http://packa=
ges.ubuntu.com/feisty/linux-source-2.6.20</a>
) and a modified VMSPLIT/PAGE_OFFSET value (see bottom for details) on an i=
386
machine with 4GB of memory. At first I thought this could be an issue with
makedumpfile stripping out things it shouldn&#8217;t, but I&#8217;ve found =
that
setting up my initrd script so that it simply performs &#8220;cp /proc/vmco=
re
/var/crash/vmcore&#8221; results in the same issue.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>I&#8217;ve tried this wi=
th both
crash 4.0-6.3 and 4.0-7.2 and get the same result. Unfortunately I&#8217;m
locked at kernel 2.6.20 for other reasons, or else I would try that.<o:p></=
o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>If anyone can offer sugg=
estions
of what to try, please let me know. If this is something that has already b=
een
resolved elsewhere, sorry to waste time, and if someone can point me to wha=
t
resolved it, perhaps I can look at backporting the fix myself. Thanks for y=
our
time.<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>crash-4.0-7.2$ ./crash ~=
/vmcore
~/targetfiles/vmlinux-2.6.20-17.39-custom2<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>crash 4.0-7.2<o:p></o:p>=
</span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&lt;snip&gt;Copyright
notices&#8230;&lt;/snip&gt;<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>GNU gdb 6.1<o:p></o:p></=
span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&lt;snip&gt;Copyright
notices&#8230;&lt;/snip&gt;<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>This GDB was configured =
as
&quot;i686-pc-linux-gnu&quot;...<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>please wait... (gatherin=
g module
symbol data)<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>WARNING: cannot access v=
malloc'd
module memory<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
KERNEL: /home/worthk/targetfiles/vmlinux-2.6.20-17.39-custom2<o:p></o:p></s=
pan></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp; DUMPF=
ILE:
/home/worthk/vmcore<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
CPUS: 2<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
DATE: Wed Oct&nbsp; 1 12:30:50 2008<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
UPTIME: 00:35:11<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>LOAD AVERAGE: 0.07, 0.09=
, 0.08<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
TASKS: 94<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp; NODEN=
AME:
test-module<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;
RELEASE: 2.6.20-17.39-custom2<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;
VERSION: #3 SMP Wed Sep 24 10:11:03 PDT 2008<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;
MACHINE: i686&nbsp; (2200 Mhz)<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
MEMORY: 5 GB<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&lt;6&gt;SysRq : Trigger=
 a
crashdump&quot;<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
PID: 4304<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;
COMMAND: &quot;bash&quot;<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
TASK: 5d7e9030&nbsp; [THREAD_INFO: f4b70000]<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;
CPU: 0<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
STATE: TASK_RUNNING (SYSRQ)<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>crash&gt; mod -s test<o:=
p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>mod: cannot access vmall=
oc'd
module memory<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>My kernel config is a bi=
t
outside the norm, in that the VMSPLIT value has been modified to give 3GB o=
f
memory the kernelspace and 1GB of memory to userspace. Below is a diff betw=
een
the default Ubuntu &#8220;generic&#8221; config and mine:<o:p></o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>diff
/boot/config-2.6.20-17-generic /boot/config-2.6.20-17.37-custom2<o:p></o:p>=
</span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>3,4c3,4<o:p></o:p></span=
></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&lt; # Linux kernel vers=
ion:
2.6.20-17-generic &lt; # Wed Aug 20 14:43:36 2008<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>---<o:p></o:p></span></p=
>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; # Linux kernel vers=
ion:
2.6.20-17.37-custom2 # Tue Aug 19 18:50:53 <o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; 2008<o:p></o:p></sp=
an></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>33c33<o:p></o:p></span><=
/p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&lt;
CONFIG_VERSION_SIGNATURE=3D&quot;Ubuntu 2.6.20-17.39-generic&quot;<o:p></o:=
p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>---<o:p></o:p></span></p=
>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt;
CONFIG_VERSION_SIGNATURE=3D&quot;Ubuntu 2.6.20-17.37-generic&quot;<o:p></o:=
p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>51c51<o:p></o:p></span><=
/p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&lt; # CONFIG_EMBEDDED i=
s not
set<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>---<o:p></o:p></span></p=
>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; CONFIG_EMBEDDED=3Dy=
<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>188,190c188,194<o:p></o:=
p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&lt; CONFIG_HIGHMEM4G=3D=
y<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&lt; # CONFIG_HIGHMEM64G=
 is not
set<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&lt;
CONFIG_PAGE_OFFSET=3D0xC0000000<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>---<o:p></o:p></span></p=
>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; # CONFIG_HIGHMEM4G =
is not
set<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; CONFIG_HIGHMEM64G=
=3Dy<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; # CONFIG_VMSPLIT_3G=
 is not
set<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; # CONFIG_VMSPLIT_3G=
_OPT is
not set<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; # CONFIG_VMSPLIT_2G=
 is not
set<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; CONFIG_VMSPLIT_1G=
=3Dy<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt;
CONFIG_PAGE_OFFSET=3D0x40000000<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>191a196<o:p></o:p></span=
></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; CONFIG_X86_PAE=3Dy<=
o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>204c209<o:p></o:p></span=
></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&lt; # CONFIG_RESOURCES_=
64BIT is
not set<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>---<o:p></o:p></span></p=
>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; CONFIG_RESOURCES_64=
BIT=3Dy<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>1161a1167<o:p></o:p></sp=
an></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; CONFIG_IDE_MAX_HWIF=
S=3D4<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>1443a1450<o:p></o:p></sp=
an></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt; # CONFIG_PATA_PLATF=
ORM is
not set<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>1525a1533<o:p></o:p></sp=
an></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>&gt;
CONFIG_I2O_EXT_ADAPTEC_DMA64=3Dy<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span>=
</p>

<p class=3DMsoNormal><span style=3D'color:#1F497D'>Kevin Worth<br>
Network Security Software Engineer<br>
ProCurve networking by HP<br>
<a href=3D"mailto:kevin.worth@hp.com">kevin.worth@hp.com</a> <br>
ph 916.785.4528<br>
fx 916.785.1196<o:p></o:p></span></p>

</div>

</body>

</html>

--_000_28113A0489833849A1CF9EC16F4215434376E9C97FGVW1097EXBame_--


--===============1377081630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1377081630==--

