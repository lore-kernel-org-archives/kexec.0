Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 12 Jan 2017 17:33:53 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv7 00/11] CONFIG_DEBUG_VIRTUAL for arm64
Message-ID: <20170112173352.GJ13843@arm.com>
References: <1484084150-1523-1-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1484084150-1523-1-git-send-email-labbott@redhat.com>
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
To: Laura Abbott <labbott@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Florian Fainelli <f.fainelli@gmail.com>, x86@kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, xen-devel@lists.xenproject.org, David Vrabel <david.vrabel@citrix.com>, Kees Cook <keescook@chromium.org>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Christoffer Dall <christoffer.dall@linaro.org>

On Tue, Jan 10, 2017 at 01:35:39PM -0800, Laura Abbott wrote:
> This is v7 of the patches to add CONFIG_DEBUG_VIRTUAL for arm64. This is
> a simple reordering of patches from v6 per request of Will Deacon for ease
> of merging support for arm which depends on this series.
> 
> Laura Abbott (11):
>   lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
>   mm/cma: Cleanup highmem check
>   mm: Introduce lm_alias
>   kexec: Switch to __pa_symbol
>   mm/kasan: Switch to using __pa_symbol and lm_alias
>   mm/usercopy: Switch to using lm_alias
>   drivers: firmware: psci: Use __pa_symbol for kernel symbol
>   arm64: Move some macros under #ifndef __ASSEMBLY__
>   arm64: Add cast for virt_to_pfn
>   arm64: Use __pa_symbol for kernel symbols
>   arm64: Add support for CONFIG_DEBUG_VIRTUAL

I've pushed this into linux-next and, assuming it survives the
autobuilders etc I'll co-ordinate with Russell to get the common parts
pulled into the ARM tree too (so he can take Florian's series). They're
currently split out on the arm64 for-next/debug-virtual branch.

Thanks!

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
