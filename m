Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OQ3Um-0002Xy-SP
	for kexec@lists.infradead.org; Sat, 19 Jun 2010 19:14:25 +0000
References: <20100619132235.GA24200@basil.fritz.box>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 19 Jun 2010 12:13:56 -0700
In-Reply-To: <20100619132235.GA24200@basil.fritz.box> (Andi Kleen's message of
	"Sat\, 19 Jun 2010 15\:22\:35 +0200")
Message-ID: <m1y6eau96z.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Export kexec.h
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, akpm@linux-foundation.org, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org

Andi Kleen <andi@firstfloor.org> writes:

> Export kexec.h
>     
> kexec_load is a system call and it needs a header
> file with its input arguments.
>
> Export the parts of kexec.h needed for this.
>
> Cc: ebiederm@xmission.com
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Is there a corresponding patch for /sbin/kexec ?
What is the reason for wanting to export a currently kernel only header?

Not that I am really opposed but without a bit more context I can't
make a reasonable review of these patches.

Eric


> diff --git a/include/linux/Kbuild b/include/linux/Kbuild
> index 2fc8e14..8fd5d09 100644
> --- a/include/linux/Kbuild
> +++ b/include/linux/Kbuild
> @@ -389,3 +389,5 @@ unifdef-y += xfrm.h
>  objhdr-y += version.h
>  header-y += wimax.h
>  header-y += wimax/
> +
> +unifdef-y += kexec.h
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 03e8e8d..f4c5a0e 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -1,8 +1,46 @@
>  #ifndef LINUX_KEXEC_H
>  #define LINUX_KEXEC_H
>  
> -#ifdef CONFIG_KEXEC
> +/* Kexec: one kernel loading another */
> +
> +#ifdef __KERNEL__
> +#include <linux/compiler.h>
>  #include <linux/types.h>
> +#endif
> +
> +#define KEXEC_ON_CRASH		0x00000001
> +#define KEXEC_PRESERVE_CONTEXT	0x00000002
> +#define KEXEC_ARCH_MASK		0xffff0000
> +
> +/* These values match the ELF architecture values.
> + * Unless there is a good reason that should continue to be the case.
> + */
> +#define KEXEC_ARCH_DEFAULT ( 0 << 16)
> +#define KEXEC_ARCH_386     ( 3 << 16)
> +#define KEXEC_ARCH_X86_64  (62 << 16)
> +#define KEXEC_ARCH_PPC     (20 << 16)
> +#define KEXEC_ARCH_PPC64   (21 << 16)
> +#define KEXEC_ARCH_IA_64   (50 << 16)
> +#define KEXEC_ARCH_ARM     (40 << 16)
> +#define KEXEC_ARCH_S390    (22 << 16)
> +#define KEXEC_ARCH_SH      (42 << 16)
> +#define KEXEC_ARCH_MIPS_LE (10 << 16)
> +#define KEXEC_ARCH_MIPS    ( 8 << 16)
> +
> +#define KEXEC_SEGMENT_MAX 16
> +struct kexec_segment {
> +	void __user *buf;
> +	size_t bufsz;
> +#ifdef __KERNEL__
> +	unsigned long mem;	/* User space sees this as a (void *) ... */
> +#else
> +	void *mem;
> +#endif
> +	size_t memsz;
> +};
> +
> +#ifdef __KERNEL__
> +#ifdef CONFIG_KEXEC
>  #include <linux/list.h>
>  #include <linux/linkage.h>
>  #include <linux/compat.h>
> @@ -57,14 +95,6 @@ typedef unsigned long kimage_entry_t;
>  #define IND_DONE         0x4
>  #define IND_SOURCE       0x8
>  
> -#define KEXEC_SEGMENT_MAX 16
> -struct kexec_segment {
> -	void __user *buf;
> -	size_t bufsz;
> -	unsigned long mem;	/* User space sees this as a (void *) ... */
> -	size_t memsz;
> -};
> -
>  #ifdef CONFIG_COMPAT
>  struct compat_kexec_segment {
>  	compat_uptr_t buf;
> @@ -163,25 +193,6 @@ extern struct kimage *kexec_crash_image;
>  #define kexec_flush_icache_page(page)
>  #endif
>  
> -#define KEXEC_ON_CRASH		0x00000001
> -#define KEXEC_PRESERVE_CONTEXT	0x00000002
> -#define KEXEC_ARCH_MASK		0xffff0000
> -
> -/* These values match the ELF architecture values.
> - * Unless there is a good reason that should continue to be the case.
> - */
> -#define KEXEC_ARCH_DEFAULT ( 0 << 16)
> -#define KEXEC_ARCH_386     ( 3 << 16)
> -#define KEXEC_ARCH_X86_64  (62 << 16)
> -#define KEXEC_ARCH_PPC     (20 << 16)
> -#define KEXEC_ARCH_PPC64   (21 << 16)
> -#define KEXEC_ARCH_IA_64   (50 << 16)
> -#define KEXEC_ARCH_ARM     (40 << 16)
> -#define KEXEC_ARCH_S390    (22 << 16)
> -#define KEXEC_ARCH_SH      (42 << 16)
> -#define KEXEC_ARCH_MIPS_LE (10 << 16)
> -#define KEXEC_ARCH_MIPS    ( 8 << 16)
> -
>  /* List of defined/legal kexec flags */
>  #ifndef CONFIG_KEXEC_JUMP
>  #define KEXEC_FLAGS    KEXEC_ON_CRASH
> @@ -215,4 +226,5 @@ struct task_struct;
>  static inline void crash_kexec(struct pt_regs *regs) { }
>  static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>  #endif /* CONFIG_KEXEC */
> +#endif
>  #endif /* LINUX_KEXEC_H */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
