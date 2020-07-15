Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvXL2-0001wa-OC
 for kexec@lists.infradead.org; Wed, 15 Jul 2020 02:40:05 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466088775.24747.1248185448154277951.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 04/12] ppc64/kexec_file: avoid stomping memory used by
 special regions
In-reply-to: <159466088775.24747.1248185448154277951.stgit@hbathini.in.ibm.com>
Date: Tue, 14 Jul 2020 23:39:45 -0300
Message-ID: <87365t8pse.fsf@morokweng.localdomain>
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


Hari Bathini <hbathini@linux.ibm.com> writes:

> diff --git a/arch/powerpc/include/asm/crashdump-ppc64.h b/arch/powerpc/include/asm/crashdump-ppc64.h
> new file mode 100644
> index 0000000..90deb46
> --- /dev/null
> +++ b/arch/powerpc/include/asm/crashdump-ppc64.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_POWERPC_CRASHDUMP_PPC64_H
> +#define _ASM_POWERPC_CRASHDUMP_PPC64_H
> +
> +/* min & max addresses for kdump load segments */
> +#define KDUMP_BUF_MIN		(crashk_res.start)
> +#define KDUMP_BUF_MAX		((crashk_res.end < ppc64_rma_size) ? \
> +				 crashk_res.end : (ppc64_rma_size - 1))
> +
> +#endif /* __ASM_POWERPC_CRASHDUMP_PPC64_H */
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 7008ea1..bf47a01 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -100,14 +100,16 @@ void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_co
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops kexec_elf64_ops;
>
> -#ifdef CONFIG_IMA_KEXEC
>  #define ARCH_HAS_KIMAGE_ARCH
>
>  struct kimage_arch {
> +	struct crash_mem *exclude_ranges;
> +
> +#ifdef CONFIG_IMA_KEXEC
>  	phys_addr_t ima_buffer_addr;
>  	size_t ima_buffer_size;
> -};
>  #endif
> +};
>
>  int setup_purgatory(struct kimage *image, const void *slave_code,
>  		    const void *fdt, unsigned long kernel_load_addr,
> @@ -125,6 +127,7 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
>  			unsigned long initrd_load_addr,
>  			unsigned long initrd_len, const char *cmdline);
>  #endif /* CONFIG_PPC64 */
> +
>  #endif /* CONFIG_KEXEC_FILE */
>
>  #else /* !CONFIG_KEXEC_CORE */
> diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
> index 23ad04c..c695f94 100644
> --- a/arch/powerpc/kexec/elf_64.c
> +++ b/arch/powerpc/kexec/elf_64.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_fdt.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <asm/crashdump-ppc64.h>
>
>  static void *elf64_load(struct kimage *image, char *kernel_buf,
>  			unsigned long kernel_len, char *initrd,
> @@ -46,6 +47,12 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>  	if (ret)
>  		goto out;
>
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		/* min & max buffer values for kdump case */
> +		kbuf.buf_min = pbuf.buf_min = KDUMP_BUF_MIN;
> +		kbuf.buf_max = pbuf.buf_max = KDUMP_BUF_MAX;

This is only my personal opinion and an actual maintainer may disagree,
but just looking at the lines above, I would assume that KDUMP_BUF_MIN
and KDUMP_BUF_MAX were constants, when in fact they aren't.

I suggest using static inline macros in <asm/crashdump-ppc64.h>, for
example:

static inline resource_size_t get_kdump_buf_min(void)
{
	return crashk_res.start;
}

static inline resource_size_t get_kdump_buf_max(void)
{
	return (crashk_res.end < ppc64_rma_size) ? \
		 crashk_res.end : (ppc64_rma_size - 1)
}


> +	}
> +
>  	ret = kexec_elf_load(image, &ehdr, &elf_info, &kbuf, &kernel_load_addr);
>  	if (ret)
>  		goto out;

<snip>

