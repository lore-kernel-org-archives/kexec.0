Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgNoe-00079k-Ns
 for kexec@lists.infradead.org; Sat, 25 May 2013 23:24:01 +0000
Date: Sun, 26 May 2013 08:24:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] kexec/s390: cleanup: Fix a mistaken comment
Message-ID: <20130525232419.GB24131@verge.net.au>
References: <51A0CB91.3090607@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51A0CB91.3090607@gmail.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Sat, May 25, 2013 at 10:32:49PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> When borrowing codes from ia64 architecture, this comment was
> forgotten to be change. So fix it.
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  kexec/arch/s390/kexec-s390.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kexec/arch/s390/kexec-s390.h b/kexec/arch/s390/kexec-s390.h
> index ee62888..ef53b11 100644
> --- a/kexec/arch/s390/kexec-s390.h
> +++ b/kexec/arch/s390/kexec-s390.h
> @@ -34,4 +34,4 @@ extern int get_memory_ranges_s390(struct memory_range range[], int *ranges,
>  				  int with_crashk);
>  extern int command_line_add(const char *str);
>  
> -#endif /* KEXEC_IA64_H */
> +#endif /* KEXEC_S390_H */
> -- 
> 1.7.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
