Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dad3H-00070z-1v
 for kexec@lists.infradead.org; Thu, 27 Jul 2017 07:17:45 +0000
Received: by mail-wm0-x243.google.com with SMTP id c184so10013374wmd.1
 for <kexec@lists.infradead.org>; Thu, 27 Jul 2017 00:17:22 -0700 (PDT)
Date: Thu, 27 Jul 2017 09:17:18 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v1 1/2] x86/mm, kexec: Fix memory corruption with SME on
 successive kexecs
Message-ID: <20170727071717.aydwpzaji6l2o6xs@gmail.com>
References: <cover.1501092102.git.thomas.lendacky@amd.com>
 <28648b23b9957506069e20bd985e3d7e8af94780.1501092102.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <28648b23b9957506069e20bd985e3d7e8af94780.1501092102.git.thomas.lendacky@amd.com>
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>


* Tom Lendacky <thomas.lendacky@amd.com> wrote:

> After issuing successive kexecs it was found that the SHA hash failed
> verification when booting the kexec'd kernel.  When SME is enabled, the
> change from using pages that were marked encrypted to now being marked as
> not encrypted (through new identify mapped page tables) results in memory
> corruption if there are any cache entries for the previously encrypted
> pages. This is because separate cache entries can exist for the same
> physical location but tagged both with and without the encryption bit.
> 
> To prevent this, issue a wbinvd before copying the pages from the source
> location to the destination location to clear any possible cache entry
> conflicts.
> 
> Cc: <kexec@lists.infradead.org>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 98111b3..c11d8bc 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -132,6 +132,13 @@ identity_mapped:
>  	/* Flush the TLB (needed?) */
>  	movq	%r9, %cr3
>  
> +	/*
> +	 * If SME is/was active, there could be old encrypted cache line
> +	 * entries that will conflict with the now unencrypted memory
> +	 * used by kexec. Flush the caches before copying the kernel.
> +	 */
> +	wbinvd

WBINVD is very expensive IIRC - several milliseconds.

So if we change the page table from encrypted to unencrypted we need to do a full 
cache flush sounds pretty broken to me - how can then this be done via an API such 
as mmap() without executing WBINVD?

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
