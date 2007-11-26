Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1IwYri-0001xO-PG
	for kexec@lists.infradead.org; Mon, 26 Nov 2007 02:58:59 -0500
Date: Sun, 25 Nov 2007 23:58:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/5] Fix the configuration dependencies
Message-Id: <20071125235843.69440d4a.akpm@linux-foundation.org>
In-Reply-To: <473D0170.1060304@mxs.nes.nec.co.jp>
References: <473CFE14.3010400@mxs.nes.nec.co.jp>
	<473D0170.1060304@mxs.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

On Fri, 16 Nov 2007 11:33:20 +0900 "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:

> 
> This patch fixes the configuration dependencies in the vmcoreinfo data.
> 
> i386's "node_data" is defined in arch/x86/mm/discontig_32.c,
> and x86_64's one is defined in arch/x86/mm/numa_64.c.
> They depend on CONFIG_NUMA:
>   arch/x86/mm/Makefile_32:7
>     obj-$(CONFIG_NUMA) += discontig_32.o
>   arch/x86/mm/Makefile_64:7
>     obj-$(CONFIG_NUMA) += numa_64.o
> 
> ia64's "pgdat_list" is defined in arch/ia64/mm/discontig.c,
> and it depends on CONFIG_DISCONTIGMEM and CONFIG_SPARSEMEM:
>   arch/ia64/mm/Makefile:9-10
>     obj-$(CONFIG_DISCONTIGMEM) += discontig.o
>     obj-$(CONFIG_SPARSEMEM)    += discontig.o
> 
> ia64's "node_memblk" is defined in arch/ia64/mm/numa.c,
> and it depends on CONFIG_NUMA:
>   arch/ia64/mm/Makefile:8
>     obj-$(CONFIG_NUMA)         += numa.o
> 
> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> ---
> diff -rpuN a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
> --- a/arch/ia64/kernel/machine_kexec.c	2007-11-14 15:39:06.000000000 +0900
> +++ b/arch/ia64/kernel/machine_kexec.c	2007-11-14 15:41:41.000000000 +0900
> @@ -129,10 +129,11 @@ void machine_kexec(struct kimage *image)
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> -#if defined(CONFIG_ARCH_DISCONTIGMEM_ENABLE) && defined(CONFIG_NUMA)
> +#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_SPARSEMEM)
>  	VMCOREINFO_SYMBOL(pgdat_list);
>  	VMCOREINFO_LENGTH(pgdat_list, MAX_NUMNODES);
> -
> +#endif
> +#ifdef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(node_memblk);
>  	VMCOREINFO_LENGTH(node_memblk, NR_NODE_MEMBLKS);
>  	VMCOREINFO_STRUCT_SIZE(node_memblk_s);
> diff -rpuN a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> --- a/arch/x86/kernel/machine_kexec_32.c	2007-11-14 15:39:19.000000000 +0900
> +++ b/arch/x86/kernel/machine_kexec_32.c	2007-11-14 15:39:33.000000000 +0900
> @@ -151,7 +151,7 @@ NORET_TYPE void machine_kexec(struct kim
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> -#ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
> +#ifdef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(node_data);
>  	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
>  #endif
> diff -rpuN a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> --- a/arch/x86/kernel/machine_kexec_64.c	2007-11-14 15:39:19.000000000 +0900
> +++ b/arch/x86/kernel/machine_kexec_64.c	2007-11-14 15:39:33.000000000 +0900
> @@ -235,7 +235,7 @@ void arch_crash_save_vmcoreinfo(void)
>  {
>  	VMCOREINFO_SYMBOL(init_level4_pgt);
>  
> -#ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
> +#ifdef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(node_data);
>  	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
>  #endif
> _
> 

x86_64-make-sparsemem-vmemmap-the-default-memory-model-v2.patch removes the
`VMCOREINFO_SYMBOL(node_data);' from arch/x86/kernel/machine_kexec_64.c
altogether, so I dropped that part of your patch.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
