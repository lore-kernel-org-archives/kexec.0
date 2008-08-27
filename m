Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYAwA-0001kS-Sy
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 02:39:11 +0000
Date: Wed, 27 Aug 2008 12:39:08 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 06/06] sh: Add vmlinux support
Message-ID: <20080827023905.GL19066@verge.net.au>
References: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
	<20080826111232.615.24048.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080826111232.615.24048.sendpatchset@rx1.opensource.se>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: kexec@lists.infradead.org

On Tue, Aug 26, 2008 at 08:12:32PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Add SuperH vmlinux support through a zero-page aware elf loader. Only for
> kexec at this point, in the future kdump support will be added.

Hi Magnus,

If these series of patches are fine by you then they are fine by me.
I just have a few minor issues with this last patch.

> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  kexec/arch/sh/Makefile       |    1 
>  kexec/arch/sh/kexec-elf-sh.c |  114 ++++++++++++++++++++++++++++++++++++++++++
>  kexec/arch/sh/kexec-sh.c     |    1 
>  kexec/arch/sh/kexec-sh.h     |    5 +
>  4 files changed, 121 insertions(+)
> 
> --- 0004/kexec/arch/sh/Makefile
> +++ work/kexec/arch/sh/Makefile	2008-08-22 13:17:18.000000000 +0900
> @@ -4,6 +4,7 @@
>  sh_KEXEC_SRCS += kexec/arch/sh/kexec-sh.c
>  sh_KEXEC_SRCS += kexec/arch/sh/kexec-zImage-sh.c
>  sh_KEXEC_SRCS += kexec/arch/sh/kexec-netbsd-sh.c
> +sh_KEXEC_SRCS += kexec/arch/sh/kexec-elf-sh.c
>  sh_KEXEC_SRCS += kexec/arch/sh/kexec-elf-rel-sh.c
>  sh_KEXEC_SRCS += kexec/arch/sh/netbsd_booter.S
>  
> --- /dev/null
> +++ work/kexec/arch/sh/kexec-elf-sh.c	2008-08-22 14:24:31.000000000 +0900
> @@ -0,0 +1,114 @@
> +/*
> + * kexec: Linux boots Linux
> + *
> + * Copyright (C) 2008  Magnus Damm
> + *
> + * Based on x86 implementation,
> + * Copyright (C) 2003-2005  Eric Biederman (ebiederm@xmission.com)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation (version 2 of the License).
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <limits.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <getopt.h>
> +#include <elf.h>
> +#include "../../kexec.h"
> +#include "../../kexec-syscall.h"
> +#include "../../kexec-elf.h"
> +#include "../../kexec-elf-boot.h"
> +#include <arch/options.h>
> +#include "kexec-sh.h"
> +
> +int elf_sh_probe(const char *buf, off_t len)
> +{
> +	struct mem_ehdr ehdr;
> +	int result;
> +	result = build_elf_exec_info(buf, len, &ehdr, 0);
> +	if (result < 0)
> +		goto out;
> +
> +	/* Verify the architecuture specific bits */
> +	if (ehdr.e_machine != EM_SH) {
> +		result = -1;
> +		goto out;
> +	}
> +
> +	result = 0;
> + out:
> +	free_elf_info(&ehdr);
> +	return result;
> +}
> +
> +void elf_sh_usage(void)
> +{
> +	printf("  --append=STRING       Set the kernel command line to STRING\n"
> +		);
> +}
> +
> +int elf_sh_load(int argc, char **argv, const char *buf, off_t len, 

The line above has trailing whitespace.

> +	struct kexec_info *info)
> +{
> +	struct mem_ehdr ehdr;
> +	const char *command_line;
> +	struct mem_sym sym;
> +	int opt;
> +	static const struct option options[] = {
> +		KEXEC_ARCH_OPTIONS
> +		{ 0, 			0, NULL, 0 },

The line above has a stray space after 0 (and before a tab).

> +	};
> +
> +	static const char short_options[] = KEXEC_OPT_STR "";
> +
> +	/*
> +	 * Parse the command line arguments
> +	 */
> +	command_line = 0;
> +	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
> +		switch(opt) {
> +		default:
> +			/* Ignore core options */
> +			if (opt < OPT_ARCH_MAX) {
> +				break;
> +			}
> +		case '?':
> +			usage();
> +			return -1;
> +		case OPT_APPEND:
> +			command_line = optarg;
> +			break;
> +		}
> +	}
> +
> +	/* Load the ELF executable */
> +	elf_exec_build_load(info, &ehdr, buf, len, 0);
> +	info->entry = (void *)ehdr.e_entry;
> +
> +	/* If we're booting a vmlinux then fill in empty_zero_page */
> +	if (elf_rel_find_symbol(&ehdr, "empty_zero_page", &sym) == 0) {
> +		unsigned char *zp = (void *)ehdr.e_shdr[sym.st_shndx].sh_data;
> +
> +		kexec_sh_setup_zero_page(zp, 4096, command_line);

kexec_sh_setup_zero_page() seems to want a signed char * as the first
argument. Does it make sense to just change zp accordingly?


> +	}
> +
> +	return 0;
> +}
> --- 0005/kexec/arch/sh/kexec-sh.c
> +++ work/kexec/arch/sh/kexec-sh.c	2008-08-22 13:17:18.000000000 +0900
> @@ -53,6 +53,7 @@ int get_memory_ranges(struct memory_rang
>  /* Supported file types and callbacks */
>  struct file_type file_type[] = {
>         {"zImage-sh", zImage_sh_probe, zImage_sh_load, zImage_sh_usage},
> +       {"elf-sh", elf_sh_probe, elf_sh_load, elf_sh_usage},
>         {"netbsd-sh", netbsd_sh_probe, netbsd_sh_load, netbsd_sh_usage},
>  };
>  int file_types = sizeof(file_type) / sizeof(file_type[0]);
> --- 0005/kexec/arch/sh/kexec-sh.h
> +++ work/kexec/arch/sh/kexec-sh.h	2008-08-22 13:17:18.000000000 +0900
> @@ -6,6 +6,11 @@ int zImage_sh_load(int argc, char **argv
>  	struct kexec_info *info);
>  void zImage_sh_usage(void);
>  
> +int elf_sh_probe(const char *buf, off_t len);
> +int elf_sh_load(int argc, char **argv, const char *buf, off_t len,
> +	struct kexec_info *info);
> +void elf_sh_usage(void);
> +
>  int netbsd_sh_probe(const char *buf, off_t len);
>  int netbsd_sh_load(int argc, char **argv, const char *buf, off_t len,
>  	struct kexec_info *info);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
