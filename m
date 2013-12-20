Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vu3nh-0002Kx-4O
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 17:23:50 +0000
Subject: Re: [PATCH] makedumpfile: memset() in cyclic bitmap initialization
 introduce segment fault
From: Lisa Mitchell <lisa.mitchell@hp.com>
In-Reply-To: <20131220141321.GA27063@redhat.com>
References: <20131218133402.GA23617@dhcp-17-89.nay.redhat.com>
 <52B39878.3030403@jp.fujitsu.com>  <20131220141321.GA27063@redhat.com>
Date: Fri, 20 Dec 2013 05:58:02 -0700
Message-ID: <1387544282.17054.80.camel@lisamlinux.fc.hp.com>
Mime-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

On Fri, 2013-12-20 at 14:13 +0000, Vivek Goyal wrote:
> On Fri, Dec 20, 2013 at 10:08:08AM +0900, HATAYAMA Daisuke wrote:
> 
> [..]
> > 
> > >cat /proc/iomem:
> > >00000000-00000fff : reserved
> > >00001000-0009ffff : System RAM
> > >000a0000-000bffff : PCI Bus 0000:00
> > >000f0000-000fffff : System ROM
> > >00100000-3d162017 : System RAM
> > >   01000000-015cab9b : Kernel code
> > >   015cab9c-019beb3f : Kernel data
> > >   01b4f000-01da9fff : Kernel bss
> > >   30000000-37ffffff : Crash kernel
> > >3d162018-3d171e57 : System RAM
> > >3d171e58-3d172017 : System RAM
> > >3d172018-3d17ae57 : System RAM
> > >3d17ae58-3dc10fff : System RAM
> > 
> > this part is consecutive but somehow is divided into 4 entries.
> > You called your environment as ``EFI virtual machine'', could you tell
> > me precisely what it mean? qemu/KVM or VMware guest system? I do want
> > to understand how this kind of memory map was created. I think this
> > kind of memory mapping is odd and I guess this is caused by the fact
> > that the system is a virtual environment.
> > 
> > And for Vivek, this case is a concrete example of multiple RAM entries
> > appearing in a single page I suspected in the mmap failure patch,
> > although these entries are consecutive in physical address and can be
> > represented by a single entry by merging them in a single entry. But
> > then it seems to me that there could be more odd case that multiple
> > RAM entries but not consecutive. I again think this should be addressed
> > in the patch for the mmap failure issue. How do you think?
> 
> Hi Hatayama,
> 
> This indeed looks very odd. See if a very small number of systems have it,
> the only thing we will do is allocate extra page in second kernel for
> a memory range. It will not make mmap() fail. So it is just a matter of
> optimization.
> 
> Given the fact I have not seen many systems with this anomaly, I am not
> too worried about it even if you don't this optimization in your patch
> series. We can always take care of it later if need be.
> 
> At the same time, if you feel strongly about it and want to fix it in
> same patch series, I don't mind.
> 
> Thanks
> Vivek

Did I get this same segmentation fault?   It happened a few times on a
3.10 based kernel on a large EFI based system , but then hasn't repeated
in further testing on this machine. This machine had no virtualization
active. Here is partial console log of dump process:  

=============================================================================

kdump: dump target is /dev/mapper/mpathc3
kdump: saving to /sysroot//var/crash/127.0.0.1-2013.11.11-09:58:20/
kdump: saving vmcore-dmesg.txt
kdump: saving vmcore-dmesg.txt complete
kdump: saving vmcore
[   46.017827] scsi 20:0:0:0: Direct-Access              Geek Squad
8192 PQ: 0 ANSI: 0 CCS
[   46.027849] scsi 20:0:0:0: alua: supports implicit and explicit TPGS
[   46.035641] scsi 20:0:0:0: alua: No target port descriptors found
[   46.042491] scsi 20:0:0:0: alua: not attached
[   46.048152] sd 20:0:0:0: [sdak] 15663104 512-byte logical blocks:
(8.01 GB/7.46 GiB)
[   46.057892] sd 20:0:0:0: [sdak] Write Protect is off
[   46.064516] sd 20:0:0:0: [sdak] No Caching mode page present
[   46.070877] sd 20:0:0:0: [sdak] Assuming drive cache: write through
[   46.081639] sd 20:0:0:0: [sdak] No Caching mode page present
[   46.088035] sd 20:0:0:0: [sdak] Assuming drive cache: write through
[   46.107070]  sdak: sdak1 sdak2 sdak3
[   46.114636] sd 20:0:0:0: [sdak] No Caching mode page present
[   46.121021] sd 20:0:0:0: [sdak] Assuming drive cache: write through
[   46.128060] sd 20:0:0:0: [sdak] Attached SCSI removable disk

