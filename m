Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WmLY4-00049A-Q0
 for kexec@lists.infradead.org; Mon, 19 May 2014 11:16:05 +0000
Date: Mon, 19 May 2014 19:15:38 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140519111538.GD1661@dhcp-16-116.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE9720CBBE@BPXM01GP.gisp.nec.co.jp>
 <20140423170818.GE24651@redhat.com>
 <20140423235041.GB1530@dhcp-17-102.nay.redhat.com>
 <20140425132214.GB10674@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720DE3D@BPXM01GP.gisp.nec.co.jp>
 <20140428125025.GA4751@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720F928@BPXM01GP.gisp.nec.co.jp>
 <20140509204924.GA9918@redhat.com>
 <20140515072249.GA2170@dhcp-16-116.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972110ED@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE972110ED@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

Hi Astushi,
 
> No, 16MB was used for bitmaps also in my case.
> --cyclic-buffer option means specifying each bitmap size, so allocated bitmap
> size is the double of --cyclic-buffer.
> (But now, this behavior is only for ELF case, just the specified size is allocated
> in kdump case. Yes, it's confusing...)
> 
>        --cyclic-buffer buffer_size
>               Specify the buffer size in kilo bytes for analysis in the cyclic
>               mode.  Actually, the double of buffer_size kilo  bytes  will  be
>               allocated  in  memory.  In the cyclic mode, the number of cycles
>               is represented as:


Yeah, I was wrong about this. If specified --cyclic-buffer doesn't
exceed the memory limit, it is equal to info->bufsize_cyclic. But for
elf dump, it need be double. E.g if free memory is 30M, --cyclic-buffer
is 16M, it will absolutely fail. But the code check here should be done
separately. Since it's meaningless for elf dump if 2 x --cyclic-buffer
exceeds the free memory.

	if (info->bufsize_cyclic > free_memory) {
	.......
	{

I think code here need be changed.

> 
> So only 456KB was the requirement for other purposes, 20% of available
> memory (3.5MB) was enough, thus the current assumption is safe even
> when available memory is only 17MB like my test.
> 
> According to my test:
> 
> http://lists.infradead.org/pipermail/kexec/2014-May/011784.html
> 
> > Here is the result on a 2nd kernel environment:
> >
> >              parameter                  |      result
> >   dump_lv | buffer[KiB] |  mmap (=4MiB) |    VmHWM [KiB]
> >   --------+-------------+---------------+------------------
> >      d31  |       1     |       on      |         776    // about 700
> >     Ed31  |       1     |       on      |         712
> >      d31  |       1     |      off      |         704
> >     Ed31  |       1     |      off      |         708
> >      d31  |    1000     |       on      |        1776    // about 700 + 1000
> >     Ed31  |    1000     |       on      |        2716    // about 700 + 1000 * 2
> >      d31  |    1000     |      off      |        1660
> >     Ed31  |    1000     |      off      |        2556
> 
> The requirement memory size for other purposes seems about 700KB when the dump
> level is 31, it's so small that we can ignore it. 
> The size will increase by KB order based on the system memory size in practice
> (this assumption comes from my code investigation), but 6MB (20% of 30MB) still
> sounds much enough as safety limit.
> This is why I was wondering why OOM happened on your machine.
> 
> Now that I heard that OOM happened only on nfs, I guess just nfs requires lots
> of memory. (I did my test only on local fs.)
> If we can get the required size, we could reflect it in the safety limit size.
> 
> I haven't checked your test result below yet, so I'll mention it later.
> 
> BTW, I prepared a temporal branch "oom" to investigate this issue, 
> let's use this after this:
> 
> http://sourceforge.net/p/makedumpfile/code/ci/oom/tree/

About OOM, I don't know why the difference between yours and mine is so
big. My test machine has 16G memory, and the reserved crashkernel=161M.
The OOM happened in a very high frequency. You can check the last
section of kdump failed log, OOM failed when use 80% for
info->bufsize_buffer though left free memory is 13M. 

I changed the code like below. 

---------------------------------------------------
diff --git a/makedumpfile.c b/makedumpfile.c
index 8dc1181..cd710a3 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3157,6 +3157,7 @@ out:
                return FALSE;
 
        if (info->flag_cyclic) {
+               printf("\ncalculate_cyclic_buffer_size,
get_free_memory_size: %llu\n", get_free_memory_size());
                if (info->bufsize_cyclic == 0) {
                        if (!calculate_cyclic_buffer_size())
                                return FALSE;
@@ -3204,6 +3205,7 @@ out:
 
                DEBUG_MSG("\n");
                DEBUG_MSG("Buffer size for the cyclic mode: %ld\n",
info->bufsize_cyclic);
+               printf("\n Buffer size for the cyclic mode: %ld\n",
info->bufsize_cyclic);
        }
 
        if (!is_xen_memory() && !cache_init())
@@ -9060,7 +9062,7 @@ calculate_cyclic_buffer_size(void) {
        if (info->num_dumpfile > 1)
                bitmap_size /= info->num_dumpfile;
 
-       info->bufsize_cyclic = MIN(limit_size, bitmap_size);
+       info->bufsize_cyclic = limit_size;

-------------------------------------------------
bhe# cat /etc/kdump.conf
path /var/crash
core_collector makedumpfile -E --message-level 1 -d 31

------------------------------------------
kdump: dump target is /dev/sda2
kdump: saving [    9.595153] EXT4-fs (sda2): re-mounted. Opts:
data=ordered
to /sysroot//var/crash/127.0.0.1-2014.05.19-18:50:18/
kdump: saving vmcore-dmesg.txt
kdump: saving vmcore-dmesg.txt complete
kdump: saving vmcore

calculate_cyclic_buffer_size, get_free_memory_size: 68857856

 Buffer size for the cyclic mode: 27543142
Copying data                       : [ 15.9 %] -[   14.955468]
makedumpfile invoked oom-killer: gfp_mask=0x10200da, order=0,
oom_score_adj=0
[   14.963876] makedumpfile cpuset=/ mems_allowed=0
[   14.968723] CPU: 0 PID: 286 Comm: makedumpfile Not tainted
3.10.0-123.el7.x86_64 #1
[   14.976606] Hardware name: Hewlett-Packard HP Z420 Workstation/1589,
BIOS J61 v01.02 03/09/2012
[   14.985567]  ffff88002fedc440 00000000f650c592 ffff88002fcb57d0
ffffffff815e19ba
[   14.993291]  ffff88002fcb5860 ffffffff815dd02d ffffffff810b68f8
ffff8800359dc0c0
[   15.001013]  ffffffff00000206 ffffffff00000000 0000000000000000
ffffffff81102e03
[   15.008733] Call Trace:
[   15.011413]  [<ffffffff815e19ba>] dump_stack+0x19/0x1b
[   15.016778]  [<ffffffff815dd02d>] dump_header+0x8e/0x214
[   15.022321]  [<ffffffff810b68f8>] ? ktime_get_ts+0x48/0xe0
[   15.028036]  [<ffffffff81102e03>] ? proc_do_uts_string+0xe3/0x130
[   15.034383]  [<ffffffff8114520e>] oom_kill_process+0x24e/0x3b0
[   15.040446]  [<ffffffff8106af3e>] ? has_capability_noaudit+0x1e/0x30
[   15.047068]  [<ffffffff81145a36>] out_of_memory+0x4b6/0x4f0
[   15.052864]  [<ffffffff8114b579>] __alloc_pages_nodemask+0xa09/0xb10
[   15.059482]  [<ffffffff81188779>] alloc_pages_current+0xa9/0x170
[   15.065711]  [<ffffffff811419f7>] __page_cache_alloc+0x87/0xb0
[   15.071804]  [<ffffffff81142606>]
grab_cache_page_write_begin+0x76/0xd0
[   15.078646]  [<ffffffffa02aa133>] ext4_da_write_begin+0xa3/0x330
[ext4]
[   15.085495]  [<ffffffff8114162e>]
generic_file_buffered_write+0x11e/0x290
[   15.092504]  [<ffffffff81143785>]
__generic_file_aio_write+0x1d5/0x3e0
[   15.099294]  [<ffffffff81050f00>] ?
rbt_memtype_copy_nth_element+0xa0/0xa0
[   15.106385]  [<ffffffff811439ed>] generic_file_aio_write+0x5d/0xc0
[   15.112841]  [<ffffffffa02a0189>] ext4_file_write+0xa9/0x450 [ext4]
[   15.119321]  [<ffffffff8117997c>] ? free_vmap_area_noflush+0x7c/0x90
[   15.125884]  [<ffffffff811af36d>] do_sync_write+0x8d/0xd0
[   15.131492]  [<ffffffff811afb0d>] vfs_write+0xbd/0x1e0
[   15.136839]  [<ffffffff811b0558>] SyS_write+0x58/0xb0
[   15.142091]  [<ffffffff815f2119>] system_call_fastpath+0x16/0x1b
[   15.148293] Mem-Info:
[   15.150770] Node 0 DMA per-cpu:
[   15.154138] CPU    0: hi:    0, btch:   1 usd:   0
[   15.159133] Node 0 DMA32 per-cpu:
[   15.162741] CPU    0: hi:   42, btch:   7 usd:  12
[   15.167732] active_anon:14395 inactive_anon:1034 isolated_anon:0
[   15.167732]  active_file:2406 inactive_file:2533 isolated_file:0
[   15.167732]  unevictable:7137 dirty:2 writeback:1511 unstable:0
[   15.167732]  free:488 slab_reclaimable:2371 slab_unreclaimable:3533
[   15.167732]  mapped:1110 shmem:1065 pagetables:166 bounce:0
[   15.167732]  free_cma:0
[   15.203076] Node 0 DMA free:508kB min:4kB low:4kB high:4kB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB
unevictabs
[   15.242882] lowmem_reserve[]: 0 128 128 128
[   15.247447] Node 0 DMA32 free:1444kB min:1444kB low:1804kB
high:2164kB active_anon:57580kB inactive_anon:4136kB active_file:9624kB
inacts
[   15.292683] lowmem_reserve[]: 0 0 0 0
[   15.296761] Node 0 DMA: 1*4kB (U) 1*8kB (U) 1*16kB (U) 1*32kB (U)
1*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4096kB B
[   15.310372] Node 0 DMA32: 78*4kB (UEM) 52*8kB (UEM) 17*16kB (UM)
12*32kB (UM) 2*64kB (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*40B
[   15.324412] Node 0 hugepages_total=0 hugepages_free=0
hugepages_surp=0 hugepages_size=2048kB
[   15.333088] 13144 total pagecache pages
[   15.337161] 0 pages in swap cache
[   15.340708] Swap cache stats: add 0, delete 0, find 0/0
[   15.346165] Free swap  = 0kB
[   15.349280] Total swap = 0kB
[   15.353385] 90211 pages RAM
[   15.356420] 53902 pages reserved
[   15.359880] 6980 pages shared
[   15.363088] 29182 pages non-shared
[   15.366719] [ pid ]   uid  tgid total_vm      rss nr_ptes swapents
oom_score_adj name
[   15.374788] [   85]     0    85    13020      553      24        0
0 systemd-journal
[   15.383818] [  134]     0   134     8860      547      22        0
-1000 systemd-udevd
[   15.392664] [  146]     0   146     5551      245      23        0
0 plymouthd
[   15.401167] [  230]     0   230     3106      537      16        0
0 dracut-pre-pivo
[   15.410181] [  286]     0   286    19985    13756      55        0
0 makedumpfile
[   15.418942] Out of memory: Kill process 286 (makedumpfile) score 368
or sacrifice child
[   15.427173] Killed process 286 (makedumpfile) total-vm:79940kB,
anon-rss:54132kB, file-rss:892kB
//lib/dracut/hooks/pre-pivot/9999-kdump.sh: line
Generating "/run/initramfs/rdsosreport.txt"

> 
> 
> Thanks
> Atsushi Kumagai
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