> +/**
> + * __locate_mem_hole_top_down - Looks top down for a large enough memory hole
> + *                              in the memory regions between buf_min & buf_max
> + *                              for the buffer. If found, sets kbuf->mem.
> + * @kbuf:                       Buffer contents and memory parameters.
> + * @buf_min:                    Minimum address for the buffer.
> + * @buf_max:                    Maximum address for the buffer.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int __locate_mem_hole_top_down(struct kexec_buf *kbuf,
> +				      u64 buf_min, u64 buf_max)
> +{
> +	int ret = -EADDRNOTAVAIL;
> +	phys_addr_t start, end;
> +	u64 i;
> +
> +	for_each_mem_range_rev(i, &memblock.memory, NULL, NUMA_NO_NODE,
> +			       MEMBLOCK_NONE, &start, &end, NULL) {
> +		if (start > buf_max)
> +			continue;
> +
> +		/* Memory hole not found */
> +		if (end < buf_min)
> +			break;
> +
> +		/* Adjust memory region based on the given range */
> +		if (start < buf_min)
> +			start = buf_min;
> +		if (end > buf_max)
> +			end = buf_max;
> +
> +		start = ALIGN(start, kbuf->buf_align);
> +		if (start < end && (end - start + 1) >= kbuf->memsz) {

This is why I dislike using start and end to express address ranges:

While struct resource seems to use the [address, end] convention, my
reading of memblock code is that it uses [addres, end). This is
guaranteed to lead to bugs. So the above has an off-by-one error. To
calculate the size of the current range, you need to use `end - start`.

> +			/* Suitable memory range found. Set kbuf->mem */
> +			kbuf->mem = ALIGN_DOWN(end - kbuf->memsz + 1,

Similarly, I believe the `+ 1` here is wrong.

> +					       kbuf->buf_align);
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * locate_mem_hole_top_down_ppc64 - Skip special memory regions to find a
> + *                                  suitable buffer with top down approach.
> + * @kbuf:                           Buffer contents and memory parameters.
> + * @buf_min:                        Minimum address for the buffer.
> + * @buf_max:                        Maximum address for the buffer.
> + * @emem:                           Exclude memory ranges.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int locate_mem_hole_top_down_ppc64(struct kexec_buf *kbuf,
> +					  u64 buf_min, u64 buf_max,
> +					  const struct crash_mem *emem)
> +{
> +	int i, ret = 0, err = -EADDRNOTAVAIL;
> +	u64 start, end, tmin, tmax;
> +
> +	tmax = buf_max;
> +	for (i = (emem->nr_ranges - 1); i >= 0; i--) {
> +		start = emem->ranges[i].start;
> +		end = emem->ranges[i].end;
> +
> +		if (start > tmax)
> +			continue;
> +
> +		if (end < tmax) {
> +			tmin = (end < buf_min ? buf_min : end + 1);
> +			ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
> +			if (!ret)
> +				return 0;
> +		}
> +
> +		tmax = start - 1;
> +
> +		if (tmax < buf_min) {
> +			ret = err;
> +			break;
> +		}
> +		ret = 0;
> +	}
> +
> +	if (!ret) {
> +		tmin = buf_min;
> +		ret = __locate_mem_hole_top_down(kbuf, tmin, tmax);
> +	}
> +	return ret;
> +}
> +
> +/**
> + * __locate_mem_hole_bottom_up - Looks bottom up for a large enough memory hole
> + *                               in the memory regions between buf_min & buf_max
> + *                               for the buffer. If found, sets kbuf->mem.
> + * @kbuf:                        Buffer contents and memory parameters.
> + * @buf_min:                     Minimum address for the buffer.
> + * @buf_max:                     Maximum address for the buffer.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int __locate_mem_hole_bottom_up(struct kexec_buf *kbuf,
> +				       u64 buf_min, u64 buf_max)
> +{
> +	int ret = -EADDRNOTAVAIL;
> +	phys_addr_t start, end;
> +	u64 i;
> +
> +	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> +			   MEMBLOCK_NONE, &start, &end, NULL) {
> +		if (end < buf_min)
> +			continue;
> +
> +		/* Memory hole not found */
> +		if (start > buf_max)
> +			break;
> +
> +		/* Adjust memory region based on the given range */
> +		if (start < buf_min)
> +			start = buf_min;
> +		if (end > buf_max)
> +			end = buf_max;

buf_max is an inclusive end address, right? Then this should read
`end = buf_max + 1`. Same thing in the top-down version above.

> +
> +		start = ALIGN(start, kbuf->buf_align);
> +		if (start < end && (end - start + 1) >= kbuf->memsz) {

Same off-by-one problem. There shouldn't be a `+ 1` here.

> +			/* Suitable memory range found. Set kbuf->mem */
> +			kbuf->mem = start;
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}


--
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
