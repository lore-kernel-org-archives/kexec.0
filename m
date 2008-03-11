Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wf-out-1314.google.com ([209.85.200.172])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZ1mU-0000un-83
	for kexec@lists.infradead.org; Tue, 11 Mar 2008 10:32:27 +0000
Received: by wf-out-1314.google.com with SMTP id 29so2314371wff.24
	for <kexec@lists.infradead.org>; Tue, 11 Mar 2008 03:32:25 -0700 (PDT)
Message-ID: <4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>
Date: Tue, 11 Mar 2008 03:25:52 -0700
From: "Rajasekaran P" <rajasekaran83@gmail.com>
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
In-Reply-To: <47D19114.1090700@am.sony.com>
MIME-Version: 1.0
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>
	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>
	<47D19114.1090700@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1763143013=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

--===============1763143013==
Content-Type: multipart/alternative; 
	boundary="----=_Part_855_17164295.1205231153363"

------=_Part_855_17164295.1205231153363
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Geoff,
Thanks for your information.

I used latest kexec tools with 2.6.23 kernel built with ps3_defconfig.
This kernel boots normally on PS3. But when I  add "crashkernel" argument,
it goes on hang.


Please have a look at the following command outputs:

# kexec -v

kexec-tools-testing 20080227 released 27th February 2008



# kexec --command-line=3D"video=3Dps3fb:mode:166 rhgb root=3D/dev/ps3da3 " =
\

--initrd=3D/boot/initrd-2.6.23.img \

-l /boot/vmlinux-2.6.23

# kexec -e

 >>>> THIS WORKS FINE, I MEAN, THE NEW KERNEL IS BOOTING UP WITH GUI (FC8)


# kexec --command-line=3D"video=3Dps3fb:mode:166 rhgb root=3D/dev/ps3da3
crashkernel=3D128M@32M" \

--initrd=3D/boot/initrd-2.6.23.img \

-l /boot/vmlinux-2.6.23


get memory ranges:1

Modified cmdline:video=3Dps3fb:mode:166 rhgb root=3D/dev/ps3da3 crashkernel=
=3D
128M@32M

segment[0].mem:0x586000 memsz:5787648

segment[1].mem:0xb0b000 memsz:36864

segment[2].mem:0xb14000 memsz:3469312

segment[3].mem:0x7fff000 memsz:4096



# umount =96a

umount: /: device is busy

# taskset 1 kexec =96e



Nothing happens after this. As you said earlier in your mail, I am not
getting any PRINTK outputs from kernel on screen.

Can anybody help me to find out any other alternate ways to debug?

Thanks in advance,

Rajasekaran


On Fri, Mar 7, 2008 at 12:01 PM, Geoff Levand <geoffrey.levand@am.sony.com>
wrote:

> Hi,
>
> I maintain kexec for PS3, but have just done what was needed to
> make it work for kboot.  I am not a kexec expert, and have
> never tried to use kdump, or other features of kexec, only the
> things needed for kboot.
>
> On 03/06/2008 09:55 PM, Rajasekaran P wrote:
> >> On Thu, Mar 06, 2008 at 04:55:04PM +0530, Rajasekaran Periyasamy
> > wrote:
> >> > Hi,
> >> > I put a printk() in the early lines of early_parse_crashk() with
> >> > KERN_EMERG, but not able to see that on the boot screen. I think the
> >> > control is not transferred to early_parse_crashk() at all. With out
> > this
> >> > "crashkernel" argument, the same kernel boots up properly.
>
>
> This kind of thing is what kboot uses, and is known to work:
>
>  kexec -l -t elf-ppc64 --append=3D'root=3DXXX video=3DYYY' /boot/vmlinux.=
strip
>  kexec -e
>
> I recommend you get it to work first.
>
>
> >> Looks strange.
> >>
> >> Could you please include more debug printks in the function
> >> do_early_param in init/main.c to check whether early_parse_crashk is
> >> called or not?
>
>
> That won't work, since it is hanging before the video driver is up,
> and you'll never see those.
>
>
> > I've tried, but no result... Please have a look at the snapshot of boot
> > process.
> >
> > I think the kernel is not at all getting initiated to boot up.
>
>
> Your photo shows that the first stage kernel has gone down, and it
> hung up either very late going down, or early coming back up in the
> second stage.
>
>
> > Whatever you see in the snapshot,
> > 1. "Modified cmdline:" is from
> > "kexec-tools-1.101/kexec/arch/ppc64/fs2dt.c" putnode() function,
>
>
> I guess that version of exec-tools (kexec-tools-1.101) may be too old,
> and doesn't have the bug-fixes I needed to make to kexec-tools for it
> to work with PS3.  Those fixes were merged into kexec-tools several
> month ago.
>
> I recommend you try with an up-to-date kexec from here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-
> tools-testing.git
>
> I have tested both 32 and 64 bit builds.
>
> I also recommend to start with a known good second stage kernel.
> I tested Linux 2.6.25-rc4 built with ps3_defconfig and it works.
> Do not use an initrd at first try.
>
> -Geoff
>
>

