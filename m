Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHNCc-0003wf-3Q
 for kexec@lists.infradead.org; Mon, 07 Oct 2019 07:13:09 +0000
Date: Mon, 7 Oct 2019 09:12:57 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Fix conversion overflow when compiling on
 32-bit platforms
Message-ID: <20191007071257.qs4dnqmyqk4difzy@verge.net.au>
References: <20191001151416.GA25667@ls3530.fritz.box>
 <20191003081406.5qmzlmlpwobydfok@verge.net.au>
 <2ac17dd1-99ef-3528-a05e-d51f8af01c95@gmx.de>
 <20191004093737.wftu7iat2gk3abq6@verge.net.au>
 <8157edc8-69cb-33b8-ae1c-7a0d80845c9d@gmx.de>
 <20191004101423.jqpakrotimjjyp3w@verge.net.au>
 <20191004110109.GA15439@ls3530.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191004110109.GA15439@ls3530.fritz.box>
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

On Fri, Oct 04, 2019 at 01:01:09PM +0200, Helge Deller wrote:
> When compiling kexec-tools on a 32-bit platform, assigning an
> (unsigned long long) value to an (unsigned long) variable creates
> this warning:
> 
> elf_info.c: In function 'read_phys_offset_elf_kcore':
> elf_info.c:805:14: warning: conversion from 'long long unsigned int' to
>      'long unsigned int' changes value from '18446744073709551615' to '4294967295'
>   805 |  *phys_off = UINT64_MAX;
> 
> Fix it by using ULONG_MAX instead of UINT64_MAX.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
