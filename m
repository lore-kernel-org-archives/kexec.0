Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v12 12/16] arm64: kexec_file: add crash dump support
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-13-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <e7605411-c54f-c744-43a7-aecc0e36e3f3@arm.com>
Date: Thu, 26 Jul 2018 14:36:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180724065759.19186-13-takahiro.akashi@linaro.org>
Content-Language: en-US
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> Enabling crash dump (kdump) includes
> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>   using crash_prepare_elf64_headers(), and
> * add two device tree properties, "linux,usable-memory-range" and
>   "linux,elfcorehdr", which represent respectively a memory range
>   to be used by crash dump kernel and the header's location

> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 5d102a1054b3..1b2c27026ae0 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -97,8 +97,12 @@ static inline void crash_post_resume(void) {}
>  #define ARCH_HAS_KIMAGE_ARCH
>  
>  struct kimage_arch {

> -	void *dtb_buf;
> +	void *dtb;

This change should be in an earlier patch, otherwise this series doesn't build
during bisect.

With the build-issues fixed:
Reviewed-by: James Morse <james.morse@arm.com>

Some boring Nits:

>  	unsigned long dtb_mem;
> +	/* Core ELF header buffer */
> +	void *elf_headers;
> +	unsigned long elf_headers_mem;
> +	unsigned long elf_headers_sz;
>  };
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index b8297f10e2ef..7356da5a53d5 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -38,12 +44,30 @@ static int setup_dtb(struct kimage *image,
>  		void **dtb_buf, unsigned long *dtb_buf_len)
>  {
>  	void *buf = NULL;
> -	size_t buf_size;
> +	size_t buf_size, range_size;
>  	int nodeoffset;
>  	int ret;
>  
>  	/* duplicate dt blob */
>  	buf_size = fdt_totalsize(initial_boot_params);
> +	range_size = of_fdt_reg_cells_size();
> +
> +	if (image->type == KEXEC_TYPE_CRASH) {
> +		buf_size += fdt_prop_len("linux,elfcorehdr", range_size);
> +		buf_size += fdt_prop_len("linux,usable-memory-range",
> +								range_size);
> +	}

Nit: it would be better if these strings were defined in a header file somewhere
so we don't risk a typo if this gets refactored.



> @@ -129,6 +170,43 @@ static int setup_dtb(struct kimage *image,
>  	return ret;
>  }
>  
> +static int prepare_elf_headers(void **addr, unsigned long *sz)
> +{
> +	struct crash_mem *cmem;
> +	unsigned int nr_ranges;
> +	int ret;
> +	u64 i;
> +	phys_addr_t start, end;
> +
> +	nr_ranges = 1; /* for exclusion of crashkernel region */

> +	for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE, 0,
> +							&start, &end, NULL)

Nit: MEMBLOCK_NONE


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
