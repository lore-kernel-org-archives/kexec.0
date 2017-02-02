Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cZFQ7-0008Mu-TN
 for kexec@lists.infradead.org; Thu, 02 Feb 2017 11:19:22 +0000
Received: by mail-pg0-f45.google.com with SMTP id 204so5171728pge.0
 for <kexec@lists.infradead.org>; Thu, 02 Feb 2017 03:18:59 -0800 (PST)
Date: Thu, 2 Feb 2017 20:19:31 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
Message-ID: <20170202111930.GG13549@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej>
 <20170201182506.GA30584@leverpostej> <58930DE6.7000103@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58930DE6.7000103@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

James,

On Thu, Feb 02, 2017 at 10:45:58AM +0000, James Morse wrote:
> Hi Akashi, Mark,
> 
> On 01/02/17 18:25, Mark Rutland wrote:
> > On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
> >> On Wed, Feb 01, 2017 at 09:46:24PM +0900, AKASHI Takahiro wrote:
> >>> arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
> >>> are meant to be called around kexec_load() in order to protect
> >>> the memory allocated for crash dump kernel once after it's loaded.
> >>>
> >>> The protection is implemented here by unmapping the region rather than
> >>> making it read-only.
> >>> To make the things work correctly, we also have to
> >>> - put the region in an isolated, page-level mapping initially, and
> >>> - move copying kexec's control_code_page to machine_kexec_prepare()
> >>>
> >>> Note that page-level mapping is also required to allow for shrinking
> >>> the size of memory, through /sys/kernel/kexec_crash_size, by any number
> >>> of multiple pages.
> 
> >> Looking at kexec_crash_size_store(), I don't see where memory returned
> >> to the OS is mapped. AFAICT, if the region is protected when the user
> >> shrinks the region, the memory will not be mapped, yet handed over to
> >> the kernel for general allocation.
> 
> kernel/kexec_core.c:crash_shrink_memory() will bailout:
> >	if (kexec_crash_image) {
> >		ret = -ENOENT;
> >		goto unlock;
> >	}
> 
> So it should only be possible to return memory to the allocators when there is
> no crash image loaded, so the area is mapped.
> 
> What happens when we unload the crash image? It looks like an unload is a call

Thank you for this heads-up!
I've almost forgot this feature.

> to do_kexec_load with nr_segments == 0, do_kexec_load() has:
> >	if (flags & KEXEC_ON_CRASH) {
> >		dest_image = &kexec_crash_image;
> >		if (kexec_crash_image)
> >			arch_kexec_unprotect_crashkres();
> 
> So we unprotect the region when we unload the kernel causing it to be remapped.
> Provided the load/protect and {load,unload}/unprotect are kept in sync, I think
> this is safe.
> 
> 
> Given the core code can unload a crash image, this hunk has me worried:
> +void arch_kexec_unprotect_crashkres(void)
> +{
> +	/*
> +	 * We don't have to make page-level mappings here because
> +	 * the crash dump kernel memory is not allowed to be shrunk
> +	 * once the kernel is loaded.
> +	 */
> +	create_pgd_mapping(&init_mm, crashk_res.start,
> +			__phys_to_virt(crashk_res.start),
> +			resource_size(&crashk_res), PAGE_KERNEL,
> +			debug_pagealloc_enabled());
> 
> 
> I don't think this is true if the order is: load -> protect, unload ->
> unprotect, shrink. The shrink will happen with potentially non-page-size mappings.

So we have to always do page-mapping, here.

-Takahiro AKASHI

> 
> Thanks,
> 
> James
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
