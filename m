Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UBNi6-0001Ss-Sw
 for kexec@lists.infradead.org; Fri, 01 Mar 2013 11:01:08 +0000
Date: Fri, 1 Mar 2013 19:53:45 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: s390x: Allow large page and change
 override bits
Message-Id: <20130301195345.cd7f83b9450d0f8e6e998b41@mxc.nes.nec.co.jp>
In-Reply-To: <20130228163132.5282e758@holzheu>
References: <20130228163132.5282e758@holzheu>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org

Hello Michael,

On Thu, 28 Feb 2013 16:31:32 +0100
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> Currently makedumpfile fails if large page or change override bits
> are set for region or segment table entries:
> 
> Excluding free pages               : [  0 %]
> _kl_rsg_table_deref_s390x: Bad region/segment table entry.
> readmem: Can't convert a virtual address(3d1015fc028) to physical address.
> readmem: type_addr: 0, addr:3d1015fc028, size:8
> reset_bitmap_of_free_pages: Can't get prev list_head.
> _kl_rsg_table_deref_s390x: Bad region/segment table entry.
> readmem: Can't convert a virtual address(3d1015fc028) to physical address.
> readmem: type_addr: 0, addr:3d1015fc028, size:8
> reset_bitmap_of_free_pages: Can't get prev list_head.
> makedumpfile Failed.
> 
> Large page support is already implemented for the makedumpfile page table
> walk. Only the check is invalid. To fix this we now allow the bits in
> rsg_table_entry_bad().

Thanks, I'll merge this patch into v1.5.4.


Atsushi Kumagai
 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  arch/s390x.c   |    4 +++-
>  makedumpfile.h |    1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> --- a/arch/s390x.c
> +++ b/arch/s390x.c
> @@ -133,7 +133,9 @@ rsg_table_entry_bad(unsigned long entry,
>  {
>  	unsigned long mask = ~_REGION_ENTRY_INVALID
>  				& ~_REGION_ENTRY_TYPE_MASK
> -				& ~_REGION_ENTRY_LENGTH;
> +				& ~_REGION_ENTRY_LENGTH
> +				& ~_SEGMENT_ENTRY_LARGE
> +				& ~_SEGMENT_ENTRY_CO;
>  
>  	if (level)
>  		mask &= ~_REGION_ENTRY_ORIGIN;
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -617,6 +617,7 @@ do { \
>  /* Bits in the segment table entry */
>  #define _SEGMENT_ENTRY_ORIGIN	~0x7ffUL
>  #define _SEGMENT_ENTRY_LARGE	0x400
> +#define _SEGMENT_ENTRY_CO	0x100
>  #define _SEGMENT_PAGE_SHIFT	31
>  #define _SEGMENT_INDEX_SHIFT	20
>  
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
