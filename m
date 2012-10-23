Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQSPO-0005eA-9A
 for kexec@lists.infradead.org; Tue, 23 Oct 2012 00:31:52 +0000
Date: Tue, 23 Oct 2012 09:30:31 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: s390x: Add 2GB frame support for page
 table walker
Message-Id: <20121023093031.a31a8792ab36f5b645d3a698@mxc.nes.nec.co.jp>
In-Reply-To: <20121022112114.133343ba@holzheu>
References: <20121019182912.135cac32@holzheu>
 <20121022162056.2acd77ed84fcac9e95f4f51d@mxc.nes.nec.co.jp>
 <20121022112114.133343ba@holzheu>
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
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com

Hello Michael,

On Mon, 22 Oct 2012 11:21:14 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

[snip] 
> > > --- a/arch/s390x.c
> > > +++ b/arch/s390x.c
> > > @@ -247,6 +247,11 @@ vtop_s390x(unsigned long vaddr)
> > >  			return NOT_PADDR;
> > >  		}
> > >  		table = entry & _REGION_ENTRY_ORIGIN;
> > > +		if ((entry & _REGION_ENTRY_LARGE) && (level == 1))
> > > {
> > > +			table &= ~0x7fffffffUL;
> > > +			paddr = table + (vaddr & 0x7ffffffUL);
> >                                                  ^^^^^^^^^^^
> > There is 0x7ffffff(27bit) but the patch for crash uses
> > 0x7fffffff(31bit). Which is correct ?
> 
> You are right! This is a typo in the makedumpfile patch. It should
> be 0x7fffffff (31 bit). Thanks for your careful review!
> 
> Here the corrected patch:

OK, I will merge it into v1.5.1.


Thanks
Atushi Kumagai

> ---
>  arch/s390x.c   | 6 ++++++
>  makedumpfile.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/s390x.c b/arch/s390x.c
> index 02b9e63..5854f10 100644
> --- a/arch/s390x.c
> +++ b/arch/s390x.c
> @@ -247,6 +247,11 @@ vtop_s390x(unsigned long vaddr)
>  			return NOT_PADDR;
>  		}
>  		table = entry & _REGION_ENTRY_ORIGIN;
> +		if ((entry & _REGION_ENTRY_LARGE) && (level == 1)) {
> +			table &= ~0x7fffffffUL;
> +			paddr = table + (vaddr & 0x7fffffffUL);
> +			return paddr;
> +		}
>  		len = RSG_TABLE_LENGTH(entry);
>  		level--;
>  	}
> @@ -257,6 +262,7 @@ vtop_s390x(unsigned long vaddr)
>  	 * if no, then get the page table entry using PX index.
>  	 */
>  	if (entry & _SEGMENT_ENTRY_LARGE) {
> +		table &= ~_PAGE_BYTE_INDEX_MASK;
>  		paddr = table + (vaddr &  _PAGE_BYTE_INDEX_MASK);
>  	} else {
>  		entry = _kl_pg_table_deref_s390x(vaddr,
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 2b88fa4..62bc5cc 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -563,6 +563,7 @@ do { \
>  #define _REGION_ENTRY_TYPE_MASK	0x0c	/* region table type mask */
>  #define _REGION_ENTRY_INVALID	0x20	/* invalid region table entry */
>  #define _REGION_ENTRY_LENGTH	0x03	/* region table length */
> +#define _REGION_ENTRY_LARGE	0x400
>  #define _REGION_OFFSET_MASK	0x7ffUL	/* region/segment table offset mask */
> 
>  #define RSG_TABLE_LEVEL(x)	(((x) & _REGION_ENTRY_TYPE_MASK) >> 2)
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
