Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ugal1-00056T-36
 for kexec@lists.infradead.org; Sun, 26 May 2013 13:13:08 +0000
Date: Sun, 26 May 2013 22:13:25 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/4] kexec-tools: Cleanup: Fix indentation
Message-ID: <20130526131325.GB11134@verge.net.au>
References: <1369213056-77661-1-git-send-email-trenn@suse.de>
 <1369213056-77661-2-git-send-email-trenn@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1369213056-77661-2-git-send-email-trenn@suse.de>
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
To: Thomas Renninger <trenn@suse.de>
Cc: yinghai@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, vgoyal@redhat.com

On Wed, May 22, 2013 at 10:57:33AM +0200, Thomas Renninger wrote:
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Thomas Renninger <Thomas Renninger" trenn@suse.de>
> ---
>  kexec/arch/i386/crashdump-x86.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index e44fceb..17c8744 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -559,11 +559,11 @@ static int add_memmap(struct memory_range *memmap_p, unsigned long long addr,
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

While you are at it could you also put spaces around the '-' and '+' in
the lines above?

> +	memmap_p[tidx].start = addr;
> +	memmap_p[tidx].end = addr + size - 1;
>  
>  	dbgprintf("Memmap after adding segment\n");
>  	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> -- 
> 1.7.6.1
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