Excluding unnecessary pages        : [  0 %] 
Excluding unnecessary 
sary pages        : [  0 %] 
Excluding unnecessary pages        : [  0
%] 
Excluding unnecessary pages        : [  8 %] 
Excluding unnecessary
pages        : [ 15 %] 
Excluding unnecessary pages        : [ 21 %] [
53.800116] usb 4-1.6: device descriptor read/64, error -110

Excluding unnecessary pages        : [ 28 %] 
Excluding unnecessary
pages        : [ 34 %] 
Excluding unnecessary pages        : [ 41 %]
Excluding unnecessary pages        : [100 %] [   59.174433] scsi
18:0:0:0: Enclosure         HP       P2000 G3 FC      T240 PQ: 0 ANSI: 5
[   59.183866] scsi 18:0:0:0: alua: supports implicit TPGS
[   59.190190] scsi 18:0:0:0: alua: port group 01 rel port 05
[   59.197694] scsi 18:0:0:0: alua: transition timeout set to 60 seconds

......

[   76.968265] makedumpfile[1291]: segfault at 7f5ac0c39010 ip
00000000004297fd sp 00007fff691683a0 error 4 in makedumpfile[400000
+46000]
//lib/dracut/hooks/pre-pivot/9999-kdump.sh: line 88:  1291 Segmentation
fault   [   76.996926] sd 18:0:1:51: [sdao] Synchronizing SCSI cache
   $CORE_COLLECT[   77.003416] sd 18:0:1:50: [sdan] Synchronizing SCSI
cache
OR /proc/vmcore [   77.010991] sd 18:0:0:51: [sdam] Synchronizing SCSI
cache
$_mp/$KDUMP_PATH[   77.018590] sd 18:0:0:50: [sdal] Synchronizing SCSI
cache
/$HOST_IP-$DATED[   77.026611] sd 14:0:1:71: [sdaj] Synchronizing SCSI
cache
IR/vmcore-incomp[   77.033849] sd 14:0:1:70: [sdai] Synchronizing SCSI
cache
lete
kdump: sav[   77.041467] sd 14:0:0:71: [sdah] Synchronizing SCSI cache
ing vmcore faile[   77.049146] sd 14:0:0:70: [sdag] Synchronizing SCSI
cached
Rebooting.


=======================================================================

I do not have a current /proc/iomem output to go with the above.
However this dump was nr_cpus=8 during crashkernel boot, with a 3.10
kernel with Daisuke's version 4 of Daisuke Hatayama's patch to allow
multi-cpu crashkernel boot. 

I have the efi memory map displayed as Linux booted, before this dump if
that helps

