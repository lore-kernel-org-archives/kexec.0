Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h84cC-0000Tc-6q
 for kexec@lists.infradead.org; Sun, 24 Mar 2019 15:00:49 +0000
Date: Sun, 24 Mar 2019 16:00:34 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
Message-ID: <20190324150034.GH23289@zn.tnic>
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190315103203.13128-2-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

> Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when SEV is active

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

On Fri, Mar 15, 2019 at 06:32:01PM +0800, Lianbo Jiang wrote:
> Currently, the arch_kexec_post_{alloc,free}_pages unconditionally

Please end function names with parentheses.

> maps the kexec area as decrypted. This works fine when SME is active.
> Because in SME, the first kernel is loaded in decrypted area by the
> BIOS, so the second kernel must be also loaded into the decrypted
> memory.
> 
> When SEV is active, the first kernel is loaded into the encrypted
> area, so the second kernel must be also loaded into the encrypted
> memory. Lets make sure that arch_kexec_post_{alloc,free}_pages does
> not clear the memory encryption mask from the kexec area when SEV
> is active.

Hold on, wait a minute!

Why do we even need this? As usual, you guys never explain what the big
picture is. So you mention SEV, which sounds to me like you want to be
able to kexec the SEV *guest*. Yes?

First of all, why?

Then, if so...

> Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index ceba408ea982..bcebf4993da4 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -566,7 +566,10 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
>  	 * not encrypted because when we boot to the new kernel the
>  	 * pages won't be accessed encrypted (initially).
>  	 */
> -	return set_memory_decrypted((unsigned long)vaddr, pages);
> +	if (sme_active())
> +		return set_memory_decrypted((unsigned long)vaddr, pages);

... then this looks yucky. Because, you're adding an sme_active() check here
but then __set_memory_enc_dec() checks

	if (!mem_encrypt_active())

and heads will spin from all the checking of memory encryption aspects.

So this would need a rework so that there are no multiple confusing
checks.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
