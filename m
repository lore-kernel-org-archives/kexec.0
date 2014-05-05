Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from svenfoo.org ([82.94.215.22] helo=mail.zonque.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WhIi8-0004fT-Lo
 for kexec@lists.infradead.org; Mon, 05 May 2014 13:13:37 +0000
Message-ID: <53678E67.2050508@zonque.org>
Date: Mon, 05 May 2014 15:13:11 +0200
From: Daniel Mack <daniel@zonque.org>
MIME-Version: 1.0
Subject: Re: [kexec-tools][PATCH] zImage-arm: bugfix: load kernel at
 TEXT_OFFSET
References: <1399290511-53398-1-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1399290511-53398-1-git-send-email-wangnan0@huawei.com>
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
Cc: Sven Neumann <s.neumann@raumfeld.com>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

On 05/05/2014 01:48 PM, Wang Nan wrote:
> This patch fix a problem introduced by commit e5d6a55 which make ARM
> kexec fails.
> 
> Due to that commit, kernel is loaded at a dynamically offset: it computes
> extra_size using size of dtb, and load zImage at base + extra_size. When
> dtb size small (for example, 0x3000 bytes), kernel will be loaded at
> address like 0x60003000. For ARM zImage such address is incorrect.

Ah, ok. Thanks for the heads-up. Your fixup works for me as well, two
minor style nits commented on inline.

> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index 4b5d3f4..539192b 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -362,11 +362,10 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>  
>  	if (dtb_file) {
>  		dtb_buf = slurp_file(dtb_file, &dtb_length);
> -		extra_size = _ALIGN(dtb_length, getpagesize());
> -	} else if (use_atags) {
> -		extra_size = 0x8000;	/* 32k should be plenty for ATAGs */
>  	}

The curly braces are not needed anymore now.

> +	extra_size = 0x8000;
> +

You can move the initialization to the variable declaration above.


Thanks,
Daniel



>  	/*
>  	 * If we are loading a dump capture kernel, we need to update kernel
>  	 * command line and also add some additional segments.
> @@ -460,6 +459,32 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
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
