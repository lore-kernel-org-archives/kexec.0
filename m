Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v2 2/2] crash_core, vmcoreinfo: Append
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date: Tue, 12 Mar 2019 19:47:37 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03569E6D@BPXM09GP.gisp.nec.co.jp>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
 <1552212242-9479-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1552212242-9479-3-git-send-email-bhsharma@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, James Morse <james.morse@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Anderson <anderson@redhat.com>, Ingo Molnar <mingo@kernel.org>, Paul Mackerras <paulus@samba.org>

Hi Bhupesh,

-----Original Message-----
> Right now user-space tools like 'makedumpfile' and 'crash' need to rely
> on a best-guess method of determining value of 'MAX_PHYSMEM_BITS'
> supported by underlying kernel.
> 
> This value is used in user-space code to calculate the bit-space
> required to store a section for SPARESMEM (similar to the existing
> calculation method used in the kernel implementation):
> 
>   #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> 
> Now, regressions have been reported in user-space utilities
> like 'makedumpfile' and 'crash' on arm64, with the recently added
> kernel support for 52-bit physical address space, as there is
> no clear method of determining this value in user-space
> (other than reading kernel CONFIG flags).
> 
> As per suggestion from makedumpfile maintainer (Kazu), it makes more
> sense to append 'MAX_PHYSMEM_BITS' to vmcoreinfo in the core code itself
> rather than in arch-specific code, so that the user-space code for other
> archs can also benefit from this addition to the vmcoreinfo and use it
> as a standard way of determining 'SECTIONS_SHIFT' value in user-land.
> 
> A reference 'makedumpfile' implementation which reads the
> 'MAX_PHYSMEM_BITS' value from vmcoreinfo in a arch-independent fashion
> is available here:
> 
> [0]. https://github.com/bhupesh-sharma/makedumpfile/blob/remove-max-phys-mem-bit-v1/arch/ppc64.c#L471
> 
> Cc: Boris Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 093c9f917ed0..44b90368e183 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -467,6 +467,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
>  	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
>  #endif
> +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);

Some architectures define MAX_PHYSMEM_BITS only with CONFIG_SPARSEMEM,
so we need to move this to the #ifdef section that exports some
mem_section things.

Thanks!
Kazu

> 
>  	arch_crash_save_vmcoreinfo();
>  	update_vmcoreinfo_note();
> --
> 2.7.4
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
