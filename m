Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WmTS0-0006jn-EE
 for kexec@lists.infradead.org; Mon, 19 May 2014 19:42:21 +0000
Received: from zmail15.collab.prod.int.phx2.redhat.com
 (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
 by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s4JJfxTt004081
 for <kexec@lists.infradead.org>; Mon, 19 May 2014 15:41:59 -0400
Date: Mon, 19 May 2014 15:41:58 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1809090930.13449697.1400528518027.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.5.1400526001.29113.kexec@lists.infradead.org>
References: <mailman.5.1400526001.29113.kexec@lists.infradead.org>
Subject: Re: [BUG REPORT] kexec and makedumpfile can't detect PAGE_OFFSET on
 arm (Wang Nan)
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org



----- Original Message -----
> 
> Hi Atsushi and Simon,
> 
> I find a problem about VMSPLIT on arm plarform, related to kexec and
> makedumpfile.
> 
> When CONFIG_VMSPLIT_1G/2G is selected by kernel, PAGE_OFFSET is actually
> 0x40000000 or 0x80000000. However, kexec hard codes PAGE_OFFSET to
> 0xc0000000 (in kexec/arch/arm/crashdump-arm.h), which is incorrect in
> these situations. For example, on realview-pbx board with 1G/3G VMSPLIT,
> PHDRs in generated /proc/vmcore is as follow:
> 
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   NOTE           0x001000 0x00000000 0x00000000 0x00690 0x00690     0
>   LOAD           0x002000 0xc0000000 0x00000000 0x10000000 0x10000000 RWE 0
>   LOAD           0x10002000 0xe0000000 0x20000000 0x8000000 0x8000000 RWE 0
>   LOAD           0x18002000 0xf0000000 0x30000000 0x10000000 0x10000000 RWE 0
>   LOAD           0x28002000 0x40000000 0x80000000 0x10000000 0x10000000 RWE 0
> 
> Which should be:
> 
>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>   ...
>   LOAD            ...     0x40000000 0x00000000 0x10000000 0x10000000 RWE 0
>   LOAD            ...     0x60000000 0x20000000 0x8000000 0x8000000 RWE 0
>   LOAD            ...     0x70000000 0x30000000 0x10000000 0x10000000 RWE 0
>   LOAD            ...     0xc0000000 0x80000000 0x10000000 0x10000000 RWE 0
> 
> I don't know why crash utility can deal with it without problem,

For ARM the crash utility masks the symbol value of "_stext" with 0x1fffffff
to determine the PAGE_OFFSET value, which was basically copied from the way
it was done for i386. 

> but in makedumpfile such VMSPLIT setting causes segfault:
> 
>  $ ./makedumpfile -c -d 31 /proc/vmcore ./out -f
>  The kernel version is not supported.
>  The created dumpfile may be incomplete.
>  Excluding unnecessary pages        : [  0.0 %] /Segmentation fault
> 
> There are many ways to deal with it, I want discuss them in the maillist and
> make a decision:
> 
>  1. Kexec changes, detect PAGE_OFFSET dynamically. However, I don't know
>     whether there is a reliably way for this purpose, here I suggest
>     kernel to export PAGE_OFFSET through sysfs, such as
>     /sys/kernel/page_offset.
> 
>  2. Or, kexec accepts PAGE_OFFSET as a command line arguments, let user
>     provide correct information.
> 
>  3. Or, makedumpfile changes, don't trust EHDR anymore. Kernel should
>     export PAGE_OFFSET through VMCOREINFO.
> 
> How do you feel?
> 
> Thank you!
> 
> 
> 
> 
> 
> ------------------------------
> 
> Message: 2
> Date: Mon, 19 May 2014 11:11:40 -0400
> From: Vivek Goyal <vgoyal@redhat.com>
> To: "bhe@redhat.com" <bhe@redhat.com>
> Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
> 	"d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, Atsushi
> 	Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "zzou@redhat.com"
> 	<zzou@redhat.com>, Larry Woodman <lwoodman@redhat.com>
> Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
> 	bufsize_cyclic for elf dump
> Message-ID: <20140519151140.GF650@redhat.com>
> Content-Type: text/plain; charset=us-ascii
> 
> On Mon, May 19, 2014 at 07:15:38PM +0800, bhe@redhat.com wrote:
> 
> [..]
> > -------------------------------------------------
> > bhe# cat /etc/kdump.conf
> > path /var/crash
> > core_collector makedumpfile -E --message-level 1 -d 31
> > 
> > ------------------------------------------
> > kdump: dump target is /dev/sda2
> > kdump: saving [    9.595153] EXT4-fs (sda2): re-mounted. Opts:
> > data=ordered
> > to /sysroot//var/crash/127.0.0.1-2014.05.19-18:50:18/
> > kdump: saving vmcore-dmesg.txt
> > kdump: saving vmcore-dmesg.txt complete
> > kdump: saving vmcore
> > 
> > calculate_cyclic_buffer_size, get_free_memory_size: 68857856
> > 
> >  Buffer size for the cyclic mode: 27543142
> 
> Bao,
> 
> So 68857856 is 65MB. So we have around 65MB free when makedumpfile
> started.
> 
> 27543142  is 26MB. So we reserved 26MB for bitmaps or we reserved
> 52MB for bitmaps?
> 
> Looking at the backtrace, larry pointed out few things.
> 
> - makedumpfile has already allocated around 52MB of anonymous memory. I
>   guess this primarily comes from bitmaps and looks like we are reserving
>   52MB in bitmaps and not 26MB. I think this could be consistent with
>   current 80% logic as 80% of 65MB is around 52MB.
> 
> 	[   15.427173] Killed process 286 (makedumpfile) total-vm:79940kB,
> 			anon-rss:54132kB, file-rss:892kB
> 
> - So we are left with 65-52 = 13MB of total memory for kernel as well
>   as makedumpfile.
>  
> - We have around 1500 pages in page cache which are in writeback stage.
>   That means around 6MB of pages are dirty and being written back to
>   disk. That means makedumpfile might not require lot of memory but
>   kernel does require free memory in dirty/writeback pages when dump
>   file is being written.
> 
> 	[   15.167732]  unevictable:7137 dirty:2 writeback:1511 unstable:0
> 
> - Larry mentioend that there are around 5000 pages (20MB of memory)
>   sitting in file pages in page cache which ideally should be reclaimable.
>   It is not clear why that memory is not being reclaimed fast enough.
> 
> 	[   15.167732]  active_file:2406 inactive_file:2533 isolated_file:0
> 
> So to me bottom line is that once the write out starts, kernel needs
> memory for holding dirty and writeback pages in cache too. So we probably
> are being too aggresive in allocating 80% of free memory for bitmaps. May
> be we should drop it down to 50-60%  of free memory for bitmaps.
> 
> Thanks
> Vivek
> 
> 
> 
> 
> > Copying data                       : [ 15.9 %] -[   14.955468]
> > makedumpfile invoked oom-killer: gfp_mask=0x10200da, order=0,
> > oom_score_adj=0
> > [   14.963876] makedumpfile cpuset=/ mems_allowed=0
> > [   14.968723] CPU: 0 PID: 286 Comm: makedumpfile Not tainted
> > 3.10.0-123.el7.x86_64 #1
> > [   14.976606] Hardware name: Hewlett-Packard HP Z420 Workstation/1589,
> > BIOS J61 v01.02 03/09/2012
> > [   14.985567]  ffff88002fedc440 00000000f650c592 ffff88002fcb57d0
> > ffffffff815e19ba
> > [   14.993291]  ffff88002fcb5860 ffffffff815dd02d ffffffff810b68f8
> > ffff8800359dc0c0
> > [   15.001013]  ffffffff00000206 ffffffff00000000 0000000000000000
> > ffffffff81102e03
> > [   15.008733] Call Trace:
> > [   15.011413]  [<ffffffff815e19ba>] dump_stack+0x19/0x1b
> > [   15.016778]  [<ffffffff815dd02d>] dump_header+0x8e/0x214
> > [   15.022321]  [<ffffffff810b68f8>] ? ktime_get_ts+0x48/0xe0
> > [   15.028036]  [<ffffffff81102e03>] ? proc_do_uts_string+0xe3/0x130
> > [   15.034383]  [<ffffffff8114520e>] oom_kill_process+0x24e/0x3b0
> > [   15.040446]  [<ffffffff8106af3e>] ? has_capability_noaudit+0x1e/0x30
> > [   15.047068]  [<ffffffff81145a36>] out_of_memory+0x4b6/0x4f0
> > [   15.052864]  [<ffffffff8114b579>] __alloc_pages_nodemask+0xa09/0xb10
> > [   15.059482]  [<ffffffff81188779>] alloc_pages_current+0xa9/0x170
> > [   15.065711]  [<ffffffff811419f7>] __page_cache_alloc+0x87/0xb0
> > [   15.071804]  [<ffffffff81142606>]
> > grab_cache_page_write_begin+0x76/0xd0
> > [   15.078646]  [<ffffffffa02aa133>] ext4_da_write_begin+0xa3/0x330
> > [ext4]
> > [   15.085495]  [<ffffffff8114162e>]
> > generic_file_buffered_write+0x11e/0x290
> > [   15.092504]  [<ffffffff81143785>]
> > __generic_file_aio_write+0x1d5/0x3e0
> > [   15.099294]  [<ffffffff81050f00>] ?
> > rbt_memtype_copy_nth_element+0xa0/0xa0
> > [   15.106385]  [<ffffffff811439ed>] generic_file_aio_write+0x5d/0xc0
> > [   15.112841]  [<ffffffffa02a0189>] ext4_file_write+0xa9/0x450 [ext4]
> > [   15.119321]  [<ffffffff8117997c>] ? free_vmap_area_noflush+0x7c/0x90
> > [   15.125884]  [<ffffffff811af36d>] do_sync_write+0x8d/0xd0
> > [   15.131492]  [<ffffffff811afb0d>] vfs_write+0xbd/0x1e0
> > [   15.136839]  [<ffffffff811b0558>] SyS_write+0x58/0xb0
> > [   15.142091]  [<ffffffff815f2119>] system_call_fastpath+0x16/0x1b
> > [   15.148293] Mem-Info:
> > [   15.150770] Node 0 DMA per-cpu:
> > [   15.154138] CPU    0: hi:    0, btch:   1 usd:   0
> > [   15.159133] Node 0 DMA32 per-cpu:
> > [   15.162741] CPU    0: hi:   42, btch:   7 usd:  12
> > [   15.167732] active_anon:14395 inactive_anon:1034 isolated_anon:0
> > [   15.167732]  active_file:2406 inactive_file:2533 isolated_file:0
> > [   15.167732]  unevictable:7137 dirty:2 writeback:1511 unstable:0
> > [   15.167732]  free:488 slab_reclaimable:2371 slab_unreclaimable:3533
> > [   15.167732]  mapped:1110 shmem:1065 pagetables:166 bounce:0
> > [   15.167732]  free_cma:0
> > [   15.203076] Node 0 DMA free:508kB min:4kB low:4kB high:4kB
> > active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB
> > unevictabs
> > [   15.242882] lowmem_reserve[]: 0 128 128 128
> > [   15.247447] Node 0 DMA32 free:1444kB min:1444kB low:1804kB
> > high:2164kB active_anon:57580kB inactive_anon:4136kB active_file:9624kB
> > inacts
> > [   15.292683] lowmem_reserve[]: 0 0 0 0
> > [   15.296761] Node 0 DMA: 1*4kB (U) 1*8kB (U) 1*16kB (U) 1*32kB (U)
> > 1*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4096kB B
> > [   15.310372] Node 0 DMA32: 78*4kB (UEM) 52*8kB (UEM) 17*16kB (UM)
> > 12*32kB (UM) 2*64kB (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*40B
> > [   15.324412] Node 0 hugepages_total=0 hugepages_free=0
> > hugepages_surp=0 hugepages_size=2048kB
> > [   15.333088] 13144 total pagecache pages
> > [   15.337161] 0 pages in swap cache
> > [   15.340708] Swap cache stats: add 0, delete 0, find 0/0
> > [   15.346165] Free swap  = 0kB
> > [   15.349280] Total swap = 0kB
> > [   15.353385] 90211 pages RAM
> > [   15.356420] 53902 pages reserved
> > [   15.359880] 6980 pages shared
> > [   15.363088] 29182 pages non-shared
> > [   15.366719] [ pid ]   uid  tgid total_vm      rss nr_ptes swapents
> > oom_score_adj name
> > [   15.374788] [   85]     0    85    13020      553      24        0
> > 0 systemd-journal
> > [   15.383818] [  134]     0   134     8860      547      22        0
> > -1000 systemd-udevd
> > [   15.392664] [  146]     0   146     5551      245      23        0
> > 0 plymouthd
> > [   15.401167] [  230]     0   230     3106      537      16        0
> > 0 dracut-pre-pivo
> > [   15.410181] [  286]     0   286    19985    13756      55        0
> > 0 makedumpfile
> > [   15.418942] Out of memory: Kill process 286 (makedumpfile) score 368
> > or sacrifice child
> > [   15.427173] Killed process 286 (makedumpfile) total-vm:79940kB,
> > anon-rss:54132kB, file-rss:892kB
> > //lib/dracut/hooks/pre-pivot/9999-kdump.sh: line
> > Generating "/run/initramfs/rdsosreport.txt"
> > 
> > > 
> > > 
> > > Thanks
> > > Atsushi Kumagai
> > > 
> 
> 
> 
> ------------------------------
> 
> Message: 3
> Date: Mon, 19 May 2014 17:09:48 +0100
> From: Will Deacon <will.deacon@arm.com>
> To: Wang Nan <wangnan0@huawei.com>
> Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
> 	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, Geng Hui
> 	<hui.geng@huawei.com>, Simon Horman <horms@verge.net.au>, Andrew
> 	Morton <akpm@linux-foundation.org>,
> 	"linux-arm-kernel@lists.infradead.org"
> 	<linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH Resend] ARM: kdump: makes second kernel use strict
> 	pfn_valid
> Message-ID: <20140519160947.GM15130@arm.com>
> Content-Type: text/plain; charset=us-ascii
> 
> On Mon, May 19, 2014 at 02:54:03AM +0100, Wang Nan wrote:
> > When SPARSEMEM and CRASH_DUMP both selected, simple pfn_valid prevents
> > the second kernel ioremap first kernel's memory if the address falls
> > into second kernel section. This limitation requires the second kernel
> > occupies a full section, and elfcorehdr must resides in another section.
> > 
> > This patch makes crash dump kernel use strict pfn_valid, removes such
> > limitation.
> > 
> > For example:
> > 
> >   For a platform with SECTION_SIZE_BITS == 28 (256MiB) and
> >   crashkernel=128M@0x28000000 in kernel cmdline, the second
> >   kernel is loaded at 0x28000000. Kexec puts elfcorehdr at
> >   0x2ff00000, and passes 'elfcorehdr=0x2ff00000 mem=130048K' to
> >   second kernel. When second kernel start, it tries to use
> >   ioremap to retrive its elfcorehrd. In this case, elfcodehdr is at the
> >   same section of the second kernel, pfn_valid will recongnize
> >   the page as valid, so ioremap will refuse to map it.
> 
> So isn't the issue here that you're passing an incorrect mem= parameter
> to the crash kernel?
> 
> Will
> 
> 
> 
> ------------------------------
> 
> Subject: Digest Footer
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 
> ------------------------------
> 
> End of kexec Digest, Vol 86, Issue 28
> *************************************
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
