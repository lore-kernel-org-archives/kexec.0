Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fZvrW-0002U4-2m
 for kexec@lists.infradead.org; Mon, 02 Jul 2018 10:15:17 +0000
Date: Mon, 2 Jul 2018 12:14:51 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
Message-ID: <20180702101451.GB28730@zn.tnic>
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180702072639.10110-2-lijiang@redhat.com>
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
Cc: thomas.lendacky@amd.com, bhe@redhat.com, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

On Mon, Jul 02, 2018 at 03:26:35PM +0800, Lianbo Jiang wrote:
> @@ -131,7 +132,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>   * caller shouldn't need to know that small detail.
>   */
>  static void __iomem *__ioremap_caller(resource_size_t phys_addr,
> -		unsigned long size, enum page_cache_mode pcm, void *caller)
> +		unsigned long size, enum page_cache_mode pcm,
> +		void *caller, bool encrypted)

So instead of sprinkling that @encrypted argument everywhere and then
setting it based on sme_active() ...

>  {
>  	unsigned long offset, vaddr;
>  	resource_size_t last_addr;
> @@ -199,7 +201,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>  	 * resulting mapping.
>  	 */
>  	prot = PAGE_KERNEL_IO;
> -	if (sev_active() && mem_flags.desc_other)
> +	if ((sev_active() && mem_flags.desc_other) || encrypted)

... why can't you simply do your checks:

	sme_active() && is_kdump_kernel()

here so that __ioremap_caller() can automatically choose the proper
pgprot value when ioremapping the memory in the kdump kernel?

And this way the callers don't even have to care whether the memory is
encrypted or not?

>  		prot = pgprot_encrypted(prot);
>  
>  	switch (pcm) {

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
