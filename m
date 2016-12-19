Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cIoXv-0008PX-JR
 for kexec@lists.infradead.org; Mon, 19 Dec 2016 03:23:28 +0000
Date: Mon, 19 Dec 2016 11:23:00 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] kexec: add cond_resched into
 kimage_alloc_crash_control_pages
Message-ID: <20161219032300.GG9239@x1>
References: <1481164674-42775-1-git-send-email-zhongjiang@huawei.com>
 <58492ADC.4070305@redhat.com> <584A3D84.6040004@huawei.com>
 <584A5A47.6040602@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <584A5A47.6040602@redhat.com>
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
To: xlpang@redhat.com
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org, zhong jiang <zhongjiang@huawei.com>, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On 12/09/16 at 03:16pm, Xunlei Pang wrote:
> On 12/09/2016 at 01:13 PM, zhong jiang wrote:
> > On 2016/12/8 17:41, Xunlei Pang wrote:
> >> On 12/08/2016 at 10:37 AM, zhongjiang wrote:
> >>> From: zhong jiang <zhongjiang@huawei.com>
> >>>
> >>> A soft lookup will occur when I run trinity in syscall kexec_load.
> >>> the corresponding stack information is as follows.
> >>>
> >>> [  237.235937] BUG: soft lockup - CPU#6 stuck for 22s! [trinity-c6:13859]
> >>> [  237.242699] Kernel panic - not syncing: softlockup: hung tasks
> >>> [  237.248573] CPU: 6 PID: 13859 Comm: trinity-c6 Tainted: G           O L ----V-------   3.10.0-327.28.3.35.zhongjiang.x86_64 #1
> >>> [  237.259984] Hardware name: Huawei Technologies Co., Ltd. Tecal BH622 V2/BC01SRSA0, BIOS RMIBV386 06/30/2014
> >>> [  237.269752]  ffffffff8187626b 0000000018cfde31 ffff88184c803e18 ffffffff81638f16
> >>> [  237.277471]  ffff88184c803e98 ffffffff8163278f 0000000000000008 ffff88184c803ea8
> >>> [  237.285190]  ffff88184c803e48 0000000018cfde31 ffff88184c803e67 0000000000000000
> >>> [  237.292909] Call Trace:
> >>> [  237.295404]  <IRQ>  [<ffffffff81638f16>] dump_stack+0x19/0x1b
> >>> [  237.301352]  [<ffffffff8163278f>] panic+0xd8/0x214
> >>> [  237.306196]  [<ffffffff8111d6fc>] watchdog_timer_fn+0x1cc/0x1e0
> >>> [  237.312157]  [<ffffffff8111d530>] ? watchdog_enable+0xc0/0xc0
> >>> [  237.317955]  [<ffffffff810aa182>] __hrtimer_run_queues+0xd2/0x260
> >>> [  237.324087]  [<ffffffff810aa720>] hrtimer_interrupt+0xb0/0x1e0
> >>> [  237.329963]  [<ffffffff8164ae5c>] ? call_softirq+0x1c/0x30
> >>> [  237.335500]  [<ffffffff81049a77>] local_apic_timer_interrupt+0x37/0x60
> >>> [  237.342228]  [<ffffffff8164bacf>] smp_apic_timer_interrupt+0x3f/0x60
> >>> [  237.348771]  [<ffffffff8164a11d>] apic_timer_interrupt+0x6d/0x80
> >>> [  237.354967]  <EOI>  [<ffffffff810f3a00>] ? kimage_alloc_control_pages+0x80/0x270
> >>> [  237.362875]  [<ffffffff811c3ebe>] ? kmem_cache_alloc_trace+0x1ce/0x1f0
> >>> [  237.369592]  [<ffffffff810f362f>] ? do_kimage_alloc_init+0x1f/0x90
> >>> [  237.375992]  [<ffffffff810f3d1a>] kimage_alloc_init+0x12a/0x180
> >>> [  237.382103]  [<ffffffff810f3f9a>] SyS_kexec_load+0x20a/0x260
> >>> [  237.387957]  [<ffffffff816494c9>] system_call_fastpath+0x16/0x1b
> >>>
> >>> the first time allocate control pages may take too much time because
> >>> crash_res.end can be set to a higher value. we need to add cond_resched
> >>> to avoid the issue.
> >>>
> >>> The patch have been tested and above issue is not appear.
> >>>
> >>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> >>> ---
> >>>  kernel/kexec_core.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> >>> index 5616755..bfc9621 100644
> >>> --- a/kernel/kexec_core.c
> >>> +++ b/kernel/kexec_core.c
> >>> @@ -441,6 +441,8 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
> >>>  	while (hole_end <= crashk_res.end) {
> >>>  		unsigned long i;
> >>>  
> >>> +		cond_resched();
> >>> +
> >> I can't see why it would take a long time to loop inside, the job it does is simply to find a control area
> >> not overlapped with image->segment[], you can see the loop "for (i = 0; i < image->nr_segments; i++)",
> >> @hole_end will be advanced to the end of its next nearby segment once overlap was detected each loop,
> >> also there are limited (<=16) segments, so it won't take long to locate the right area.
> >>
> >> Am I missing something?
> >>
> >> Regards,
> >> Xunlei
> >   if the crashkernel = auto is set in cmdline.  it represent crashk_res.end will exceed to 4G, the first allocate control pages will
> >   loop  million times. if we set crashk_res.end to the higher value manually,  you can image....
> 
> How does "loop million times" happen? See my inlined comments prefixed with "pxl".
> 
> kimage_alloc_crash_control_pages():
>     while (hole_end <= crashk_res.end) {
>         unsigned long i;
> 
>         if (hole_end > KEXEC_CRASH_CONTROL_MEMORY_LIMIT)
>             break;
>         /* See if I overlap any of the segments */
>         for (i = 0; i < image->nr_segments; i++) {  // pxl: max 16 loops, all existent segments are not overlapped, though may not sorted.
>             unsigned long mstart, mend;
> 
>             mstart = image->segment[i].mem;
>             mend   = mstart + image->segment[i].memsz - 1;
>             if ((hole_end >= mstart) && (hole_start <= mend)) {
>                 /* Advance the hole to the end of the segment */
>                 hole_start = (mend + (size - 1)) & ~(size - 1);
>                 hole_end   = hole_start + size - 1;
>                 break;  // pxl: If overlap was found, break for loop, @hole_end starts after the overlapped segment area, and will while loop again
>             }
>         }
>         /* If I don't overlap any segments I have found my hole! */
>         if (i == image->nr_segments) {
>             pages = pfn_to_page(hole_start >> PAGE_SHIFT);
>             image->control_page = hole_end;
>             break;   // pxl: no overlap with all the segments, get the result and break the while loop. END.
>         }   
>     }
> 
> So, the worst "while" loops in theory would be (image->nr_segments + 1), no?

It's very interesting. I got the different result by mental arithmatic.
Assume nr_segments is 16, and they are placed in continuous physical
memory, then in the first while loop, it will failed in image->segment[0]
and adjust hole_start and hole_end. Then it failed in 2nd while loop
after comparing with image->segment[0] and image->segment[1]. Finally it
will get a new position after image->segment[15] after 16 comparision in
the 16th while loop. So the amount should be (1+2+3+3+16) which is
(1+16)*8, 136 times.

Not sure if the counting is right, I am wondering how it will loop
millions of times even though crashk_res.end will exceed to 4G. The
times should not be related to how much memory resreved, only the
nr_segments, maybe I am wrong.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
