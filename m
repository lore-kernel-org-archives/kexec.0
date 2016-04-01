Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1am35S-0001Fg-AQ
 for kexec@lists.infradead.org; Fri, 01 Apr 2016 17:42:23 +0000
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 18:42:00 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7475C219004D
 for <kexec@lists.infradead.org>; Fri,  1 Apr 2016 18:41:36 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31HfuYZ60293326
 for <kexec@lists.infradead.org>; Fri, 1 Apr 2016 17:41:56 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u31HftDj014009
 for <kexec@lists.infradead.org>; Fri, 1 Apr 2016 11:41:56 -0600
Date: Fri, 1 Apr 2016 19:41:54 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390/kexec: Consolidate
 crash_map/unmap_reserved_pages() and
 arch_kexec_protect(unprotect)_crashkres()
Message-ID: <20160401194154.1b4c623f@holzheu>
In-Reply-To: <1459338441-21919-1-git-send-email-xlpang@redhat.com>
References: <1459338441-21919-1-git-send-email-xlpang@redhat.com>
Mime-Version: 1.0
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Minfei Huang <mhuang@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Hello Xunlei again,

Some initial comments below...

On Wed, 30 Mar 2016 19:47:21 +0800
Xunlei Pang <xlpang@redhat.com> wrote:

> Commit 3f625002581b ("kexec: introduce a protection mechanism
> for the crashkernel reserved memory") is a similar mechanism
> for protecting the crash kernel reserved memory to previous
> crash_map/unmap_reserved_pages() implementation, the new one
> is more generic in name and cleaner in code (besides, some
> arch may not be allowed to unmap the pgtable).
> 
> Therefore, this patch consolidates them, and uses the new
> arch_kexec_protect(unprotect)_crashkres() to replace former
> crash_map/unmap_reserved_pages() which by now has been only
> used by S390.
> 
> The consolidation work needs the crash memory to be mapped
> initially, so get rid of S390 crash kernel memblock removal
> in reserve_crashkernel(). Once kdump kernel is loaded, the
> new arch_kexec_protect_crashkres() implemented for S390 will
> actually unmap the pgtable like before.
> 
> The patch also fixed a S390 crash_shrink_memory() bad page warning
> in passing due to not using memblock_reserve():
>   BUG: Bad page state in process bash  pfn:7e400
>   page:000003d101f90000 count:0 mapcount:1 mapping: (null) index:0x0
>   flags: 0x0()
>   page dumped because: nonzero mapcount
>   Modules linked in: ghash_s390 prng aes_s390 des_s390 des_generic
>   CPU: 0 PID: 1558 Comm: bash Not tainted 4.6.0-rc1-next-20160327 #1
>        0000000073007a58 0000000073007ae8 0000000000000002 0000000000000000
>        0000000073007b88 0000000073007b00 0000000073007b00 000000000022cf4e
>        0000000000a579b8 00000000007b0dd6 0000000000791a8c
>        000000000000000b
>        0000000073007b48 0000000073007ae8 0000000000000000 0000000000000000
>        070003d100000001 0000000000112f20 0000000073007ae8 0000000073007b48
>   Call Trace:
>   ([<0000000000112e0c>] show_trace+0x5c/0x78)
>   ([<0000000000112ed4>] show_stack+0x6c/0xe8)
>   ([<00000000003f28dc>] dump_stack+0x84/0xb8)
>   ([<0000000000235454>] bad_page+0xec/0x158)
>   ([<00000000002357a4>] free_pages_prepare+0x2e4/0x308)
>   ([<00000000002383a2>] free_hot_cold_page+0x42/0x198)
>   ([<00000000001c45e0>] crash_free_reserved_phys_range+0x60/0x88)
>   ([<00000000001c49b0>] crash_shrink_memory+0xb8/0x1a0)
>   ([<000000000015bcae>] kexec_crash_size_store+0x46/0x60)
>   ([<000000000033d326>] kernfs_fop_write+0x136/0x180)
>   ([<00000000002b253c>] __vfs_write+0x3c/0x100)
>   ([<00000000002b35ce>] vfs_write+0x8e/0x190)
>   ([<00000000002b4ca0>] SyS_write+0x60/0xd0)
>   ([<000000000063067c>] system_call+0x244/0x264)
> 
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> ---
> Tested kexec/kdump on S390x
> 
>  arch/s390/kernel/machine_kexec.c | 86 ++++++++++++++++++++++------------------
>  arch/s390/kernel/setup.c         |  7 ++--
>  include/linux/kexec.h            |  2 -
>  kernel/kexec.c                   | 12 ------
>  kernel/kexec_core.c              | 11 +----
>  5 files changed, 54 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
> index 2f1b721..1ec6cfc 100644
> --- a/arch/s390/kernel/machine_kexec.c
> +++ b/arch/s390/kernel/machine_kexec.c
> @@ -35,6 +35,52 @@ extern const unsigned long long relocate_kernel_len;
>  #ifdef CONFIG_CRASH_DUMP
> 
>  /*
> + * Map or unmap crashkernel memory
> + */
> +static void crash_map_pages(int enable)
> +{
> +	unsigned long size = resource_size(&crashk_res);
> +
> +	BUG_ON(crashk_res.start % KEXEC_CRASH_MEM_ALIGN ||
> +	       size % KEXEC_CRASH_MEM_ALIGN);
> +	if (enable)
> +		vmem_add_mapping(crashk_res.start, size);
> +	else {
> +		vmem_remove_mapping(crashk_res.start, size);
> +		if (size)
> +			os_info_crashkernel_add(crashk_res.start, size);
> +		else
> +			os_info_crashkernel_add(0, 0);
> +	}
> +}

Please do not move these functions in the file. If you leave it at their
old location, the patch will be *much* smaller.

> +
> +/*
> + * Map crashkernel memory
> + */
> +static void crash_map_reserved_pages(void)
> +{
> +	crash_map_pages(1);
> +}
> +
> +/*
> + * Unmap crashkernel memory
> + */
> +static void crash_unmap_reserved_pages(void)
> +{
> +	crash_map_pages(0);
> +}
> +
> +void arch_kexec_protect_crashkres(void)
> +{
> +	crash_unmap_reserved_pages();
> +}
> +
> +void arch_kexec_unprotect_crashkres(void)
> +{
> +	crash_map_reserved_pages();
> +}

Please replace the crash_(un)map_reserved_pages functions
with the new arch_kexec_(un)protect() functions like the following:

/*
 * Unmap crashkernel memory
 */
void arch_kexec_protect_crashkres(void)
{
        crash_map_pages(0);
}

/*
 * Map crashkernel memory
 */
void arch_kexec_unprotect_crashkres(void)
{
        crash_map_pages(1);
}

... and remove the old functions.

> +
> +/*
>   * PM notifier callback for kdump
>   */
>  static int machine_kdump_pm_cb(struct notifier_block *nb, unsigned long action,
> @@ -43,12 +89,12 @@ static int machine_kdump_pm_cb(struct notifier_block *nb, unsigned long action,
>  	switch (action) {
>  	case PM_SUSPEND_PREPARE:
>  	case PM_HIBERNATION_PREPARE:
> -		if (crashk_res.start)
> +		if (kexec_crash_image)

Why this change?

>  			crash_map_reserved_pages();

arch_kexec_unprotect_crashkres();

>  		break;
>  	case PM_POST_SUSPEND:
>  	case PM_POST_HIBERNATION:
> -		if (crashk_res.start)
> +		if (kexec_crash_image)

Why this change?

>  			crash_unmap_reserved_pages();

arch_kexec_protect_crashkres();

>  		break;
>  	default:
> @@ -147,42 +193,6 @@ static int kdump_csum_valid(struct kimage *image)
>  }
> 
>  /*
> - * Map or unmap crashkernel memory
> - */
> -static void crash_map_pages(int enable)
> -{
> -	unsigned long size = resource_size(&crashk_res);
> -
> -	BUG_ON(crashk_res.start % KEXEC_CRASH_MEM_ALIGN ||
> -	       size % KEXEC_CRASH_MEM_ALIGN);
> -	if (enable)
> -		vmem_add_mapping(crashk_res.start, size);
> -	else {
> -		vmem_remove_mapping(crashk_res.start, size);
> -		if (size)
> -			os_info_crashkernel_add(crashk_res.start, size);
> -		else
> -			os_info_crashkernel_add(0, 0);
> -	}
> -}
> -
> -/*
> - * Map crashkernel memory
> - */
> -void crash_map_reserved_pages(void)
> -{
> -	crash_map_pages(1);
> -}
> -
> -/*
> - * Unmap crashkernel memory
> - */
> -void crash_unmap_reserved_pages(void)
> -{
> -	crash_map_pages(0);
> -}
> -
> -/*
>   * Give back memory to hypervisor before new kdump is loaded
>   */
>  static int machine_kexec_prepare_kdump(void)
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index d3f9688..5f00437 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -603,7 +603,7 @@ static void __init reserve_crashkernel(void)
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
>  	insert_resource(&iomem_resource, &crashk_res);
> -	memblock_remove(crash_base, crash_size);
> +	memblock_reserve(crash_base, crash_size);

I will discuss this next week in our team.

>  	pr_info("Reserving %lluMB of memory at %lluMB "
>  		"for crashkernel (System RAM: %luMB)\n",
>  		crash_size >> 20, crash_base >> 20,
> @@ -871,7 +871,6 @@ void __init setup_arch(char **cmdline_p)
>  	setup_memory();
> 
>  	check_initrd();
> -	reserve_crashkernel();
>  #ifdef CONFIG_CRASH_DUMP
>  	/*
>  	 * Be aware that smp_save_dump_cpus() triggers a system reset.
> @@ -890,7 +889,9 @@ void __init setup_arch(char **cmdline_p)
>  	/*
>  	 * Create kernel page tables and switch to virtual addressing.
>  	 */
> -        paging_init();
> +	paging_init();
> +
> +	reserve_crashkernel();

I will discuss this next week in our team.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
