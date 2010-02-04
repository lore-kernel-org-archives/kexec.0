Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
In-Reply-To: <32AB6BC050DF9E4E91868C4C3B7B6ABBAE09CE@lion.reldatainc.local>
References: <32AB6BC050DF9E4E91868C4C3B7B6ABBAE09A5@lion.reldatainc.local>	<20100203202510.GC17059@redhat.com>
	<32AB6BC050DF9E4E91868C4C3B7B6ABBAE09B6@lion.reldatainc.local>	<20100203205008.GD17059@redhat.com>
	<32AB6BC050DF9E4E91868C4C3B7B6ABBAE09BE@lion.reldatainc.local>	<20100203211759.GE17059@redhat.com>
	<32AB6BC050DF9E4E91868C4C3B7B6ABBAE09CE@lion.reldatainc.local>
MIME-Version: 1.0
Subject: RE: problems in loading capture kernel
Message-ID: <OF67C05ED1.CE0DB28E-ON652576C0.00256FE8-652576C0.0027742F@tcs.com>
From: Chandan12 K <chandan12.k@tcs.com>
Date: Thu, 4 Feb 2010 12:40:56 +0530
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0387146527=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Soumendu Satapathy <soumendu.satapathy@reldata.com>
Cc: kexec-bounces@lists.infradead.org, Kexec Mailing List <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

This is a multipart message in MIME format.
--===============0387146527==
Content-Type: multipart/alternative; boundary="=_alternative 0027742E652576C0_="

This is a multipart message in MIME format.
--=_alternative 0027742E652576C0_=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"

Hi Soumendu,


I also had similar issue, but my problem got solved once I looked across 
the memory layout of the BIOS. example you may have 8G of memory on system 
but there exists some memory area where can't be user by the kernel (they 
are generally reserved for some ACPI data or some other firmware data).

So, kindly do check that BIOS memory layout and allocate the memory 
address for capture kernel from the available memory.

For example in my system it looks like 

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c000 (usable)
 BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bf3a1000 (usable)
 BIOS-e820: 00000000bf3a1000 - 00000000bf3c2000 (ACPI NVS)
 BIOS-e820: 00000000bf3c2000 - 00000000bf3c3000 (ACPI data)
 BIOS-e820: 00000000bf3c3000 - 00000000bf3d6000 (reserved)
 BIOS-e820: 00000000bf3d6000 - 00000000bf3d7000 (ACPI NVS)
 BIOS-e820: 00000000bf3d7000 - 00000000bf3e8000 (reserved)
 BIOS-e820: 00000000bf3e8000 - 00000000bf3eb000 (ACPI NVS)
 BIOS-e820: 00000000bf3eb000 - 00000000bf449000 (reserved)
 BIOS-e820: 00000000bf449000 - 00000000bf44b000 (ACPI data)
 BIOS-e820: 00000000bf44b000 - 00000000bf44c000 (ACPI NVS)
 BIOS-e820: 00000000bf44c000 - 00000000bf456000 (ACPI data)
 BIOS-e820: 00000000bf456000 - 00000000bf45f000 (ACPI NVS)
 BIOS-e820: 00000000bf45f000 - 00000000bf47e000 (reserved)
 BIOS-e820: 00000000bf47e000 - 00000000bf681000 (ACPI NVS)
 BIOS-e820: 00000000bf681000 - 00000000bf800000 (usable)
 BIOS-e820: 00000000c0000000 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000240000000 (usable)

Here I can see various memory areas which are already reserved and can't 
be used. So, if you can get similar memory map (during bootup) and 
allocate the address to the "usable" one, probably it may help you to 
jettison your capture kernel loading issue. 

Thanks
Chandan 




From:
"Soumendu Satapathy" <soumendu.satapathy@reldata.com>
To:
"Vivek Goyal" <vgoyal@redhat.com>
Cc:
Kexec Mailing List <kexec@lists.infradead.org>
Date:
02/04/2010 03:38 AM
Subject:
RE: problems in loading capture kernel
Sent by:
kexec-bounces@lists.infradead.org



cat /proc/iomem | grep -i crash
  02000000-05ffffff : Crash kernel

I reserve memory now at 32M.  I can see the entry in /proc/iomem. But
the problem still persists. Perhaps kexec_load() is not loading into the

available reserved memory somehow.

