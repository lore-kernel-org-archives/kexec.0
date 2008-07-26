Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KMgku-0001pO-R1
	for kexec@lists.infradead.org; Sat, 26 Jul 2008 10:12:05 +0000
Date: Sat, 26 Jul 2008 03:10:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] crashdump: fix undefined reference to `elfcorehdr_addr'
Message-Id: <20080726031034.82e2feef.akpm@linux-foundation.org>
In-Reply-To: <20080726092519.GA4341@elte.hu>
References: <20080726092519.GA4341@elte.hu>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Chandru <chandru@in.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, 26 Jul 2008 11:25:19 +0200 Ingo Molnar <mingo@elte.hu> wrote:

> 
> please apply before -rc1.
> 
> 	Ingo
> 
> ----------->
> >From 72db7cba50b6a05825f8a287f74002cc38f04fb7 Mon Sep 17 00:00:00 2001
> From: Ingo Molnar <mingo@elte.hu>
> Date: Sat, 26 Jul 2008 11:22:33 +0200
> Subject: [PATCH] crashdump: fix undefined reference to `elfcorehdr_addr'
> 
> fix build bug introduced by 95b68dec0d5 "calgary iommu: use the first
> kernels TCE tables in kdump":
> 
>  arch/x86/kernel/built-in.o: In function `calgary_iommu_init':
>  (.init.text+0x8399): undefined reference to `elfcorehdr_addr'
>  arch/x86/kernel/built-in.o: In function `calgary_iommu_init':
>  (.init.text+0x856c): undefined reference to `elfcorehdr_addr'
>  arch/x86/kernel/built-in.o: In function `detect_calgary':
>  (.init.text+0x8c68): undefined reference to `elfcorehdr_addr'
>  arch/x86/kernel/built-in.o: In function `detect_calgary':
>  (.init.text+0x8d0c): undefined reference to `elfcorehdr_addr'
>
> make elfcorehdr_addr a generally available symbol.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  include/linux/crash_dump.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 6cd39a9..025e4f5 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -8,7 +8,13 @@
>  #include <linux/proc_fs.h>
>  
>  #define ELFCORE_ADDR_MAX	(-1ULL)
> +
> +#ifdef CONFIG_PROC_VMCORE
>  extern unsigned long long elfcorehdr_addr;
> +#else
> +static const unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
> +#endif
> +
>  extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
>  						unsigned long, int);
>  extern const struct file_operations proc_vmcore_operations;

spose that'll fix it.  But it seems odd that is_kdump_kernel() will
return false if CONFIG_PROC_VMCORE=n, CONFIG_CRASH_DUMP=y.  I mean,
it's still a crashdump kernel, is it not?



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
