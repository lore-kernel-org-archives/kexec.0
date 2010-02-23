Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lion.reldata.com ([209.123.188.11] helo=reldata.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nk3IO-00088H-3J
	for kexec@lists.infradead.org; Tue, 23 Feb 2010 22:32:04 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: FW: 2.6.18 Fedora core kernel gives: "Overlapping memorysegments
	at" error
Date: Tue, 23 Feb 2010 17:31:58 -0500
Message-ID: <32AB6BC050DF9E4E91868C4C3B7B6ABBB5694C@lion.reldatainc.local>
References: <32AB6BC050DF9E4E91868C4C3B7B6ABBB56926@lion.reldatainc.local>
	<20100223215032.GG11930@redhat.com> 
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
To: Soumendu Satapathy <soumendu.satapathy@reldata.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Well the Entry point in the readelf shows 0x2000100.  But the physical
start address that I specified in the .config file for the capture
kernel is CONFIG_PHYSICAL_START=0x2000000.

I am just wondering, could it be an issue ?

Thanks
Soumendu


-----Original Message-----
From: Soumendu Satapathy 
Sent: Tuesday, February 23, 2010 5:17 PM
To: 'Vivek Goyal'
Cc: Kexec Mailing List
Subject: RE: FW: 2.6.18 Fedora core kernel gives: "Overlapping
memorysegments at" error

$ readelf -l vmlinux

Elf file type is EXEC (Executable file)
Entry point 0x2000100
There are 4 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000200000 0xffffffff82000000
0x0000000002000000
                 0x0000000000658608 0x0000000000658608  R E    200000
  LOAD           0x0000000000859000 0xffffffff82659000
0x0000000002659000
                 0x0000000000111085 0x000000000019d6b0  RWE    200000
  LOAD           0x0000000000a00000 0xffffffffff600000
0x000000000272d000
                 0x0000000000000c08 0x0000000000000c08  RWE    200000
  NOTE           0x0000000000000000 0x0000000000000000
0x0000000000000000
                 0x0000000000000000 0x0000000000000000  R      8

 Section to Segment mapping:
  Segment Sections...
   00     .text __ex_table .rodata .pci_fixup __ksymtab __ksymtab_gpl
__ksymtab_gpl_future __kcrctab __kcrctab_gpl __kcrctab_gpl_future
__ksymtab_strings __param .eh_frame
   01     .data .data.cacheline_aligned .data.read_mostly
.data.init_task .data.page_aligned .init.text .init.data .init.setup
.initcall.init .con_initcall.init .security_initcall.init
.altinstructions .altinstr_replacement .exit.text .init.ramfs .bss
   02     .vsyscall_0 .xtime_lock .vxtime .wall_jiffies .sys_tz
.sysctl_vsyscall .xtime .jiffies .vsyscall_1 .vsyscall_2 .vsyscall_3
   03




I did two tests one with 2.6.27 x86_64 Fedora core and the other with
2.6.18 x86_64 Fedora core. I use kexec-tools-2.0.1 for all the tests.

With 2.6.27, I use the vmlinuz image as the first kernel. I make a
relocatable kernel by setting the required config options for the
capture kernel.
I use the same 2.6.27 kernel for both the first and the capture kernel.
In 2.6.27, the use vmlinuz image which I have made relocatable as a
capture kernel and I load it. It works fine. 


With 2,6,18, I use the vmlinuz image as the first kernel. I use the same
2.6.18 as the capture kernel. I don't find an option or config option
here to 
make the capture kernel as RELOCATABLE as I find a default config option
in 2.6.27 i.e CONFIG_RELOCATABLE=y. When I load the vmlinuz in this case
it complains of not being RELOCATABLE. So in 2.6.18, I use the vmlinux
image as the capture kernel and loads it. 

While loading the 2.6.18 vmlinux image ( the capture kernel ), it throws
the following error:-
 Overlapping memory segments at  0x27f7000

 "sort_segments failed"


I think if I could have used the vmlinuz image as the capture kernel in
case of 2.6.18, probably it will work. But since I am not able to make
that relocatable I had to use the vmlinux imgae as the capture kernel in
case of 2.6.18. 

How can I make the 2.6.18 kernel RELOCATABLE, is there a config option ?
if yes, please let me know and I will give it a try to see if the
problem persists or not. If not, then I am afraid there could be some
bug.

Thanks
Soumendu

-----Original Message-----
From: Vivek Goyal [mailto:vgoyal@redhat.com] 
Sent: Tuesday, February 23, 2010 4:51 PM
To: Soumendu Satapathy
Cc: Kexec Mailing List
Subject: Re: FW: 2.6.18 Fedora core kernel gives: "Overlapping
memorysegments at" error

On Tue, Feb 23, 2010 at 04:32:59PM -0500, Soumendu Satapathy wrote:
> Hi Vivek,
> 
>  
> 
> Is it a bug? Its works for 2.6.27 but fails for 2.6.18 kernel. However
I
> use the vmlinuz image as a capture kernel in case of 2.6.27 as it does
> not complain of relocatable kernel with it.
> 
>  
> 
> I am using a vmlinux kernel image to load as it complains  vmlinuz
image
> for not being relocatable in case of 2.6.18.
> 
>  
> 
> I get the following error:-
> 
>  
> 
> Overlapping memory segments at  0x27f7000
> 
> "sort_segments failed"
> 

Can you post the output of "readelf -l vmlinux" just curious if vmlinux
is reporting somehow overlappig memory segments. But you seem to be
suggesting that that same vmlinux works with older version of
kexec-tools?
If yes, then it sounds like we introduced some bug in newer version of
kexec-tools.

What is your environemnt? I mean what is your production kernel. Are you
running 2.6.18 as production kernel and trying out loading 2.6.27 and
2.6.18  as capture kernel, or you have 2.6.27 as production kernel and
trying out 2.6.27 and 2.6.18 as capture kernel. Not that it matters much
at this point of time, just curious.

So I would begin with trying to load 2.6.18 vmlinux with older version
of kexec-tools.

Is this 2.6.18 vmlinux relocatable?

Thanks
Vivek

>  
> 
>  
> 
> Thanks
> 
> Soumendu
> 
>  
> 
> From: Soumendu Satapathy 
> Sent: Tuesday, February 23, 2010 11:10 AM
> To: Kexec Mailing List
> Subject: 2.6.18 Fedora core kernel gives: "Overlapping memory segments
> at" error
> 
>  
> 
> This is my .config  for the capture kernel.
> 
>  
> 
> CONFIG_KEXEC=y
> 
> CONFIG_CRASH_DUMP=y
> 
> CONFIG_PHYSICAL_START=0x2000000
> 
>  
> 
> I use crashkernel=64M@32M.
> 
>  
> 
> Thanks
> 
> Soumendu
> 
>  
> 
> From: Soumendu Satapathy 
> Sent: Tuesday, February 23, 2010 11:07 AM
> To: Kexec Mailing List
> Subject: 2.6.18 Fedora core kernel gives: "Overlapping memory segments
> at" error
> 
>  
> 
> Hi there,
> 
>  
> 
> When I use a 2.6.27 Fedora core I am able to load a capture kernel
> properly and it boots when the first kernel crashes.
> 
> I am using a x86_64 platform and 2.6.27 Fedora core.
> 
>  
> 
> I use crashkernel=64M@32M.
> 
>  
> 
> But when I use a 2.6.18 in the same environment and settings as above,
I
> get the following error when I load a capture kernel:-
> 
>  
> 
> "Overlapping memory segments at"  error
> 
> "Sort segments failed"
> 
>  
> 
> I found that the kernel segments overlap when loading them in the 64M
> memory reserved for the capture kernel. My system memory is MemTotal:
> 8037944 kB
> 
>  
> 
> I am using kexec-tools-2.0.1 and the "cat /proc/iomem"  o/p is as
> follows.
> 
>  
> 
> 00000000-0009b3ff : System RAM
> 
> 0009b400-0009ffff : reserved
> 
> 000e4000-000fffff : reserved
> 
> 00100000-cff6ffff : System RAM
> 
>   00200000-006f0747 : Kernel code
> 
>   006f0748-009b9b3f : Kernel data
> 
>   00be2000-01219ea7 : Kernel bss
> 
>   02000000-05ffffff : Crash kernel
> 
> cff70000-cff77fff : ACPI Tables
> 
> cff78000-cff7ffff : ACPI Non-volatile Storage
> 
> cff80000-cfffffff : reserved
> 
> d1000000-d11fffff : PCI Bus 0000:01
> 
>   d1000000-d10fffff : PCI Bus 0000:02
> 
>     d1000000-d107ffff : 0000:02:03.0
> 
>     d1080000-d10fffff : 0000:02:03.1
> 
>   d1100000-d11fffff : PCI Bus 0000:03
> 
>     d1100000-d113ffff : 0000:03:02.0
> 
>     d1140000-d117ffff : 0000:03:02.1
> 
> d1200000-d12fffff : PCI Bus 0000:04
> 
>   d1200000-d12fffff : PCI Bus 0000:05
> 
>     d1200000-d120ffff : 0000:05:04.0
> 
> d1300000-d13fffff : PCI Bus 0000:06
> 
>   d1300000-d13fffff : PCI Bus 0000:07
> 
>     d1300000-d130ffff : 0000:07:04.0
> 
> d1400000-d14fffff : PCI Bus 0000:09
> 
>   d1400000-d141ffff : 0000:09:01.0
> 
> d1500000-d15003ff : 0000:00:1f.1
> 
> dd000000-dd000fff : 0000:00:01.0
> 
> dd001000-dd00100f : 0000:00:1d.4
> 
> dd001400-dd0017ff : 0000:00:1d.7
> 
>   dd001400-dd0017ff : ehci_hcd
> 
> dd100000-dd3fffff : PCI Bus 0000:01
> 
>   dd100000-dd100fff : 0000:01:00.1
> 
>   dd101000-dd101fff : 0000:01:00.3
> 
>   dd200000-dd2fffff : PCI Bus 0000:02
> 
>     dd200000-dd201fff : 0000:02:03.0
> 
>     dd202000-dd203fff : 0000:02:03.1
> 
>   dd300000-dd3fffff : PCI Bus 0000:03
> 
>     dd300000-dd300fff : 0000:03:02.0
> 
>     dd301000-dd301fff : 0000:03:02.1
> 
> dd400000-dd4fffff : PCI Bus 0000:04
> 
>   dd400000-dd4fffff : PCI Bus 0000:05
> 
>     dd400000-dd40ffff : 0000:05:04.0
> 
>       dd400000-dd40ffff : tg3
> 
>     dd410000-dd41ffff : 0000:05:04.0
> 
>       dd410000-dd41ffff : tg3
> 
>     dd420000-dd42ffff : 0000:05:04.1
> 
>       dd420000-dd42ffff : tg3
> 
>     dd430000-dd43ffff : 0000:05:04.1
> 
>       dd430000-dd43ffff : tg3
> 
> dd500000-dd5fffff : PCI Bus 0000:06
> 
>   dd500000-dd5fffff : PCI Bus 0000:07
> 
>     dd500000-dd50ffff : 0000:07:04.0
> 
>       dd500000-dd50ffff : tg3
> 
>     dd510000-dd51ffff : 0000:07:04.0
> 
>       dd510000-dd51ffff : tg3
> 
>     dd520000-dd52ffff : 0000:07:04.1
> 
>       dd520000-dd52ffff : tg3
> 
>     dd530000-dd53ffff : 0000:07:04.1
> 
>       dd530000-dd53ffff : tg3
> 
> dd600000-dd6fffff : PCI Bus 0000:08
> 
>   dd600000-dd61ffff : 0000:08:01.0
> 
>     dd600000-dd61ffff : e1000
> 
>   dd620000-dd63ffff : 0000:08:02.0
> 
>     dd620000-dd63ffff : e1000
> 
> dd700000-deffffff : PCI Bus 0000:09
> 
>   dd700000-dd700fff : 0000:09:01.0
> 
>   de000000-deffffff : 0000:09:01.0
> 
> e0000000-efffffff : PCI MMCONFIG 0
> 
>   e0000000-efffffff : reserved
> 
> fec00000-fec0ffff : reserved
> 
>   fec00000-fec00fff : IOAPIC 0
> 
> fec10000-fec10fff : IOAPIC 1
> 
> fec80000-fec80fff : IOAPIC 2
> 
> fee00000-fee00fff : Local APIC
> 
>   fee00000-fee00fff : reserved
> 
> ff800000-ffbfffff : reserved
> 
> fffffc00-ffffffff : reserved
> 
> 100000000-22fffffff : System RAM
> 
>  
> 
> Could it be a bug in the Kexec? 
> 
>  
> 
> thanks
> 
> Soumendu S Satapathy
> 
> Senior Software Developer
> 
> RELDATA Inc.
> 
> 1719 Route 10, Suite 209
> 
> Parsippany, NJ 07054
> 
> (973) 644-2770  ext. 139  office
> 
> 732-692-7230 mobile
> 
> (973) 644-3385 fax
> 
> soumendu.satapathy@reldata.com
> 
> www.reldata.com <http://www.reldata.com/> 
> 
>  
> 
>  
> 
>  
> 
> Soumendu S Satapathy
> 
> Senior Software Developer
> 
> RELDATA Inc.
> 
> 1719 Route 10, Suite 209
> 
> Parsippany, NJ 07054
> 
> (973) 644-2770  ext. 139  office
> 
> 732-692-7230 mobile
> 
> (973) 644-3385 fax
> 
> soumendu.satapathy@reldata.com
> 
> www.reldata.com <http://www.reldata.com/> 
> 
>  
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
