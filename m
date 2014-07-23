Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X9k18-0000RE-E6
 for kexec@lists.infradead.org; Wed, 23 Jul 2014 00:02:46 +0000
Date: Wed, 23 Jul 2014 09:02:24 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc64: disabling exception handling when building
 the purgatory
Message-ID: <20140723000224.GD21367@verge.net.au>
References: <20140722104255.GF13924@dhcp-17-37.nay.redhat.com>
 <20140722162228.12506.28076.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140722162228.12506.28076.stgit@nimbus>
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
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, chaowang@redhat.com

On Tue, Jul 22, 2014 at 06:22:28PM +0200, Laurent Dufour wrote:
> Some Linux distributions would like to turn on the GCC exception handling
> by default. As this option introduces symbols in the built code that are
> defined in a separate shared library, this is not a good idea to have such
> an option activated when building the purgatory.
> 
> This patch forces the exception handling to be turned off when building the
> purgatory on ppc64 BE and LE.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied.

> ---
>  purgatory/arch/ppc64/Makefile |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
> index 712e2b194bee..6c58fa20dad9 100644
> --- a/purgatory/arch/ppc64/Makefile
> +++ b/purgatory/arch/ppc64/Makefile
> @@ -9,7 +9,8 @@ ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/console-ppc64.c
>  ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/crashdump_backup.c
>  ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/misc.S
>  
> -ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float -fno-stack-protector
> +ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -msoft-float -fno-stack-protector	\
> +				-fno-exceptions
>  ppc64_PURGATORY_EXTRA_ASFLAGS += -m64
>  ifeq ($(SUBARCH),BE)
>  	ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
