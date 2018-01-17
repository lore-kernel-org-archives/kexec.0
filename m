Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2nam03on0050.outbound.protection.outlook.com
 ([104.47.42.50] helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ebxQb-0000qH-Ct
 for kexec@lists.infradead.org; Wed, 17 Jan 2018 23:47:35 +0000
Subject: Re: [PATCH] x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()
From: Tom Lendacky <thomas.lendacky@amd.com>
References: <20180117234141.21184.44067.stgit@tlendack-t1.amdoffice.net>
Message-ID: <2a4c4e77-b27f-1537-515c-5ac7644c4768@amd.com>
Date: Wed, 17 Jan 2018 17:47:11 -0600
MIME-Version: 1.0
In-Reply-To: <20180117234141.21184.44067.stgit@tlendack-t1.amdoffice.net>
Content-Language: en-US
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
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Yu Chen <yu.c.chen@intel.com>, Baoquan He <bhe@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Arjan van de Ven <arjan@linux.intel.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, ebiederm@redhat.com, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Rui Zhang <rui.zhang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Dan Williams <dan.j.williams@intel.com>

On 1/17/2018 5:41 PM, Tom Lendacky wrote:
> Some issues have been reported with the for loop in stop_this_cpu() that
> issues the 'wbinvd; hlt' sequence.  Reverting this sequence to halt()
> has been shown to resolve the issue.
> 
> However, the wbinvd is needed when running with SME.  The reason for the
> wbinvd is to prevent cache flush races between encrypted and non-encrypted
> entries that have the same physical address.  This can occur when
> kexec'ing from memory encryption active to inactive or vice-versa.  The
> important thing is to not have outside of kernel text memory references
> (such as stack usage), so the usage of the native_*() functions is needed
> since these expand as inline asm sequences.  So instead of reverting the
> change, rework the sequence.
> 
> Move the wbinvd instruction outside of the for loop as native_wbinvd()
> and make its execution conditional on X86_FEATURE_SME.  In the for loop,
> change the asm 'wbinvd; hlt' sequence back to a halt sequence but use
> the native_halt() call.
> 
> Cc: <stable@vger.kernel.org> # 4.14.x
> Fixes: bba4ed011a52 ("x86/mm, kexec: Allow kexec to be used with SME")
> Reported-by: Dave Young <dyoung@redhat.com>

Dave,

Can you test this and see if it resolves your issue?

Thanks,
Tom

> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/process.c |   25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 63711fe..03408b9 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -379,19 +379,24 @@ void stop_this_cpu(void *dummy)
>  	disable_local_APIC();
>  	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
>  
> +	/*
> +	 * Use wbinvd on processors that support SME. This provides support
> +	 * for performing a successful kexec when going from SME inactive
> +	 * to SME active (or vice-versa). The cache must be cleared so that
> +	 * if there are entries with the same physical address, both with and
> +	 * without the encryption bit, they don't race each other when flushed
> +	 * and potentially end up with the wrong entry being committed to
> +	 * memory.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_SME))
> +		native_wbinvd();
>  	for (;;) {
>  		/*
> -		 * Use wbinvd followed by hlt to stop the processor. This
> -		 * provides support for kexec on a processor that supports
> -		 * SME. With kexec, going from SME inactive to SME active
> -		 * requires clearing cache entries so that addresses without
> -		 * the encryption bit set don't corrupt the same physical
> -		 * address that has the encryption bit set when caches are
> -		 * flushed. To achieve this a wbinvd is performed followed by
> -		 * a hlt. Even if the processor is not in the kexec/SME
> -		 * scenario this only adds a wbinvd to a halting processor.
> +		 * Use native_halt() so that memory contents don't change
> +		 * (stack usage and variables) after possibly issuing the
> +		 * native_wbinvd() above.
>  		 */
> -		asm volatile("wbinvd; hlt" : : : "memory");
> +		native_halt();
>  	}
>  }
>  
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
