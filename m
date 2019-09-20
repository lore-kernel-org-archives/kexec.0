Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
References: <20190913225009.3406-1-prsriva@linux.microsoft.com>
 <20190913225009.3406-2-prsriva@linux.microsoft.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima measurement
 log in kexec_file_load
In-reply-to: <20190913225009.3406-2-prsriva@linux.microsoft.com>
Date: Fri, 20 Sep 2019 00:07:02 -0300
Message-ID: <87zhiz1x9l.fsf@morokweng.localdomain>
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
To: Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, takahiro.akashi@linaro.org, sboyd@kernel.org, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, yamada.masahiro@socionext.com, kristina.martsenko@arm.org, duwe@lst.de, allison@lohutok.net, james.morse@arm.org, linux-integrity@vger.kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org


Hello Prakhar,

Prakhar Srivastava <prsriva@linux.microsoft.com> writes:

> During kexec_file_load, carrying forward the ima measurement log allows
> a verifying party to get the entire runtime event log since the last
> full reboot since that is when PCRs were last reset.
>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> ---
>  arch/arm64/Kconfig                     |   7 +
>  arch/arm64/include/asm/ima.h           |  29 ++++
>  arch/arm64/include/asm/kexec.h         |   5 +
>  arch/arm64/kernel/Makefile             |   3 +-
>  arch/arm64/kernel/ima_kexec.c          | 213 +++++++++++++++++++++++++
>  arch/arm64/kernel/machine_kexec_file.c |   6 +
>  6 files changed, 262 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/ima.h
>  create mode 100644 arch/arm64/kernel/ima_kexec.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 3adcec05b1f6..f39b12dbf9e8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -976,6 +976,13 @@ config KEXEC_VERIFY_SIG
>  	  verification for the corresponding kernel image type being
>  	  loaded in order for this to work.
>
> +config HAVE_IMA_KEXEC
> +	bool "Carry over IMA measurement log during kexec_file_load() syscall"
> +	depends on KEXEC_FILE
> +	help
> +	  Select this option to carry over IMA measurement log during
> +	  kexec_file_load.
> +
>  config KEXEC_IMAGE_VERIFY_SIG
>  	bool "Enable Image signature verification support"
>  	default y

This is not right. As it stands, HAVE_IMA_KEXEC is essentially a synonym
for IMA_KEXEC.

It's not meant to be user-visible in the config process. Instead, it's
meant to be selected by the arch Kconfig (probably by the ARM64 config
symbol) to signal to IMA's Kconfig that it can offer the IMA_KEXEC
option.

I also mentioned in my previous review that config HAVE_IMA_KEXEC should
be defined in arch/Kconfig, not separately in both arch/arm64/Kconfig
and arch/powerpc/Kconfig.

> diff --git a/arch/arm64/include/asm/ima.h b/arch/arm64/include/asm/ima.h
> new file mode 100644
> index 000000000000..e23cee84729f
> --- /dev/null
> +++ b/arch/arm64/include/asm/ima.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_IMA_H
> +#define _ASM_ARM64_IMA_H
> +
> +struct kimage;
> +
> +int ima_get_kexec_buffer(void **addr, size_t *size);
> +int ima_free_kexec_buffer(void);
> +
> +#ifdef CONFIG_IMA
> +void remove_ima_buffer(void *fdt, int chosen_node);
> +#else
> +static inline void remove_ima_buffer(void *fdt, int chosen_node) {}
> +#endif

I mentioned in my previous review that remove_ima_buffer() should exist
even if CONFIG_IMA isn't set. Did you arrive at a different conclusion?

> +
> +#ifdef CONFIG_IMA_KEXEC
> +int arch_ima_add_kexec_buffer(struct kimage *image, unsigned long load_addr,
> +			      size_t size);
> +
> +int setup_ima_buffer(const struct kimage *image, void *fdt, int chosen_node);
> +#else
> +static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
> +				   int chosen_node)
> +{
> +	remove_ima_buffer(fdt, chosen_node);
> +	return 0;
> +}
> +#endif /* CONFIG_IMA_KEXEC */
> +#endif /* _ASM_ARM64_IMA_H */

> diff --git a/arch/arm64/kernel/ima_kexec.c b/arch/arm64/kernel/ima_kexec.c
> new file mode 100644
> index 000000000000..b14326d541f3
> --- /dev/null
> +++ b/arch/arm64/kernel/ima_kexec.c

In the previous patch, you took the powerpc file and made a few
modifications to fit your needs. This file is now somewhat different
than the powerpc version, but I don't understand to what purpose. It's
not different in any significant way.

Based on review comments from your previous patch, I was expecting to
see code from the powerpc file moved to an arch-independent part of the
the kernel and possibly adapted so that both arm64 and powerpc could use
it. Can you explain why you chose this approach instead? What is the
advantage of having superficially different but basically equivalent
code in the two architectures?

Actually, there's one change that is significant: instead of a single
linux,ima-kexec-buffer property holding the start address and size of
the buffer, ARM64 is now using two properties (linux,ima-kexec-buffer
and linux,ima-kexec-buffer-end) for the start and end addresses. In my
opinion, unless there's a good reason for it Linux should be consistent
accross architectures when possible.

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
