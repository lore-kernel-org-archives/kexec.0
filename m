Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZKg81-0007ZB-EH
 for kexec@lists.infradead.org; Thu, 30 Jul 2015 05:11:37 +0000
Date: Thu, 30 Jul 2015 13:15:53 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH] align crash_notes allocation to make it be inside one
 physical page
Message-ID: <20150730051553.GB27915@dhcp-128-25.nay.redhat.com>
References: <1438225679-13052-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438225679-13052-1-git-send-email-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, tatsu@ab.jp.nec.com, seiji.aguchi.tr@hitachi.com, dyoung@redhat.com, vgoyal@redhat.com, ebiederm@xmission.com

On 07/30/15 at 11:07am, Baoquan He wrote:
> People reported that crash_notes in /proc/vmcore were corrupted and
> this cause crash kdump failure. With code debugging and log we got
> the root cause. This is because percpu variable crash_notes are
> allocated in 2 vmalloc pages. As you know percpu is based on vmalloc
> by default. Then vmalloc can't guarantee 2 continuous vmalloc pages
> are also on 2 continuous physical pages. Then 1st kernel export the
> starting addr and size, kdump kernel use the starting addr and size
> to get the content of crash_notes, then 2nd part may not be in the
> next neighbouring physical page as we think. That's why nhdr_ptr->n_namesz
> or nhdr_ptr->n_descsz could be very huge in update_note_header_size_elf64()
> and cause note header merging failure or some warnings.
> 
> In this patch change to call __alloc_percpu() to passed in the align
> value which is nearest the the 2^log(sizeof(note_buf_t)). This align
> value can make sure the crash_notes is allocated inside one physical
> page since sizeof(note_buf_t) in all ARCHS is smaller PAGE_SIZE. But
> add a WARN_ON in case it grow to be bigger than PAGE_SIZE in the future.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  kernel/kexec.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index a785c10..1740c42 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1620,7 +1620,16 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
>  static int __init crash_notes_memory_init(void)
>  {
>  	/* Allocate memory for saving cpu registers. */
> -	crash_notes = alloc_percpu(note_buf_t);
> +	size_t size, align;
> +	int order;
> +
> +	size = sizeof(note_buf_t);
> +	order = get_count_order(size);
> +	align = 1<< order;
> +
> +	WARN_ON(size > PAGE_SIZE);

It is fine without this warning, since percpu will fail to allocate the
memory larger than PAGE_SIZE.

Thanks
Minfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
