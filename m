Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZWLa-0007ZO-Dp
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 02:10:11 +0000
Date: Mon, 14 Apr 2014 11:09:46 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH RESEND v5 01/10] x86, cleanup: fix indent
Message-ID: <20140414020946.GH22411@verge.net.au>
References: <1397183011-1526-1-git-send-email-chaowang@redhat.com>
 <1397183011-1526-2-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397183011-1526-2-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On Fri, Apr 11, 2014 at 10:23:22AM +0800, WANG Chao wrote:
> Signed-off-by: WANG Chao <chaowang@redhat.com>

Thanks, Applied.

> ---
>  kexec/arch/i386/crashdump-x86.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 91872ab..72bce0b 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -509,11 +509,11 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
>  		else if (addr > mend)
>  			tidx = i+1;
>  	}
> -		/* Insert the memory region. */
> -		for (j = nr_entries-1; j >= tidx; j--)
> -			memmap_p[j+1] = memmap_p[j];
> -		memmap_p[tidx].start = addr;
> -		memmap_p[tidx].end = addr + size - 1;
> +	/* Insert the memory region. */
> +	for (j = nr_entries-1; j >= tidx; j--)
> +		memmap_p[j+1] = memmap_p[j];
> +	memmap_p[tidx].start = addr;
> +	memmap_p[tidx].end = addr + size - 1;
>  
>  	dbgprintf("Memmap after adding segment\n");
>  	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> -- 
> 1.8.5.3
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
