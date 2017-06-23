Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dOKOT-0002xF-FP
 for kexec@lists.infradead.org; Fri, 23 Jun 2017 08:56:47 +0000
Date: Fri, 23 Jun 2017 10:56:07 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 31/36] x86/mm, kexec: Allow kexec to be used with SME
Message-ID: <20170623085606.ett5nuiow2ye7p3a@pd.tnic>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185545.18967.90815.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170616185545.18967.90815.stgit@tlendack-t1.amdoffice.net>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jun 16, 2017 at 01:55:45PM -0500, Tom Lendacky wrote:
> Provide support so that kexec can be used to boot a kernel when SME is
> enabled.
> 
> Support is needed to allocate pages for kexec without encryption.  This
> is needed in order to be able to reboot in the kernel in the same manner
> as originally booted.
> 
> Additionally, when shutting down all of the CPUs we need to be sure to
> flush the caches and then halt. This is needed when booting from a state
> where SME was not active into a state where SME is active (or vice-versa).
> Without these steps, it is possible for cache lines to exist for the same
> physical location but tagged both with and without the encryption bit. This
> can cause random memory corruption when caches are flushed depending on
> which cacheline is written last.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/init.h          |    1 +
>  arch/x86/include/asm/kexec.h         |    8 ++++++++
>  arch/x86/include/asm/pgtable_types.h |    1 +
>  arch/x86/kernel/machine_kexec_64.c   |   22 +++++++++++++++++++++-
>  arch/x86/kernel/process.c            |   17 +++++++++++++++--
>  arch/x86/mm/ident_map.c              |   12 ++++++++----
>  include/linux/kexec.h                |   14 ++++++++++++++
>  kernel/kexec_core.c                  |   12 +++++++++++-
>  8 files changed, 79 insertions(+), 8 deletions(-)

...

> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index c9481eb..5d17fd6 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -334,6 +334,20 @@ static inline void *boot_phys_to_virt(unsigned long entry)
>  	return phys_to_virt(boot_phys_to_phys(entry));
>  }
>  
> +#ifndef arch_kexec_post_alloc_pages
> +static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages,
> +					      gfp_t gfp)
> +{
> +	return 0;
> +}
> +#endif

Just a nitpick:

static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp) { return 0; }
static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }

Other than that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