kexec_load failed: Cannot assign requested address
entry       = 0x92550 flags = 1
nr_segments = 4
segment[0].buf   = 0x8eeb40
segment[0].bufsz = 2e4d
segment[0].mem   = 0x8f000
segment[0].memsz = 3000
segment[1].buf   = 0x8e78d0
segment[1].bufsz = 7100
segment[1].mem   = 0x92000
segment[1].memsz = 9000
segment[2].buf   = 0x7f7d32395e10
segment[2].bufsz = 3159f0
segment[2].mem   = 0x100000
segment[2].memsz = 316000
segment[3].buf   = 0x7f7d32a3d010
segment[3].bufsz = 13b165
segment[3].mem   = 0x7fec4000
segment[3].memsz = 13c000


Thanks
Soumendu

-----Original Message-----
From: Vivek Goyal [mailto:vgoyal@redhat.com] 
Sent: Wednesday, February 03, 2010 4:18 PM
To: Soumendu Satapathy
Cc: Kexec Mailing List
Subject: Re: problems in loading capture kernel

On Wed, Feb 03, 2010 at 03:55:40PM -0500, Soumendu Satapathy wrote:
> cat /proc/iomem
> 
> 00000000-0009b3ff : System RAM
> 0009b400-0009ffff : reserved
> 000e4000-000fffff : reserved
> 00100000-cff6ffff : System RAM
>   00200000-006f0557 : Kernel code
>   006f0558-009b9b3f : Kernel data
>   00be2000-01219ea7 : Kernel bss

[..]
> 100000000-22fffffff : System RAM
> 
> I don't see a crashkernel entry in the above. Perhaps that might be
the
> issue.

Yes.

00be2000-01219ea7 : Kernel bss

You are trying to reserve memory starting at 16MB (0x1000000) and that
area has been claimed by kernel bss reigon. Try reserving memory at
some other address, say 32MB (crashkernel=64M@32M).

Vivek

