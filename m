Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IXUoW-0007aI-JZ
	for kexec@lists.infradead.org; Tue, 18 Sep 2007 00:36:01 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8I4ZsqY026651
	for <kexec@lists.infradead.org>; Tue, 18 Sep 2007 00:35:54 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8I4Zsik559462
	for <kexec@lists.infradead.org>; Tue, 18 Sep 2007 00:35:54 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8I4ZsXm016339
	for <kexec@lists.infradead.org>; Tue, 18 Sep 2007 00:35:54 -0400
Date: Tue, 18 Sep 2007 10:06:07 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [patch 2/7] Use extended crashkernel command line on i386
Message-ID: <20070918043607.GB4842@in.ibm.com>
References: <20070913161428.343951643@strauss.suse.de>
	<20070913161429.087964162@strauss.suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070913161429.087964162@strauss.suse.de>
Reply-To: vgoyal@in.ibm.com
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
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Sep 13, 2007 at 06:14:30PM +0200, Bernhard Walle wrote:
> -
>  void arch_crash_save_vmcoreinfo(void)
>  {
>  #ifdef CONFIG_ARCH_DISCONTIGMEM_ENABLE
> --- a/arch/i386/kernel/setup.c
> +++ b/arch/i386/kernel/setup.c
> @@ -381,6 +381,33 @@ extern unsigned long __init setup_memory
>  extern void zone_sizes_init(void);
>  #endif /* !CONFIG_NEED_MULTIPLE_NODES */
> 
> +#ifdef CONFIG_KEXEC
> +static void reserve_crashkernel(void)
> +{
> +	unsigned long long 	free_mem;
> +	unsigned long long 	crash_size, crash_base;
> +	int			ret;
> +
> +	free_mem = (max_low_pfn + highend_pfn - highstart_pfn) << PAGE_SHIFT;
> +
> +	ret = parse_crashkernel(boot_command_line, free_mem,
> +			&crash_size, &crash_base);
> +	if (ret == 0 && crash_size > 0 && crash_base > 0) {
> +		printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
> +				"for crashkernel (System RAM: %ldMB)\n",
> +				(unsigned long)(crash_size >> 20),
> +				(unsigned long)(crash_base >> 20),
> +				(unsigned long)(free_mem >> 20));
> +		crashk_res.start = crash_base;
> +		crashk_res.end   = crash_base + crash_size - 1;
> +		reserve_bootmem(crash_base, crash_size);

Hi Bernhard,

I think we might need to do more here. Because [offset] is optional, one
would assume that things will work even if offset is not specified. But
in this patchset, that's not the case for i386 and x86_64. It will silently
fail if a user does not specify the offset. No memory will be reserved for
capture kernel.

I think we either need to make offset mandatory or put in additional
intelligence here to choose the offset automatically based on the memory
available.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
