Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWAFj-0002QZ-RW
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 19:26:01 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1381859307-11932-1-git-send-email-geert@linux-m68k.org>
 <1381859307-11932-2-git-send-email-geert@linux-m68k.org>
Date: Tue, 15 Oct 2013 12:25:16 -0700
In-Reply-To: <1381859307-11932-2-git-send-email-geert@linux-m68k.org> (Geert
 Uytterhoeven's message of "Tue, 15 Oct 2013 19:48:25 +0200")
Message-ID: <8761sy1gmb.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] kexec: Add debug printing of kimage table entries
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Print a list of pages to be copied if debugging is enabled.
> Consecutive entries are merged to reduce screen clutter.

Why is this desirable?

I can understand this as debugging code to understand what is happening,
but why would we want to maintain this print statement long term?

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> ---
>  kernel/kexec.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 490afc03627e..e25022ac229e 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1073,6 +1073,80 @@ asmlinkage long compat_sys_kexec_load(unsigned long entry,
>  }
>  #endif
>  
> +#ifdef DEBUG
> +struct kimage_block {
> +	unsigned long dst, src, len;
> +};
> +
> +static void kimage_print_block(const struct kimage_block *block)
> +{
> +	pr_info("Copy from 0x%lx-0x%lx to 0x%lx-0x%lx (0x%lx bytes)\n",
> +		block->src, block->src + block->len - 1, block->dst,
> +		block->dst + block->len - 1, block->len);
> +}
> +
> +static void kimage_print(const struct kimage *image)
> +{
> +	void *control_code_page;
> +	const kimage_entry_t *ptr;
> +	kimage_entry_t entry;
> +	struct kimage_block block;
> +	unsigned long dnext = KIMAGE_NO_DEST, snext = KIMAGE_NO_DEST;
> +	unsigned long total = 0;
> +
> +	control_code_page = page_address(image->control_code_page);
> +	pr_info("Control code page 0x%p (phys 0x%lx)\n",
> +		control_code_page, virt_to_phys(control_code_page));
> +
> +	ptr = &image->head;
> +	block.dst = KIMAGE_NO_DEST;
> +	block.src = KIMAGE_NO_DEST;
> +	block.len = 0;
> +	while ((entry = *ptr)) {
> +		if (entry & IND_DONE)
> +			break;
> +
> +		if (entry & IND_DESTINATION) {
> +			if (block.len > 0) {
> +				kimage_print_block(&block);
> +				total += block.len;
> +			}
> +			dnext = block.dst = entry & PAGE_MASK;
> +			block.src = KIMAGE_NO_DEST;
> +			block.len = 0;
> +		}
> +
> +		if (entry & IND_SOURCE) {
> +			if (!block.len) {
> +				snext = block.src = entry & PAGE_MASK;
> +			} else if ((entry & PAGE_MASK) != snext) {
> +				kimage_print_block(&block);
> +				total += block.len;
> +				block.dst = dnext;
> +				snext = block.src = entry & PAGE_MASK;
> +				block.len = 0;
> +			}
> +			dnext += PAGE_SIZE;
> +			snext += PAGE_SIZE;
> +			block.len += PAGE_SIZE;
> +		}
> +
> +		if (entry & IND_INDIRECTION) {
> +			pr_info("Indirection page 0x%lx\n", entry & PAGE_MASK);
> +			ptr = phys_to_virt(entry & PAGE_MASK);
> +		} else
> +			ptr++;
> +	}
> +	if (block.len) {
> +		kimage_print_block(&block);
> +		total += block.len;
> +	}
> +	pr_info("Total: 0x%lx/%ld bytes\n", total, total);
> +}
> +#else
> +static inline void kimage_print(const struct kimage *image) {}
> +#endif
> +
>  void crash_kexec(struct pt_regs *regs)
>  {
>  	/* Take the kexec_mutex here to prevent sys_kexec_load
> @@ -1090,6 +1164,7 @@ void crash_kexec(struct pt_regs *regs)
>  			crash_setup_regs(&fixed_regs, regs);
>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);
> +			kimage_print(kexec_crash_image);
>  			machine_kexec(kexec_crash_image);
>  		}
>  		mutex_unlock(&kexec_mutex);
> @@ -1680,6 +1755,7 @@ int kernel_kexec(void)
>  		machine_shutdown();
>  	}
>  
> +	kimage_print(kexec_image);
>  	machine_kexec(kexec_image);
>  
>  #ifdef CONFIG_KEXEC_JUMP

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
