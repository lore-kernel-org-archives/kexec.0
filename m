Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cohLQ-0006yb-J8
 for kexec@lists.infradead.org; Fri, 17 Mar 2017 02:10:22 +0000
Date: Fri, 17 Mar 2017 10:09:51 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec regression since 4.9 caused by efi
Message-ID: <20170317020951.GA3942@dhcp-128-65.nay.redhat.com>
References: <20170308201616.GC8598@vader>
 <20170309063806.GB17257@dhcp-128-65.nay.redhat.com>
 <20170309095408.GA17883@vader>
 <20170313073748.GA6332@dhcp-128-65.nay.redhat.com>
 <20170316124132.GF6261@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170316124132.GF6261@codeblueprint.co.uk>
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
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com

On 03/16/17 at 12:41pm, Matt Fleming wrote:
> On Mon, 13 Mar, at 03:37:48PM, Dave Young wrote:
> > 
> > Omar, could you try below patch? Looking at the efi_mem_desc_lookup, it is not
> > correct to be used in efi_arch_mem_reserve, if it passed your test, I
> > can rewrite patch log with more background and send it out:
> > 
> >         for_each_efi_memory_desc(md) {
> > 		[snip]
> >                 if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
> >                     md->type != EFI_BOOT_SERVICES_DATA &&
> >                     md->type != EFI_RUNTIME_SERVICES_DATA) {
> >                         continue;
> >                 }
> > 
> > In above code, it meant to get a md of EFI_MEMORY_RUNTIME of either boot
> > data or runtime data, this is wrong for efi_mem_reserve, because we are
> > reserving boot data which has no EFI_MEMORY_RUNTIME attribute at the
> > running time. Just is happened to work and we did not capture the error.
> 
> Wouldn't something like this be simpler?
> 
> ---
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 30031d5293c4..cdfe8c628959 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -201,6 +201,10 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  		return;
>  	}
>  
> +	/* No need to reserve regions that will never be freed. */
> +	if (md.attribute & EFI_MEMORY_RUNTIME)
> +		return;
> +

Matt, I think it should be fine although I think the md type checking in
efi_mem_desc_lookup() is causing confusion and not easy to understand..

How about move the if chunk early like below because it seems no need
to sanity check the addr + size any more if the md is still RUNTIME?

--- linux-x86.orig/arch/x86/platform/efi/quirks.c
+++ linux-x86/arch/x86/platform/efi/quirks.c
@@ -196,6 +196,10 @@ void __init efi_arch_mem_reserve(phys_ad
 		return;
 	}
 
+	/* No need to reserve regions that will never be freed. */
+	if (md.attribute & EFI_MEMORY_RUNTIME)
+		return;
+
 	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
 		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
 		return;

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
