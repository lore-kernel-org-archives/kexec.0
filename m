Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1d1FYG-0001Yy-92
 for kexec@lists.infradead.org; Thu, 20 Apr 2017 17:07:30 +0000
Date: Thu, 20 Apr 2017 18:59:22 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 05/32] x86/CPU/AMD: Handle SME reduction in physical
 address size
Message-ID: <20170420165922.j2inlwbchrs6senw@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211711.10190.30861.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170418211711.10190.30861.stgit@tlendack-t1.amdoffice.net>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Apr 18, 2017 at 04:17:11PM -0500, Tom Lendacky wrote:
> When System Memory Encryption (SME) is enabled, the physical address
> space is reduced. Adjust the x86_phys_bits value to reflect this
> reduction.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/cpu/amd.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

...

> @@ -622,8 +624,14 @@ static void early_init_amd(struct cpuinfo_x86 *c)
>  
>  			/* Check if SME is enabled */
>  			rdmsrl(MSR_K8_SYSCFG, msr);
> -			if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
> +			if (msr & MSR_K8_SYSCFG_MEM_ENCRYPT) {
> +				unsigned int ebx;
> +
> +				ebx = cpuid_ebx(0x8000001f);
> +				c->x86_phys_bits -= (ebx >> 6) & 0x3f;
> +			} else {
>  				clear_cpu_cap(c, X86_FEATURE_SME);
> +			}

Lemme do some simplifying to save an indent level, get rid of local var
ebx and kill some { }-brackets for a bit better readability:

        if (c->extended_cpuid_level >= 0x8000001f) {
                u64 msr;

                if (!cpu_has(c, X86_FEATURE_SME))
                        return;

                /* Check if SME is enabled */
                rdmsrl(MSR_K8_SYSCFG, msr);
                if (msr & MSR_K8_SYSCFG_MEM_ENCRYPT)
                        c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
                else
                        clear_cpu_cap(c, X86_FEATURE_SME);
        }

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
