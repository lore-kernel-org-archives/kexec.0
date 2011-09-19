Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [2002:4e20:1eda::1] (helo=caramon.arm.linux.org.uk)
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R5cqn-0000I3-6D
	for kexec@lists.infradead.org; Mon, 19 Sep 2011 12:21:31 +0000
Date: Mon, 19 Sep 2011 13:20:59 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: kdump: copy kernel relocation code at the kexec
	prepare stage
Message-ID: <20110919122059.GQ16381@n2100.arm.linux.org.uk>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Lei Wen <leiwen@marvell.com>
Cc: Yu Tang <ytang5@marvell.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Chao Xie <chao.xie@marvell.com>

On Thu, Sep 15, 2011 at 10:32:09PM -0700, Lei Wen wrote:
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index e59bbd4..f60fc90 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -32,6 +32,21 @@ static atomic_t waiting_for_crash_ipi;
>  
>  int machine_kexec_prepare(struct kimage *image)
>  {
> +	unsigned long page_list;
> +	void *reboot_code_buffer;
> +	page_list = image->head & PAGE_MASK;
> +
> +	reboot_code_buffer = page_address(image->control_code_page);
> +
> +	/* Prepare parameters for reboot_code_buffer*/
> +	kexec_start_address = image->start;
> +	kexec_indirection_page = page_list;
> +	kexec_mach_type = machine_arch_type;
> +	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
> +
> +	/* copy our kernel relocation code to the control code page */
> +	memcpy(reboot_code_buffer,
> +	       relocate_new_kernel, relocate_new_kernel_size);
>  	return 0;
>  }
>  
> @@ -82,29 +97,14 @@ void (*kexec_reinit)(void);
>  
>  void machine_kexec(struct kimage *image)
>  {
> -	unsigned long page_list;
>  	unsigned long reboot_code_buffer_phys;
>  	void *reboot_code_buffer;
>  
> -
> -	page_list = image->head & PAGE_MASK;
> -
>  	/* we need both effective and real address here */
>  	reboot_code_buffer_phys =
>  	    page_to_pfn(image->control_code_page) << PAGE_SHIFT;
>  	reboot_code_buffer = page_address(image->control_code_page);
>  
> -	/* Prepare parameters for reboot_code_buffer*/
> -	kexec_start_address = image->start;
> -	kexec_indirection_page = page_list;
> -	kexec_mach_type = machine_arch_type;
> -	kexec_boot_atags = image->start - KEXEC_ARM_ZIMAGE_OFFSET + KEXEC_ARM_ATAGS_OFFSET;
> -
> -	/* copy our kernel relocation code to the control code page */
> -	memcpy(reboot_code_buffer,
> -	       relocate_new_kernel, relocate_new_kernel_size);
> -
> -
>  	flush_icache_range((unsigned long) reboot_code_buffer,
>  			   (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);

You should keep this flush with the memcpy - the two are intimately
related - the flush is to ensure I/D cache coherency for the code
which was copied into the page.  Splitting them into two different
functions is asking for future bugs.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
