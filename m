Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c9orM-0007KZ-WF
 for kexec@lists.infradead.org; Thu, 24 Nov 2016 07:54:22 +0000
Date: Thu, 24 Nov 2016 08:53:55 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] purgatory: Change default sha256 optimization to -O2
Message-ID: <20161124075355.GC13096@verge.net.au>
References: <32a52ca4-8741-e0e6-92c1-6b9583fa479b@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32a52ca4-8741-e0e6-92c1-6b9583fa479b@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org

On Wed, Nov 23, 2016 at 09:57:09AM -0800, Geoff Levand wrote:
> Change the default purgatory sha256 code optimization from -O0 to -O2, and add a
> new arch specific makefile variable $(ARCH)_PURGATORY_SHA256_CFLAGS which can
> over ride this default.  Set ia64_PURGATORY_SHA256_CFLAGS to -O0 to retain the
> previous optimization level for ia64.
> 
> The purgatory sha256 code needs the be built with -O0 for the  ia64
> architecture.  Currently this code is built with -O0 for all architectures,
> which slows down the calculations for architectures which could otherwise
> use -O2.

Could you give an indication of the performance improvement you expect,
e.g. on arm64?

> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  purgatory/Makefile           | 4 +---
>  purgatory/arch/ia64/Makefile | 4 ++++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index ca0443c..328904e 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -38,9 +38,7 @@ clean += $(PURGATORY_OBJS) $(PURGATORY_DEPS) $(PURGATORY)
>  -include $(PURGATORY_DEPS)
> -# sha256.c needs to be compiled without optimization, else
> -# purgatory fails to execute on ia64.
> -purgatory/sha256.o: CFLAGS += -O0
> +purgatory/sha256.o: CFLAGS += -O2 $($(ARCH)_PURGATORY_SHA256_CFLAGS)
>  purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
>  	mkdir -p $(@D)
> diff --git a/purgatory/arch/ia64/Makefile b/purgatory/arch/ia64/Makefile
> index 32c3d97..4a2564c 100644
> --- a/purgatory/arch/ia64/Makefile
> +++ b/purgatory/arch/ia64/Makefile
> @@ -8,6 +8,10 @@ ia64_PURGATORY_SRCS += purgatory/arch/ia64/vga.c
>  ia64_PURGATORY_EXTRA_CFLAGS = -ffixed-r28
> +# sha256.c needs to be compiled without optimization, else
> +# purgatory fails to execute on ia64.
> +ia64_PURGATORY_SHA256_CFLAGS = -O0
> +
>  dist += purgatory/arch/ia64/Makefile $(ia64_PURGATORY_SRCS)	\
>  	purgatory/arch/ia64/io.h purgatory/arch/ia64/purgatory-ia64.h
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
