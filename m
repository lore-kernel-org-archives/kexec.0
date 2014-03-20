Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQTzO-0001gx-0u
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 03:49:54 +0000
Date: Thu, 20 Mar 2014 12:49:31 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 1/4] cleanup: add dbgprint_mem_range function
Message-ID: <20140320034931.GB10601@verge.net.au>
References: <1395216241-13983-1-git-send-email-chaowang@redhat.com>
 <1395216241-13983-2-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395216241-13983-2-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On Wed, Mar 19, 2014 at 04:03:58PM +0800, WANG Chao wrote:
> dbgprint_mem_range is used for printing the given memory range under
> debugging mode.
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> Tested-by: Linn Crosetto <linn@hp.com>

Thanks, I have applied this patch.

> ---
>  kexec/arch/i386/kexec-x86-common.c |  6 +-----
>  kexec/kexec.c                      | 10 ++++++++++
>  kexec/kexec.h                      |  1 +
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
> index f55e2c2..e416177 100644
> --- a/kexec/arch/i386/kexec-x86-common.c
> +++ b/kexec/arch/i386/kexec-x86-common.c
> @@ -374,11 +374,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>  			mem_max = end;
>  	}
>  
> -	dbgprintf("MEMORY RANGES\n");
> -	for (i = 0; i < *ranges; i++) {
> -		dbgprintf("%016Lx-%016Lx (%d)\n", (*range)[i].start,
> -			  (*range)[i].end, (*range)[i].type);
> -	}
> +	dbgprint_mem_range("MEMORY RANGES", *range, *ranges);
>  
>  	return ret;
>  }
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 382f86a..133e622 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -53,6 +53,16 @@ unsigned long long mem_max = ULONG_MAX;
>  static unsigned long kexec_flags = 0;
>  int kexec_debug = 0;
>  
> +void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr)
> +{
> +	int i;
> +	dbgprintf("%s\n", prefix);
> +	for (i = 0; i < nr_mr; i++) {
> +		dbgprintf("%016llx-%016llx (%d)\n", mr[i].start,
> +			  mr[i].end, mr[i].type);
> +	}
> +}
> +
>  void die(const char *fmt, ...)
>  {
>  	va_list args;
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 2bd6e96..d69bba2 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -232,6 +232,7 @@ extern int file_types;
>  
>  #define KEXEC_OPT_STR "h?vdfxluet:p"
>  
> +extern void dbgprint_mem_range(const char *prefix, struct memory_range *mr, int nr_mr);
>  extern void die(const char *fmt, ...)
>  	__attribute__ ((format (printf, 1, 2)));
>  extern void *xmalloc(size_t size);
> -- 
> 1.8.5.3
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
