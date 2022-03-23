From: Eric DeVolder <eric.devolder@oracle.com>
Date: Wed, 23 Mar 2022 13:32:51 -0500
Subject: [RFC v3 PATCH 3/5] powrepc/crash hp: update kimage struct
In-Reply-To: <20220321080422.56255-4-sourabhjain@linux.ibm.com>
References: <20220321080422.56255-1-sourabhjain@linux.ibm.com>
 <20220321080422.56255-4-sourabhjain@linux.ibm.com>
Message-ID: <8fc2d63d-97db-59ab-3043-d453fed1e7e3@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 3/21/22 03:04, Sourabh Jain wrote:
> Two new members fdt_index and fdt_index_valid are added in kimage_arch
> struct to track the FDT kexec segment. These new members of kimage_arch
> struct will help the crash hotplug handler to easily access the FDT
> segment from the kexec segment array. Otherwise, we have to loop through
> all kexec segments to find the FDT segments.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

> ---
>   arch/powerpc/include/asm/kexec.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index e1288826e22e..19c2cab6a880 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -104,6 +104,8 @@ extern const struct kexec_file_ops kexec_elf64_ops;
>   struct kimage_arch {
>   	struct crash_mem *exclude_ranges;
>   
> +	int fdt_index;
> +	bool fdt_index_valid;
>   	unsigned long backup_start;
>   	void *backup_buf;
>   	void *fdt;
> 

Question, for the kexec_file_load scenario, is there a need to have the fdt_index segment excluded 
by kexec_calculate_store_digests() ?

