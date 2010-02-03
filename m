Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lion.reldata.com ([209.123.188.11] helo=reldata.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NcmeF-0004NG-Dm
	for kexec@lists.infradead.org; Wed, 03 Feb 2010 21:20:35 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: problems in loading capture kernel
Date: Wed, 3 Feb 2010 15:55:40 -0500
Message-ID: <32AB6BC050DF9E4E91868C4C3B7B6ABBAE09BE@lion.reldatainc.local>
In-Reply-To: <20100203205008.GD17059@redhat.com>
References: <32AB6BC050DF9E4E91868C4C3B7B6ABBAE09A5@lion.reldatainc.local>
	<20100203202510.GC17059@redhat.com>
	<32AB6BC050DF9E4E91868C4C3B7B6ABBAE09B6@lion.reldatainc.local>
	<20100203205008.GD17059@redhat.com>
From: "Soumendu Satapathy" <soumendu.satapathy@reldata.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

cat /proc/iomem

00000000-0009b3ff : System RAM
0009b400-0009ffff : reserved
000e4000-000fffff : reserved
00100000-cff6ffff : System RAM
  00200000-006f0557 : Kernel code
  006f0558-009b9b3f : Kernel data
  00be2000-01219ea7 : Kernel bss
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

I don't see a crashkernel entry in the above. Perhaps that might be the
issue.


Thanks
Soumendu

-----Original Message-----
From: Vivek Goyal [mailto:vgoyal@redhat.com] 
Sent: Wednesday, February 03, 2010 3:50 PM
To: Soumendu Satapathy
Cc: Kexec Mailing List
Subject: Re: problems in loading capture kernel

On Wed, Feb 03, 2010 at 03:41:25PM -0500, Soumendu Satapathy wrote:

> Oh! I am sorry. That's not an issue, I just did some trace to check
the
> errno. The errno = 99 which is invalid address.
> 
> 
> - Have you reserved the space for second kernel?
> 
> Yes, I have reserved with the boot parameters. crashkernel=64M@16M
> 
> 
> - Have you compiled kernel as relocatable one or built a second kernel
>   and trying to load vmlinux.
> CONFIG_KEXEC=y
> CONFIG_CRASH_DUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_RELOCATABLE=y
> CONFIG_PHYSICAL_ALIGN=0x200000
> 

Please do not exclude kexec mailing list from CC. Adding it again.

Can you paste your `cat /proc/iomem` output and make sure space for
crash
kernel has been reserved.

Thanks
Vivek

> I have used the above config option for the capture kernel . Compiled
> and build it. And was trying to pre-load it using the following
command.
> kexec -p  /boot/vmlinuz-2.6.27_capturekernel03feb
> --initrd=/boot/initrd-2.6.27.img  --append="root=/dev/nfs
> nfsroot=192.168.101.3:/FILESYSTEMS/nfs-roots/root-55 ip=dhcp selinux=0
> 1  irqpoll  maxcpus=1  reset_devices"
> 
> 
> - What was the last working version or setup of kdump in your
> environment.
> 
> Kdump worked well in my environment with a vanilla kernel (2.6.18).
The
> one that I am using now is a Fedora core 2.6.27 and it is somehow
> failing with it.
> 
> 
> Thanks
> Soumendu
> 
> -----Original Message-----
> From: Vivek Goyal [mailto:vgoyal@redhat.com] 
> Sent: Wednesday, February 03, 2010 3:25 PM
> To: Soumendu Satapathy
> Cc: Kexec Mailing List
> Subject: Re: problems in loading capture kernel
> 
> On Wed, Feb 03, 2010 at 02:46:53PM -0500, Soumendu Satapathy wrote:
> > Hi Vivek ,
> > 
> >  
> > 
> > I am having some problems to load the capture kernel.
> > 
> >  
> > 
> > The following is the error. I am using a x86_64 box. I am using
2.6.27
> > linux kernel for both the first kernel and the capture kernel. The
> > capture kenel I have configured with CONFIG_SMP=n.
> > 
> > maxcpus=1.
> > 
> >  
> > 
> > kexec_load failed: Cannot assign requested address  99
> > 
> 
> This looks little odd. Where is this address "99" coming from?
> 
> Few things.
> 
> - Have you reserved the space for second kernel?
> - Have you compiled kernel as relocatable one or built a second kernel
>   and trying to load vmlinux.
> - What was the last working version or setup of kdump in your
> environment.
> 
> I would begin at running gdb at kexec to figure out where this
seemingly
> bad address "99" coming from.
> 
> CCing kexec mailing list, in case somebody has seen similar message.
> 
> Thanks
> Vivek
> 
> > entry       = 0x92550 flags = 1
> > 
> > nr_segments = 4
> > 
> > segment[0].buf   = 0xb75b40
> > 
> > segment[0].bufsz = 2e77
> > 
> > segment[0].mem   = 0x8f000
> > 
> > segment[0].memsz = 3000
> > 
> > segment[1].buf   = 0xb6e8d0
> > 
> > segment[1].bufsz = 7100
> > 
> > segment[1].mem   = 0x92000
> > 
> > segment[1].memsz = 9000
> > 
> > segment[2].buf   = 0x7f5aab6c4e10
> > 
> > segment[2].bufsz = 3159d0
> > 
> > segment[2].mem   = 0x100000
> > 
> > segment[2].memsz = 316000
> > 
> > segment[3].buf   = 0x7f5aabd6c010
> > 
> > segment[3].bufsz = 13b153
> > 
> > segment[3].mem   = 0x7fec4000
> > 
> > segment[3].memsz = 13c000
> > 
> >  
> > 
> >  
> > 
> > Can you please provide some inputs ?
> > 
> >  
> > 
> > thanks
> > 
> > Soumendu S Satapathy
> > 
> > Senior Software Developer
> > 
> > RELDATA Inc.
> > 
> > 1719 Route 10, Suite 209
> > 
> > Parsippany, NJ 07054
> > 
> > (973) 644-2770  ext. 139  office
> > 
> > 732-692-7230 mobile
> > 
> > (973) 644-3385 fax
> > 
> > soumendu.satapathy@reldata.com
> > 
> > www.reldata.com <http://www.reldata.com/> 
> > 
> >  
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
