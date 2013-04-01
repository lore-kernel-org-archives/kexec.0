Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UMWv9-0005in-2i
 for kexec@lists.infradead.org; Mon, 01 Apr 2013 05:04:40 +0000
Date: Mon, 1 Apr 2013 14:04:31 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] purgatory: compile sha256.c only on ia64 with -O0
Message-ID: <20130401050431.GJ16289@verge.net.au>
References: <1364763549-10790-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1364763549-10790-1-git-send-email-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: kexec@lists.infradead.org

On Sun, Mar 31, 2013 at 10:59:09PM +0200, Richard Weinberger wrote:
> If we have to compile sha256.c on ia64 with -O0 to produce sane code
> do it only on ia64.
> 
> This change makes executing a new kernel on my AMD geode CPU much faster.
> Without the patch "kexec -e" takes 27 seconds, with only 16.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  purgatory/Makefile           | 15 +--------------
>  purgatory/arch/ia64/Makefile |  3 +++
>  2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index e39adec..6be8362 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -16,16 +16,7 @@ PURGATORY_SRCS += purgatory/string.c
>  dist += purgatory/Makefile $(PURGATORY_SRCS)				\
>  	purgatory/include/purgatory.h purgatory/include/string.h
>  
> -include $(srcdir)/purgatory/arch/alpha/Makefile
> -include $(srcdir)/purgatory/arch/arm/Makefile
> -include $(srcdir)/purgatory/arch/i386/Makefile
> -include $(srcdir)/purgatory/arch/ia64/Makefile
> -include $(srcdir)/purgatory/arch/mips/Makefile
> -include $(srcdir)/purgatory/arch/ppc/Makefile
> -include $(srcdir)/purgatory/arch/ppc64/Makefile
> -include $(srcdir)/purgatory/arch/s390/Makefile
> -include $(srcdir)/purgatory/arch/sh/Makefile
> -include $(srcdir)/purgatory/arch/x86_64/Makefile
> +include $(srcdir)/purgatory/arch/$(ARCH)/Makefile

I believe the above portion will break make dist my
causing it to omit purgatory/arch/* other than
purgatory/arch/$(ARCH)

>  
>  PURGATORY_SRCS+=$($(ARCH)_PURGATORY_SRCS)
>  
> @@ -36,10 +27,6 @@ clean += $(PURGATORY_OBJS) $(PURGATORY_DEPS) $(PURGATORY)
>  
>  -include $(PURGATORY_DEPS)
>  
> -# sha256.c needs to be compiled without optimization, else
> -# purgatory fails to execute on ia64.
> -purgatory/sha256.o: CFLAGS += -O0
> -
>  purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
>  	mkdir -p $(@D)
>  	$(COMPILE.c) -o $@ $^
> diff --git a/purgatory/arch/ia64/Makefile b/purgatory/arch/ia64/Makefile
> index 32c3d97..a8a5c62 100644
> --- a/purgatory/arch/ia64/Makefile
> +++ b/purgatory/arch/ia64/Makefile
> @@ -11,3 +11,6 @@ ia64_PURGATORY_EXTRA_CFLAGS = -ffixed-r28
>  dist += purgatory/arch/ia64/Makefile $(ia64_PURGATORY_SRCS)	\
>  	purgatory/arch/ia64/io.h purgatory/arch/ia64/purgatory-ia64.h
>  
> +# sha256.c needs to be compiled without optimization, else
> +# purgatory fails to execute on ia64.
> +purgatory/sha256.o: ia64_PURGATORY_EXTRA_CFLAGS += -O0
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
