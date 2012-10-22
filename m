Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQCL6-0006pK-JH
 for kexec@lists.infradead.org; Mon, 22 Oct 2012 07:22:23 +0000
Date: Mon, 22 Oct 2012 16:20:56 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: s390x: Add 2GB frame support for page
 table walker
Message-Id: <20121022162056.2acd77ed84fcac9e95f4f51d@mxc.nes.nec.co.jp>
In-Reply-To: <20121019182912.135cac32@holzheu>
References: <20121019182912.135cac32@holzheu>
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
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org

Hello Michael,

On Fri, 19 Oct 2012 18:29:12 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> On s390 the zEC12 machines support 2GB frames. In order to walk page
> tables correctly add support to the page table walker function so it
> detects 2GB frames.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Thank you for your work. I have a question.

> ---
>  arch/s390x.c   |    6 ++++++
>  makedumpfile.h |    1 +
>  2 files changed, 7 insertions(+)
> 
> --- a/arch/s390x.c
> +++ b/arch/s390x.c
> @@ -247,6 +247,11 @@ vtop_s390x(unsigned long vaddr)
>  			return NOT_PADDR;
>  		}
>  		table = entry & _REGION_ENTRY_ORIGIN;
> +		if ((entry & _REGION_ENTRY_LARGE) && (level == 1)) {
> +			table &= ~0x7fffffffUL;
> +			paddr = table + (vaddr & 0x7ffffffUL);
                                                 ^^^^^^^^^^^
There is 0x7ffffff(27bit) but the patch for crash uses 0x7fffffff(31bit).
Which is correct ?


Thanks
Atsushi Kumagai

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
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
