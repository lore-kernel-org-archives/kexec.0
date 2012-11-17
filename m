Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TZbyC-0006lY-RE
 for kexec@lists.infradead.org; Sat, 17 Nov 2012 06:33:37 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-9-git-send-email-yinghai@kernel.org>
Date: Fri, 16 Nov 2012 22:33:22 -0800
In-Reply-To: <1353107067-14564-9-git-send-email-yinghai@kernel.org> (Yinghai
 Lu's message of "Fri, 16 Nov 2012 15:04:27 -0800")
Message-ID: <87625420y5.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 8/8] x86: put 64bit bzImage high
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Yinghai Lu <yinghai@kernel.org> writes:

> also need to make sure pass right 64bit start address to go there
> directly later.

There are some silly things here but I think the clean way to handle
this is to create a kexec/arch/i386/kexec-bzImage64.c that handles
loading a bzImage with a 64bit entry point.

That should keep the code simpler and easier to read.  Although it will
probably introduce a bit more code.

Eric

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  kexec/arch/i386/kexec-bzImage.c |   53 ++++++++++++++++++++++++++++++++++++--
>  1 files changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
> index 6998587..3e705ca 100644
> --- a/kexec/arch/i386/kexec-bzImage.c
> +++ b/kexec/arch/i386/kexec-bzImage.c
> @@ -18,8 +18,10 @@
>   */
>  
>  #define _GNU_SOURCE
> +#include <stddef.h>
>  #include <stdio.h>
>  #include <string.h>
> +#include <limits.h>
>  #include <stdlib.h>
>  #include <errno.h>
>  #include <sys/types.h>
> @@ -35,6 +37,7 @@
>  #include "../../kexec-elf.h"
>  #include "../../kexec-syscall.h"
>  #include "kexec-x86.h"
> +#include "../x86_64/kexec-x86_64.h"
>  #include "x86-linux-setup.h"
>  #include "crashdump-x86.h"
>  #include <arch/options.h>
> @@ -111,12 +114,15 @@ int do_bzImage_load(struct kexec_info *info,
>  	size_t size;
>  	int kern16_size;
>  	unsigned long setup_base, setup_size;
> +	struct entry64_regs regs64;
>  	struct entry32_regs regs32;
>  	struct entry16_regs regs16;
>  	unsigned int relocatable_kernel = 0;
>  	unsigned long kernel32_load_addr;
>  	char *modified_cmdline;
>  	unsigned long cmdline_end;
> +	unsigned long code64_start_offset = 0;
> +	unsigned long kernel64_load_addr = 0;
>  
>  	/*
>  	 * Find out about the file I am about to load.
> @@ -154,6 +160,13 @@ int do_bzImage_load(struct kexec_info *info,
>  		dbgprintf("bzImage is relocatable\n");
>  	}
>  
> +	if (setup_header.protocol_version >= 0x020C) {
> +		code64_start_offset = setup_header.code64_start_offset;
> +		if (code64_start_offset)
> +			dbgprintf("code64_start_offset: 0x%lx\n",
> +					 code64_start_offset);
> +	}
> +
>  	/* Can't use bzImage for crash dump purposes with real mode entry */
>  	if((info->kexec_flags & KEXEC_ON_CRASH) && real_mode_entry) {
>  		fprintf(stderr, "Can't use bzImage for crash dump purposes"
> @@ -250,7 +263,26 @@ int do_bzImage_load(struct kexec_info *info,
>  				kernel32_max_addr = real_mode->initrd_addr_max;
>  		}
>  
> -		kernel32_load_addr = add_buffer(info, kernel + kern16_size,
> +		if (!real_mode_entry && code64_start_offset) {
> +			/* align to 1G to avoid cross the PUD_SIZE boundary */
> +			kernel64_load_addr = add_buffer(
> +						info, kernel + kern16_size,
> +						size, size, 1UL<<30,
> +						1UL<<32, ULONG_MAX,
> +						-1);
> +			if (!kernel64_load_addr)
> +				kernel64_load_addr = add_buffer(
> +						info, kernel + kern16_size,
> +						size, size, 1UL<<30,
> +						1UL<<30, 1UL<<32,
> +						-1);
> +			if (kernel64_load_addr)
> +				kernel64_load_addr += code64_start_offset;
> +		}
> +
> +		if (!kernel64_load_addr)
> +			kernel32_load_addr = add_buffer(
> +						info, kernel + kern16_size,
>  						size, size, kern_align,
>  						0x100000, kernel32_max_addr,
>  						1);
> @@ -260,8 +292,11 @@ int do_bzImage_load(struct kexec_info *info,
>  		add_segment(info, kernel + kern16_size, size,
>  				kernel32_load_addr, size);
>  	}
> -		
> -	dbgprintf("Loaded 32bit kernel at 0x%lx\n", kernel32_load_addr);
> +
> +	if (kernel64_load_addr)
> +		dbgprintf("Loaded 64bit kernel at 0x%lx\n", kernel64_load_addr);
> +	else
> +		dbgprintf("Loaded 32bit kernel at 0x%lx\n", kernel32_load_addr);
>  
>  	/* Tell the kernel what is going on */
>  	setup_linux_bootloader_parameters(info, real_mode, setup_base,
> @@ -271,6 +306,16 @@ int do_bzImage_load(struct kexec_info *info,
>  	/* Get the initial register values */
>  	elf_rel_get_symbol(&info->rhdr, "entry16_regs", &regs16, sizeof(regs16));
>  	elf_rel_get_symbol(&info->rhdr, "entry32_regs", &regs32, sizeof(regs32));
> +	if (kernel64_load_addr) {
> +		elf_rel_get_symbol(&info->rhdr, "entry64_regs", &regs64, sizeof(regs64));
> +		regs64.rbx = 0;           /* Bootstrap processor */
> +		regs64.rsi = setup_base;  /* Pointer to the parameters */
> +		regs64.rip = kernel64_load_addr; /* the entry point */
> +		regs64.rsp = elf_rel_get_addr(&info->rhdr, "stack_end"); /* Stack, unused */
> +		elf_rel_set_symbol(&info->rhdr, "entry64_regs", &regs64, sizeof(regs64));
> +
> +		goto cmd_line;
> +	}
>  	/*
>  
>  	 * Initialize the 32bit start information.
> @@ -320,6 +365,8 @@ int do_bzImage_load(struct kexec_info *info,
>  	elf_rel_set_symbol(&info->rhdr, "entry16_regs", &regs16, sizeof(regs16));
>  	elf_rel_set_symbol(&info->rhdr, "entry16_debug_regs", &regs16, sizeof(regs16));
>  	elf_rel_set_symbol(&info->rhdr, "entry32_regs", &regs32, sizeof(regs32));
> +
> +cmd_line:
>  	cmdline_end = setup_base + kern16_size + command_line_len - 1;
>  	elf_rel_set_symbol(&info->rhdr, "cmdline_end", &cmdline_end,
>  			   sizeof(unsigned long));

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
