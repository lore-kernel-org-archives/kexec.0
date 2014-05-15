Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WkriT-0007qu-4m
 for kexec@lists.infradead.org; Thu, 15 May 2014 09:12:42 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Date: Thu, 15 May 2014 09:10:43 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE972110ED@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
 <20140421151240.GB4367@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720CBBE@BPXM01GP.gisp.nec.co.jp>
 <20140423170818.GE24651@redhat.com>
 <20140423235041.GB1530@dhcp-17-102.nay.redhat.com>
 <20140425132214.GB10674@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720DE3D@BPXM01GP.gisp.nec.co.jp>
 <20140428125025.GA4751@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720F928@BPXM01GP.gisp.nec.co.jp>
 <20140509204924.GA9918@redhat.com>
 <20140515072249.GA2170@dhcp-16-116.nay.redhat.com>
In-Reply-To: <20140515072249.GA2170@dhcp-16-116.nay.redhat.com>
Content-Language: ja-JP
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
To: "bhe@redhat.com" <bhe@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>

>On 05/09/14 at 04:49pm, Vivek Goyal wrote:
>> On Fri, May 09, 2014 at 05:36:13AM +0000, Atsushi Kumagai wrote:
>>
>> [..]
>> > I tried to reproduce OOM in my environment.
>> > Unfortunately, I couldn't get a chance to use a large memory machine,
>> > so I controlled the bitmap buffer size with --cyclic-buffer like below:
>> >
>> > / # free
>> >               total         used         free       shared      buffers
>> >   Mem:        37544        19796        17748            0           56
>> >  Swap:            0            0            0
>> > Total:        37544        19796        17748
>> > / # /mnt/usr/sbin/makedumpfile_static -E --cyclic-buffer=8000 /proc/vmcore /mnt/tmp/dumpfile.E
>> > Copying data                       : [100.0 %] |
>> >
>> > The dumpfile is saved to /mnt/tmp/dumpfile.E.
>> >
>> > makedumpfile Completed.
>> > VmHWM:     16456 kB
>> > / #
>> >
>> > As above, OOM didn't happen even when makedumpfile consumed most of the
>> > available memory (the remains were only 1MB).
>> >
>> > Of course, OOM happened when the memory usage exceeded the limit:
>>
>> Hi Atsushi,
>>
>> I think this is the key point. How did makedumpfile exceed the limit. So
>> if you don't specify --cyclic-buffer=X, then makedumpfile will allocate
>> 80% of available memory. That would be roughly 16MB of cyclic buffer
>> (instead of 8MB).
>
>Hi,
>
>Here I think Vivek is right. In Astushi's test, when
>--cyclic-buffer=8000 and elf dump, the info->bufsize_cyclic is only 4M,
>because it need be divided by 2 for elf case.

