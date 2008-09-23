Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KiHQY-000621-Jd
	for kexec@lists.infradead.org; Tue, 23 Sep 2008 23:36:19 +0000
Date: Wed, 24 Sep 2008 09:36:17 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] IA64: better calculate PT_LOAD segment size
Message-ID: <20080923233615.GE14438@verge.net.au>
References: <48D45D21.7080702@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48D45D21.7080702@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Bernhard Walle <bwalle@suse.de>, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org

On Fri, Sep 19, 2008 at 07:17:05PM -0700, Jay Lan wrote:
> This patch combines consecutive PL_LOAD segments into one.
> The end address of the last PL_LOAD segment, calculated by
> adding p_memsz to p_paddr & rounded up to ELF_PAGE_SIZE,
> will be the end address of this loaded_segments[] entry.
> 
> This patch fixes the kdump kernel MCA problem caused by under-
> allocation of memory and a "kdump broken on ALtix 350" problem
> reported by Bernhard Walle.
> 
> Simon, this patch replaces my previous patch I submitted on the
> underallocation issue.
> 
> Signed-off-by: Jay Lan <jlan@sgi.com>
> 

The logic-bug portion of this fix I am fine with.
As you pointed out previously & has higher precedence
than += which makes the following bogus:

                        loaded_segments[loaded_segments_num].end +=
                                (phdr->p_memsz + ELF_PAGE_SIZE - 1) &
                                ~(ELF_PAGE_SIZE - 1)

The segment merging portion I am less clear about.
Why are there gaps in the first place? If these
multiple PT_LOAD segments are really one segment,
why aren't they being fed in as one segment?

> ---
>  kexec/arch/ia64/crashdump-ia64.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Index: kexec-tools/kexec/arch/ia64/crashdump-ia64.c
> ===================================================================
> --- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2008-09-19 14:33:07.593344017 -0700
> +++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2008-09-19 17:39:03.732928237 -0700
> @@ -86,19 +86,20 @@ static void add_loaded_segments_info(str
>                  loaded_segments[loaded_segments_num].end =
>  			loaded_segments[loaded_segments_num].start;
>  
> +		/* Consolidate consecutive PL_LOAD segments into one.
> +		 * The end addr of the last PL_LOAD segment, calculated by
> +		 * adding p_memsz to p_paddr & rounded up to ELF_PAGE_SIZE,
> +		 * will be the end address of this loaded_segments entry.
> +		 */
>  		while (i < ehdr->e_phnum) {
>  			phdr = &ehdr->e_phdr[i];
>  	                if (phdr->p_type != PT_LOAD)
>  	                        break;
> -			if (loaded_segments[loaded_segments_num].end !=
> -				phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
> -				break;
> -			loaded_segments[loaded_segments_num].end +=
> -				(phdr->p_memsz + ELF_PAGE_SIZE - 1) &
> -				~(ELF_PAGE_SIZE - 1);
> +			loaded_segments[loaded_segments_num].end =
> +				(phdr->p_paddr + phdr->p_memsz +
> +				ELF_PAGE_SIZE - 1) & ~(ELF_PAGE_SIZE - 1);
>  			i++;
>  		}
> -
>  		loaded_segments_num++;
>  	}
>  }


-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
