Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WdBLa-0003M8-2A
 for kexec@lists.infradead.org; Thu, 24 Apr 2014 04:33:18 +0000
Date: Thu, 24 Apr 2014 13:32:55 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [kexec-tools] [PATCH] Do not distribute generated files in the
 release tarball
Message-ID: <20140424043255.GC9469@verge.net.au>
References: <1398313256-20388-1-git-send-email-pabs3@bonedaddy.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398313256-20388-1-git-send-email-pabs3@bonedaddy.net>
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
To: Paul Wise <pabs3@bonedaddy.net>
Cc: kexec@lists.infradead.org

While I'm not opposed to this off-hand I am curious to know what the
motivation for it is.

On Thu, Apr 24, 2014 at 12:20:56PM +0800, Paul Wise wrote:
> ---
>  kexec/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/Makefile b/kexec/Makefile
> index 7d3175b..a758b4a 100644
> --- a/kexec/Makefile
> +++ b/kexec/Makefile
> @@ -29,7 +29,7 @@ KEXEC_SRCS_base += kexec/kexec-xen.c
>  
>  KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
>  
> -dist += kexec/Makefile $(KEXEC_GENERATED_SRCS)			\
> +dist += kexec/Makefile						\
>  	$(KEXEC_SRCS_base) kexec/crashdump-elf.c		\
>  	kexec/crashdump.h kexec/firmware_memmap.h		\
>  	kexec/kexec-elf-boot.h					\
> -- 
> 1.9.2
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
