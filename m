From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Wed, 25 May 2022 19:56:39 +0530
Subject: [PATCH v8 7/7] x86/crash: Add x86 crash hotplug support for
 kexec_load
In-Reply-To: <20220505184603.1548-8-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-8-eric.devolder@oracle.com>
Message-ID: <e9ddbcfe-f8d4-e542-deab-a0fadf86c6eb@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hello Eric,

On 06/05/22 00:16, Eric DeVolder wrote:
> For kexec_file_load support, the loading of the crash kernel occurs
> entirely within the kernel, and as such the elfcorehdr is readily
> identified (so that it can be modified upon hotplug events).
>
> This change enables support for kexec_load by identifying the
> elfcorehdr segment in the arch_crash_handle_hotplug_event(),
> if it has not already been identified.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   arch/x86/kernel/crash.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 951ef365f0a7..845d7c77854d 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -485,6 +485,30 @@ void arch_crash_handle_hotplug_event(struct kimage *image,
>   	void *elfbuf = NULL;
>   	unsigned long mem, memsz;
>   
> +	/*
> +	 * When the struct kimage is alloced, it is wiped to zero, so
> +	 * the elfcorehdr_index_valid defaults to false. It is set on the
> +	 * kexec_file_load path, or here for kexec_load, if not already
> +	 * identified.
> +	 */
> +	if (!image->elfcorehdr_index_valid) {
> +		unsigned int n;
> +
> +		for (n = 0; n < image->nr_segments; n++) {
> +			mem = image->segment[n].mem;
> +			memsz = image->segment[n].memsz;
> +			ptr = map_crash_pages(mem, memsz);
> +			if (ptr) {
> +				/* The segment containing elfcorehdr */
> +				if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> +					image->elfcorehdr_index = (int)n;
> +					image->elfcorehdr_index_valid = true;

How about finding elfcorehdr index on kexec_load path post 
kimage_load_segment call in
do_kexec_load (kernel/kexec.c) or other suitable place? This way we can 
avoid checking for
elfcorehdr index for every hotplug. Also we might not need 
image->elfcorehdr_index_valid.

Thanks,
Sourabh Jain



