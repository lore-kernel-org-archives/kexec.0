Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a2Czz-0001uS-Ok
 for kexec@lists.infradead.org; Fri, 27 Nov 2015 06:59:16 +0000
Date: Fri, 27 Nov 2015 14:58:47 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86: Make sure E820_PM[AE]M are defined if needed
Message-ID: <20151127065847.GF13853@dhcp-128-28.nay.redhat.com>
References: <1448584578-5706-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1448584578-5706-1-git-send-email-horms@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org, Petr Tesarik <ptesarik@suse.com>

On 11/27/15 at 09:36am, Simon Horman wrote:
> It appears that (older?) revisions of xenctl.h define
> all of the E820_* values used in kexec-x86-common.c except
> E820_PMAM and E820_PMEM. This results in a build failure when
> building against libxenctl.
> 
> Avoid this problem by providing local definitions of those values.
> 
> It seems reasonable to do so in the kexec-x86-common.c as
> currently that is the only source file that uses the values in question.
> 
> Fixes: 56a12abc1df1 ("kexec: fix mmap return code handling")
> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> Cc: Petr Tesarik <ptesarik@suse.com>
> Cc: Baoquan He <bhe@redhat.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  kexec/arch/i386/kexec-x86-common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
> index b308e4719503..3e97239c0c78 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -44,6 +44,12 @@
>  #include <xenctrl.h>
>  #endif /* HAVE_LIBXENCTRL */
>  
> +/* Used below but not present in (older?) xenctrl.h */
> +#ifndef E820_PMEM
> +#define E820_PMEM         7
> +#define E820_PRAM         12
> +#endif
> +

It looks very ugly but seems no better way to do it.

>  static struct memory_range memory_range[MAX_MEMORY_RANGES];
>  
>  /**
> -- 
> 2.1.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
