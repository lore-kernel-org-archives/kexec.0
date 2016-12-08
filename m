Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cEpLa-0006rv-5S
 for kexec@lists.infradead.org; Thu, 08 Dec 2016 03:26:15 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1481164674-42775-1-git-send-email-zhongjiang@huawei.com>
Date: Thu, 08 Dec 2016 16:22:32 +1300
In-Reply-To: <1481164674-42775-1-git-send-email-zhongjiang@huawei.com>
 (zhongjiang@huawei.com's message of "Thu, 8 Dec 2016 10:37:54 +0800")
Message-ID: <878trrxfyf.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] kexec: add cond_resched into
 kimage_alloc_crash_control_pages
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
To: zhongjiang <zhongjiang@huawei.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

zhongjiang <zhongjiang@huawei.com> writes:

> From: zhong jiang <zhongjiang@huawei.com>
>
> A soft lookup will occur when I run trinity in syscall kexec_load.
> the corresponding stack information is as follows.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> [  237.235937] BUG: soft lockup - CPU#6 stuck for 22s! [trinity-c6:13859]
> [  237.242699] Kernel panic - not syncing: softlockup: hung tasks
> [  237.248573] CPU: 6 PID: 13859 Comm: trinity-c6 Tainted: G           O L ----V-------   3.10.0-327.28.3.35.zhongjiang.x86_64 #1
> [  237.259984] Hardware name: Huawei Technologies Co., Ltd. Tecal BH622 V2/BC01SRSA0, BIOS RMIBV386 06/30/2014
> [  237.269752]  ffffffff8187626b 0000000018cfde31 ffff88184c803e18 ffffffff81638f16
> [  237.277471]  ffff88184c803e98 ffffffff8163278f 0000000000000008 ffff88184c803ea8
> [  237.285190]  ffff88184c803e48 0000000018cfde31 ffff88184c803e67 0000000000000000
> [  237.292909] Call Trace:
> [  237.295404]  <IRQ>  [<ffffffff81638f16>] dump_stack+0x19/0x1b
> [  237.301352]  [<ffffffff8163278f>] panic+0xd8/0x214
> [  237.306196]  [<ffffffff8111d6fc>] watchdog_timer_fn+0x1cc/0x1e0
> [  237.312157]  [<ffffffff8111d530>] ? watchdog_enable+0xc0/0xc0
> [  237.317955]  [<ffffffff810aa182>] __hrtimer_run_queues+0xd2/0x260
> [  237.324087]  [<ffffffff810aa720>] hrtimer_interrupt+0xb0/0x1e0
> [  237.329963]  [<ffffffff8164ae5c>] ? call_softirq+0x1c/0x30
> [  237.335500]  [<ffffffff81049a77>] local_apic_timer_interrupt+0x37/0x60
> [  237.342228]  [<ffffffff8164bacf>] smp_apic_timer_interrupt+0x3f/0x60
> [  237.348771]  [<ffffffff8164a11d>] apic_timer_interrupt+0x6d/0x80
> [  237.354967]  <EOI>  [<ffffffff810f3a00>] ? kimage_alloc_control_pages+0x80/0x270
> [  237.362875]  [<ffffffff811c3ebe>] ? kmem_cache_alloc_trace+0x1ce/0x1f0
> [  237.369592]  [<ffffffff810f362f>] ? do_kimage_alloc_init+0x1f/0x90
> [  237.375992]  [<ffffffff810f3d1a>] kimage_alloc_init+0x12a/0x180
> [  237.382103]  [<ffffffff810f3f9a>] SyS_kexec_load+0x20a/0x260
> [  237.387957]  [<ffffffff816494c9>] system_call_fastpath+0x16/0x1b
>
> the first time allocate control pages may take too much time because
> crash_res.end can be set to a higher value. we need to add cond_resched
> to avoid the issue.
>
> The patch have been tested and above issue is not appear.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5616755..bfc9621 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -441,6 +441,8 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>  	while (hole_end <= crashk_res.end) {
>  		unsigned long i;
>  
> +		cond_resched();
> +
>  		if (hole_end > KEXEC_CRASH_CONTROL_MEMORY_LIMIT)
>  			break;
>  		/* See if I overlap any of the segments */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
