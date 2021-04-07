Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU9UM-005C11-GV
 for kexec@lists.infradead.org; Wed, 07 Apr 2021 14:49:12 +0000
Received: by mail-wr1-x42b.google.com with SMTP id 12so3791845wrz.7
 for <kexec@lists.infradead.org>; Wed, 07 Apr 2021 07:49:02 -0700 (PDT)
Date: Wed, 7 Apr 2021 16:48:59 +0200
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: crashkernel reservation failed - No suitable area found on a
 cortina/gemini SoC
Message-ID: <YG3GWxYU02UhOnUX@Red>
References: <YG2rfzRvHIZKXkf/@Red>
 <34ff1fcc-e9ee-02c2-b2a8-d98a24ce94c3@linux.vnet.ibm.com>
 <YG3AZ4K2auqEz9BK@Red>
 <7a75028b-4495-cd51-6a32-59fcf6e0f166@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a75028b-4495-cd51-6a32-59fcf6e0f166@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Le Wed, Apr 07, 2021 at 07:28:26AM -0700, Bruce Mitchell a =E9crit :
> On 4/7/2021 07:23, Corentin Labbe wrote:
> > Le Wed, Apr 07, 2021 at 07:13:04AM -0700, Bruce Mitchell a =E9crit :
> >> On 4/7/2021 05:54, Corentin Labbe wrote:
> >>> Hello
> >>>
> >>> I try to do kexec on a cortina/gemini SoC.
> >>> On a "normal" boot, kexec fail to find memory so I added crashkernel=
=3D8M to cmdline. (kernel size is ~6M).
> >>> But now, kernel fail to reserve memory:
> >>> Load Kern image from 0x30020000 to 0x800000 size 7340032
> >>> Booting Linux on physical CPU 0x0
> >>> Linux version 5.12.0-rc5-next-20210401+ (compile@Red) (armv7a-unknown=
-linux-gnueabihf-gcc (Gentoo 9.3.0-r2 p4) 9.3.0, GNU ld (Gentoo 2.34 p6) 2.=
34.0) #98 PREEMPT Wed Apr 7 14:14:08 CEST 2021
> >>> CPU: FA526 [66015261] revision 1 (ARMv4), cr=3D0000397f
> >>> CPU: VIVT data cache, VIVT instruction cache
> >>> OF: fdt: Machine model: Edimax NS-2502
> >>> Memory policy: Data cache writeback
> >>> Zone ranges:
> >>>     Normal   [mem 0x0000000000000000-0x0000000007ffffff]
> >>>     HighMem  empty
> >>> Movable zone start for each node
> >>> Early memory node ranges
> >>>     node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> >>> Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
> >>> crashkernel reservation failed - No suitable area found.
> >>> Built 1 zonelists, mobility grouping on.  Total pages: 32512
> >>> Kernel command line: console=3DttyS0,19200n8 ip=3Ddhcp crashkernel=3D=
8M
> >>> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
> >>> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
> >>> mem auto-init: stack:off, heap alloc:off, heap free:off
> >>> Memory: 119476K/131072K available (5034K kernel code, 579K rwdata, 13=
72K rodata, 3020K init, 210K bss, 11596K reserved, 0K cma-reserved, 0K high=
mem)
> >>> SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1
> >>>
> >>> What can I do ?
> >>>
> >>> Thanks
> >>> Regards
> >>>
> >>> _______________________________________________
> >>> kexec mailing list
> >>> kexec@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/kexec
> >>>
> >>
> >> Hello Corentin,
> >>
> >> I see much larger crashkernel=3DxxM being shown here
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/admin-guide/kdump/kdump.rst
> >> and from many of my other searches.
> >>
> >> Here is an interesting article on kdump for ARM-32
> >> https://kaiwantech.wordpress.com/2017/07/13/setting-up-kdump-and-crash=
-for-arm-32-an-ongoing-saga/
> >>
> >>
> >> Here is the kernel command line reference
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/admin-guide/kernel-parameters.txt?h=3Dv5.11#n732
> >>
> >> I feel your frustrations too.
> > =

> > Hello
> > =

> > Thanks but I have already read those documentation.
> > I search to know why the kernel cannot find 8M of memory ouf of 128.
> > =

> > Regards
> > =

> =

> How much more memory does the kernel and initrd above and beyond just =

> their physical size?  (heaps, stacks, buffers, virtual filesystems)

The kernel size include a rootfs.cpio.lzma of 3MB and dtb is appended.
The total kernel size is 7MB.
The uncompressed size of the kernel is 13M (size of vmlinux)
The uncompressed size of rootfs is 11M.

cat /proc/meminfo =

MemTotal:         122496 kB
MemFree:          103700 kB
MemAvailable:     101936 kB
Buffers:               0 kB
Cached:            10904 kB
SwapCached:            0 kB
Active:             4304 kB
Inactive:           8012 kB
Active(anon):       4304 kB
Inactive(anon):     8012 kB
Active(file):          0 kB
Inactive(file):        0 kB
Unevictable:           0 kB
Mlocked:               0 kB
HighTotal:             0 kB
HighFree:              0 kB
LowTotal:         122496 kB
LowFree:          103700 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:          1428 kB
Mapped:             3552 kB
Shmem:             10904 kB
KReclaimable:        608 kB
Slab:               2960 kB
SReclaimable:        608 kB
SUnreclaim:         2352 kB
KernelStack:         312 kB
PageTables:          136 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       61248 kB
Committed_AS:      14336 kB
VmallocTotal:     901120 kB
VmallocUsed:          64 kB
VmallocChunk:          0 kB
Percpu:               32 kB
CmaTotal:              0 kB
CmaFree:               0 kB


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
