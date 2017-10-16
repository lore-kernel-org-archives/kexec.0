Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1e3zRS-0007eR-Jv
 for kexec@lists.infradead.org; Mon, 16 Oct 2017 07:04:04 +0000
Date: Mon, 16 Oct 2017 08:53:13 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/4] kexec-tools: mips: Merge adjacent memory ranges.
Message-ID: <20171016065313.g5va4jel5si2udbm@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-2-david.daney@cavium.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171012210228.7353-2-david.daney@cavium.com>
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
To: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org, kexec@lists.infradead.org

On Thu, Oct 12, 2017 at 02:02:25PM -0700, David Daney wrote:
> Some kernel versions running on MIPS split the System RAM memory
> regions reported in /proc/iomem.  This may cause loading of the kexec
> kernel to fail if it crosses one of the splits.
> 
> Fix by merging adjacent memory ranges that have the same type.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  kexec/arch/mips/kexec-mips.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
> index 2e5b700..415c2ed 100644
> --- a/kexec/arch/mips/kexec-mips.c
> +++ b/kexec/arch/mips/kexec-mips.c
> @@ -60,10 +60,16 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>  		} else {
>  			continue;
>  		}
> -		memory_range[memory_ranges].start = start;
> -		memory_range[memory_ranges].end = end;
> -		memory_range[memory_ranges].type = type;
> -		memory_ranges++;
> +		if (memory_ranges > 0 &&

It seems that this will never merge the first memory range
with subsequent ones. Is that intentional?


> +		    memory_range[memory_ranges - 1].end == start &&
> +		    memory_range[memory_ranges - 1].type == type) {
> +			memory_range[memory_ranges - 1].end = end;
> +		} else {
> +			memory_range[memory_ranges].start = start;
> +			memory_range[memory_ranges].end = end;
> +			memory_range[memory_ranges].type = type;
> +			memory_ranges++;
> +		}
>  	}
>  	fclose(fp);
>  	*range = memory_range;
> -- 
> 2.9.5
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
