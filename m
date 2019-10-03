Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFwFZ-0005bu-BN
 for kexec@lists.infradead.org; Thu, 03 Oct 2019 08:14:14 +0000
Date: Thu, 3 Oct 2019 10:14:06 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Fix conversion overflow when compiling on
 32-bit platforms
Message-ID: <20191003081406.5qmzlmlpwobydfok@verge.net.au>
References: <20191001151416.GA25667@ls3530.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191001151416.GA25667@ls3530.fritz.box>
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
To: Helge Deller <deller@gmx.de>
Cc: Sven Schnelle <svens@stackframe.org>, kexec@lists.infradead.org

On Tue, Oct 01, 2019 at 05:14:16PM +0200, Helge Deller wrote:
> When compiling kexec-tools on a 32-bit platform, assigning an
> (unsigned long long) value to an (unsigned long) variable creates
> this warning:
> 
> elf_info.c: In function 'read_phys_offset_elf_kcore':
> elf_info.c:805:14: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295'
>   805 |  *phys_off = UINT64_MAX;
>       |              ^~~~~~~~~~
> 
> Fix it by casting UINT64_MAX to (unsigned long) before storing it to *phys_off.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
> index 2bce5cb..4d16983 100644
> --- a/util_lib/elf_info.c
> +++ b/util_lib/elf_info.c
> @@ -802,7 +802,7 @@ int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off)
>  {
>  	int ret;
> 
> -	*phys_off = UINT64_MAX;
> +	*phys_off = (unsigned long) UINT64_MAX;

This seems to mask the problem that UINT64_MAX is not the right
initialiser for unsigned long values on 32-bit platforms.

Could we consider using UINT64_MAX from limits.h instead?

> 
>  	ret = read_elf(fd);
>  	if (!ret) {
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
