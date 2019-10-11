Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v6 14/17] arm64: kexec: move relocation function setup and
 clean up
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-15-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <f1c50a5f-103e-e6d7-e93d-e873a169833e@arm.com>
Date: Fri, 11 Oct 2019 19:19:12 +0100
MIME-Version: 1.0
In-Reply-To: <20191004185234.31471-15-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 04/10/2019 19:52, Pavel Tatashin wrote:
> Currently, kernel relocation function is configured in machine_kexec()
> at the time of kexec reboot by using control_code_page.
> 
> This operation, however, is more logical to be done during kexec_load,
> and thus remove from reboot time. Move, setup of this function to
> newly added machine_kexec_post_load().
> 
> In addition, do some cleanup: add infor about reloction function to

infor ? reloction?


> kexec_image_info(), and remove extra messages from machine_kexec().


> Make dtb_mem, always available, if CONFIG_KEXEC_FILE is not configured
> dtb_mem is set to zero anyway.

This is unrelated cleanup, please do it as an earlier patch to make it clearer what you
are changing here.

(I'm not convinced you need to cache va<->pa)


> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 12a561a54128..d15ca1ca1e83 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -90,14 +90,15 @@ static inline void crash_prepare_suspend(void) {}
>  static inline void crash_post_resume(void) {}
>  #endif
>  
> -#ifdef CONFIG_KEXEC_FILE
>  #define ARCH_HAS_KIMAGE_ARCH
>  
>  struct kimage_arch {
>  	void *dtb;
>  	unsigned long dtb_mem;

> +	unsigned long kern_reloc;

This is cache-ing the physical address of an all-architectures value from struct kimage,
in the arch specific part of struct kiamge. Why?

(You must have the struct kimage on hand to access this thing at all!)

If its supposed to be a physical address, please use phys_addr_t.

>  };


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 0df8493624e0..9b41da50e6f7 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -42,6 +42,7 @@ static void _kexec_image_info(const char *func, int line,
>  	pr_debug("    start:       %lx\n", kimage->start);
>  	pr_debug("    head:        %lx\n", kimage->head);
>  	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
> +	pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
>  
>  	for (i = 0; i < kimage->nr_segments; i++) {
>  		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
> @@ -58,6 +59,19 @@ void machine_kexec_cleanup(struct kimage *kimage)
>  	/* Empty routine needed to avoid build errors. */
>  }
>  
> +int machine_kexec_post_load(struct kimage *kimage)
> +{
> +	unsigned long kern_reloc;
> +
> +	kern_reloc = page_to_phys(kimage->control_code_page);

kern_reloc should be phys_addr_t.


> +	memcpy(__va(kern_reloc), arm64_relocate_new_kernel,
> +	       arm64_relocate_new_kernel_size);
> +	kimage->arch.kern_reloc = kern_reloc;


Please move the cache maintenance in here too. This will save us doing it late during
kdump. This will also group the mmu-on changes together.


> +}


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
