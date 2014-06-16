Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WwgG9-0007ab-DV
 for kexec@lists.infradead.org; Mon, 16 Jun 2014 23:24:17 +0000
Date: Tue, 17 Jun 2014 08:23:53 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc64: move to device tree version 17
Message-ID: <20140616232353.GA24011@verge.net.au>
References: <20140616124243.11173.39355.stgit@nimbus>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140616124243.11173.39355.stgit@nimbus>
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
Cc: kexec@lists.infradead.org

On Mon, Jun 16, 2014 at 02:42:43PM +0200, Laurent Dufour wrote:
> Kernel commit e6a6928c3ea1d0195ed75a091e345696b916c09b changed the way the
> device tree is processed in the kernel. Now version 2 is no more supported.
> 
> This patch move the version of the device tree generated in ppc64
> environment from 2 to 17, allowing to kexec kernel 3.16.
> 
> In addition, automates the define of NEED_STRUCTURE_BLOCK_EXTRA_PAD which
> should not be set for DT version 16 and above.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Thanks, applied.

> ---
>  kexec/arch/ppc64/kexec-ppc64.h |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kexec/arch/ppc64/kexec-ppc64.h b/kexec/arch/ppc64/kexec-ppc64.h
> index 9a0aecf..89ee942 100644
> --- a/kexec/arch/ppc64/kexec-ppc64.h
> +++ b/kexec/arch/ppc64/kexec-ppc64.h
> @@ -6,9 +6,11 @@
>  #define CORE_TYPE_ELF32 1
>  #define CORE_TYPE_ELF64 2
>  
> -#define BOOT_BLOCK_VERSION 2
> -#define BOOT_BLOCK_LAST_COMP_VERSION 2
> -#define NEED_STRUCTURE_BLOCK_EXTRA_PAD
> +#define BOOT_BLOCK_VERSION 17
> +#define BOOT_BLOCK_LAST_COMP_VERSION 17
> +#if (BOOT_BLOCK_VERSION < 16)
> +#	define NEED_STRUCTURE_BLOCK_EXTRA_PAD
> +#endif
>  #define HAVE_DYNAMIC_MEMORY
>  #define NEED_RESERVE_DTB
>  
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
