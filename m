Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbRQJ-0000Li-LU
 for kexec@lists.infradead.org; Thu, 22 Nov 2012 07:42:13 +0000
Date: Thu, 22 Nov 2012 16:30:54 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: fix to exclude_unnecessary_pages_cyclic
Message-Id: <20121122163054.ebd90a1caa5924f135ac0a02@mxc.nes.nec.co.jp>
In-Reply-To: <E1TbGF5-00087E-Sy@eag09.americas.sgi.com>
References: <E1TbGF5-00087E-Sy@eag09.americas.sgi.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: cpw@sgi.com
Cc: kexec@lists.infradead.org

Hello Cliff,

On Wed, 21 Nov 2012 13:45:51 -0600
Cliff Wickman <cpw@sgi.com> wrote:

> 
> The || in exclude_unnecessary_pages_cyclic() makes makedumpfile
> scan all the memmap sections, not just the ones containing the current
> cyclic range.
> 
> Diffed against makedumpfile-1.5.1

Thanks, I'll merge this patch into v1.5.1.


Atsushi Kumagai

> ---
>  makedumpfile.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: makedumpfile-1.5.1/makedumpfile.c
> ===================================================================
> --- makedumpfile-1.5.1.orig/makedumpfile.c
> +++ makedumpfile-1.5.1/makedumpfile.c
> @@ -4187,7 +4187,7 @@ exclude_unnecessary_pages_cyclic(void)
>  			if (mmd->mem_map == NOT_MEMMAP_ADDR)
>  				continue;
>  
> -			if (mmd->pfn_end >= info->cyclic_start_pfn || mmd->pfn_start <= info->cyclic_end_pfn) {
> +			if (mmd->pfn_end >= info->cyclic_start_pfn && mmd->pfn_start <= info->cyclic_end_pfn) {
>  				if (!__exclude_unnecessary_pages(mmd->mem_map,
>  								 mmd->pfn_start, mmd->pfn_end))
>  					return FALSE;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