0.000000] efi:  ACPI=0x73ffe000  ACPI 2.0=0x73ffe014  SMBIOS=0x72ef8000 
[    0.000000] efi: mem00: type=3, attr=0xf,
range=[0x0000000000000000-0x0000000000001000) (0MB)
[    0.000000] efi: mem01: type=2, attr=0xf,
range=[0x0000000000001000-0x0000000000004000) (0MB)
[    0.000000] efi: mem02: type=7, attr=0xf,
range=[0x0000000000004000-0x000000000008e000) (0MB)
[    0.000000] efi: mem03: type=0, attr=0xf,
range=[0x000000000008e000-0x0000000000090000) (0MB)
[    0.000000] efi: mem04: type=7, attr=0xf,
range=[0x0000000000090000-0x00000000000a0000) (0MB)
[    0.000000] efi: mem05: type=7, attr=0xf,
range=[0x0000000000100000-0x0000000001000000) (15MB)
[    0.000000] efi: mem06: type=2, attr=0xf,
range=[0x0000000001000000-0x0000000002268000) (18MB)
[    0.000000] efi: mem07: type=7, attr=0xf,
range=[0x0000000002268000-0x0000000010000000) (221MB)
[    0.000000] efi: mem08: type=3, attr=0xf,
range=[0x0000000010000000-0x0000000010066000) (0MB)
[    0.000000] efi: mem09: type=7, attr=0xf,
range=[0x0000000010066000-0x0000000029dfb000) (413MB)
[    0.000000] efi: mem10: type=2, attr=0xf,
range=[0x0000000029dfb000-0x0000000039ba0000) (253MB)
[    0.000000] efi: mem11: type=4, attr=0xf,
range=[0x0000000039ba0000-0x000000003e179000) (69MB)
[    0.000000] efi: mem12: type=3, attr=0xf,
range=[0x000000003e179000-0x000000003e55c000) (3MB)
[    0.000000] efi: mem13: type=4, attr=0xf,
range=[0x000000003e55c000-0x000000003e567000) (0MB)
[    0.000000] efi: mem14: type=3, attr=0xf,
range=[0x000000003e567000-0x000000003e6e9000) (1MB)
[    0.000000] efi: mem15: type=4, attr=0xf,
range=[0x000000003e6e9000-0x000000003e6f4000) (0MB)
[    0.000000] efi: mem16: type=3, attr=0xf,
range=[0x000000003e6f4000-0x000000003e88f000) (1MB)
[    0.000000] efi: mem17: type=4, attr=0xf,
range=[0x000000003e88f000-0x000000003e8f4000) (0MB)
[    0.000000] efi: mem18: type=3, attr=0xf,
range=[0x000000003e8f4000-0x000000003e9cf000) (0MB)
[    0.000000] efi: mem19: type=4, attr=0xf,
range=[0x000000003e9cf000-0x000000003e9d0000) (0MB)
[    0.000000] efi: mem20: type=3, attr=0xf,
range=[0x000000003e9d0000-0x000000003ee9d000) (4MB)
[    0.000000] efi: mem21: type=4, attr=0xf,
range=[0x000000003ee9d000-0x000000003ef9b000) (0MB)
[    0.000000] efi: mem22: type=0, attr=0xf,
range=[0x000000003ef9b000-0x000000003efab000) (0MB)
[    0.000000] efi: mem23: type=4, attr=0xf,
range=[0x000000003efab000-0x000000006ba1b000) (714MB)
[    0.000000] efi: mem24: type=10, attr=0xf,
range=[0x000000006ba1b000-0x000000006ca1b000) (16MB)
[    0.000000] efi: mem25: type=4, attr=0xf,
range=[0x000000006ca1b000-0x00000000709ff000) (63MB)
[    0.000000] efi: mem26: type=7, attr=0xf,
range=[0x00000000709ff000-0x0000000070a10000) (0MB)
[    0.000000] efi: mem27: type=2, attr=0xf,
range=[0x0000000070a10000-0x0000000070c34000) (2MB)
[    0.000000] efi: mem28: type=7, attr=0xf,
range=[0x0000000070c34000-0x0000000070c35000) (0MB)
[    0.000000] efi: mem29: type=2, attr=0xf,
range=[0x0000000070c35000-0x0000000070dff000) (1MB)
[    0.000000] efi: mem30: type=7, attr=0xf,
range=[0x0000000070dff000-0x0000000070fa9000) (1MB)
[    0.000000] efi: mem31: type=1, attr=0xf,
range=[0x0000000070fa9000-0x00000000711ff000) (2MB)
[    0.000000] efi: mem32: type=7, attr=0xf,
range=[0x00000000711ff000-0x000000007120e000) (0MB)
[    0.000000] efi: mem33: type=3, attr=0xf,
range=[0x000000007120e000-0x00000000721ff000) (15MB)
[    0.000000] efi: mem34: type=6, attr=0x800000000000000f,
range=[0x00000000721ff000-0x00000000725ff000) (4MB)
[    0.000000] efi: mem35: type=5, attr=0x800000000000000f,
range=[0x00000000725ff000-0x0000000072dff000) (8MB)
[    0.000000] efi: mem36: type=0, attr=0xf,
range=[0x0000000072dff000-0x0000000072eff000) (1MB)
[    0.000000] efi: mem37: type=10, attr=0xf,
range=[0x0000000072eff000-0x0000000073eff000) (16MB)
[    0.000000] efi: mem38: type=9, attr=0xf,
range=[0x0000000073eff000-0x0000000073fff000) (1MB)
[    0.000000] efi: mem39: type=4, attr=0xf,
range=[0x0000000073fff000-0x000000007c000000) (128MB)
[    0.000000] efi: mem40: type=7, attr=0xf,
range=[0x0000000100000000-0x0000001080000000) (63488MB)
[    0.000000] efi: mem41: type=7, attr=0xf,
range=[0x0000020000000000-0x0000021000000000) (65536MB)
[    0.000000] efi: mem42: type=7, attr=0xf,
range=[0x0000038000000000-0x0000039000000000) (65536MB)
[    0.000000] efi: mem43: type=7, attr=0xf,
range=[0x0000050000000000-0x0000051000000000) (65536MB)
[    0.000000] efi: mem44: type=7, attr=0xf,
range=[0x0000068000000000-0x0000069000000000) (65536MB)
[    0.000000] efi: mem45: type=7, attr=0xf,
range=[0x0000080000000000-0x0000081000000000) (65536MB)
[    0.000000] efi: mem46: type=7, attr=0xf,
range=[0x0000098000000000-0x0000099000000000) (65536MB)
[    0.000000] efi: mem47: type=7, attr=0xf,
range=[0x00000b0000000000-0x00000b1000000000) (65536MB)
[    0.000000] efi: mem48: type=7, attr=0xf,
range=[0x00000c8000000000-0x00000c9000000000) (65536MB)
[    0.000000] efi: mem49: type=7, attr=0xf,
range=[0x00000e0000000000-0x00000e1000000000) (65536MB)
[    0.000000] efi: mem50: type=7, attr=0xf,
range=[0x00000f8000000000-0x00000f9000000000) (65536MB)
[    0.000000] efi: mem51: type=7, attr=0xf,
range=[0x0000110000000000-0x0000111000000000) (65536MB)
[    0.000000] efi: mem52: type=7, attr=0xf,
range=[0x0000128000000000-0x0000129000000000) (65536MB)
[    0.000000] efi: mem53: type=7, attr=0xf,
range=[0x0000140000000000-0x0000141000000000) (65536MB)
[    0.000000] efi: mem54: type=7, attr=0xf,
range=[0x0000158000000000-0x0000159000000000) (65536MB)
[    0.000000] efi: mem55: type=7, attr=0xf,
range=[0x0000170000000000-0x0000171000000000) (65536MB)
[    0.000000] efi: mem56: type=11, attr=0x8000000000000001,
range=[0x0000000080000000-0x0000000090000000) (256MB)
[    0.000000] efi: mem57: type=11, attr=0x8000000000000001,
range=[0x00000000fed1c000-0x00000000fed20000) (0MB)
[    0.000000] efi: mem58: type=11, attr=0x8000000000000001,
range=[0x00000000ff000000-0x00000000ff200000) (2MB)
[    0.000000] efi: mem59: type=11, attr=0x8000000000000001,
range=[0x00003fdfe0000000-0x00003fdff4000000) (320MB)
[    0.000000] efi: mem60: type=11, attr=0x8000000000000001,
range=[0x00003fe060000000-0x00003fe074000000) (320MB)
[    0.000000] efi: mem61: type=11, attr=0x8000000000000001,
range=[0x00003fe0e0000000-0x00003fe0f4000000) (320MB)
[    0.000000] efi: mem62: type=11, attr=0x8000000000000001,
range=[0x00003fe160000000-0x00003fe174000000) (320MB)
[    0.000000] efi: mem63: type=11, attr=0x8000000000000001,
range=[0x00003fe1e0000000-0x00003fe1f4000000) (320MB)
[    0.000000] efi: mem64: type=11, attr=0x8000000000000001,
range=[0x00003fe260000000-0x00003fe274000000) (320MB)
[    0.000000] efi: mem65: type=11, attr=0x8000000000000001,
range=[0x00003fe2e0000000-0x00003fe2f4000000) (320MB)
[    0.000000] efi: mem66: type=11, attr=0x8000000000000001,
range=[0x00003fe360000000-0x00003fe374000000) (320MB)
[    0.000000] efi: mem67: type=11, attr=0x8000000000000001,
range=[0x00003fe3e0000000-0x00003fe3f4000000) (320MB)
[    0.000000] efi: mem68: type=11, attr=0x8000000000000001,
range=[0x00003fe460000000-0x00003fe474000000) (320MB)
[    0.000000] efi: mem69: type=11, attr=0x8000000000000001,
range=[0x00003fe4e0000000-0x00003fe4f4000000) (320MB)
[    0.000000] efi: mem70: type=11, attr=0x8000000000000001,
range=[0x00003fe560000000-0x00003fe574000000) (320MB)
[    0.000000] efi: mem71: type=11, attr=0x8000000000000001,
range=[0x00003fe5e0000000-0x00003fe5f4000000) (320MB)
[    0.000000] efi: mem72: type=11, attr=0x8000000000000001,
range=[0x00003fe660000000-0x00003fe674000000) (320MB)
[    0.000000] efi: mem73: type=11, attr=0x8000000000000001,
range=[0x00003fe6e0000000-0x00003fe6f4000000) (320MB)
[    0.000000] efi: mem74: type=11, attr=0x8000000000000001,
range=[0x00003fe760000000-0x00003fe774000000) (320MB)
[    0.000000] efi: mem75: type=11, attr=0x8000000000000001,
range=[0x00003fe7e0000000-0x00003fe7f4000000) (320MB)

> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