No, 16MB was used for bitmaps also in my case.
--cyclic-buffer option means specifying each bitmap size, so allocated bitmap
size is the double of --cyclic-buffer.
(But now, this behavior is only for ELF case, just the specified size is allocated
in kdump case. Yes, it's confusing...)

       --cyclic-buffer buffer_size
              Specify the buffer size in kilo bytes for analysis in the cyclic
              mode.  Actually, the double of buffer_size kilo  bytes  will  be
              allocated  in  memory.  In the cyclic mode, the number of cycles
              is represented as:

So only 456KB was the requirement for other purposes, 20% of available
memory (3.5MB) was enough, thus the current assumption is safe even
when available memory is only 17MB like my test.

According to my test:

http://lists.infradead.org/pipermail/kexec/2014-May/011784.html

> Here is the result on a 2nd kernel environment:
>
>              parameter                  |      result
>   dump_lv | buffer[KiB] |  mmap (=4MiB) |    VmHWM [KiB]
>   --------+-------------+---------------+------------------
>      d31  |       1     |       on      |         776    // about 700
>     Ed31  |       1     |       on      |         712
>      d31  |       1     |      off      |         704
>     Ed31  |       1     |      off      |         708
>      d31  |    1000     |       on      |        1776    // about 700 + 1000
>     Ed31  |    1000     |       on      |        2716    // about 700 + 1000 * 2
>      d31  |    1000     |      off      |        1660
>     Ed31  |    1000     |      off      |        2556

The requirement memory size for other purposes seems about 700KB when the dump
level is 31, it's so small that we can ignore it. 
The size will increase by KB order based on the system memory size in practice
(this assumption comes from my code investigation), but 6MB (20% of 30MB) still
sounds much enough as safety limit.
This is why I was wondering why OOM happened on your machine.

Now that I heard that OOM happened only on nfs, I guess just nfs requires lots
of memory. (I did my test only on local fs.)
If we can get the required size, we could reflect it in the safety limit size.

I haven't checked your test result below yet, so I'll mention it later.

BTW, I prepared a temporal branch "oom" to investigate this issue, 
let's use this after this:

http://sourceforge.net/p/makedumpfile/code/ci/oom/tree/


Thanks
Atsushi Kumagai

>I took tests on my local machine with 16G memory, the result suprised
>me. In my tests, even 70% is not safe. I didn't specify
>--cyclic-buffer=X like Astushi did, just change code like below, I think
>it's more accurate.
>
>@@ -9049,8 +9055,9 @@ calculate_cyclic_buffer_size(void) {
>         * should be 40% of free memory to keep the size of cyclic
>         * buffer
>         * within 80% of free memory.
>         */
>        if (info->flag_elf_dumpfile) {
>-               limit_size = get_free_memory_size() * 0.4;
>+               limit_size = get_free_memory_size() * 0.30;
>        } else {
>                limit_size = get_free_memory_size() * 0.8;
>        }
>@@ -9060,7 +9067,8 @@ calculate_cyclic_buffer_size(void) {
>        if (info->num_dumpfile > 1)
>                bitmap_size /= info->num_dumpfile;
>
>-       info->bufsize_cyclic = MIN(limit_size, bitmap_size);
>+       info->bufsize_cyclic = limit_size;
>
>        return TRUE;
> }
>
>All dump is elf format, and target is nfs and local separately. And the
>crashkernel=168M
>
>Then in nfs dump, when bufsize_cyclic is 80% of memory, OOM happened 3
>times in all 5 times. when bufsize_cyclic is 70% of memory, OOM happened
>2 times in all 7 times. I paste the output message in the following
>(aaaa) section, it's 80% of memory for bufsize_cyclic.
>
>
>Then I thought 70% is not safe, maybe local fs dump is better. So I took
>local fs dump, when bufsize_cyclic is 80%, OOM happened 3 times in all 5
>times of test. When bufsize_cyclic is 70%, 2 of 5. when 60%, finally,
>it's safe now. I paste the output message in the following (bbbb)
>section, it's 80% of memory for bufsize_cyclic.
>
>I can't get a conclusion, just give the test result for your reference.
>
>(aaaa)
>pre-pivot:/# cat /etc/kdump.conf
>
>nfs 10.66.16.116:/var/crash
>path /var/crash
>core_collector makedumpfile -E --message-level 1 -d 31
>default shell
>pre-pivot:/#
>pre-pivot:/# exit
>kdump: dump target is 10.66.16.116:/var/crash
>kdump: saving to
>/sysroot/mnt//var/crash/10.66.16.106-2014.05.15-09:08:03/
>kdump: saving vmcore-dmesg.txt
>kdump: saving vmcore-dmesg.txt complete
>kdump: saving vmcore
>
>calculate_cyclic_buffer_size, free memory 34795520
>
>Buffer size for the cyclic mode: 13918208
>Excluding unnecessary pages        : [100.0 %] |
>writeout_dumpfile,before write_elf_headerfree, memory 6819840
>Excluding unnecessary pages        : [100.0 %] \
>writeout_dumpfile,before write_elf_pages_cyclic, memory 6791168
>
>In calculate_cyclic_buffer_size, free memory 6791168
>Copying data                       : [  1.1 %] /
>In calculate_cyclic_buffer_size, free memory 2412544
>Excluding unnecessary pages        : [100.0 %] |
>In calculate_cyclic_buffer_size, free memory 2691072
>Excluding unnecessary pages        : [100.0 %] \
>In calculate_cyclic_buffer_size, free memory 2756608
>Copying data                       : [  2.8 %] |
>In calculate_cyclic_buffer_size, free memory 2363392
>Copying data                       : [ 17.2 %] \[   56.567080] usb
>2-1.1: USB disconnect, device number 3
>[   58.025437] usb 2-1.1: new low-speed USB device number 5 using
>ehci-pci
>[   58.125797] usb 2-1.1: New USB device found, idVendor=03f0,
>idProduct=0b4a
>[   58.132907] usb 2-1.1: New USB device strings: Mfr=1, Product=2,
>SerialNumber=0
>[   58.140431] usb 2-1.1: Product: USB Optical Mouse
>[   58.145345] usb 2-1.1: Manufacturer: Logitech
>[   58.153006] input: Logitech USB Optical Mouse as
>/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2-1.1:1.0/input/input4
>[   58.164942] hid-generic 0003:03F0:0B4A.0003: input,hidraw0: USB HID
>v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:1d.0-1.1/inp0
>[   58.646175] makedumpfile invoked oom-killer: gfp_mask=0x10200da,
>order=0, oom_score_adj=0
>[   58.654581] makedumpfile cpuset=/ mems_allowed=0
>[   58.659411] CPU: 0 PID: 517 Comm: makedumpfile Not tainted
>3.10.0-114.el7.x86_64 #1
>[   58.667275] Hardware name: Hewlett-Packard HP Z420 Workstation/1589,
>BIOS J61 v01.02 03/09/2012
>[   58.676177]  ffff880032db4440 000000003ed297af ffff88002e4b3880
>ffffffff815ec0ca
>[   58.683882]  ffff88002e4b3910 ffffffff815e773d ffffffff810b6918
>ffff880033aca0c0
>[   58.691584]  ffffffff00000206 ffffffff00000000 0000000000000000
>ffffffff81102e03
>[   58.699293] Call Trace:
>[   58.701959]  [<ffffffff815ec0ca>] dump_stack+0x19/0x1b
>[   58.707309]  [<ffffffff815e773d>] dump_header+0x8e/0x214
>[   58.712827]  [<ffffffff810b6918>] ? ktime_get_ts+0x48/0xe0
>[   58.718529]  [<ffffffff81102e03>] ? delayacct_end+0x33/0xb0
>[   58.724310]  [<ffffffff8114516e>] oom_kill_process+0x24e/0x3b0
>[   58.730339]  [<ffffffff8106af3e>] ? has_capability_noaudit+0x1e/0x30
>[   58.736895]  [<ffffffff81145996>] out_of_memory+0x4b6/0x4f0
>[   58.742665]  [<ffffffff8114b55b>] __alloc_pages_nodemask+0xa7b/0xac0
>[   58.749222]  [<ffffffff811885f9>] alloc_pages_current+0xa9/0x170
>[   58.755440]  [<ffffffff81141957>] __page_cache_alloc+0x87/0xb0
>[   58.761479]  [<ffffffff81142566>]
>grab_cache_page_write_begin+0x76/0xd0
>[   58.768304]  [<ffffffffa03f4767>] nfs_write_begin+0x77/0x210 [nfs]
>[   58.774694]  [<ffffffff8114158e>]
>generic_file_buffered_write+0x11e/0x290
>[   58.781693]  [<ffffffff81050f00>] ?
>rbt_memtype_copy_nth_element+0xa0/0xa0
>[   58.788779]  [<ffffffff811436e5>]
>__generic_file_aio_write+0x1d5/0x3e0
>[   58.795512]  [<ffffffff8114394d>] generic_file_aio_write+0x5d/0xc0
>[   58.801903]  [<ffffffffa03f3c1b>] nfs_file_write+0xbb/0x1d0 [nfs]
>[   58.808206]  [<ffffffff811af21d>] do_sync_write+0x8d/0xd0
>[   58.813796]  [<ffffffff811af9bd>] vfs_write+0xbd/0x1e0
>[   58.819141]  [<ffffffff811af4a4>] ? generic_file_llseek+0x24/0x30
>[   58.825434]  [<ffffffff811b0408>] SyS_write+0x58/0xb0
>[   58.830676]  [<ffffffff815fc819>] system_call_fastpath+0x16/0x1b
>[   58.836874] Mem-Info:
>[   58.839349] Node 0 DMA per-cpu:
>[   58.842714] CPU    0: hi:    0, btch:   1 usd:   0
>[   58.847704] Node 0 DMA32 per-cpu:
>[   58.851244] CPU    0: hi:   42, btch:   7 usd:   0
>[   58.856235] active_anon:11294 inactive_anon:925 isolated_anon:0
>[   58.856235]  active_file:1032 inactive_file:1653 isolated_file:32
>[   58.856235]  unevictable:11030 dirty:0 writeback:1800 unstable:0
>[   58.856235]  free:473 slab_reclaimable:2202 slab_unreclaimable:3849
>[   58.856235]  mapped:1245 shmem:1103 pagetables:283 bounce:0
>[   58.856235]  free_cma:0
>[   58.891859] Node 0 DMA free:492kB min:4kB low:4kB high:4kB
>active_anon:0kB inactive_anon:0kB active_file:4kB inactive_file:8kB
>unevictabs
>[   58.931901] lowmem_reserve[]: 0 122 122 122
>[   58.936393] Node 0 DMA32 free:1400kB min:1412kB low:1764kB
>high:2116kB active_anon:45176kB inactive_anon:3700kB active_file:4124kB
>inacts
>[   58.981849] lowmem_reserve[]: 0 0 0 0
>[   58.985815] Node 0 DMA: 3*4kB (UM) 2*8kB (U) 1*16kB (M) 0*32kB 1*64kB
>(U) 1*128kB (U) 1*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 4B
>[   58.999026] Node 0 DMA32: 38*4kB (EM) 78*8kB (UEMR) 11*16kB (UER)
>0*32kB 3*64kB (R) 0*128kB 1*256kB (R) 0*512kB 0*1024kB 0*2048kB 0*4096B
>[   59.012831] Node 0 hugepages_total=0 hugepages_free=0
>hugepages_surp=0 hugepages_size=2048kB
>[   59.021469] 14852 total pagecache pages
>[   59.025522] 0 pages in swap cache
>[   59.029048] Swap cache stats: add 0, delete 0, find 0/0
>[   59.034491] Free swap  = 0kB
>[   59.037583] Total swap = 0kB
>[   59.041703] 90211 pages RAM
>[   59.044712] 53920 pages reserved
>[   59.048157] 267612 pages shared
>[   59.051514] 31588 pages non-shared
>[   59.055133] [ pid ]   uid  tgid total_vm      rss nr_ptes swapents
>oom_score_adj name
>[   59.063173] [   64]     0    64    13020      570      24        0
>0 systemd-journal
>[   59.072172] [  170]    32   170     9977      282      23        0
>0 rpcbind
>[   59.080474] [  174]     0   174    11120      416      25        0
>0 rpc.statd
>[   59.088960] [  179]     0   179     6366      169      16        0
>0 rpc.idmapd
>[   59.097551] [  201]     0   201     8729      425      22        0
>-1000 systemd-udevd
>[   59.106402] [  324]     0   324    25589     3179      47        0
>0 dhclient
>[   59.114815] [  383]     0   383     3101      553      16        0
>0 dracut-pre-pivo
>[   59.123832] [  517]     0   517    13333     7103      42        0
>0 makedumpfile
>[   59.132594] [  518]     0   518     8728      272      21        0
>0 systemd-udevd
>[   59.141442] [  519]     0   519     8728      214      21        0
>0 systemd-udevd
>[   59.150287] Out of memory: Kill process 517 (makedumpfile) score 190
>or sacrifice child
>[   59.158527] Killed process 517 (makedumpfile) total-vm:53332kB,
>anon-rss:27524kB, file-rss:888kB
>//lib/dracut/hooks/pre-pivot/9999-kdump.sh: line
>Generating "/run/initramfs/rdsosreport.txt"
>
>
>(bbbb)
>kdump: dump target is /dev/sda2
>kdump: saving t[   13.492083] EXT4-fs (sda2): re-mounted. Opts:
>data=ordered
>o /sysroot//var/crash/127.0.0.1-2014.05.15-11:24:51/
>kdump: saving vmcore-dmesg.txt
>kdump: saving vmcore-dmesg.txt complete
>kdump: saving vmcore
>
>calculate_cyclic_buffer_size, free memory 77033472
>
>Buffer size for the cyclic mode: 30813388
>Excluding unnecessary pages        : [100.0 %] |
>writeout_dumpfile,before write_elf_headerfree, memory 15233024
>Excluding unnecessary pages        : [100.0 %] -
>writeout_dumpfile,before write_elf_pages_cyclic, memory 15204352
>
>In calculate_cyclic_buffer_size, free memory 15204352
>Excluding unnecessary pages        : [100.0 %] /
>In calculate_cyclic_buffer_size, free memory 2932736
>Excluding unnecessary pages        : [100.0 %] |
>In calculate_cyclic_buffer_size, free memory 2387968
>Excluding unnecessary pages        : [100.0 %] \
>In calculate_cyclic_buffer_size, free memory 2555904
>Excluding unnecessary pages        : [100.0 %] -
>In calculate_cyclic_buffer_size, free memory 2838528
>Copying data                       : [  3.8 %] |[   15.406789]
>makedumpfile invoked oom-killer: gfp_mask=0x10200da, order=0,
>oom_score_adj=0
>[   15.415222] makedumpfile cpuset=/ mems_allowed=0
>[   15.420191] CPU: 0 PID: 287 Comm: makedumpfile Not tainted
>3.10.0-114.el7.x86_64 #1
>[   15.428092] Hardware name: Hewlett-Packard HP Z420 Workstation/1589,
>BIOS J61 v01.02 03/09/2012
>[   15.437280]  ffff88002f8196c0 0000000043db25d9 ffff88002ff2b7e0
>ffffffff815ec0ca
>[   15.445105]  ffff88002ff2b870 ffffffff815e773d ffffffff810b6918
>ffff880030018bb0
>[   15.452935]  ffffffff00000206 ffffffff00000000 0000000000000000
>ffffffff81102e03
>[   15.460693] Call Trace:
>[   15.463375]  [<ffffffff815ec0ca>] dump_stack+0x19/0x1b
>[   15.468743]  [<ffffffff815e773d>] dump_header+0x8e/0x214
>[   15.474288]  [<ffffffff810b6918>] ? ktime_get_ts+0x48/0xe0
>[   15.479999]  [<ffffffff81102e03>] ? delayacct_end+0x33/0xb0
>[   15.485790]  [<ffffffff8114516e>] oom_kill_process+0x24e/0x3b0
>[   15.491848]  [<ffffffff8106af3e>] ? has_capability_noaudit+0x1e/0x30
>[   15.498430]  [<ffffffff81145996>] out_of_memory+0x4b6/0x4f0
>[   15.504222]  [<ffffffff8114b55b>] __alloc_pages_nodemask+0xa7b/0xac0
>[   15.510793]  [<ffffffff811885f9>] alloc_pages_current+0xa9/0x170
>[   15.517020]  [<ffffffff81141957>] __page_cache_alloc+0x87/0xb0
>[   15.523061]  [<ffffffff81142566>]
>grab_cache_page_write_begin+0x76/0xd0
>[   15.529898]  [<ffffffffa02ab133>] ext4_da_write_begin+0xa3/0x330
>[ext4]
>[   15.536728]  [<ffffffff8114158e>]
>generic_file_buffered_write+0x11e/0x290
>[   15.543724]  [<ffffffff811436e5>]
>__generic_file_aio_write+0x1d5/0x3e0
>[   15.550462]  [<ffffffff81050f00>] ?
>rbt_memtype_copy_nth_element+0xa0/0xa0
>[   15.557551]  [<ffffffff8114394d>] generic_file_aio_write+0x5d/0xc0
>[   15.563952]  [<ffffffffa02a1189>] ext4_file_write+0xa9/0x450 [ext4]
>[   15.570434]  [<ffffffff811797fc>] ? free_vmap_area_noflush+0x7c/0x90
>[   15.577009]  [<ffffffff811af21d>] do_sync_write+0x8d/0xd0
>[   15.582616]  [<ffffffff811af9bd>] vfs_write+0xbd/0x1e0
>[   15.587967]  [<ffffffff811b0408>] SyS_write+0x58/0xb0
>[   15.593223]  [<ffffffff815fc819>] system_call_fastpath+0x16/0x1b
>[   15.599437] Mem-Info:
>[   15.601912] Node 0 DMA per-cpu:
>[   15.605283] CPU    0: hi:    0, btch:   1 usd:   0
>[   15.610279] Node 0 DMA32 per-cpu:
>[   15.613825] CPU    0: hi:   42, btch:   7 usd:  29
>[   15.618827] active_anon:16072 inactive_anon:924 isolated_anon:0
>[   15.618827]  active_file:2075 inactive_file:2232 isolated_file:0
>[   15.618827]  unevictable:6464 dirty:0 writeback:3 unstable:0
>[   15.618827]  free:511 slab_reclaimable:2077 slab_unreclaimable:3528
>[   15.618827]  mapped:1055 shmem:1088 pagetables:146 bounce:0
>[   15.618827]  free_cma:0
>[   15.654098] Node 0 DMA free:508kB min:4kB low:4kB high:4kB
>active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB
>unevictabs
>[   15.693926] lowmem_reserve[]: 0 129 129 129
>[   15.698429] Node 0 DMA32 free:1536kB min:1452kB low:1812kB
>high:2176kB active_anon:64288kB inactive_anon:3696kB active_file:8300kB
>inacto
>[   15.742999] lowmem_reserve[]: 0 0 0 0
>[   15.746981] Node 0 DMA: 1*4kB (U) 1*8kB (U) 1*16kB (U) 1*32kB (U)
>1*64kB (U) 1*128kB (U) 1*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4096kB B
>[   15.760499] Node 0 DMA32: 6*4kB (M) 7*8kB (R) 3*16kB (R) 2*32kB (M)
>1*64kB (M) 0*128kB 1*256kB (R) 0*512kB 1*1024kB (R) 0*2048kB 0*4096kB
>[   15.774255] Node 0 hugepages_total=0 hugepages_free=0
>hugepages_surp=0 hugepages_size=2048kB
>[   15.782928] 11860 total pagecache pages
>[   15.786986] 0 pages in swap cache
>[   15.790524] Swap cache stats: add 0, delete 0, find 0/0
>[   15.795976] Free swap  = 0kB
>[   15.799080] Total swap = 0kB
>[   15.803169] 90211 pages RAM
>[   15.806188] 53919 pages reserved
>[   15.809635] 6131 pages shared
>[   15.812820] 29843 pages non-shared
>[   15.816437] [ pid ]   uid  tgid total_vm      rss nr_ptes swapents
>oom_score_adj name
>[   15.824495] [   64]     0    64    13020      559      23        0
>0 systemd-journal
>[   15.833506] [  119]     0   119     8864      549      23        0
>-1000 systemd-udevd
>[   15.842347] [  204]     0   204     3071      531      15        0
>0 dracut-pre-pivo
>[   15.851353] [  287]     0   287    21581    15351      58        0
>0 makedumpfile
>[   15.860103] Out of memory: Kill process 287 (makedumpfile) score 411
>or sacrifice child
>[   15.868333] Killed process 287 (makedumpfile) total-vm:86324kB,
>anon-rss:60516kB, file-rss:888kB
>//lib/dracut/hooks/pre-pivot/999
>Generating "/run/initramfs/rdsosreport.txt"

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