> 
> 
> Thanks
> Soumendu
> 
> -----Original Message-----
> From: Vivek Goyal [mailto:vgoyal@redhat.com] 
> Sent: Wednesday, February 03, 2010 3:50 PM
> To: Soumendu Satapathy
> Cc: Kexec Mailing List
> Subject: Re: problems in loading capture kernel
> 
> On Wed, Feb 03, 2010 at 03:41:25PM -0500, Soumendu Satapathy wrote:
> 
> > Oh! I am sorry. That's not an issue, I just did some trace to check
> the
> > errno. The errno = 99 which is invalid address.
> > 
> > 
> > - Have you reserved the space for second kernel?
> > 
> > Yes, I have reserved with the boot parameters. crashkernel=64M@16M
> > 
> > 
> > - Have you compiled kernel as relocatable one or built a second
kernel
> >   and trying to load vmlinux.
> > CONFIG_KEXEC=y
> > CONFIG_CRASH_DUMP=y
> > CONFIG_PHYSICAL_START=0x1000000
> > CONFIG_RELOCATABLE=y
> > CONFIG_PHYSICAL_ALIGN=0x200000
> > 
> 
> Please do not exclude kexec mailing list from CC. Adding it again.
> 
> Can you paste your `cat /proc/iomem` output and make sure space for
> crash
> kernel has been reserved.
> 
> Thanks
> Vivek
> 
> > I have used the above config option for the capture kernel .
Compiled
> > and build it. And was trying to pre-load it using the following
> command.
> > kexec -p  /boot/vmlinuz-2.6.27_capturekernel03feb
> > --initrd=/boot/initrd-2.6.27.img  --append="root=/dev/nfs
> > nfsroot=192.168.101.3:/FILESYSTEMS/nfs-roots/root-55 ip=dhcp
selinux=0
> > 1  irqpoll  maxcpus=1  reset_devices"
> > 
> > 
> > - What was the last working version or setup of kdump in your
> > environment.
> > 
> > Kdump worked well in my environment with a vanilla kernel (2.6.18).
> The
> > one that I am using now is a Fedora core 2.6.27 and it is somehow
> > failing with it.
> > 
> > 
> > Thanks
> > Soumendu
> > 
> > -----Original Message-----
> > From: Vivek Goyal [mailto:vgoyal@redhat.com] 
> > Sent: Wednesday, February 03, 2010 3:25 PM
> > To: Soumendu Satapathy
> > Cc: Kexec Mailing List
> > Subject: Re: problems in loading capture kernel
> > 
> > On Wed, Feb 03, 2010 at 02:46:53PM -0500, Soumendu Satapathy wrote:
> > > Hi Vivek ,
> > > 
> > > 
> > > 
> > > I am having some problems to load the capture kernel.
> > > 
> > > 
> > > 
> > > The following is the error. I am using a x86_64 box. I am using
> 2.6.27
> > > linux kernel for both the first kernel and the capture kernel. The
> > > capture kenel I have configured with CONFIG_SMP=n.
> > > 
> > > maxcpus=1.
> > > 
> > > 
> > > 
> > > kexec_load failed: Cannot assign requested address  99
> > > 
> > 
> > This looks little odd. Where is this address "99" coming from?
> > 
> > Few things.
> > 
> > - Have you reserved the space for second kernel?
> > - Have you compiled kernel as relocatable one or built a second
kernel
> >   and trying to load vmlinux.
> > - What was the last working version or setup of kdump in your
> > environment.
> > 
> > I would begin at running gdb at kexec to figure out where this
> seemingly
> > bad address "99" coming from.
> > 
> > CCing kexec mailing list, in case somebody has seen similar message.
> > 
> > Thanks
> > Vivek
> > 
> > > entry       = 0x92550 flags = 1
> > > 
> > > nr_segments = 4
> > > 
> > > segment[0].buf   = 0xb75b40
> > > 
> > > segment[0].bufsz = 2e77
> > > 
> > > segment[0].mem   = 0x8f000
> > > 
> > > segment[0].memsz = 3000
> > > 
> > > segment[1].buf   = 0xb6e8d0
> > > 
> > > segment[1].bufsz = 7100
> > > 
> > > segment[1].mem   = 0x92000
> > > 
> > > segment[1].memsz = 9000
> > > 
> > > segment[2].buf   = 0x7f5aab6c4e10
> > > 
> > > segment[2].bufsz = 3159d0
> > > 
> > > segment[2].mem   = 0x100000
> > > 
> > > segment[2].memsz = 316000
> > > 
> > > segment[3].buf   = 0x7f5aabd6c010
> > > 
> > > segment[3].bufsz = 13b153
> > > 
> > > segment[3].mem   = 0x7fec4000
> > > 
> > > segment[3].memsz = 13c000
> > > 
> > > 
> > > 
> > > 
> > > 
> > > Can you please provide some inputs ?
> > > 
> > > 
> > > 
> > > thanks
> > > 
> > > Soumendu S Satapathy
> > > 
> > > Senior Software Developer
> > > 
> > > RELDATA Inc.
> > > 
> > > 1719 Route 10, Suite 209
> > > 
> > > Parsippany, NJ 07054
> > > 
> > > (973) 644-2770  ext. 139  office
> > > 
> > > 732-692-7230 mobile
> > > 
> > > (973) 644-3385 fax
> > > 
> > > soumendu.satapathy@reldata.com
> > > 
> > > www.reldata.com <http://www.reldata.com/> 
> > > 
> > > 
> > > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec


=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you



--=_alternative 0027742E652576C0_=
Content-Transfer-Encoding: 7bit
Content-Type: text/html; charset="us-ascii"


