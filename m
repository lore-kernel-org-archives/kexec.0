Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fY4HF-0003Tx-SJ
 for kexec@lists.infradead.org; Wed, 27 Jun 2018 06:50:08 +0000
Date: Wed, 27 Jun 2018 08:49:47 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] arm64: increase command line size to 2048
Message-ID: <20180627064946.65pfbswtjpytqteh@verge.net.au>
References: <1530042449-19329-1-git-send-email-kamatam@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1530042449-19329-1-git-send-email-kamatam@amazon.com>
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
To: Munehisa Kamata <kamatam@amazon.com>
Cc: kexec@lists.infradead.org

On Tue, Jun 26, 2018 at 12:47:28PM -0700, Munehisa Kamata wrote:
> Otherwise, we can hit the current 512 chars limit before hitting the
> Linux kernel's one, where allows 2048 chars in arm64.
> 
> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>

Hi,

This looks fine to me but I will wait to see if there are other reviews
before applying.

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  kexec/arch/arm64/kexec-arm64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
> index bf724ef..22e4b69 100644
> --- a/kexec/arch/arm64/kexec-arm64.h
> +++ b/kexec/arch/arm64/kexec-arm64.h
> @@ -15,7 +15,7 @@
>  
>  #define BOOT_BLOCK_VERSION 17
>  #define BOOT_BLOCK_LAST_COMP_VERSION 16
> -#define COMMAND_LINE_SIZE 512
> +#define COMMAND_LINE_SIZE 2048 /* from kernel */
>  
>  #define KiB(x) ((x) * 1024UL)
>  #define MiB(x) (KiB(x) * 1024UL)
> -- 
> 2.7.4
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
