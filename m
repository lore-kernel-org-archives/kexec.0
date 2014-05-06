Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ee0-x22c.google.com ([2a00:1450:4013:c00::22c])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Whc4q-0006xz-4d
 for kexec@lists.infradead.org; Tue, 06 May 2014 09:54:21 +0000
Received: by mail-ee0-f44.google.com with SMTP id c41so6149640eek.31
 for <kexec@lists.infradead.org>; Tue, 06 May 2014 02:53:57 -0700 (PDT)
Message-ID: <5368B120.4000600@gmail.com>
Date: Tue, 06 May 2014 11:53:36 +0200
From: Daniel Mack <zonque@gmail.com>
MIME-Version: 1.0
Subject: Re: [kexec-tools][PATCH v2] zImage-arm: bugfix: kernel offset must
 be 0x8000
References: <53678E67.2050508@zonque.org>
 <1399336709-21905-1-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1399336709-21905-1-git-send-email-wangnan0@huawei.com>
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
To: Wang Nan <wangnan0@huawei.com>, Simon Horman <horms@verge.net.au>
Cc: Sven Neumann <s.neumann@raumfeld.com>, kexec@lists.infradead.org

On 05/06/2014 02:38 AM, Wang Nan wrote:
> This patch fixs a problem introduced by commit e5d6a55 which make ARM
> kexec fails.
> 
> Due to that commit, kernel is loaded at a dynamically offset: it computes
> extra_size using size of dtb, and load zImage at base + extra_size. When
> dtb size small (for example, 0x3000 bytes), kernel will be loaded at
> address like 0x60003000. For ARM zImage such address is incorrect.
> 
> In kernel code arch/arm/boot/compressed/head.S, zImage builds a
> temporary page table at (pc & 0xf8000000) + TEXT_OFFSET - 0x4000. The
> related instructions sequence is:
> 
>  mov     r4, pc
>  and     r4, r4, #0xf8000000
>  add     r4, r4, #TEXT_OFFSET @ (TEXT_OFFSET == 0x8000 on most platforms)
>  call cache_on
>    ...
>    call __armv7_mmu_cache_on
>      ...
>      call __setup_mmu
>        sub     r3, r4, #16384          @ Page directory size
> 
> r3 becomes page table pointer.
> 
> When kernel is loaded at 0x60003000, page table is still built at
> 0x60004000, which destroys kernel.
> 
> This patch make extra_size a fix value (0x8000) to avoid the failure.
> 
> For the problem commit e5d6a55 tries solve, this patch uses
> locate_holes() to find a place can hold initrd and dtb.
> 
> Change from v1:
>  - Coding style enhancements.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Cc: Daniel Mack <zonque@gmail.com>

Tested-by: Daniel Mack <zonque@gmail.com>


Many thanks again for the fix and the elaboration!


Daniel


> Cc: Sven Neumann <s.neumann@raumfeld.com>
> Cc: Simon Horman <horms@verge.net.au>
> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index 4b5d3f4..bc99e79 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -282,7 +282,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  {
>  	unsigned long base;
>  	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
> -	unsigned int extra_size = 0;
> +	unsigned int extra_size = 0x8000; /* TEXT_OFFSET */
>  	const char *command_line;
>  	char *modified_cmdline = NULL;
>  	off_t command_line_len;
> @@ -356,16 +356,11 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  		if (command_line_len > COMMAND_LINE_SIZE)
>  			command_line_len = COMMAND_LINE_SIZE;
>  	}
> -	if (ramdisk) {
> +	if (ramdisk)
>  		ramdisk_buf = slurp_file(ramdisk, &initrd_size);
> -	}
>  
> -	if (dtb_file) {
> +	if (dtb_file)
>  		dtb_buf = slurp_file(dtb_file, &dtb_length);
> -		extra_size = _ALIGN(dtb_length, getpagesize());
> -	} else if (use_atags) {
> -		extra_size = 0x8000;	/* 32k should be plenty for ATAGs */
> -	}
>  
>  	/*
>  	 * If we are loading a dump capture kernel, we need to update kernel
> @@ -460,6 +455,32 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  			create_flatten_tree(&dtb_buf, &dtb_length, command_line);
>  		}
>  
> +		/*
> +		 * Search in memory to make sure there is enough memory
> +		 * to hold initrd and dtb.
> +		 *
> +		 * Even if no initrd is used, this check is still
> +		 * required for dtb.
> +		 *
> +		 * Crash kernel use fixed address, no check is ok.
> +		 */
> +		if ((info->kexec_flags & KEXEC_ON_CRASH) == 0) {
> +			unsigned long page_size = getpagesize();
> +			/*
> +			 * DTB size may be increase a little
> +			 * when setup initrd size. Add a full page
> +			 * for it is enough.
> +			 */
> +			unsigned long hole_size = _ALIGN_UP(initrd_size, page_size) +
> +				_ALIGN(dtb_length + page_size, page_size);
> +			unsigned long initrd_base_new = locate_hole(info,
> +					hole_size, page_size,
> +					initrd_base, ULONG_MAX, INT_MAX);
> +			if (base == ULONG_MAX)
> +				return -1;
> +			initrd_base = initrd_base_new;
> +		}
> +
>  		if (ramdisk) {
>  			add_segment(info, ramdisk_buf, initrd_size,
>  			            initrd_base, initrd_size);
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
