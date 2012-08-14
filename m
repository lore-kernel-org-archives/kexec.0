Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T1CW9-0008BJ-6V
 for kexec@lists.infradead.org; Tue, 14 Aug 2012 08:30:26 +0000
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 14 Aug 2012 18:29:24 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7E8UGx422478852
 for <kexec@lists.infradead.org>; Tue, 14 Aug 2012 18:30:16 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7E8UFf6018283
 for <kexec@lists.infradead.org>; Tue, 14 Aug 2012 18:30:15 +1000
Message-ID: <502A0BF4.5070702@linux.vnet.ibm.com>
Date: Tue, 14 Aug 2012 13:57:32 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] build: Avoid duplicate files in tarball
References: <1343876888-21106-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1343876888-21106-1-git-send-email-horms@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On 08/02/2012 08:38 AM, Simon Horman wrote:
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  kexec/Makefile             | 75 +++++++++++++++++++++++++++-------------------
>  kexec/arch/arm/Makefile    |  2 +-
>  kexec/arch/ppc/Makefile    |  3 +-
>  kexec/arch/sh/Makefile     |  3 +-
>  kexec/arch/x86_64/Makefile | 12 +++++---
>  purgatory/Makefile         |  2 --
>  6 files changed, 58 insertions(+), 39 deletions(-)
> 
[...]
> diff --git a/kexec/arch/x86_64/Makefile b/kexec/arch/x86_64/Makefile
> index 916babf..405bdf5 100644
> --- a/kexec/arch/x86_64/Makefile
> +++ b/kexec/arch/x86_64/Makefile
> @@ -9,10 +9,14 @@ x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-nbi.c
>  x86_64_KEXEC_SRCS += kexec/arch/i386/x86-linux-setup.c
>  x86_64_KEXEC_SRCS += kexec/arch/i386/kexec-x86-common.c
>  x86_64_KEXEC_SRCS += kexec/arch/i386/crashdump-x86.c
> -x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-x86_64.c
> -x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-x86_64.c
> -x86_64_KEXEC_SRCS += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> 
> -dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS) \
> +x86_64_KEXEC_SRCS_native =  kexec/arch/x86_64/kexec-x86_64.c
> +x86_64_KEXEC_SRCS_native += kexec/arch/x86_64/kexec-elf-x86_64.c
> +x86_64_KEXEC_SRCS_native += kexec/arch/x86_64/kexec-elf-rel-x86_64.c
> +
> +x86_64_KEXEC_SRCS += $(x86_64_KEXEC_SRCS_native)
> +
> +# Don't add sources in i386/ to dist, as i386/Makefile adds them
> +dist += kexec/arch/x86_64/Makefile $(x86_64_KEXEC_SRCS_native) \
>  	kexec/arch/x86_64/kexec-x86_64.h \
>  	kexec/arch/x86_64/include/arch/options.h
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index ee1679c..711799b 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -27,8 +27,6 @@ include $(srcdir)/purgatory/arch/s390/Makefile
>  include $(srcdir)/purgatory/arch/sh/Makefile
>  include $(srcdir)/purgatory/arch/x86_64/Makefile
> 
> -PURGATORY_SRCS+=$($(ARCH)_PURGATORY_SRCS)

Any reason why the above line has been removed? With the above line
removed nothing under 'purgatory/arch/*/' directory gets compiled. This
makes loading of panic kernel (kexec -p) to fail. I tested it on ppc64
and it fails. Same issue may also exist on other architecture.

Restored the line and able to load panic kernel successfully.

> -
>  PURGATORY_OBJS = $(call objify, $(PURGATORY_SRCS)) purgatory/sha256.o
>  PURGATORY_DEPS = $(call depify, $(PURGATORY_OBJS))
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
