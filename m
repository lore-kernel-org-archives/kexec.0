Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Taf3X-00081S-3d
 for kexec@lists.infradead.org; Tue, 20 Nov 2012 04:03:29 +0000
Date: Tue, 20 Nov 2012 12:55:28 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: s390x: Allow HW Change-bit override for
 page table entries
Message-Id: <20121120125528.deef0c56ee8c0ddf328a950e@mxc.nes.nec.co.jp>
In-Reply-To: <20121116143458.2d1a66e3@holzheu>
References: <20121116143458.2d1a66e3@holzheu>
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
To: holzheu@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org

Hello Michael,

On Fri, 16 Nov 2012 14:34:58 +0100
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> The HW Change-bit override (0x100) is used now for s390x. This patch allows
> page table entries that have set this bit.
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Thanks for your work.
I will merge this patch into v1.5.2.


Thanks
Atsushi Kumagai

> ---
>  arch/s390x.c   |    4 ++--
>  makedumpfile.h |    1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> --- a/arch/s390x.c
> +++ b/arch/s390x.c
> @@ -195,10 +195,10 @@ static ulong _kl_pg_table_deref_s390x(un
>  	readmem(VADDR, table + offset, &entry, sizeof(entry));
>  	/*
>  	 * Check if the page table entry could be read and doesn't have
> -	 * any of the reserved bits set.
> +	 * the reserved bit set.
>  	 * Check if the page table entry has the invalid bit set.
>  	 */
> -	if (entry &  (_PAGE_CO | _PAGE_ZERO | _PAGE_INVALID)) {
> +	if (entry &  (_PAGE_ZERO | _PAGE_INVALID)) {
>  		ERRMSG("Invalid page table entry.\n");
>  		return 0;
>  	}
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -575,7 +575,6 @@ do { \
>  #define _SEGMENT_INDEX_SHIFT	20
>  
>  /* Hardware bits in the page table entry */
> -#define _PAGE_CO		0x100	/* HW Change-bit override */
>  #define _PAGE_ZERO		0x800	/* Bit pos 52 must conatin zero */
>  #define _PAGE_INVALID		0x400	/* HW invalid bit */
>  #define _PAGE_INDEX_SHIFT	12
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
