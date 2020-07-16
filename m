Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvt1b-0001m2-G5
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 01:49:28 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466085652.24747.2414199807974963385.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 02/12] powerpc/kexec_file: mark PPC64 specific code
In-reply-to: <159466085652.24747.2414199807974963385.stgit@hbathini.in.ibm.com>
Date: Wed, 15 Jul 2020 22:49:12 -0300
Message-ID: <87v9io8c13.fsf@morokweng.localdomain>
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


I didn't forget about this patch. I just wanted to see more of the
changes before comenting on it.

Hari Bathini <hbathini@linux.ibm.com> writes:

> Some of the kexec_file_load code isn't PPC64 specific. Move PPC64
> specific code from kexec/file_load.c to kexec/file_load_64.c. Also,
> rename purgatory/trampoline.S to purgatory/trampoline_64.S in the
> same spirit.

There's only a 64 bit implementation of kexec_file_load() so this is a
somewhat theoretical exercise, but there's no harm in getting the code
organized, so:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

I have just one question below.

> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>
> ---
>
> v2 -> v3:
> * Unchanged. Added Tested-by tag from Pingfan.
>
> v1 -> v2:
> * No changes.
>
>
>  arch/powerpc/include/asm/kexec.h       |   11 +++
>  arch/powerpc/kexec/Makefile            |    2 -
>  arch/powerpc/kexec/elf_64.c            |    7 +-
>  arch/powerpc/kexec/file_load.c         |   37 ++--------
>  arch/powerpc/kexec/file_load_64.c      |  108 ++++++++++++++++++++++++++++++
>  arch/powerpc/purgatory/Makefile        |    4 +
>  arch/powerpc/purgatory/trampoline.S    |  117 --------------------------------
>  arch/powerpc/purgatory/trampoline_64.S |  117 ++++++++++++++++++++++++++++++++
>  8 files changed, 248 insertions(+), 155 deletions(-)
>  create mode 100644 arch/powerpc/kexec/file_load_64.c
>  delete mode 100644 arch/powerpc/purgatory/trampoline.S
>  create mode 100644 arch/powerpc/purgatory/trampoline_64.S

<snip>

> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> new file mode 100644
> index 0000000..e6bff960
> --- /dev/null
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ppc64 code to implement the kexec_file_load syscall
> + *
> + * Copyright (C) 2004  Adam Litke (agl@us.ibm.com)
> + * Copyright (C) 2004  IBM Corp.
> + * Copyright (C) 2004,2005  Milton D Miller II, IBM Corporation
> + * Copyright (C) 2005  R Sharada (sharada@in.ibm.com)
> + * Copyright (C) 2006  Mohan Kumar M (mohan@in.ibm.com)
> + * Copyright (C) 2020  IBM Corporation
> + *
> + * Based on kexec-tools' kexec-ppc64.c, kexec-elf-rel-ppc64.c, fs2dt.c.
> + * Heavily modified for the kernel by
> + * Hari Bathini <hbathini@linux.ibm.com>.
> + */
> +
> +#include <linux/kexec.h>
> +#include <linux/of_fdt.h>
> +#include <linux/libfdt.h>
> +
> +const struct kexec_file_ops * const kexec_file_loaders[] = {
> +	&kexec_elf64_ops,
> +	NULL
> +};
> +
> +/**
> + * setup_purgatory_ppc64 - initialize PPC64 specific purgatory's global
> + *                         variables and call setup_purgatory() to initialize
> + *                         common global variable.
> + * @image:                 kexec image.
> + * @slave_code:            Slave code for the purgatory.
> + * @fdt:                   Flattened device tree for the next kernel.
> + * @kernel_load_addr:      Address where the kernel is loaded.
> + * @fdt_load_addr:         Address where the flattened device tree is loaded.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
> +			  const void *fdt, unsigned long kernel_load_addr,
> +			  unsigned long fdt_load_addr)
> +{
> +	int ret;
> +
> +	ret = setup_purgatory(image, slave_code, fdt, kernel_load_addr,
> +			      fdt_load_addr);
> +	if (ret)
> +		pr_err("Failed to setup purgatory symbols");
> +	return ret;
> +}
> +
> +/**
> + * setup_new_fdt_ppc64 - Update the flattend device-tree of the kernel
> + *                       being loaded.
> + * @image:               kexec image being loaded.
> + * @fdt:                 Flattened device tree for the next kernel.
> + * @initrd_load_addr:    Address where the next initrd will be loaded.
> + * @initrd_len:          Size of the next initrd, or 0 if there will be none.
> + * @cmdline:             Command line for the next kernel, or NULL if there will
> + *                       be none.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
> +			unsigned long initrd_load_addr,
> +			unsigned long initrd_len, const char *cmdline)
> +{
> +	int chosen_node, ret;
> +
> +	/* Remove memory reservation for the current device tree. */
> +	ret = delete_fdt_mem_rsv(fdt, __pa(initial_boot_params),
> +				 fdt_totalsize(initial_boot_params));
> +	if (ret == 0)
> +		pr_debug("Removed old device tree reservation.\n");
> +	else if (ret != -ENOENT) {
> +		pr_err("Failed to remove old device-tree reservation.\n");
> +		return ret;
> +	}
> +
> +	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len,
> +			    cmdline, &chosen_node);
> +	if (ret)
> +		return ret;
> +
> +	ret = fdt_setprop(fdt, chosen_node, "linux,booted-from-kexec", NULL, 0);
> +	if (ret)
> +		pr_err("Failed to update device-tree with linux,booted-from-kexec\n");
> +
> +	return ret;
> +}

For setup_purgatory_ppc64() you start with an empty function and build
from there, but for setup_new_fdt_ppc64() you moved some code here. Is
the code above 64 bit specific?

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