<br><font size=2 face="sans-serif">Hi Soumendu,</font>
<br>
<br>
<br><font size=2 face="sans-serif">I also had similar issue, but my problem
got solved once I looked across the memory layout of the BIOS. example
you may have 8G of memory on system but there exists some memory area where
can't be user by the kernel (they are generally reserved for some ACPI
data or some other firmware data).</font>
<br>
<br><font size=2 face="sans-serif">So, kindly do check that BIOS memory
layout and allocate the memory address for capture kernel from the available
memory.</font>
<br>
<br><font size=2 face="sans-serif">For example in my system it looks like
</font>
<br>
<br><font size=2 face="sans-serif">BIOS-provided physical RAM map:</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 0000000000000000 -
000000000009c000 (usable)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 000000000009c000 -
00000000000a0000 (reserved)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000000e0000 -
0000000000100000 (reserved)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 0000000000100000 -
00000000bf3a1000 (usable)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf3a1000 -
00000000bf3c2000 (ACPI NVS)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf3c2000 -
00000000bf3c3000 (ACPI data)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf3c3000 -
00000000bf3d6000 (reserved)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf3d6000 -
00000000bf3d7000 (ACPI NVS)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf3d7000 -
00000000bf3e8000 (reserved)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf3e8000 -
00000000bf3eb000 (ACPI NVS)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf3eb000 -
00000000bf449000 (reserved)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf449000 -
00000000bf44b000 (ACPI data)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf44b000 -
00000000bf44c000 (ACPI NVS)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf44c000 -
00000000bf456000 (ACPI data)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf456000 -
00000000bf45f000 (ACPI NVS)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf45f000 -
00000000bf47e000 (reserved)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf47e000 -
00000000bf681000 (ACPI NVS)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000bf681000 -
00000000bf800000 (usable)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000c0000000 -
00000000d0000000 (reserved)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000fed1c000 -
00000000fed20000 (reserved)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 00000000ff000000 -
0000000100000000 (reserved)</font>
<br><font size=2 face="sans-serif">&nbsp;BIOS-e820: 0000000100000000 -
0000000240000000 (usable)</font>
<br>
<br><font size=2 face="sans-serif">Here I can see various memory areas
which are already reserved and can't be used. So, if you can get similar
memory map (during bootup) and allocate the address to the &quot;usable&quot;
one, probably it may help you to jettison your capture kernel loading issue.
</font>
<br>
<br><font size=2 face="sans-serif">Thanks<br>
Chandan <br>
</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">From:</font>
<td><font size=1 face="sans-serif">&quot;Soumendu Satapathy&quot; &lt;soumendu.satapathy@reldata.com&gt;</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">To:</font>
<td><font size=1 face="sans-serif">&quot;Vivek Goyal&quot; &lt;vgoyal@redhat.com&gt;</font>
<tr>
<td valign=top><font size=1 color=#5f5f5f face="sans-serif">Cc:</font>
<td><font size=1 face="sans-serif">Kexec Mailing List &lt;kexec@lists.infradead.org&gt;</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">Date:</font>
<td><font size=1 face="sans-serif">02/04/2010 03:38 AM</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">Subject:</font>
<td><font size=1 face="sans-serif">RE: problems in loading capture kernel</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">Sent by:</font>
<td><font size=1 face="sans-serif">kexec-bounces@lists.infradead.org</font></table>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>cat /proc/iomem | grep -i crash<br>
 &nbsp;02000000-05ffffff : Crash kernel<br>
