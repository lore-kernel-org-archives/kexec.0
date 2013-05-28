Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from etrn.xmission.com ([198.60.22.17])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhSV2-0008Ml-55
 for kexec@lists.infradead.org; Tue, 28 May 2013 22:36:13 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <51A183B0.7000607@gmail.com>
Date: Tue, 28 May 2013 15:35:23 -0700
In-Reply-To: <51A183B0.7000607@gmail.com> (Zhang Yanfei's message of "Sun, 26
 May 2013 11:38:24 +0800")
Message-ID: <87obbu7mxg.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] kexec-tools: Remove saved_max_mem
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Zhang Yanfei <zhangyanfei.yes@gmail.com> writes:

> When loading the dump-capture kernel, in some architectures(mips/ppc/ppc64),
> we should add the parameter "savemaxmem=" in the dump-capture kernel
> commandline to tell the new kernel the amount of memory that the previous
> kernel used.
>
> Then in the dump-capture kernel, we parse this parameter and assign the
> value to saved_max_pfn. In these architectures, the only user of
> saved_max_pfn is the read interface read_oldmem for /dev/oldmem.
>
> But, no one actually uses the /dev/oldmem interface. And we have decided
> to remove the /dev/oldmem interface. A kernel side patch to remove this
> interface have been sent. See https://lkml.org/lkml/2013/5/24/451.
>
> So in kexec-tools, we don't need to pass this parameter anymore. This
> patchset aims to remove the related variables and funtions in
> kexec-tools.

To this series.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

No one cares unless they are actually using /dev/oldmem, and so far
it appears no one actually uses /dev/oldmem so this change looks very
safe.

> Zhang Yanfei (4):
>   kexec-tools: mips: Remove saved_max_mem
>   kexec-tools: ppc: Remove saved_max_mem
>   kexec-tools: ppc64: Remove saved_max_mem
>   kexec-tools: sh: Remove saved_max_mem
>
>  kexec/arch/mips/crashdump-mips.c   |   34 ----------------------------------
>  kexec/arch/ppc/crashdump-powerpc.c |   19 -------------------
>  kexec/arch/ppc64/crashdump-ppc64.c |   19 -------------------
>  kexec/arch/sh/crashdump-sh.c       |    6 ------
>  4 files changed, 0 insertions(+), 78 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
