Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iJFZC-0005hq-EO
 for kexec@lists.infradead.org; Sat, 12 Oct 2019 11:28:11 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20191012022140.19003-1-lijiang@redhat.com>
 <20191012022140.19003-4-lijiang@redhat.com>
Date: Sat, 12 Oct 2019 06:26:42 -0500
In-Reply-To: <20191012022140.19003-4-lijiang@redhat.com> (Lianbo Jiang's
 message of "Sat, 12 Oct 2019 10:21:40 +0800")
Message-ID: <87d0f22oi5.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the
 backup region
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, vgoyal@redhat.com

Lianbo Jiang <lijiang@redhat.com> writes:

> When the crashkernel kernel command line option is specified, the
> low 1MiB memory will always be reserved, which makes that the memory
> allocated later won't fall into the low 1MiB area, thereby, it's not
> necessary to create a backup region and also no need to copy the first
> 640k content to a backup region.
>
> Currently, the code related to the backup region can be safely removed,
> so lets clean up.
>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---

> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index eb651fbde92a..cc5774fc84c0 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  
>  #ifdef CONFIG_KEXEC_FILE
>  
> -static unsigned long crash_zero_bytes;
> -
>  static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>  {
>  	unsigned int *nr_ranges = arg;
> @@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  {
>  	struct crash_mem *cmem = arg;
>  
> -	cmem->ranges[cmem->nr_ranges].start = res->start;
> -	cmem->ranges[cmem->nr_ranges].end = res->end;
> -	cmem->nr_ranges++;
> +	if (res->start >= SZ_1M) {
> +		cmem->ranges[cmem->nr_ranges].start = res->start;
> +		cmem->ranges[cmem->nr_ranges].end = res->end;
> +		cmem->nr_ranges++;
> +	} else if (res->end > SZ_1M) {
> +		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
> +		cmem->ranges[cmem->nr_ranges].end = res->end;
> +		cmem->nr_ranges++;
> +	}

What is going on with this chunk?  I can guess but this needs a clear
comment.

>  
>  	return 0;
>  }

> @@ -356,9 +337,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>  	cmd.params = params;
>  
> -	/* Add first 640K segment */
> -	ei.addr = image->arch.backup_src_start;
> -	ei.size = image->arch.backup_src_sz;
> +	/*
> +	 * Add the low memory range[0x1000, SZ_1M], skip
> +	 * the first zero page.
> +	 */
> +	ei.addr = PAGE_SIZE;
> +	ei.size = SZ_1M - PAGE_SIZE;
>  	ei.type = E820_TYPE_RAM;
>  	add_e820_entry(params, &ei);

Likewise here.  Why do we need a special case?
Why the magic with PAGE_SIZE?

Is this needed because of your other special case above?

When SME is active and the crashkernel command line is enabled do we
just want to leave the low 1MB unencrypted?  So we don't need any
special cases?

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
