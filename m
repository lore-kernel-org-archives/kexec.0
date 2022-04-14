From: Laurent Dufour <ldufour@linux.ibm.com>
Date: Thu, 14 Apr 2022 18:39:25 +0200
Subject: [RFC v4 PATCH 5/5] powerpc/crash hp: add crash hotplug support
 for kexec_load
In-Reply-To: <20220411084357.157308-6-sourabhjain@linux.ibm.com>
References: <20220411084357.157308-1-sourabhjain@linux.ibm.com>
 <20220411084357.157308-6-sourabhjain@linux.ibm.com>
Message-ID: <fc93749d-d7b9-2c56-f156-9f5ffd4808f7@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 11/04/2022, 10:43:57, Sourabh Jain wrote:
> The kernel changes needed for crash hotplug support for kexec_load system
> calls are similar to kexec_file_load (which has already been implemented
> in earlier patches) except for finding the index of the FDT segment in the
> kexec segment array. Since the kexec segment array is prepared by the
> kexec tool in the userspace, the kernel is not aware of at which index FDT
> segment is present.
> 
> Now to enable crash hotplug support for the kexec_load case, the crash
> hotplug handler is updated to identify the index at which the FDT segment
> is present in the kexec segment array by comparing the first 32 bits of
> every kexec segment with the FDT magic number.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/kexec/core_64.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 62f77cc86407..e3f224f8eb3a 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -480,7 +480,9 @@ int update_cpus_node(void *fdt)
>  void arch_crash_hotplug_handler(struct kimage *image, unsigned int hp_action,
>  				unsigned long a, unsigned long b)
>  {
> -	void *fdt;
> +	void *fdt, *ptr;
> +	unsigned int n;
> +	unsigned long mem, memsz;
>  
>  	/* No action needed for CPU hot-unplug */
>  	if (hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> @@ -492,6 +494,24 @@ void arch_crash_hotplug_handler(struct kimage *image, unsigned int hp_action,
>  		return;
>  	}
>  
> +	/* Sine kexec segments for kexec_load system call is prepred by
           Since

FWIW,
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>

> +	 * kexec tool in userspace we need loop through all the segments
> +	 * to find out segment index corresponds FDT segment. In case of
> +	 * kexec_file_load it is discovered during the load itself.
> +	 */
> +	if (!image->arch.fdt_index_valid) {
> +		for (n = 0; n < image->nr_segments; n++) {
> +			mem = image->segment[n].mem;
> +			memsz = image->segment[n].memsz;
> +			ptr = __va(mem);
> +			if (ptr && fdt_magic(ptr) == FDT_MAGIC) {
> +				image->arch.fdt_index = n;
> +				image->arch.fdt_index_valid = true;
> +				break;
> +			}
> +		}
> +	}
> +
>  	/* Must have valid FDT index */
>  	if (!image->arch.fdt_index_valid) {
>  		pr_err("crash hp: unable to locate FDT segment");