<br>
I reserve memory now at 32M. &nbsp;I can see the entry in /proc/iomem.
But<br>
the problem still persists. Perhaps kexec_load() is not loading into the<br>
<br>
available reserved memory somehow.<br>
<br>
kexec_load failed: Cannot assign requested address<br>
entry &nbsp; &nbsp; &nbsp; = 0x92550 flags = 1<br>
nr_segments = 4<br>
segment[0].buf &nbsp; = 0x8eeb40<br>
segment[0].bufsz = 2e4d<br>
segment[0].mem &nbsp; = 0x8f000<br>
segment[0].memsz = 3000<br>
segment[1].buf &nbsp; = 0x8e78d0<br>
segment[1].bufsz = 7100<br>
segment[1].mem &nbsp; = 0x92000<br>
segment[1].memsz = 9000<br>
segment[2].buf &nbsp; = 0x7f7d32395e10<br>
segment[2].bufsz = 3159f0<br>
segment[2].mem &nbsp; = 0x100000<br>
segment[2].memsz = 316000<br>
segment[3].buf &nbsp; = 0x7f7d32a3d010<br>
segment[3].bufsz = 13b165<br>
segment[3].mem &nbsp; = 0x7fec4000<br>
segment[3].memsz = 13c000<br>
<br>
<br>
Thanks<br>
Soumendu<br>
<br>
-----Original Message-----<br>
From: Vivek Goyal [</font></tt><a href=mailto:vgoyal@redhat.com><tt><font size=2>mailto:vgoyal@redhat.com</font></tt></a><tt><font size=2>]
<br>
Sent: Wednesday, February 03, 2010 4:18 PM<br>
To: Soumendu Satapathy<br>
Cc: Kexec Mailing List<br>
Subject: Re: problems in loading capture kernel<br>
<br>
On Wed, Feb 03, 2010 at 03:55:40PM -0500, Soumendu Satapathy wrote:<br>
&gt; cat /proc/iomem<br>
&gt; <br>
&gt; 00000000-0009b3ff : System RAM<br>
&gt; 0009b400-0009ffff : reserved<br>
&gt; 000e4000-000fffff : reserved<br>
&gt; 00100000-cff6ffff : System RAM<br>
&gt; &nbsp; 00200000-006f0557 : Kernel code<br>
&gt; &nbsp; 006f0558-009b9b3f : Kernel data<br>
&gt; &nbsp; 00be2000-01219ea7 : Kernel bss<br>
<br>
[..]<br>
&gt; 100000000-22fffffff : System RAM<br>
&gt; <br>
&gt; I don't see a crashkernel entry in the above. Perhaps that might be<br>
the<br>
&gt; issue.<br>
<br>
Yes.<br>
<br>
00be2000-01219ea7 : Kernel bss<br>
<br>
You are trying to reserve memory starting at 16MB (0x1000000) and that<br>
area has been claimed by kernel bss reigon. Try reserving memory at<br>
some other address, say 32MB (crashkernel=64M@32M).<br>
<br>
Vivek<br>
<br>
&gt; <br>
&gt; <br>
&gt; Thanks<br>
&gt; Soumendu<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Vivek Goyal [</font></tt><a href=mailto:vgoyal@redhat.com><tt><font size=2>mailto:vgoyal@redhat.com</font></tt></a><tt><font size=2>]
<br>
&gt; Sent: Wednesday, February 03, 2010 3:50 PM<br>
&gt; To: Soumendu Satapathy<br>
&gt; Cc: Kexec Mailing List<br>
&gt; Subject: Re: problems in loading capture kernel<br>
&gt; <br>
&gt; On Wed, Feb 03, 2010 at 03:41:25PM -0500, Soumendu Satapathy wrote:<br>
&gt; <br>
&gt; &gt; Oh! I am sorry. That's not an issue, I just did some trace to
check<br>
&gt; the<br>
&gt; &gt; errno. The errno = 99 which is invalid address.<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; - Have you reserved the space for second kernel?<br>
&gt; &gt; <br>
&gt; &gt; Yes, I have reserved with the boot parameters. crashkernel=64M@16M<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; - Have you compiled kernel as relocatable one or built a second<br>
kernel<br>
&gt; &gt; &nbsp; and trying to load vmlinux.<br>
&gt; &gt; CONFIG_KEXEC=y<br>
&gt; &gt; CONFIG_CRASH_DUMP=y<br>
&gt; &gt; CONFIG_PHYSICAL_START=0x1000000<br>
&gt; &gt; CONFIG_RELOCATABLE=y<br>
&gt; &gt; CONFIG_PHYSICAL_ALIGN=0x200000<br>
&gt; &gt; <br>
&gt; <br>
&gt; Please do not exclude kexec mailing list from CC. Adding it again.<br>
&gt; <br>
&gt; Can you paste your `cat /proc/iomem` output and make sure space for<br>
&gt; crash<br>
&gt; kernel has been reserved.<br>
&gt; <br>
&gt; Thanks<br>
&gt; Vivek<br>
&gt; <br>
&gt; &gt; I have used the above config option for the capture kernel .<br>
Compiled<br>
&gt; &gt; and build it. And was trying to pre-load it using the following<br>
&gt; command.<br>
&gt; &gt; kexec -p &nbsp;/boot/vmlinuz-2.6.27_capturekernel03feb<br>
&gt; &gt; --initrd=/boot/initrd-2.6.27.img &nbsp;--append=&quot;root=/dev/nfs<br>
&gt; &gt; nfsroot=192.168.101.3:/FILESYSTEMS/nfs-roots/root-55 ip=dhcp<br>
selinux=0<br>
&gt; &gt; 1 &nbsp;irqpoll &nbsp;maxcpus=1 &nbsp;reset_devices&quot;<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; - What was the last working version or setup of kdump in your<br>
&gt; &gt; environment.<br>
&gt; &gt; <br>
&gt; &gt; Kdump worked well in my environment with a vanilla kernel (2.6.18).<br>
&gt; The<br>
&gt; &gt; one that I am using now is a Fedora core 2.6.27 and it is somehow<br>
&gt; &gt; failing with it.<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Thanks<br>
&gt; &gt; Soumendu<br>
&gt; &gt; <br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: Vivek Goyal [</font></tt><a href=mailto:vgoyal@redhat.com><tt><font size=2>mailto:vgoyal@redhat.com</font></tt></a><tt><font size=2>]
<br>
&gt; &gt; Sent: Wednesday, February 03, 2010 3:25 PM<br>
&gt; &gt; To: Soumendu Satapathy<br>
&gt; &gt; Cc: Kexec Mailing List<br>
&gt; &gt; Subject: Re: problems in loading capture kernel<br>
&gt; &gt; <br>
&gt; &gt; On Wed, Feb 03, 2010 at 02:46:53PM -0500, Soumendu Satapathy
wrote:<br>
&gt; &gt; &gt; Hi Vivek ,<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &nbsp;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I am having some problems to load the capture kernel.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &nbsp;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The following is the error. I am using a x86_64 box. I am
using<br>
&gt; 2.6.27<br>
&gt; &gt; &gt; linux kernel for both the first kernel and the capture kernel.
The<br>
&gt; &gt; &gt; capture kenel I have configured with CONFIG_SMP=n.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; maxcpus=1.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &nbsp;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; kexec_load failed: Cannot assign requested address &nbsp;99<br>
&gt; &gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; This looks little odd. Where is this address &quot;99&quot; coming
from?<br>
&gt; &gt; <br>
&gt; &gt; Few things.<br>
&gt; &gt; <br>
&gt; &gt; - Have you reserved the space for second kernel?<br>
&gt; &gt; - Have you compiled kernel as relocatable one or built a second<br>
kernel<br>
&gt; &gt; &nbsp; and trying to load vmlinux.<br>
&gt; &gt; - What was the last working version or setup of kdump in your<br>
&gt; &gt; environment.<br>
&gt; &gt; <br>
&gt; &gt; I would begin at running gdb at kexec to figure out where this<br>
&gt; seemingly<br>
&gt; &gt; bad address &quot;99&quot; coming from.<br>
&gt; &gt; <br>
&gt; &gt; CCing kexec mailing list, in case somebody has seen similar message.<br>
&gt; &gt; <br>
&gt; &gt; Thanks<br>
&gt; &gt; Vivek<br>
&gt; &gt; <br>
&gt; &gt; &gt; entry &nbsp; &nbsp; &nbsp; = 0x92550 flags = 1<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; nr_segments = 4<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[0].buf &nbsp; = 0xb75b40<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[0].bufsz = 2e77<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[0].mem &nbsp; = 0x8f000<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[0].memsz = 3000<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[1].buf &nbsp; = 0xb6e8d0<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[1].bufsz = 7100<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[1].mem &nbsp; = 0x92000<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[1].memsz = 9000<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[2].buf &nbsp; = 0x7f5aab6c4e10<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[2].bufsz = 3159d0<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[2].mem &nbsp; = 0x100000<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[2].memsz = 316000<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[3].buf &nbsp; = 0x7f5aabd6c010<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[3].bufsz = 13b153<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[3].mem &nbsp; = 0x7fec4000<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; segment[3].memsz = 13c000<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &nbsp;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &nbsp;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Can you please provide some inputs ?<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &nbsp;<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; thanks<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Soumendu S Satapathy<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Senior Software Developer<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; RELDATA Inc.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; 1719 Route 10, Suite 209<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Parsippany, NJ 07054<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; (973) 644-2770 &nbsp;ext. 139 &nbsp;office<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; 732-692-7230 mobile<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; (973) 644-3385 fax<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; soumendu.satapathy@reldata.com<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; </font></tt><a href=www.reldata.com><tt><font size=2>www.reldata.com</font></tt></a><tt><font size=2>
&lt;</font></tt><a href=http://www.reldata.com/><tt><font size=2>http://www.reldata.com/</font></tt></a><tt><font size=2>&gt;
<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; &nbsp;<br>
&gt; &gt; &gt; <br>
<br>
_______________________________________________<br>
kexec mailing list<br>
kexec@lists.infradead.org<br>
</font></tt><a href=http://lists.infradead.org/mailman/listinfo/kexec><tt><font size=2>http://lists.infradead.org/mailman/listinfo/kexec</font></tt></a><tt><font size=2><br>
</font></tt>
<br>
<br><pre>=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you


</pre>
--=_alternative 0027742E652576C0_=--



--===============0387146527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0387146527==--