------=_Part_855_17164295.1205231153363
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Geoff,<br>Thanks for your information.<br><br>I used latest kexec tools =
with 2.6.23 kernel built with ps3_defconfig. <br>This kernel boots normally=
 on PS3. But when I&nbsp; add &quot;crashkernel&quot; argument, it goes on =
hang. <br>
<br><br>Please have a look at the following command outputs:<br><div>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;"># kexec -v</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">kexec-tools-testing 20080227 released 27th February 2008</=
span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">&nbsp;</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;"># kexec --command-line=3D&quot;video=3Dps3fb:mode:166 rhgb
root=3D/dev/ps3da3 &quot; \</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;" lang=3D"NL">--initrd=3D/boot/initrd-2.6.23.img \</span></f=
ont></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;" lang=3D"NL">-l /boot/vmlinux-2.6.23</span></font></p><p><f=
ont face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-family=
: Verdana;" lang=3D"NL"># kexec -e<br>
</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">&nbsp;&gt;&gt;&gt;&gt; THIS WORKS FINE, I MEAN, THE NEW KE=
RNEL IS BOOTING UP WITH GUI (FC8)</span></font></p><p><font face=3D"Verdana=
" size=3D"2"><span style=3D"font-size: 10pt; font-family: Verdana;"><br>
</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;"># kexec --command-line=3D&quot;video=3Dps3fb:mode:166 rhgb
root=3D/dev/ps3da3 crashkernel=3D128M@32M&quot; \</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;" lang=3D"NL">--initrd=3D/boot/initrd-2.6.23.img \</span></f=
ont></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;" lang=3D"NL">-l /boot/vmlinux-2.6.23</span></font></p>



<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">&nbsp;<br>get memory ranges:1</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">Modified cmdline:video=3Dps3fb:mode:166 rhgb root=3D/dev/p=
s3da3
crashkernel=3D128M@32M</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">segment[0].mem:0x586000 memsz:5787648</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">segment[1].mem:0xb0b000 memsz:36864</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;" lang=3D"NL">segment[2].mem:0xb14000 memsz:3469312</span></=
font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;" lang=3D"NL">segment[3].mem:0x7fff000 memsz:4096</span></fo=
nt></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;" lang=3D"NL">&nbsp;</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;"># umount =96a</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">umount: /: device is busy</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;"># taskset 1 kexec =96e</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">&nbsp;</span></font></p><p><font face=3D"Verdana" size=3D"=
2"><span style=3D"font-size: 10pt; font-family: Verdana;">Nothing happens a=
fter this. As you said earlier in your mail, I am not getting any PRINTK ou=
tputs from kernel on screen.<br>
</span></font></p>

