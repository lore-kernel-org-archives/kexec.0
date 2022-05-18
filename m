From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 18 May 2022 13:47:05 -0700
Subject: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
In-Reply-To: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <20220518134705.7ae186d5419b24d689a38ccc@linux-foundation.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, 18 May 2022 23:48:28 +0530 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> symbols") [1], binutils (v2.36+) started dropping section symbols that
> it thought were unused.  This isn't an issue in general, but with
> kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
> separate .text.unlikely section and the section symbol ".text.unlikely"
> is being dropped. Due to this, recordmcount is unable to find a non-weak
> symbol in .text.unlikely to generate a relocation record against.
> 
> Address this by dropping the weak attribute from these functions:
> - arch_kexec_apply_relocations() is not overridden by any architecture
>   today, so just drop the weak attribute.
> - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>   Retain the function prototype for those and move the weak
>   implementation into the header as a static inline for other
>   architectures.
> 
> ...
>

Sigh.  This patch demonstrates why I like __weak :<

> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -229,6 +225,30 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mend);
>  extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
>  				       void **addr, unsigned long *sz);
> +
> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)

Let's avoid listing the architectures here?  Better to add

	select ARCH_HAVE_ARCH_KEXEC_APPLY_RELOCATIONS_ADD

to arch/<arch>/Kconfig?

Please cc me on any additional work on this.

