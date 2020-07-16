Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvsqn-0000uG-5A
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 01:38:18 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466096898.24747.16701009925943468066.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 09/12] ppc64/kexec_file: setup backup region for kdump
 kernel
In-reply-to: <159466096898.24747.16701009925943468066.stgit@hbathini.in.ibm.com>
Date: Wed, 15 Jul 2020 22:38:01 -0300
Message-ID: <87y2nk8cjq.fsf@morokweng.localdomain>
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
Cc: kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

> @@ -968,7 +1040,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>
>  	/*
>  	 * Restrict memory usage for kdump kernel by setting up
> -	 * usable memory ranges.
> +	 * usable memory ranges and memory reserve map.
>  	 */
>  	if (image->type == KEXEC_TYPE_CRASH) {
>  		ret = get_usable_memory_ranges(&umem);
> @@ -980,6 +1052,24 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>  			pr_err("Error setting up usable-memory property for kdump kernel\n");
>  			goto out;
>  		}
> +
> +		ret = fdt_add_mem_rsv(fdt, BACKUP_SRC_START + BACKUP_SRC_SIZE,
> +				      crashk_res.start - BACKUP_SRC_SIZE);

I believe this answers my question from the other email about how the
crashkernel is prevented from stomping in the crashed kernel's memory,
right? I needed to think for a bit to understand what the above
reservation was protecting. I think it's worth adding a comment.

> +		if (ret) {
> +			pr_err("Error reserving crash memory: %s\n",
> +			       fdt_strerror(ret));
> +			goto out;
> +		}
> +	}
> +
> +	if (image->arch.backup_start) {
> +		ret = fdt_add_mem_rsv(fdt, image->arch.backup_start,
> +				      BACKUP_SRC_SIZE);
> +		if (ret) {
> +			pr_err("Error reserving memory for backup: %s\n",
> +			       fdt_strerror(ret));
> +			goto out;
> +		}
>  	}

This is only true for KEXEC_TYPE_CRASH, if I'm following the code
correctly. I think it would be clearer to put the if above inside the if
for KEXEC_TYPE_CRASH to make it clearer.

>
>  	ret = setup_new_fdt(image, fdt, initrd_load_addr, initrd_len,

<snip>

> diff --git a/arch/powerpc/purgatory/purgatory_64.c b/arch/powerpc/purgatory/purgatory_64.c
> new file mode 100644
> index 0000000..1eca74c
> --- /dev/null
> +++ b/arch/powerpc/purgatory/purgatory_64.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * purgatory: Runs between two kernels
> + *
> + * Copyright 2020, Hari Bathini, IBM Corporation.
> + */
> +
> +#include <asm/purgatory.h>
> +#include <asm/crashdump-ppc64.h>
> +
> +extern unsigned long backup_start;
> +
> +static void *__memcpy(void *dest, const void *src, unsigned long n)
> +{
> +	unsigned long i;
> +	unsigned char *d;
> +	const unsigned char *s;
> +
> +	d = dest;
> +	s = src;
> +	for (i = 0; i < n; i++)
> +		d[i] = s[i];
> +
> +	return dest;
> +}
> +
> +void purgatory(void)
> +{
> +	void *dest, *src;
> +
> +	src = (void *)BACKUP_SRC_START;
> +	if (backup_start) {
> +		dest = (void *)backup_start;
> +		__memcpy(dest, src, BACKUP_SRC_SIZE);
> +	}
> +}

In general I'm in favor of using C code over assembly, but having to
bring in that relocation support just for the above makes me wonder if
it's worth it in this case.

--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