<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">Can anybody help me to find out any other alternate ways t=
o debug?</span></font></p><p><font face=3D"Verdana" size=3D"2"><span style=
=3D"font-size: 10pt; font-family: Verdana;">Thanks in advance,</span></font=
></p>
<p><font face=3D"Verdana" size=3D"2"><span style=3D"font-size: 10pt; font-f=
amily: Verdana;">Rajasekaran<br></span></font></p></div><br><br><div class=
=3D"gmail_quote">On Fri, Mar 7, 2008 at 12:01 PM, Geoff Levand &lt;<a href=
=3D"mailto:geoffrey.levand@am.sony.com">geoffrey.levand@am.sony.com</a>&gt;=
 wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<br>
I maintain kexec for PS3, but have just done what was needed to<br>
make it work for kboot. &nbsp;I am not a kexec expert, and have<br>
never tried to use kdump, or other features of kexec, only the<br>
things needed for kboot.<br>
<div class=3D"Ih2E3d"><br>
On 03/06/2008 09:55 PM, Rajasekaran P wrote:<br>
&gt;&gt; On Thu, Mar 06, 2008 at 04:55:04PM +0530, Rajasekaran Periyasamy<b=
r>
&gt; wrote:<br>
&gt;&gt; &gt; Hi,<br>
&gt;&gt; &gt; I put a printk() in the early lines of early_parse_crashk() w=
ith<br>
&gt;&gt; &gt; KERN_EMERG, but not able to see that on the boot screen. I th=
ink the<br>
&gt;&gt; &gt; control is not transferred to early_parse_crashk() at all. Wi=
th out<br>
&gt; this<br>
&gt;&gt; &gt; &quot;crashkernel&quot; argument, the same kernel boots up pr=
operly.<br>
<br>
<br>
</div>This kind of thing is what kboot uses, and is known to work:<br>
<br>
 &nbsp;kexec -l -t elf-ppc64 --append=3D&#39;root=3DXXX video=3DYYY&#39; /b=
oot/vmlinux.strip<br>
 &nbsp;kexec -e<br>
<br>
I recommend you get it to work first.<br>
<div class=3D"Ih2E3d"><br>
<br>
&gt;&gt; Looks strange.<br>
&gt;&gt;<br>
&gt;&gt; Could you please include more debug printks in the function<br>
&gt;&gt; do_early_param in init/main.c to check whether early_parse_crashk =
is<br>
&gt;&gt; called or not?<br>
<br>
<br>
</div>That won&#39;t work, since it is hanging before the video driver is u=
p,<br>
and you&#39;ll never see those.<br>
<div class=3D"Ih2E3d"><br>
<br>
&gt; I&#39;ve tried, but no result... Please have a look at the snapshot of=
 boot<br>
&gt; process.<br>
&gt;<br>
&gt; I think the kernel is not at all getting initiated to boot up.<br>
<br>
<br>
</div>Your photo shows that the first stage kernel has gone down, and it<br=
>
hung up either very late going down, or early coming back up in the<br>
second stage.<br>
<div class=3D"Ih2E3d"><br>
<br>
&gt; Whatever you see in the snapshot,<br>
&gt; 1. &quot;Modified cmdline:&quot; is from<br>
&gt; &quot;kexec-tools-1.101/kexec/arch/ppc64/fs2dt.c&quot; putnode() funct=
ion,<br>
<br>
<br>
</div>I guess that version of exec-tools (kexec-tools-1.101) may be too old=
,<br>
and doesn&#39;t have the bug-fixes I needed to make to kexec-tools for it<b=
r>
to work with PS3. &nbsp;Those fixes were merged into kexec-tools several<br=
>
month ago.<br>
<br>
I recommend you try with an up-to-date kexec from here:<br>
<br>
git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git=
<br>
<br>
I have tested both 32 and 64 bit builds.<br>
<br>
I also recommend to start with a known good second stage kernel.<br>
I tested Linux 2.6.25-rc4 built with ps3_defconfig and it works.<br>
Do not use an initrd at first try.<br>
<font color=3D"#888888"><br>
-Geoff<br>
<br>
</font></blockquote></div><br>

------=_Part_855_17164295.1205231153363--


--===============1763143013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1763143013==--

