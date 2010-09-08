Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OtQBj-00007g-7O
	for kexec@lists.infradead.org; Wed, 08 Sep 2010 19:20:08 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <E1OtMLz-0001yp-Ia@eag09.americas.sgi.com>
Date: Wed, 08 Sep 2010 12:19:43 -0700
In-Reply-To: <E1OtMLz-0001yp-Ia@eag09.americas.sgi.com> (Cliff Wickman's
	message of "Wed, 08 Sep 2010 10:14:27 -0500")
Message-ID: <m1eid4gi0g.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: copy_oldmem_page using cached addressing
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
To: Cliff Wickman <cpw@sgi.com>
Cc: mingo@elte.hu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Cliff Wickman <cpw@sgi.com> writes:

> From: Cliff Wickman <cpw@sgi.com>
>
> The copy of /proc/vmcore to a user buffer proceeds much faster
> if the kernel addresses memory as cached.
>
> With this patch we have seen an increase in transfer rate from less than
> 15MB/s to 80-460MB/s, depending on size of the transfer.  This makes
> a big difference in time needed to save a system dump.
>
> (Does anyone know of a reason why copy_oldmem_page() would need
>  to use uncached addresses?)
>
> Diffed against 2.6.36-rc3

I believe this code simply predates being able to specify the
caching attributes at ioremap time.  Being cached in this case
actually looks more correct, as that is the default for RAM
and we are talking about RAM.

Ultimately either there is another cpu running wild with these pages
mapped with some random set of attributes, and we cannot get the
permissions right or we have captured all of the cpus and this is the
only mapping so it doesn't matter.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Cliff Wickman <cpw@sgi.com>
> ---
>  arch/x86/kernel/crash_dump_64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linus.current/arch/x86/kernel/crash_dump_64.c
> ===================================================================
> --- linus.current.orig/arch/x86/kernel/crash_dump_64.c
> +++ linus.current/arch/x86/kernel/crash_dump_64.c
> @@ -34,7 +34,7 @@ ssize_t copy_oldmem_page(unsigned long p
>  	if (!csize)
>  		return 0;
>  
> -	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> +	vaddr = ioremap_cache(pfn << PAGE_SHIFT, PAGE_SIZE);
>  	if (!vaddr)
>  		return -ENOMEM;
>  
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
