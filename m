Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqcf0-008tRu-Q9
 for kexec@lists.infradead.org; Tue, 08 Jun 2021 14:24:56 +0000
Date: Tue, 8 Jun 2021 22:24:32 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] crash_core, vmcoreinfo: Append 'SECTION_SIZE_BITS' to
 vmcoreinfo
Message-ID: <20210608142432.GA587883@MiWiFi-R3L-srv>
References: <20210608103359.84907-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210608103359.84907-1-kernelfans@gmail.com>
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
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>, akpm@linux-foundation.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Dave Young <dyoung@redhat.com>, Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Anderson <anderson@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org

On 06/08/21 at 06:33am, Pingfan Liu wrote:
> As mentioned in kernel commit 1d50e5d0c505 ("crash_core, vmcoreinfo:
> Append 'MAX_PHYSMEM_BITS' to vmcoreinfo"), SECTION_SIZE_BITS in the
> formula:
>     #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> 
> Besides SECTIONS_SHIFT, SECTION_SIZE_BITS is also used to calculate
> PAGES_PER_SECTION in makedumpfile just like kernel.
> 
> Unfortunately, this arch-dependent macro SECTION_SIZE_BITS changes, e.g.
> recently in kernel commit f0b13ee23241 ("arm64/sparsemem: reduce
> SECTION_SIZE_BITS"). But user space wants a stable interface to get this
> info. Such info is impossible to be deduced from a crashdump vmcore.
> Hence append SECTION_SIZE_BITS to vmcoreinfo.

> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Boris Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Cc: x86@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org


Add the discussion of the original thread in kexec ML for reference:
http://lists.infradead.org/pipermail/kexec/2021-June/022676.html

This looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 825284baaf46..684a6061a13a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -464,6 +464,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>  	VMCOREINFO_STRUCT_SIZE(mem_section);
>  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> +	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
>  	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>  #endif
>  	VMCOREINFO_STRUCT_SIZE(page);
> -- 
> 2.29.2
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
