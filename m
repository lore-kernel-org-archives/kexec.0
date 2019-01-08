Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggjsg-00011p-5F
 for kexec@lists.infradead.org; Tue, 08 Jan 2019 05:24:51 +0000
Date: Tue, 8 Jan 2019 13:24:40 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH V2] x86/kexec: fix a kexec_file_load failure
Message-ID: <20190108052440.GA17983@MiWiFi-R3L-srv>
References: <20181228011247.GA9999@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181228011247.GA9999@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

On 12/28/18 at 09:12am, Dave Young wrote:
> The code cleanup mentioned in Fixes tag changed the behavior of
> kexec_locate_mem_hole.  The kexec_locate_mem_hole will try to
> allocate free memory only when kbuf.mem is initialized as zero.
> 
> But in x86 kexec_file_load implementation there are a few places
> the kbuf.mem is reused like below:
>   /* kbuf initialized, kbuf.mem = 0 */
>   ...
>   kexec_add_buffer()
>   ...
>   kexec_add_buffer()
> 
>   The second kexec_add_buffer will reuse previous kbuf but not
>   reinitialize the kbuf.mem.
> 
> Thus kexec_file_load failed because the sanity check failed.
> 
> So explictily reset kbuf.mem to fix the issue.
> 
> Fixes: b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
> Signed-off-by: Dave Young <dyoung@redhat.com>
> Cc: <stable@vger.kernel.org>
> ---
> V1 -> V2: use KEXEC_BUF_MEM_UNKNOWN in code.
>  arch/x86/kernel/crash.c           | 1 +
>  arch/x86/kernel/kexec-bzimage64.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index f631a3f15587..6b7890c7889b 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -469,6 +469,7 @@ int crash_load_segments(struct kimage *image)
>  

Wondering why this place doesn't need the initialization assignment.
Isn't it to assign in all places before kexec_add_buffer() calling?

	/* Add backup segment. */
        if (image->arch.backup_src_sz) { 
	}

>  	kbuf.memsz = kbuf.bufsz;
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret) {
>  		vfree((void *)image->arch.elf_headers);
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 278cd07228dd..0d5efa34f359 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -434,6 +434,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	kbuf.memsz = PAGE_ALIGN(header->init_size);
>  	kbuf.buf_align = header->kernel_alignment;
>  	kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;

Same question for bzImage64_load(), there are three kexec_add_buffer()
calling, I only saw two initialization in this patch.

> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret)
>  		goto out_free_params;
> @@ -448,6 +449,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  		kbuf.bufsz = kbuf.memsz = initrd_len;
>  		kbuf.buf_align = PAGE_SIZE;
>  		kbuf.buf_min = MIN_INITRD_LOAD_ADDR;
> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  		ret = kexec_add_buffer(&kbuf);
>  		if (ret)
>  			goto out_free_params;
> -- 
> 2.17.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
