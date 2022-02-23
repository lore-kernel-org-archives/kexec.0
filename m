From: Baoquan He <bhe@redhat.com>
Date: Wed, 23 Feb 2022 11:46:26 +0800
Subject: [PATCH v4 04/10] crash hp: prototype change for
 crash_prepare_elf64_headers
In-Reply-To: <20220209195706.51522-5-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-5-eric.devolder@oracle.com>
Message-ID: <YhWuElhbF4GslSfq@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/09/22 at 02:57pm, Eric DeVolder wrote:
> From within crash_prepare_elf64_headers() there is a need to
> reference the struct kimage hotplug members. As such, this
> change passes the struct kimage as a parameter to the
> crash_prepare_elf64_headers().

One more sentence can be added"

"This is preparation for later patch, no functionality change."

Otherwise, this patch looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 6 +++---
>  arch/powerpc/kexec/file_load_64.c      | 2 +-
>  arch/x86/kernel/crash.c                | 3 ++-
>  include/linux/kexec.h                  | 5 +++--
>  kernel/kexec_file.c                    | 4 ++--
>  5 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 59c648d51848..7dbafb42ecf2 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  	return kexec_image_post_load_cleanup_default(image);
>  }
>  
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
> +static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
>  {
>  	struct crash_mem *cmem;
>  	unsigned int nr_ranges;
> @@ -67,7 +67,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
>  
>  	if (!ret)
> -		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
> +		ret =  crash_prepare_elf64_headers(image, cmem, true, addr, sz);
>  
>  	kfree(cmem);
>  	return ret;
> @@ -96,7 +96,7 @@ int load_other_segments(struct kimage *image,
>  
>  	/* load elf core header */
>  	if (image->type == KEXEC_TYPE_CRASH) {
> -		ret = prepare_elf_headers(&headers, &headers_sz);
> +		ret = prepare_elf_headers(image, &headers, &headers_sz);
>  		if (ret) {
>  			pr_err("Preparing elf core header failed\n");
>  			goto out_err;
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index b4981b651d9a..07da6bf1cf24 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -797,7 +797,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
>  		goto out;
>  
>  	/* Setup elfcorehdr segment */
> -	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
> +	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
>  	if (ret) {
>  		pr_err("Failed to prepare elf headers for the core\n");
>  		goto out;
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9730c88530fc..9db41cce8d97 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -265,7 +265,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>  		goto out;
>  
>  	/* By default prepare 64bit headers */
> -	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
> +	ret =  crash_prepare_elf64_headers(image, cmem,
> +				IS_ENABLED(CONFIG_X86_64), addr, sz);
>  
>  out:
>  	vfree(cmem);
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 13c238c2da48..b11d75a6b2bc 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -221,8 +221,9 @@ struct crash_mem {
>  extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mstart,
>  				   unsigned long long mend);
> -extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> -				       void **addr, unsigned long *sz);
> +extern int crash_prepare_elf64_headers(struct kimage *image,
> +	struct crash_mem *mem, int kernel_map,
> +	void **addr, unsigned long *sz);
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  #ifdef CONFIG_KEXEC_ELF
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b..801d0d0a5012 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -1260,8 +1260,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  	return 0;
>  }
>  
> -int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
> -			  void **addr, unsigned long *sz)
> +int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
> +	int kernel_map, void **addr, unsigned long *sz)
>  {
>  	Elf64_Ehdr *ehdr;
>  	Elf64_Phdr *phdr;
> -- 
> 2.27.0
> 


